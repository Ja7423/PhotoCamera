//
//  PhotoPreviewViewController.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/8.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AssetModel.h"
#import "DataSourceModel.h"
#import "PhotoPreviewCollectionViewCell.h"
#import "VideoPlayer.h"

@interface PhotoPreviewViewController : UIViewController <PhotoPreviewCollectionViewCellDelegate>

- (instancetype)initWithDataModel:(DataSourceModel *)dataModel;

@property (nonatomic, assign) NSInteger didSelectIndex;

@end
