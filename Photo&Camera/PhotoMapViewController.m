//
//  PhotoMapViewController.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2017/1/16.
//  Copyright © 2017年 何家瑋. All rights reserved.
//

#import "PhotoMapViewController.h"

@interface PhotoMapViewController () <MKMapViewDelegate, CCHMapClusterControllerDelegate>

@property(nonatomic) CCHMapClusterController * CCHMapClusterController;
@property (nonatomic) MKMapView * mapView;

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        if (!_photosAsset)
        {
                [[[Photo alloc]init] getAlbumAssetWithFetchResult:_fetchResultModel.result completion:^(NSArray *photosAsset) {
                        _photosAsset = photosAsset;
                }];
        }
        
        _mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
        _mapView.delegate = self;
        _CCHMapClusterController = [[CCHMapClusterController alloc]initWithMapView:_mapView];
        _CCHMapClusterController.delegate = self;
        [_CCHMapClusterController addAnnotations:[self addAnnotation] withCompletionHandler:nil];
        [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)addAnnotation
{
        NSMutableArray *annotations = [[NSMutableArray alloc]init];
        
        [_photosAsset enumerateObjectsUsingBlock:^(AssetModel *asset, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (asset.location)
                {
                        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
                        
                        annotation.coordinate = asset.location.coordinate;
                        
                        [annotations addObject:annotation];
                }
                
        }];
        
        return annotations;
}

- (AssetModel *)assetModelFromLocation:(CCHMapClusterAnnotation *)mapClusterAnnotation
{
        AssetModel *model = nil;
        NSArray * annotations = [mapClusterAnnotation.annotations allObjects];
        MKPointAnnotation *pointAnnotation = annotations[0];
        
        for (AssetModel *asset in _photosAsset) {
                if (asset.location.coordinate.latitude == pointAnnotation.coordinate.latitude &&
                    asset.location.coordinate.longitude == pointAnnotation.coordinate.longitude)
                {
                        model = asset;
                        break;
                }
        }
        
        return model;
}

- (void)addPhotoImageFromAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation ToAnnotationView:(PhotoMapAnnotationView *)annotationView
{
        AssetModel *assetModel = [self assetModelFromLocation:mapClusterAnnotation];
        [assetModel photoImageWidth:CGSizeMake(50, 50) completion:^(UIImage *image) {
                
                annotationView.photoImageView.image = image;
        }];
}

#pragma mark - CCHMapClusterControllerDelegate
- (NSString *)mapClusterController:(CCHMapClusterController *)mapClusterController titleForMapClusterAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation
{
        NSUInteger numAnnotations = mapClusterAnnotation.annotations.count;
        NSString *unit = numAnnotations > 1 ? @"pictures" : @"picture";
        return [NSString stringWithFormat:@"%tu %@", numAnnotations, unit];
}

- (void)mapClusterController:(CCHMapClusterController *)mapClusterController willReuseMapClusterAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation
{
        PhotoMapAnnotationView *annotationView = (PhotoMapAnnotationView *)[self.mapView viewForAnnotation:mapClusterAnnotation];
        annotationView.count = mapClusterAnnotation.annotations.count;
        annotationView.uniqueLocation = mapClusterAnnotation.isUniqueLocation;
        [self addPhotoImageFromAnnotation:mapClusterAnnotation ToAnnotationView:annotationView];
}

#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
        PhotoMapAnnotationView *annotationView = (PhotoMapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"customAnnotationVIew"];;
        
        if (!annotationView)
                annotationView = [[PhotoMapAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"customAnnotationVIew"];
        
        annotationView.annotation = annotation;
        annotationView.canShowCallout = YES;
        
        CCHMapClusterAnnotation *mapClusterAnnotation = (CCHMapClusterAnnotation *)annotation;
        annotationView.count = mapClusterAnnotation.annotations.count;
        annotationView.uniqueLocation = mapClusterAnnotation.isUniqueLocation;
        [self addPhotoImageFromAnnotation:mapClusterAnnotation ToAnnotationView:annotationView];
        
        return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
        CCHMapClusterAnnotation *mapClusterAnnotation = view.annotation;
        NSLog(@"didSelectAnnotationView");
        NSLog(@"isUniqueLocation : %d", mapClusterAnnotation.isUniqueLocation);
        NSLog(@"count : %lu", (unsigned long)mapClusterAnnotation.annotations.count);
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
