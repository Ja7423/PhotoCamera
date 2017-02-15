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

- (void)configureTimeLabel
{
        dispatch_async(dispatch_get_main_queue(), ^{
                _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _photoImageView.frame.size.height * 0.75 , _photoImageView.frame.size.width, _photoImageView.frame.size.height *0.25)];
                _timeLabel.backgroundColor = [UIColor blackColor];
                _timeLabel.font = [UIFont boldSystemFontOfSize:11];
                _timeLabel.textColor = [UIColor whiteColor];
                _timeLabel.textAlignment = NSTextAlignmentRight;
                [_timeLabel setText:[NSString stringWithFormat:@"%@", _cellModel.timeDuration]];
                [_photoImageView addSubview:_timeLabel];
        });
}

- (void)releaseTimeLabel
{
        if (_cellModel.mediaType == MediaTypeVideo && _timeLabel)
        {
                [_timeLabel removeFromSuperview];
                _timeLabel = nil;
        }
}

@end
