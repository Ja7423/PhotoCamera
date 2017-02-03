//
//  AlbumTableViewCell.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/4.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "AlbumTableViewCell.h"

@interface AlbumTableViewCell ()

@end

@implementation AlbumTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)albumImageView
{
        if (!_albumImageView)
        {
                _albumImageView = [[UIImageView alloc]init];
                _albumImageView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
                _albumImageView.contentMode = UIViewContentModeScaleAspectFill;
                _albumImageView.clipsToBounds = YES;
                _albumImageView.backgroundColor = [UIColor blackColor];
                [self.contentView addSubview:_albumImageView];
        }
        
        return _albumImageView;
}

- (UILabel *)albumLabel
{
        if (!_albumLabel)
        {
                _albumLabel = [[UILabel alloc]init];
                _albumLabel.font = [UIFont boldSystemFontOfSize:17];
                _albumLabel.frame = CGRectMake(self.frame.size.height + 30, 0, self.frame.size.width * 0.5, self.frame.size.height);
                _albumLabel.textColor = [UIColor blackColor];
                _albumLabel.textAlignment = NSTextAlignmentLeft;
                [self.contentView addSubview:_albumLabel];
        }
        
        return _albumLabel;
}

- (void)layoutSubviews
{
        [super layoutSubviews];
}

@end
