//
//  Button.m
//  CoreGraphics
//
//  Created by 何家瑋 on 2016/11/21.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "Button.h"

@implementation Button


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

        switch (self.tag) {
                case ShutterButtonTag:
                        [self drawShutterButton:rect];
                        break;
                case SwitchButtonTag:
                        [self drawSwitchButtonWithFrame:rect];
                        break;
                case FlashButtonTag:
                        [self drawFlashButton:rect];
                        break;
                case CancelButtonTag:
                        [self drawCancelButtonWithFrame:rect];
                        break;
                default:
                        break;
        }

}

- (void)drawShutterButton:(CGRect)rect
{
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Color Declarations
        UIColor* color0 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* color1 = [UIColor colorWithRed: 0.812 green: 0.812 blue: 0.812 alpha: 0.62];
        
        
        // Subframes
        CGRect page1 = CGRectMake(CGRectGetMinX(rect) + floor(CGRectGetWidth(rect) * 0.03691 + 0.12) + 0.38, CGRectGetMinY(rect) + floor(CGRectGetHeight(rect) * 0.03466 + 0.43) + 0.07, floor(CGRectGetWidth(rect) * 0.96691 + 0.12) - floor(CGRectGetWidth(rect) * 0.03691 + 0.12), floor(CGRectGetHeight(rect) * 0.96466 + 0.43) - floor(CGRectGetHeight(rect) * 0.03466 + 0.43));
        
        
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.62);
        CGContextBeginTransparencyLayer(context, NULL);
        
        
        // bezierPathWithOvalInRect() 畫橢圓形
        UIBezierPath* cameraShutterVectorPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(page1) + floor(CGRectGetWidth(page1) * 0.00000 + 0.5), CGRectGetMinY(page1) + floor(CGRectGetHeight(page1) * 0.00000 + 0.5), floor(CGRectGetWidth(page1) * 1.00000 + 0.5) - floor(CGRectGetWidth(page1) * 0.00000 + 0.5), floor(CGRectGetHeight(page1) * 1.00000 + 0.5) - floor(CGRectGetHeight(page1) * 0.00000 + 0.5))];
        
        [color1 setFill]; // 設定要填滿的顏色
        [cameraShutterVectorPath fill]; // 填滿
        
        [color0 setStroke]; // 設定線條顏色
        cameraShutterVectorPath.lineWidth = 3;
        [cameraShutterVectorPath stroke]; //畫線
        
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
}

- (void)drawFlashButton:(CGRect)rect
{
        // General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Color Declarations
        UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        // Subframes
        CGRect page1 = CGRectMake(CGRectGetMinX(rect) + floor(CGRectGetWidth(rect) * 0.16636 + 0.23) + 0.27, CGRectGetMinY(rect) + floor(CGRectGetHeight(rect) * 0.03852 + 0.2) + 0.3, floor(CGRectGetWidth(rect) * 0.83136 + 0.23) - floor(CGRectGetWidth(rect) * 0.16636 + 0.23), floor(CGRectGetHeight(rect) * 0.96352 + 0.2) - floor(CGRectGetHeight(rect) * 0.03852 + 0.2));
        
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.8);
        CGContextBeginTransparencyLayer(context, NULL);
        
        
        // FlashVector Drawing
        UIBezierPath* flashVectorPath = [UIBezierPath bezierPath];
        [flashVectorPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
        [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.17944 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.45268 * CGRectGetHeight(page1))];
        [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.45896 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55598 * CGRectGetHeight(page1))];
        [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
        [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.90397 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55854 * CGRectGetHeight(page1))];
        [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.64845 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.45124 * CGRectGetHeight(page1))];
        [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
        [flashVectorPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
        [flashVectorPath closePath];
        flashVectorPath.miterLimit = 4;
        
        flashVectorPath.usesEvenOddFillRule = YES;
        
        [color setFill];
        [flashVectorPath fill];
        
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
}

- (void)drawSwitchButtonWithFrame: (CGRect)rect
{
        // General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Color Declarations
        UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        // Subframes
        CGRect page1 = CGRectMake(CGRectGetMinX(rect) + floor(CGRectGetWidth(rect) * 0.02908 - 0.32) + 0.82, CGRectGetMinY(rect) + floor(CGRectGetHeight(rect) * 0.01817 + 0.13) + 0.37, floor(CGRectGetWidth(rect) * 0.97408 - 0.32) - floor(CGRectGetWidth(rect) * 0.02908 - 0.32), floor(CGRectGetHeight(rect) * 0.98317 + 0.13) - floor(CGRectGetHeight(rect) * 0.01817 + 0.13));
        
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.8);
        CGContextBeginTransparencyLayer(context, NULL);
        
        // SwitchButton Drawing
        UIBezierPath* SwitchButtonPath = [UIBezierPath bezierPath];
        [SwitchButtonPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.71159 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.26224 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.74989 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.28882 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.25052 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.23289 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.26224 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.69811 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.28882 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.21947 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.73432 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.25052 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.71159 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.69811 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.74989 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.76367 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.73432 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.78093 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.29844 * CGRectGetHeight(page1))];
        [SwitchButtonPath closePath];
        [SwitchButtonPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.64822 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49827 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.58197 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.64822 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.42102 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.63816 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.64822 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.57553 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.58197 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.63816 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.35229 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49827 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.41853 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.63816 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.35229 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.57553 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.35229 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.42102 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.41853 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.35839 * CGRectGetHeight(page1))];
        [SwitchButtonPath closePath];
        [SwitchButtonPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.61199 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49828 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56196 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.61199 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.43994 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.60391 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.61199 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55662 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56196 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.60391 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.38852 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49828 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43854 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.60391 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.38852 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55662 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.50025 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.38852 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.43994 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43854 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.39265 * CGRectGetHeight(page1))];
        [SwitchButtonPath closePath];
        [SwitchButtonPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.55331 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93945 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.46313 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.55331 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95963 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87890 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.55331 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91927 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.46313 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87890 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93945 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43560 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87890 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91927 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95963 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43560 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44509 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1))];
        [SwitchButtonPath closePath];
        [SwitchButtonPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54376 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96935 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56951 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94150 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.55898 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95916 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56951 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94915 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.53831 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91011 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56951 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93296 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.55641 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.92149 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.93710 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49845 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.76177 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.89176 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.93710 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.71446 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.80324 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.20083 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.93710 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.38156 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.88576 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.27600 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56357 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08956 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.73905 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.14237 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.65600 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.10229 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56113 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06055 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56233 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.07897 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56113 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06849 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.56380 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.02956 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.56113 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.05211 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.56248 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04081 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49845 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.80982 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.05919 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.25782 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54376 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96936 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.74557 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.79941 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94839 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54376 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96935 * CGRectGetHeight(page1))];
        [SwitchButtonPath closePath];
        [SwitchButtonPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43424 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96708 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49844 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.18917 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93664 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.73843 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.46250 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.02706 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.24931 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.20387 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04519 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.42790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06054 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.44266 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.03911 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.42790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.05148 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.45250 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08762 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.42790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06800 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43790 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.07770 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.06290 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49844 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.23344 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.11001 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.06290 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.28540 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43318 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.90687 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.06290 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.70518 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.22349 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87646 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43628 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94150 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43462 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91929 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43628 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.93215 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43424 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96708 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.43628 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.94858 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.43533 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95769 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.43424 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96708 * CGRectGetHeight(page1))];
        [SwitchButtonPath closePath];
        [SwitchButtonPath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44090 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06055 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.53107 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.44090 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08073 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.44090 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04037 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.53107 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.06055 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.55860 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04037 * CGRectGetHeight(page1))];
        [SwitchButtonPath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08073 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.55860 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1))];
        [SwitchButtonPath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54911 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12110 * CGRectGetHeight(page1))];
        [SwitchButtonPath closePath];
        SwitchButtonPath.miterLimit = 4;
        
        SwitchButtonPath.usesEvenOddFillRule = YES;
        
        [color2 setFill];
        [SwitchButtonPath fill];
        
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
}

