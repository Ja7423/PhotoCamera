//
//  CameraView.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/8.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "CameraView.h"

@interface CameraView ()
{
        Camera *camera;
}

@property (strong, nonatomic)Button *shutterButton;
@property (strong, nonatomic)Button *flashButton;
@property (strong, nonatomic)Button *switchButton;
@property (strong, nonatomic)Button *cancelButton;

@end

@implementation CameraView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
        
        camera = [Camera sharedInstance];
        [self getPreviewView];
        [self setupUserInterface];
        
        [camera launchCamera];
        
}

- (instancetype)initWithFrame:(CGRect)frame
{
        self = [super initWithFrame:frame];
        
        if (self) {
                self.bounds = frame;
        }
        
        return self;
}

- (void)getPreviewView
{
        [camera setPreviewLayerSize:self.bounds];
        [self.layer addSublayer:camera.previewLayer];
}

- (void)setupUserInterface
{
        self.shutterButton = [[Button alloc]init];
        self.shutterButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.21, self.bounds.size.width * 0.21};
        self.shutterButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height*0.875);
        self.shutterButton.tag = ShutterButtonTag;
        self.shutterButton.backgroundColor = [UIColor clearColor];
        [self.shutterButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shutterButton];
        
        
        self.flashButton = [[Button alloc]init];
        self.flashButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.10, self.bounds.size.width * 0.10};
        self.flashButton.center = CGPointMake(self.frame.size.width * 0.90, self.frame.size.height*0.10);
        self.flashButton.tag = FlashButtonTag;
        self.flashButton.backgroundColor = [UIColor clearColor];
        [self.flashButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.flashButton];
        
        
        self.switchButton = [[Button alloc]init];
        self.switchButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.10, self.bounds.size.width * 0.10};
        self.switchButton.center = CGPointMake(self.frame.size.width *0.90, self.frame.size.height*0.925);
        self.switchButton.tag = SwitchButtonTag;
        self.switchButton.backgroundColor = [UIColor clearColor];
        [self.switchButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.switchButton];
        
        
        self.cancelButton = [[Button alloc]init];
        self.cancelButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.10, self.bounds.size.width * 0.10};
        self.cancelButton.center = CGPointMake(self.frame.size.width *0.10, self.frame.size.height*0.10);
        self.cancelButton.tag = CancelButtonTag;
        self.cancelButton.backgroundColor = [UIColor clearColor];
        [self.cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
}

- (IBAction)buttonClick:(UIButton *)sender
{
        if (sender.tag == ShutterButtonTag)
        {
                [camera capturePictureWithAnimation:^{
                        dispatch_async( dispatch_get_main_queue(), ^{
                                self.layer.opacity = 0.0;
                                [UIView animateWithDuration:0.25 animations:^{
                                        self.layer.opacity = 1.0;
                                }];
                        } );
                }];
        }
        else if (sender.tag == SwitchButtonTag)
        {
                [camera switchCameraWithAnimation:^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                                [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
                        });
                }];
        }
        else if (sender.tag == CancelButtonTag)
        {
                [camera closeCamera];
                [self removeFromSuperview];
        }
}

@end
