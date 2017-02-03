//
//  AssetModel.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/4.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "VideoPlayer.h"


@interface FetchResultModel : NSObject

@property (nonatomic) id result;

@property (nonatomic) NSString *albumName;

@property (nonatomic ,assign) NSUInteger count;

- (UIImage *)postImageWidth:(CGSize)width;

@end


@interface AssetModel : NSObject

@property (nonatomic) PHAsset* asset;

@property (nonatomic, assign) NSInteger mediaType;

@property (nonatomic) NSString *timeDuration;

@property (nonatomic) CLLocation *location;

- (void)photoImageWidth:(CGSize)width completion:(void (^) (UIImage *image))completion;


@end



