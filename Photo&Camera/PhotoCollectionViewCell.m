//
//  PhotoCollectionViewCell.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/6.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()

@end

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
        self = [super initWithFrame:frame];
        
        if (self)
        {
                _photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
                _photoImageView.clipsToBounds = YES;
                _photoImageView.backgroundColor = [UIColor blackColor];
                [self.contentView addSubview:_photoImageView];
        }
        
        return self;
}

- (void)layoutSubviews
{
        [super layoutSubviews];
}

- (UILabel *)timeLabel
{
        if (!_timeLabel)
        {
                CGFloat YPoint = _photoImageView.frame.size.height * 0.75;
                
                _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, YPoint , _photoImageView.frame.size.width, _photoImageView.frame.size.height *0.25)];
                
                _timeLabel.backgroundColor = [UIColor blackColor];
                _timeLabel.font = [UIFont boldSystemFontOfSize:11];
                _timeLabel.textColor = [UIColor whiteColor];
                _timeLabel.textAlignment = NSTextAlignmentRight;
                
                [self.contentView addSubview:_timeLabel];
                [self.contentView bringSubviewToFront:_timeLabel];
        }
        
        return _timeLabel;
}

@end
