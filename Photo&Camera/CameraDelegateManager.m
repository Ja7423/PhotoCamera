//
//  CameraDelegateManager.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/23.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "CameraDelegateManager.h"

@interface CameraDelegateManager ()
{
        Photo * _photo;
}

@property (nonatomic) NSData *photoData;

@end


@implementation CameraDelegateManager

#pragma mark - AVCapturePhotoCaptureDelegate method
- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings
{
        if (self.captureAnimation)
                self.captureAnimation();
        
        _photo = [[Photo alloc]init];
        _photoData = nil;
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error
{
        if (error) {
                NSLog(@"error : %@", error.description);
                return;
        }
        
        _photoData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings error:(nullable NSError *)error
{
        /*
         it’s guaranteed to occur last, and to use this as the point where you handle the results of the photo capture.
         */
        
        typeof(self) __weak weakSelf = self;
        [_photo addPhotoData:_photoData completion:^(BOOL success, NSError *error) {
                
                _photo = nil;
                if ([weakSelf.delegate respondsToSelector:@selector(CameraDelegate:didFinishCapturePhoto:withError:)])
                        [weakSelf.delegate CameraDelegate:weakSelf didFinishCapturePhoto:weakSelf.photoData withError:error];
        }];
}


@end
