//
//  PhotoPreviewCollectionViewCell.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/8.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetModel.h"
#import "Define.h"

@class PhotoPreviewCollectionViewCell;
@protocol PhotoPreviewCollectionViewCellDelegate <NSObject>

@optional
- (void)PhotoPreviewCollectionViewCell:(PhotoPreviewCollectionViewCell *)cell didDetectGestureType:(GestureTyep)gestureType GestureRecognizer:(UIGestureRecognizer*)gesture;

@end

@interface PhotoPreviewCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <PhotoPreviewCollectionViewCellDelegate> delegate;

@property (nonatomic) AssetModel * cellModel;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *imageContainerView;
@property (nonatomic) UIImageView *photoImageView;

@property (nonatomic) UIButton *playButton;

- (void)releaseUI;

- (void)resizeSubviews;

- (void)addGesture;
- (void)removeGesture;
- (void)zoomScale:(CGPoint)touchLocation;

@end
