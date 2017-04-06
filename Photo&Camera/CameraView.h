//
//  CameraView.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/8.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Camera.h"
#import "Button.h"
#import "Define.h"

@class CameraView;
@protocol CameraViewDelegate <NSObject>

@optional
- (void)cameraView:(CameraView *)cameraView didClickButton:(UIButton *)button;

@end

@interface CameraView : UIView

@property (weak, nonatomic) id <CameraViewDelegate> delegate;

@end
