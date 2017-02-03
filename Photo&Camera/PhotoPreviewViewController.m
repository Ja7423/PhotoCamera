//
//  PhotoPreviewViewController.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/8.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "PhotoPreviewViewController.h"

@interface PhotoPreviewViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate, AVPlayerViewControllerDelegate>
{
        UICollectionView * _collectionView;
        UICollectionViewFlowLayout *_layout;
        Photo *_photo;
        VideoPlayer * _videoPlayer;
        NSInteger didSelectedCellIndexPath;
        
        BOOL navigationBarIsHidden;
}

@end

@implementation PhotoPreviewViewController
- (instancetype)init
{
        self = [super init];
        
        if (self)
        {
                self.hidesBottomBarWhenPushed = YES;
                self.automaticallyAdjustsScrollViewInsets = NO;
                self.view.clipsToBounds = YES;
                self.navigationController.navigationBar.translucent = NO;
        }
        
        return self;
}

- (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        if (!_photosAsset)
        {
                [_photo getAlbumAssetWithFetchResult:_fetchResultModel.result completion:^(NSArray *photosAsset) {
                        _photosAsset = photosAsset;
                }];
        }
        
        _photo = [[Photo alloc]init];
        [self configureCollectionView];
        
        navigationBarIsHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];
        
        [_collectionView setContentOffset:CGPointMake(_layout.itemSize.width * _didSelectIndex, 0) animated:NO];
        
        [self.view setNeedsLayout];
}

- (void)viewDidLayoutSubviews
{
        [super viewDidLayoutSubviews];
        
        // when dismiss AVPlayerViewController, collection view won't scroll to posiion bottom automatically
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:didSelectedCellIndexPath inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}


- (void)configureCollectionView
{
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(self.view.frame.size.width + 20, self.view.frame.size.height - 64);
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, self.view.frame.size.width + 20, self.view.frame.size.height) collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.contentOffset = CGPointMake(0, 0);
        _collectionView.contentSize = CGSizeMake(self.photosAsset.count * (self.view.frame.size.width + 20), self.view.frame.size.height);
        [_collectionView registerClass:[PhotoPreviewCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoPreviewCollectionViewCell"];
        [self.view addSubview:_collectionView];
}

- (UIButton *)configPlayButton
{
        UIButton * _playButton;
        UIImage *playerImage = [UIImage imageNamed:@"VideoPlayer.png"];
        _playButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [_playButton setImage:playerImage forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return _playButton;
}

#pragma mark - button action
- (void)playButtonClick:(UIButton *)sender
{
        typeof(self) __weak weakSelf = self;
        
        didSelectedCellIndexPath = sender.tag;
        AssetModel *model = _photosAsset[sender.tag];
        _videoPlayer = [VideoPlayer videoPlayerWithAsset:model.asset];
        [_videoPlayer getPlayerViewController:^(AVPlayerViewController *_avPlayerViewController) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:_avPlayerViewController animated:YES completion:^{
                                
                                [_avPlayerViewController.player play];
                        }];
                });
        }];
}

#pragma mark - status bar
- (BOOL)prefersStatusBarHidden
{
        return navigationBarIsHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
        return UIStatusBarAnimationNone;
}

#pragma mark - navigation bar
- (void)setNavigationBarAppearance:(BOOL)hidden animated:(BOOL)animated
{
        [self.navigationController setNavigationBarHidden:hidden animated:animated];
        
        [UIView animateWithDuration:0.35 animations:^{
        
                [self setNeedsStatusBarAppearanceUpdate];
        }];
}

#pragma mark - collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return _photosAsset.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        PhotoPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoPreviewCollectionViewCell" forIndexPath:indexPath];
        
        AssetModel *model = _photosAsset[indexPath.row];
        
        [_photo getPhotoWithWidth:cell.frame.size Asset:model.asset completion:^(UIImage *image) {
                
                cell.photoImageView.image = image;
                cell.cellModel = model;
                [cell resizeSubviews];
        }];
        
        return cell;
}

#pragma mark - collection view delegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
        PhotoPreviewCollectionViewCell *previewCell = (PhotoPreviewCollectionViewCell *)cell;
        if (previewCell.cellModel.mediaType == MediaTypeVideo)
        {
                UIButton *playButton = [self configPlayButton];
                playButton.tag = indexPath.row;
                previewCell.playButton = playButton;
        }
        
        [previewCell addGesture];
        previewCell.delegate = self;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
        PhotoPreviewCollectionViewCell *previewCell = (PhotoPreviewCollectionViewCell *)cell;
        
        [previewCell releaseUI];
        [previewCell removeGesture];
        previewCell.delegate = nil;
}

#pragma mark - cell delegate
- (void)PhotoPreviewCollectionViewCell:(PhotoPreviewCollectionViewCell *)cell didDetectGestureType:(GestureTyep)gestureType GestureRecognizer:(UIGestureRecognizer *)gesture
{
        switch (gestureType) {
                case GestureTypeSingleTap:
                        navigationBarIsHidden = !navigationBarIsHidden;
                        [self setNavigationBarAppearance:navigationBarIsHidden animated:YES];
                        break;
                case GestureTypeDoubleTap:
                        [cell zoomScale:[gesture locationInView:cell]];
                        break;
                default:
                        break;
        }
        
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
