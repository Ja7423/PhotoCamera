//
//  Camera.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "Camera.h"

@interface Camera ()

@property (nonatomic) dispatch_queue_t serialQueue;
@property (nonatomic, strong)CameraDelegateManager *manager;
@property (nonatomic) AVCapturePhotoOutput *photoOutput;
@property (nonatomic) void (^switchAnimation)(void);

@end

static Camera * _camera = nil;

@implementation Camera

#pragma mark - public method
+ (Camera *)sharedInstance
{
        if (!_camera)
        {
                _camera = [[Camera alloc]init];
        }
        
        return _camera;
}


- (instancetype)init
{
        self = [super init];
        
        if (self) {
                
                _previewLayer = [[AVCaptureVideoPreviewLayer alloc]init];
                _captureSession = [[AVCaptureSession alloc]init];
                [self configureCaptureSession];
                
                _serialQueue = dispatch_queue_create("SerialQueue", NULL);
        }
        
        return self;
}

+ (void)CheckCameraIsAvailable
{
        AVAuthorizationStatus Status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (Status) {
                case AVAuthorizationStatusNotDetermined:
                        NSLog(@"AVAuthorizationStatusNotDetermined");
                        [self RequestCameraPermission];
                        break;
                case AVAuthorizationStatusRestricted:
                        NSLog(@"AVAuthorizationStatusRestricted");
                        break;
                case AVAuthorizationStatusDenied:
                        NSLog(@"AVAuthorizationStatusDenied");
                        break;
                case AVAuthorizationStatusAuthorized:
                        NSLog(@"AVAuthorizationStatusAuthorized");
                        break;
                default:
                        break;
        }
}

+ (void)RequestCameraPermission
{
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:nil];
}

- (void)launchCamera
{
        [self.captureSession startRunning];
}


#pragma mark action
- (void)capturePictureWithAnimation:(void (^)(void))animation
{
        self.manager = [[CameraDelegateManager alloc]init];
        
        if (animation)
                self.manager.captureAnimation = animation;
        
        AVCaptureVideoOrientation orientation = self.previewLayer.connection.videoOrientation;
        
        dispatch_async(self.serialQueue, ^{
        
                AVCapturePhotoSettings *photoSettings = [self configurePhotoSettings];
                
                AVCaptureConnection*captureConnection = [self.photoOutput connectionWithMediaType:AVMediaTypeVideo];
                captureConnection.videoOrientation = orientation;
                
                [self.photoOutput capturePhotoWithSettings:photoSettings delegate:_manager];
        });
}

- (void)switchCameraWithAnimation:(void (^)(void))animation
{
        if (animation)
                self.switchAnimation = animation;
        
        AVCaptureDeviceInput *currentDeviceInput = self.captureSession.inputs[0];
        AVCaptureDevice *currentDevice = currentDeviceInput.device;
        
        switch (currentDevice.position) {
                case AVCaptureDevicePositionUnspecified:
                case AVCaptureDevicePositionBack:
                        [self changeCameraToPositionFront];
                        break;
                case AVCaptureDevicePositionFront:
                        [self changeCameraToPositionBack];
                        break;
                default:
                        break;
        }
}

- (void)changeCameraToPositionBack
{
        NSError *error = nil;
        AVCaptureDevice *device = [self configureCaptrueDeviceWithPosition:AVCaptureDevicePositionBack];
        AVCaptureDeviceInput *newDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        AVCaptureDeviceInput *currentDeviceInput = self.captureSession.inputs[0];
        
        if (error) return;
        
        [self.captureSession beginConfiguration];
        
        [self.captureSession removeInput:currentDeviceInput];
        
        if ([self.captureSession canAddInput:newDeviceInput])
                [self.captureSession addInput:newDeviceInput];
        else
                [self.captureSession addInput:currentDeviceInput];
        
        [self.captureSession commitConfiguration];
        
        if (self.switchAnimation)
                self.switchAnimation();
}

- (void)changeCameraToPositionFront
{
        NSError *error = nil;
        AVCaptureDevice *device = [self configureCaptrueDeviceWithPosition:AVCaptureDevicePositionFront];
        AVCaptureDeviceInput *newDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        AVCaptureDeviceInput *currentDeviceInput = self.captureSession.inputs[0];
        
        if (error)
                return;
        
        [self.captureSession beginConfiguration];
        
        [self.captureSession removeInput:currentDeviceInput];
        
        if ([self.captureSession canAddInput:newDeviceInput])
                [self.captureSession addInput:newDeviceInput];
        else
                [self.captureSession addInput:currentDeviceInput];
        
        if (self.switchAnimation)
                self.switchAnimation();
        
        [self.captureSession commitConfiguration];
}

- (void)closeCamera
{
        [self.captureSession stopRunning];
}

#pragma mark - preview layer
- (void)addVideoPreviewLayer
{
        self.previewLayer.session = self.captureSession;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self setPreviewLayerConnection];
        [self setPreviewLayerEffect];
}

