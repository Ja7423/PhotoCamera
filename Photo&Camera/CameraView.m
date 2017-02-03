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

@property (strong, nonatomic)Button *ShutterButton;
@property (strong, nonatomic)Button *FlashButton;
@property (strong, nonatomic)Button *SwitchButton;
@property (strong, nonatomic)Button *CancelButton;

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
        self.ShutterButton = [[Button alloc]init];
        self.ShutterButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.21, self.bounds.size.width * 0.21};
        self.ShutterButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height*0.875);
        self.ShutterButton.tag = ShutterButtonTag;
        self.ShutterButton.backgroundColor = [UIColor clearColor];
        [self.ShutterButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.ShutterButton];
        
        
        self.FlashButton = [[Button alloc]init];
        self.FlashButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.10, self.bounds.size.width * 0.10};
        self.FlashButton.center = CGPointMake(self.frame.size.width * 0.90, self.frame.size.height*0.10);
        self.FlashButton.tag = FlashButtonTag;
        self.FlashButton.backgroundColor = [UIColor clearColor];
        [self.FlashButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.FlashButton];
        
        
        self.SwitchButton = [[Button alloc]init];
        self.SwitchButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.10, self.bounds.size.width * 0.10};
        self.SwitchButton.center = CGPointMake(self.frame.size.width *0.90, self.frame.size.height*0.925);
        self.SwitchButton.tag = SwitchButtonTag;
        self.SwitchButton.backgroundColor = [UIColor clearColor];
        [self.SwitchButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.SwitchButton];
        
        
        self.CancelButton = [[Button alloc]init];
        self.CancelButton.frame = (CGRect){0, 0, self.bounds.size.width * 0.10, self.bounds.size.width * 0.10};
        self.CancelButton.center = CGPointMake(self.frame.size.width *0.10, self.frame.size.height*0.10);
        self.CancelButton.tag = CancelButtonTag;
        self.CancelButton.backgroundColor = [UIColor clearColor];
        [self.CancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.CancelButton];
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
        else if (sender.tag == FlashButtonTag)
        {
                
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
