//
//  test.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "test.h"

@implementation test
{
        UIButton *_addBtn, *_subBtn;
        UIView  *_backView;
        UISlider *_speedSlider;
        UILabel *_showLabel;
        
        NSTimer *_labelActionTimer;
        NSLayoutConstraint *_thumbConstraint;
}

- (instancetype) init {
        
        self = [super init];
        
        if (self) {
                [self setUI];
                [self setConstriant];
                Result = 4;
                _speedSlider.value = Result;
                [self setSliderValue:Result];
        }
        
        return self;
}
- (void) setUI {
        
        _addBtn = [[UIButton alloc] init];
        _subBtn = [[UIButton alloc] init];
        _backView = [[UIView alloc] init];
        _speedSlider = [[UISlider alloc] init];
        _showLabel = [[UILabel alloc] init];
        
        [_speedSlider setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [_speedSlider setMinimumTrackImage:[[self imageFromColor:[UIColor redColor]] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0] forState:UIControlStateNormal];
        [_speedSlider setMaximumTrackImage:[[self imageFromColor:[UIColor whiteColor]] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0] forState:UIControlStateNormal];
        
        CGSize size = CGSizeMake(49, 49);
        CGPoint offset = CGPointMake(0, 0);
        UIImageView *sliderImage = [[UIImageView alloc]init];
        sliderImage.image = [self imageWithImage:[UIImage imageNamed:@"rectangle"] scaledToSize:size andOffSet:offset];
        [sliderImage setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [_speedSlider setThumbImage:sliderImage.image forState:UIControlStateNormal];
        [_speedSlider setMinimumValue:0];
//        [_speedSlider setMaximumValue: (int)speedArray.count - 1];
        
        [_addBtn setImage:[UIImage imageNamed:@"plusButton"] forState:UIControlStateNormal];
        [_subBtn setImage:[UIImage imageNamed:@"minusBtn"] forState:UIControlStateNormal];
        
        [_addBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_subBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_subBtn setTitle:@"-" forState:UIControlStateNormal];
        
        [_addBtn.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
        [_subBtn.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
        
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_subBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview: _addBtn];
        [self addSubview: _subBtn];
        [self addSubview: _backView];
        [self addSubview: _speedSlider];
        [self addSubview: _showLabel];
        
        [_addBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_subBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_backView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_speedSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_showLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        
        [_addBtn addTarget:self action:@selector(addFunction) forControlEvents:UIControlEventTouchUpInside];
        [_subBtn addTarget:self action:@selector(SubFunction) forControlEvents:UIControlEventTouchUpInside];
        [_speedSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}
- (void) setConstriant {
        [self setEdge:self view:_addBtn attr:NSLayoutAttributeLeft constant:0.0];
        [self setEdge:self view:_addBtn attr:NSLayoutAttributeTop constant:0.0];
        [self setEdge:self view:_addBtn attr:NSLayoutAttributeRight constant:0.0];
        
        [self setEdge:self view:_subBtn attr:NSLayoutAttributeLeft constant:0.0];
        [self setEdge:self view:_subBtn attr:NSLayoutAttributeBottom constant:0.0];
        [self setEdge:self view:_subBtn attr:NSLayoutAttributeRight constant:0.0];
        
        [self setEdge:self view:_backView attr:NSLayoutAttributeLeft constant:0.0];
        [self setEdge:self view:_backView attr:NSLayoutAttributeRight constant:0.0];
        
        [self setEdge:self view:_speedSlider attr:NSLayoutAttributeCenterX constant:0.0];
        [self setEdge:self view:_speedSlider attr:NSLayoutAttributeCenterY constant:0.0];
        
        [self setEdge:self view:_showLabel attr:NSLayoutAttributeCenterY constant:0.0];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_showLabel
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0
                                                          constant:100.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_showLabel
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0
                                                          constant:20.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_showLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_speedSlider
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_backView
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0 constant:0.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_speedSlider
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_backView
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0 constant:0.0]];
        NSNumber *heightNum = @(40);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_addBtn(==heightNum)]-[_backView]-[_subBtn(==heightNum)]"
                                                                     options:0
                                                                     metrics:NSDictionaryOfVariableBindings(heightNum)
                                                                       views:NSDictionaryOfVariableBindings(_addBtn,_backView,    _subBtn)]];
}

static int Result;

- (void) addFunction {
        if (Result > 0) {
                Result --;
                [_speedSlider setValue:Result];
                [self setSliderValue:Result];
        }
}

- (void) SubFunction {
//        if (Result < (int)speedArray.count - 1) {
//                Result ++;
//                [_speedSlider setValue:Result];
//                [self setSliderValue:Result];
//        }
}

- (void) valueChange:(id) sender {
        Result = (int)_speedSlider.value;
        [self setSliderValue:Result];
}

- (void) setSliderValue:(int) index{
        
//        [_showLabel setText:[NSString stringWithFormat:@"%@",speedArray[(int)speedArray.count- 1 - index]]];
        
}

- (void)setEdge:(UIView*)superview view:(UIView*)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
        [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:superview attribute:attr multiplier:1.0 constant:constant]];
}

- (UIImage *)imageFromColor:(UIColor *)color {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
}
- (UIImage *)circleImageFromColor:(UIColor *)color {
        CGRect borderRect = CGRectMake(0.0, 0.0, 30.0, 30.0);
        UIGraphicsBeginImageContext(borderRect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextStrokeEllipseInRect(context, borderRect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize andOffSet:(CGPoint)offSet{
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [image drawInRect:CGRectMake(offSet.x, offSet.y, newSize.width-offSet.x, newSize.height-offSet.y)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
}

@end
