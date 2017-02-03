//
//  PhotoPreviewCollectionViewCell.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/8.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "PhotoPreviewCollectionViewCell.h"

@interface PhotoPreviewCollectionViewCell () <UIScrollViewDelegate>
{
        UITapGestureRecognizer *_singleTap;
        UITapGestureRecognizer *_doubleTap;
}

@end

@implementation PhotoPreviewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
        self = [super initWithFrame:frame];
        
        if (self)
        {
                [self configureView];
        }
        
        return self;
}

- (void)setCellModel:(AssetModel *)cellModel
{
        _cellModel = cellModel;
        
        if (_cellModel.mediaType == MediaTypeVideo)
                _scrollView.maximumZoomScale = 1.0;
}

- (void)configureView
{
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
        [self.contentView addSubview:_scrollView];
        
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
        _imageContainerView.backgroundColor = [UIColor greenColor];
        [_scrollView addSubview:_imageContainerView];
        
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.clipsToBounds = YES;
        [_imageContainerView addSubview:_photoImageView];
}

- (void)setPlayButton:(UIButton *)playButton
{
        dispatch_async(dispatch_get_main_queue(), ^{
                
                _playButton = playButton;
                [_playButton setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
                [self addSubview:_playButton];
        });
}

- (void)releaseUI
{
        if (_cellModel.mediaType == MediaTypeVideo && _playButton)
        {
                [_playButton removeFromSuperview];
                _playButton = nil;
        }
}


- (void)resizeSubviews
{
        CGRect frame = _imageContainerView.frame;
        frame.origin = CGPointZero;
        frame.size.width = _scrollView.frame.size.width;
        
        UIImage *image = _photoImageView.image;
        CGFloat height = image.size.height / (image.size.width / _scrollView.frame.size.width);
        
        if (height < 1 || isnan(height) || (height > self.frame.size.height))
                height = self.frame.size.height;

        frame.size.height = floor(height);

        _imageContainerView.frame = frame;
        _imageContainerView.center = CGPointMake(_imageContainerView.center.x, self.frame.size.height / 2);
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, MAX(_imageContainerView.frame.size.height, self.frame.size.height));
        [_scrollView scrollRectToVisible:self.bounds animated:NO];
        _scrollView.alwaysBounceVertical = _imageContainerView.frame.size.height <= self.frame.size.height ? NO : YES;
        
        _photoImageView.frame = _imageContainerView.bounds;
}

#pragma mark - gesture
- (void)addGesture
{
        _singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
        [self addGestureRecognizer:_singleTap];
        
        _doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:_doubleTap];
        
        [_singleTap requireGestureRecognizerToFail:_doubleTap];
}

- (void)removeGesture
{
        [self removeGestureRecognizer:_singleTap];
        [self removeGestureRecognizer:_doubleTap];
        
        _singleTap = nil;
        _doubleTap = nil;
}

- (void)zoomScale:(CGPoint)touchLocation
{
        if (_cellModel.mediaType == MediaTypeVideo)
                return;
        
        if (_scrollView.zoomScale != _scrollView.minimumZoomScale)
        {
                [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
        }
        else
        {
                CGFloat newZoomScale = ((_scrollView.maximumZoomScale + _scrollView.minimumZoomScale) / 2);
                CGFloat xsize = self.bounds.size.width / newZoomScale;
                CGFloat ysize = self.bounds.size.height / newZoomScale;
                [_scrollView zoomToRect:CGRectMake(touchLocation.x - xsize/2, touchLocation.y - ysize/2, xsize, ysize) animated:YES];
        }
}

- (void)didTap:(UITapGestureRecognizer *)gesture
{
        switch (gesture.numberOfTapsRequired) {
                case GestureTypeSingleTap:
                        if (_delegate &&[_delegate respondsToSelector:@selector(PhotoPreviewCollectionViewCell:didDetectGestureType:GestureRecognizer:)])
                        {
                                [_delegate PhotoPreviewCollectionViewCell:self didDetectGestureType:GestureTypeSingleTap GestureRecognizer:gesture];
                        }
                        
                        break;
                case GestureTypeDoubleTap:
                        if (_delegate &&[_delegate respondsToSelector:@selector(PhotoPreviewCollectionViewCell:didDetectGestureType:GestureRecognizer:)])
                        {
                                [_delegate PhotoPreviewCollectionViewCell:self didDetectGestureType:GestureTypeDoubleTap GestureRecognizer:gesture];
                        }
                        
                        break;
                default:
                        break;
        }
}

#pragma mark - scroll view delegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
        return _imageContainerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
        CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        _imageContainerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end
