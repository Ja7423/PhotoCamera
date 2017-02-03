//
//  PhotoPickerViewController.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "PhotoPickerViewController.h"

@interface PhotoPickerViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
        NSArray * _photosAsset;
        UICollectionView * _collectionView;
        UICollectionViewFlowLayout *_layout;
}

@end

@implementation PhotoPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"map" style:UIBarButtonItemStylePlain target:self action:@selector(goToMapCategory)];
        
        [self configureCollectionView];
        
        [[[Photo alloc]init] getAlbumAssetWithFetchResult:_fetchResultModel.result completion:^(NSArray *photosAsset) {
                _photosAsset = [NSArray arrayWithArray:photosAsset];
        }];
}

- (void)configureCollectionView
{
        CGFloat width = (self.view.frame.size.width - 25) / 4;
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.itemSize = CGSizeMake(width, width);
        _layout.minimumLineSpacing = 5; //上下間距
        _layout.minimumInteritemSpacing = 5; //左右間距
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:_layout];
        _collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5); //cell與邊界的距離
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentSize = CGSizeMake(self.view.frame.size.width, (_photosAsset.count / 4) * width);
        [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
        [self.view addSubview:_collectionView];
}

- (void)viewDidLayoutSubviews
{
        [super viewDidLayoutSubviews];
        
        /*
         About the scrollToBottom issue I find that it seems like in the viewWillAppear the layout isn't correct yet. The frame and the insets of the collectionView are right but it seems that the internal layout is not calculated yet. ScrollToItemAtIndexPath() can work in viewDidAppear and viewDidLayoutSubviews.
         http://stackoverflow.com/questions/14760496/uicollectionview-automatically-scroll-to-bottom-when-screen-loads
         */
        
        if (_photosAsset.count == 0)
                return;
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(_photosAsset.count - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
- (void)goToMapCategory
{
        PhotoMapViewController * _photoMapVC = [[PhotoMapViewController alloc]init];
        _photoMapVC.fetchResultModel = _fetchResultModel;
        _photoMapVC.photosAsset = _photosAsset;
        [self.navigationController pushViewController:_photoMapVC animated:YES];
}

#pragma mark - collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return _photosAsset.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];

        AssetModel *model = _photosAsset[indexPath.row];
        [model photoImageWidth:cell.photoImageView.frame.size completion:^(UIImage *image) {
                cell.photoImageView.image = image;
        }];
        
        if (model.mediaType == MediaTypeVideo)
                [cell.timeLabel setText:model.timeDuration];
        
        return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        PhotoPreviewViewController *previewVC = [[PhotoPreviewViewController alloc]init];
        previewVC.fetchResultModel = self.fetchResultModel;
        previewVC.photosAsset = _photosAsset;
        previewVC.didSelectIndex = indexPath.row;
        [self.navigationController pushViewController:previewVC animated:YES];
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
