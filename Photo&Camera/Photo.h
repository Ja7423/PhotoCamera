//
//  Photo.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "AssetModel.h"
#import "Define.h"

@interface Photo : NSObject
+ (void)CheckPhotoisAvailable;

- (NSArray *)getAlbumList;
- (void)getAlbumPostImageWithSize:(CGSize)size FetchResult:(PHFetchResult *)result completion:(void (^) (UIImage * image))completion;
- (void)getAlbumAssetWithFetchResult:(PHFetchResult *)result completion:(void (^) (NSArray *photosAsset))completion;
- (void)getPhotoWithSize:(CGSize)size Asset:(PHAsset *)asset completion:(void (^) (UIImage * image))completion;

- (void)addPhotoData:(NSData *)photoData completion:(void (^) (BOOL success, NSError * error))completion;
- (void)deletePhotoAsset:(NSArray *)photoAssets completion:(void (^) (BOOL success, NSError * error))completion;

- (void)getVideoWithAsset:(PHAsset *)asset completion:(void (^) (AVPlayerItem * playerItem))completion;

@end
