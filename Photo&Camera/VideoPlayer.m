//
//  VideoPlayer.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/14.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "VideoPlayer.h"

@interface VideoPlayer ()
{
        Photo * _photo;
}

@property (nonatomic) AVPlayerViewController * playerViewController;
@property (nonatomic) PHAsset * asset;

@end


@implementation VideoPlayer

#pragma mark - public method
+ (VideoPlayer *)videoPlayerWithAsset:(PHAsset *)asset
{
        return [[VideoPlayer alloc]initWithAsset:asset];
}

- (instancetype)initWithAsset:(PHAsset *)asset
{
        self = [super init];
        
        if (self)
        {
                _playerViewController = [[AVPlayerViewController alloc]init];
                _photo = [[Photo alloc]init];
                _asset = asset;
        }
        
        return self;
}

- (void)getPlayerViewController:(void (^) (AVPlayerViewController *))completionHandler
{
        if (_asset)
        {
                [_photo getVideoWithAsset:_asset completion:^(AVPlayerItem *playerItem) {
                        
                        _playerViewController.player = [AVPlayer playerWithPlayerItem:playerItem];
                        _playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
                        _playerViewController.showsPlaybackControls = YES;
                        _playerViewController.view.clipsToBounds = YES;
                        
                        completionHandler(_playerViewController);
                }];
        }
}


@end
