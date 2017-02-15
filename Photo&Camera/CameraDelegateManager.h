//
//  CameraDelegateManager.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/23.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "Photo.h"

@class CameraDelegateManager;
@protocol CameraDelegate <NSObject>

@optional
- (void)CameraDelegate:(CameraDelegateManager *)CameraDelegateManager didFinishCapturePhoto:(NSData *)photoData withError:(NSError *)error;

@end

@interface CameraDelegateManager : NSObject <AVCapturePhotoCaptureDelegate>

@property (nonatomic, weak) id<CameraDelegate>delegate;
@property (nonatomic) void (^captureAnimation)(void);

@end
