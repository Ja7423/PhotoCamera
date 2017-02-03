//
//  PhotoMapAnnotationView.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2017/1/18.
//  Copyright © 2017年 何家瑋. All rights reserved.
//

#import "PhotoMapAnnotationView.h"

@interface PhotoMapAnnotationView ()

@property (nonatomic) UILabel *countLabel;
@property (nonatomic) UIImageView *labelImageView;

@end

@implementation PhotoMapAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
        self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        
        if (self)
        {
                self.frame = CGRectMake(0, 0, 50, 50);
                [self initialUI];
        }
        
        return self;
}

- (void)initialUI
{
        [self configurePhotoImageView];
        [self configureLabelImage];
        [self configureCountLabel];
}

- (void)configurePhotoImageView
{
        _photoImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        [self addSubview:_photoImageView];
}

- (void)configureLabelImage
{
        _labelImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CircleBlue"]];
        _labelImageView.center = CGPointMake(CGRectGetMaxX(_photoImageView.frame), 0);
        [_photoImageView addSubview:_labelImageView];
}

- (void)configureCountLabel
{
        _countLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _countLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.adjustsFontSizeToFitWidth = YES;
        _countLabel.minimumScaleFactor = 2;
        _countLabel.numberOfLines = 1;
        _countLabel.font = [UIFont boldSystemFontOfSize:12];
        _countLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _countLabel.center = CGPointMake(CGRectGetMaxX(_photoImageView.frame), 0);
        [_photoImageView addSubview:_countLabel];
}

- (void)setCount:(NSUInteger)count
{
        _count = count;
        
        self.countLabel.text = [@(count) stringValue];
}

- (void)setUniqueLocation:(BOOL)uniqueLocation
{
        _uniqueLocation = uniqueLocation;
}

- (void)setBlue:(BOOL)blue
{
        _blue = blue;
        [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
