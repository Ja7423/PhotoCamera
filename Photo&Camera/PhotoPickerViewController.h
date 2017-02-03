//
//  PhotoPickerViewController.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "AssetModel.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoPreviewViewController.h"
#import "PhotoMapViewController.h"

@interface PhotoPickerViewController : UIViewController

@property (nonatomic) FetchResultModel *fetchResultModel;

@end