- (void)drawCancelButtonWithFrame: (CGRect)rect
{
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        
        //// Subframes
        CGRect page1 = CGRectMake(CGRectGetMinX(rect) + floor(CGRectGetWidth(rect) * 0.07703 + 0.09) + 0.41, CGRectGetMinY(rect) + floor(CGRectGetHeight(rect) * 0.07659 + 0.5) + 0, floor(CGRectGetWidth(rect) * 0.92543 + 0.41) - floor(CGRectGetWidth(rect) * 0.07703 + 0.09) - 0.32, floor(CGRectGetHeight(rect) * 0.92499 - 0.18) - floor(CGRectGetHeight(rect) * 0.07659 + 0.5) + 0.68);
        
        CGContextSaveGState(context);
        CGContextSetAlpha(context, 0.8);
        CGContextBeginTransparencyLayer(context, NULL);
        
        
        //// Shape Drawing
        UIBezierPath* shapePath = UIBezierPath.bezierPath;
        [shapePath moveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.00789 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.13838 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.32328 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.45377 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.32225 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.55004 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.37044 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.50178 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.36996 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.50197 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.87228 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.12772 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 1.00000 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.03587 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.92109 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.07891 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.96413 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.44996 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.67775 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.54623 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.67672 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.49833 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.62970 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.49837 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.62962 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.86162 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.99211 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.99211 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.86162 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.91121 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.95519 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.95519 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.91121 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.67672 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.54623 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.67775 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.44996 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.62944 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49883 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.62919 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.49872 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 1.00000 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.12772 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.87228 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00000 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.96413 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.07891 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.92109 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.03587 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.55004 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.32225 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.45377 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.32328 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.50206 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.37032 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.50186 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.37051 * CGRectGetHeight(page1))];
        [shapePath addLineToPoint: CGPointMake(CGRectGetMinX(page1) + 0.13838 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.00789 * CGRectGetHeight(page1))];
        [shapePath addCurveToPoint: CGPointMake(CGRectGetMinX(page1) + 0.00789 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.13838 * CGRectGetHeight(page1)) controlPoint1: CGPointMake(CGRectGetMinX(page1) + 0.08879 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.04481 * CGRectGetHeight(page1)) controlPoint2: CGPointMake(CGRectGetMinX(page1) + 0.04481 * CGRectGetWidth(page1), CGRectGetMinY(page1) + 0.08879 * CGRectGetHeight(page1))];
        [shapePath closePath];
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = YES;
        
        [color3 setFill];
        [shapePath fill];
        
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);

}


@end