- (void)setPreviewLayerEffect
{
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:0.6];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        [self.previewLayer addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
}

- (void)setPreviewLayerSize:(CGRect)rect
{
        [self.previewLayer setFrame:rect];
}

- (void)setPreviewLayerConnection
{
        UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
        if ( statusBarOrientation != UIInterfaceOrientationUnknown )
                self.previewLayer.connection.videoOrientation = (AVCaptureVideoOrientation)statusBarOrientation;
        else
                self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        
        
        /*      UIInterfaceOrientation
         UIInterfaceOrientationUnknown                  = UIDeviceOrientationUnknown,
         UIInterfaceOrientationPortrait                    = UIDeviceOrientationPortrait,
         UIInterfaceOrientationPortraitUpsideDown  = UIDeviceOrientationPortraitUpsideDown,
         UIInterfaceOrientationLandscapeLeft          = UIDeviceOrientationLandscapeRight,
         UIInterfaceOrientationLandscapeRight        = UIDeviceOrientationLandscapeLeft
         */
        
        /*      AVCaptureVideoOrientation
         AVCaptureVideoOrientationPortrait                    = 1,
         AVCaptureVideoOrientationPortraitUpsideDown  = 2,
         AVCaptureVideoOrientationLandscapeRight        = 3,
         AVCaptureVideoOrientationLandscapeLeft         = 4,
         */
}

#pragma mark - initial camera
- (AVCaptureDevice *)configureCaptrueDeviceWithPosition:(AVCaptureDevicePosition)position
{
        AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInDuoCamera mediaType:AVMediaTypeVideo position:position];
        if ( ! videoDevice )
        {
                // If the back dual camera is not available, default to the back wide angle camera.
                videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:position];
        }
        
        return videoDevice;
}


- (AVCaptureDeviceInput *)configureDeviceInput
{
        NSError *error = nil;
        AVCaptureDevice *device = [self configureCaptrueDeviceWithPosition:AVCaptureDevicePositionBack];
        AVCaptureDeviceInput *input= [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        return input;
}


- (AVCapturePhotoOutput *)configurePhotoOutput
{
        AVCapturePhotoOutput *output = [[AVCapturePhotoOutput alloc]init];
        
        output.highResolutionCaptureEnabled = YES;
        
        if (output.livePhotoCaptureSupported)
                output.livePhotoCaptureEnabled = YES;
        
        return output;
}

- (void)configureCaptureSession
{
        /*
           Changes to the capture session configuration should be grouped together and bracketed between calls to beginConfiguration and commitConfiguration. The capture session should only need to be configured once, unless you are making major alterations such as adding or removing inputs or outputs.
         */
        [self.captureSession beginConfiguration];
        
        // add input
        AVCaptureDeviceInput *input= [self configureDeviceInput];
        if (input)
        {
                if ([self.captureSession canAddInput:input])
                        [self.captureSession addInput:input];
        }
        else
        {
                [self.captureSession commitConfiguration];
                return;
        }
        
        // process preview layer
        [self addVideoPreviewLayer];
        
        // add output
        AVCapturePhotoOutput *output = [self configurePhotoOutput];
        if (output)
        {
                if ([self.captureSession canAddOutput:output])
                {
                        [self.captureSession addOutput:output];
                        self.photoOutput = output;
                }
        }
        else
        {
                [self.captureSession commitConfiguration];
                return;
        }
        
        /* 
            sessionPreset defines the resolution and quality level of the video output. For most photo capture purposes, it is best set to AVCaptureSessionPresetPhoto to deliver high resolution photo quality output.
         */
        self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
        
        [self.captureSession commitConfiguration];
}

- (AVCapturePhotoSettings *)configurePhotoSettings
{
        /*
         This dictionary must contain a value for either the kCVPixelBufferPixelFormatTypeKey (to request an uncompressed format) or AVVideoCodecKey (to request a compressed format such as JPEG) key, but not both.
         
         If this dictionary has the kCVPixelBufferPixelFormatTypeKey key, the value for that key must be listed in the photo output’s availablePhotoPixelFormatTypes array.
         
         If this dictionary has the AVVideoCodecKey key, the value for that key must be listed in the photo output’s availablePhotoCodecTypes array.
         */
        
        NSDictionary *settingFormat = @{AVVideoCodecKey : AVVideoCodecJPEG};
        AVCapturePhotoSettings *photoSettings = [AVCapturePhotoSettings photoSettingsWithFormat:settingFormat];
        
        NSArray *supportedFlashModes = self.photoOutput.supportedFlashModes;
        
        if (supportedFlashModes.count == 1)
                photoSettings.flashMode = AVCaptureFlashModeOff;
        else
                photoSettings.flashMode = AVCaptureFlashModeAuto;
        
        photoSettings.highResolutionPhotoEnabled = YES;
        
        return photoSettings;
}

@end
