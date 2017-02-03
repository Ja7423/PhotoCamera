//
//  VideoPlayer.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/14.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AVKit/AVKit.h>
#import "Photo.h"

@interface VideoPlayer : NSObject

+ (VideoPlayer *)videoPlayerWithAsset:(PHAsset *)asset;
- (instancetype)initWithAsset:(PHAsset *)asset;
- (void)getPlayerViewController:(void (^) (AVPlayerViewController * _avPlayerViewController))completionHandler;

@end
