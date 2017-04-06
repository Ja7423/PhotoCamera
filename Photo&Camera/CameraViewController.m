//
//  CameraViewController.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2017/4/6.
//  Copyright © 2017年 何家瑋. All rights reserved.
//

#import "CameraViewController.h"
#import "Camera.h"
#import "CameraView.h"

@interface CameraViewController () <CameraViewDelegate>
{
        Camera *camera;
}

@property (nonatomic) CameraView * cameraview;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        [Camera CheckCameraIsAvailable];
        camera = [Camera sharedInstance];
        [camera setPreviewLayerSize:self.view.bounds];
        [camera launchCamera];
        
        _cameraview = [[CameraView alloc]initWithFrame:self.view.bounds];
        _cameraview.delegate = self;
        [_cameraview.layer addSublayer:camera.previewLayer];
        [self.view addSubview:_cameraview];
}


- (void)cameraView:(CameraView *)cameraView didClickButton:(UIButton *)button
{
        if (button.tag == ShutterButtonTag)
        {
                [camera capturePictureWithAnimation:^{
                        dispatch_async( dispatch_get_main_queue(), ^{
                                self.cameraview.layer.opacity = 0.0;
                                [UIView animateWithDuration:0.25 animations:^{
                                        self.cameraview.layer.opacity = 1.0;
                                }];
                        } );
                }];
        }
        else if (button.tag == SwitchButtonTag)
        {
                [camera switchCameraWithAnimation:^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                                [UIView transitionWithView:self.cameraview duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
                        });
                }];
        }
        else if (button.tag == CancelButtonTag)
        {
                [camera closeCamera];
                [self.cameraview removeFromSuperview];
                
                [self dismissViewControllerAnimated:YES completion:nil];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
