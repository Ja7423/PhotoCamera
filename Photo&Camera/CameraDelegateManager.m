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
        NSData *photoData;
}

@end

@implementation CameraDelegateManager

#pragma mark - AVCapturePhotoCaptureDelegate method
- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings
{
        if (self.captureAnimation)
                self.captureAnimation();
        
        photoData = nil;
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error
{
        if (error) {
                NSLog(@"error : %@", error.description);
                return;
        }
        
        photoData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings error:(nullable NSError *)error
{
        /*
         it’s guaranteed to occur last, and to use this as the point where you handle the results of the photo capture.
         */
        
        PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        
        [photoLibrary performChanges:^{
        
                PHAssetCreationRequest *photoRequest = [PHAssetCreationRequest creationRequestForAsset];
                [photoRequest addResourceWithType:PHAssetResourceTypePhoto data:photoData options:nil];
                
                
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
                
                if ([self.delegate respondsToSelector:@selector(CameraDelegate:didFinishCapturePhoto:withError:)])
                        [self.delegate CameraDelegate:self didFinishCapturePhoto:photoData withError:error];
                
        }];
}


@end
