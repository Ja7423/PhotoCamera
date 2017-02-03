//
//  PhotoMapViewController.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2017/1/16.
//  Copyright © 2017年 何家瑋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AssetModel.h"
#import "Photo.h"
#import "PhotoMapAnnotationView.h"

#import <CCHMapClusterController.h>
#import <CCHMapClusterAnnotation.h>
#import <CCHMapClusterControllerDelegate.h>

@interface PhotoMapViewController : UIViewController

@property (nonatomic) FetchResultModel *fetchResultModel;
@property (nonatomic) NSArray * photosAsset;

@end
