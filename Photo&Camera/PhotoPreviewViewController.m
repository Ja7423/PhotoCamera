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
        VideoPlayer * _videoPlayer;
        DataSourceModel * _dataSourceModel;
        
        UICollectionView * _collectionView;
        UICollectionViewFlowLayout *_layout;
        UIToolbar * _toolBar;
        
        BOOL _navigationBarIsHidden;
        BOOL _needUpdateData;
}

@end

@implementation PhotoPreviewViewController
- (instancetype)initWithDataModel:(DataSourceModel *)dataModel
{
        self = [self init];
        
        if (self)
        {
                _dataSourceModel = dataModel;
        }
        
        return self;
}

- (instancetype)init
{
        self = [super init];
        
        if (self)
        {
                self.hidesBottomBarWhenPushed = YES;
                self.automaticallyAdjustsScrollViewInsets = NO;
                self.navigationController.navigationBar.translucent = NO;
        }
        
        return self;
}

- (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        [self configureCollectionView];
        [self configureToolBar];
        
        _navigationBarIsHidden = NO;
        _needUpdateData = NO;
        
        self.view.clipsToBounds = YES;
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
        _collectionView.contentSize = CGSizeMake([_dataSourceModel numberOfDataAtIndex:0] * (self.view.frame.size.width + 20), self.view.frame.size.height);
        [_collectionView registerClass:[PhotoPreviewCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoPreviewCollectionViewCell"];
        [self.view addSubview:_collectionView];
}

- (void)configureToolBar
{
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
        _toolBar.barStyle = UIBarStyleBlack;
        _toolBar.translucent = YES;
        _toolBar.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *trashBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deletePhoto)];
        
        UIBarButtonItem *actionBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePhoto)];
        
        UIBarButtonItem *flexibleBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSArray *items = [NSArray arrayWithObjects:trashBarButton, flexibleBarButton, actionBarButton,nil];
        
        [_toolBar setItems:items];
        
        [self.view addSubview:_toolBar];
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
        
        AssetModel *model = [_dataSourceModel dataAtIndex:sender.tag];
        _videoPlayer = [VideoPlayer videoPlayerWithAsset:model.asset];
        [_videoPlayer getPlayerViewController:^(AVPlayerViewController *_avPlayerViewController) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:_avPlayerViewController animated:YES completion:^{
                                [_avPlayerViewController.player play];
                        }];
                });
        }];
}

- (void)deletePhoto
{
        AssetModel *model = [_dataSourceModel dataAtIndex:_didSelectIndex];
        
        NSArray * deleteAssets = [NSArray arrayWithObject:model];
        [_dataSourceModel deletePhoto:deleteAssets completion:^(BOOL success, NSError *error) {
                
                if (success)
                {
                        dispatch_async(dispatch_get_main_queue(), ^{
                                if (_didSelectIndex > 0)
                                        _didSelectIndex -= 1;
                                else
                                        _didSelectIndex = 1;
                                
                                [_collectionView setContentOffset:CGPointMake(_layout.itemSize.width * _didSelectIndex, 0) animated:NO];
                                [_collectionView reloadData];
                        });
                        
                        [_dataSourceModel.delegate dataSourceModelDidChange:_dataSourceModel];
                }
        }];
}

- (void)sharePhoto
{
        AssetModel *model = [_dataSourceModel dataAtIndex:_didSelectIndex];
        UIScreen *screen = [UIScreen mainScreen];
        CGSize imageTargetSize = CGSizeMake(screen.bounds.size.width, screen.bounds.size.height);
        
        typeof(self) __weak weakSelf = self;
        [model photoImageSize:imageTargetSize completion:^(UIImage *image) {

                UIImage *shareImage = image;
                
                NSArray *items = [NSArray arrayWithObjects:shareImage, nil];
                UIActivityViewController * _activityVC = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf presentViewController:_activityVC animated:YES completion:nil];
                });
        }];
}

#pragma mark - status bar
- (BOOL)prefersStatusBarHidden
{
        return _navigationBarIsHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
        return UIStatusBarAnimationNone;
}

#pragma mark - navigation bar
- (void)setNavigationBarAppearance:(BOOL)hidden animated:(BOOL)animated
{
        CGFloat alpha = (hidden) ? 0.0 : 1.0;
        
        [self.navigationController setNavigationBarHidden:hidden animated:animated];
        
        [UIView animateWithDuration:0.35 animations:^{
                
                _toolBar.alpha = alpha;
                
                [self setNeedsStatusBarAppearanceUpdate];
        }];
}

#pragma mark - collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return [_dataSourceModel numberOfDataAtIndex:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        PhotoPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoPreviewCollectionViewCell" forIndexPath:indexPath];
        
        AssetModel *model = [_dataSourceModel dataAtIndex:indexPath.row];
        cell.cellModel = model;
        
        [model photoImageSize:cell.frame.size completion:^(UIImage *image) {
                cell.photoImageView.image = image;
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
        
        _didSelectIndex = indexPath.row;
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
                        _navigationBarIsHidden = !_navigationBarIsHidden;
                        [self setNavigationBarAppearance:_navigationBarIsHidden animated:NO];
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
