//
//  Camera.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CameraDelegateManager.h"

@interface Camera : NSObject

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) NSData *photoData;


+ (Camera *)sharedInstance;
+ (void)CheckCameraIsAvailable;
- (void)launchCamera;

- (void)capturePictureWithAnimation:(void (^)(void))animation;
- (void)switchCameraWithAnimation:(void (^)(void))animation;
- (void)closeCamera;

- (void)setPreviewLayerSize:(CGRect)rect;

@end
