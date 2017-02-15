//
//  Photo.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/11/2.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "Photo.h"

@implementation Photo

#pragma mark - public method
+ (void)CheckPhotoisAvailable
{
        PHAuthorizationStatus Status = [PHPhotoLibrary authorizationStatus];
        
        switch (Status) {
                case PHAuthorizationStatusNotDetermined:
                        // User has not yet made a choice with regards to this application
                        NSLog(@"PHAuthorizationStatusNotDetermined");
                        [self RequestPhotoPermission];
                        break;
                        
                case PHAuthorizationStatusRestricted:
                        // This application is not authorized to access photo data.
                        // The user cannot change this application’s status, possibly due to active restrictions
                        //   such as parental controls being in place.
                        NSLog(@"PHAuthorizationStatusRestricted");
                        break;
                        
                case PHAuthorizationStatusDenied:
                        // User has explicitly denied this application access to photos data.
                        NSLog(@"PHAuthorizationStatusDenied");
                        break;
                        
                case PHAuthorizationStatusAuthorized:
                        // User has authorized this application to access photos data.
                        NSLog(@"PHAuthorizationStatusAuthorized");
                        break;
                        
                default:
                        break;
        }
}

+ (void)RequestPhotoPermission
{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
        }];
}


#pragma mark - Album operation
/**
 @method : getAlbumList()
 @return all Album list
 */
- (NSArray *)getAlbumList
{
        NSMutableArray<FetchResultModel *> *albumList = [NSMutableArray array];
        PHFetchOptions *options = [[PHFetchOptions alloc]init];
        
        //系統內建的相簿
        PHFetchResult *CollectionTypeSmartAlbumResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        for (PHAssetCollection *assetCollection in CollectionTypeSmartAlbumResult)
        {
                if ([self selectAlbum:assetCollection.localizedTitle])
                {
                        PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
                        
                        FetchResultModel *_FetchResultModel = [[FetchResultModel alloc]init];
                        _FetchResultModel.albumName = assetCollection.localizedTitle;
                        _FetchResultModel.result = assetResult;
                        
                        [albumList addObject:_FetchResultModel];
                }
        }
        
        //使用者自創的相簿
        PHFetchResult *CollectionTypeAlbumResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        for (PHAssetCollection *assetCollection in CollectionTypeAlbumResult)
        {
                PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
                
                FetchResultModel *_FetchResultModel = [[FetchResultModel alloc]init];
                _FetchResultModel.albumName = assetCollection.localizedTitle;
                _FetchResultModel.result = assetResult;
                
                [albumList addObject:_FetchResultModel];
        }
        
        return albumList;
}

- (void)getAlbumPostImageWithSize:(CGSize)size FetchResult:(PHFetchResult *)result completion:(void (^) (UIImage *))completion
{
        [self getPhotoWithSize:size Asset:result.lastObject completion:completion];
}

- (void)getAlbumAssetWithFetchResult:(PHFetchResult *)result completion:(void (^) (NSArray *))completion
{
        NSMutableArray *photosAsset = [NSMutableArray array];
        
        [result enumerateObjectsUsingBlock:^(PHAsset * asset, NSUInteger idx, BOOL * _Nonnull stop) {
                
                AssetModel *_assetModel = [[AssetModel alloc]init];
                _assetModel.asset = asset;
                _assetModel.mediaType = asset.mediaType;
                _assetModel.location = asset.location;
                
                if (asset.mediaType == PHAssetMediaTypeVideo)
                        _assetModel.timeDuration = [self setupDuration:asset.duration];
                
                [photosAsset addObject:_assetModel];
        }];
        
        if (completion)
                completion(photosAsset);
}

- (void)getPhotoWithSize:(CGSize)size Asset:(PHAsset *)asset completion:(void (^) (UIImage *))completion
{
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        option.networkAccessAllowed = YES;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        option.synchronous = false;
        
        // size剛剛好的話，圖片會模糊
        CGFloat target = MAX(size.width, size.height);
        CGSize targetSize = CGSizeMake(target *2.0, target *2.0);
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                
                if (completion)
                        completion(result);
        }];
}

/* choose which album you need */
- (BOOL)selectAlbum:(NSString *)albumName
{
        if ([albumName isEqualToString:@"All Photos"] ||
            [albumName isEqualToString:@"Favorites"] ||
            [albumName isEqualToString:@"Videos"] ||
            [albumName isEqualToString:@"Selfies"] )
        {
                return YES;
        }

        return NO;
}

#pragma mark - Asset change
- (void)addPhotoData:(NSData *)photoData completion:(void (^) (BOOL success, NSError * error))completion
{
        PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        
        [photoLibrary performChanges:^{
                
                PHAssetCreationRequest *photoRequest = [PHAssetCreationRequest creationRequestForAsset];
                [photoRequest addResourceWithType:PHAssetResourceTypePhoto data:photoData options:nil];
                
                
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
                
                if (completion)
                        completion(success, error);
        }];
}

- (void)deletePhotoAsset:(NSArray *)photoAssets completion:(void (^) (BOOL success, NSError * error))completion
{
        PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        NSMutableArray * deletes;
        
        if (photoAssets && [photoAssets[0] isKindOfClass:[AssetModel class]])
        {
                deletes = [NSMutableArray array];
                
                for (AssetModel * assetModel in photoAssets)
                {
                        [deletes addObject:assetModel.asset];
                }
        }
        else if (photoAssets && [photoAssets[0] isKindOfClass:[PHAsset class]])
        {
                deletes = [NSMutableArray arrayWithArray:photoAssets];
        }
        
        [photoLibrary performChanges:^{
                
                [PHAssetChangeRequest deleteAssets:deletes];
                
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
                
                if (completion)
                        completion(success, error);
        }];
}

#pragma mark - Video
- (void)getVideoWithAsset:(PHAsset *)asset completion:(void (^) (AVPlayerItem *))completion
{
        [[PHImageManager defaultManager]requestPlayerItemForVideo:asset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
                
                if(completion)
                        completion(playerItem);
        }];
}

- (NSString *)setupDuration:(NSTimeInterval)duration
{
        NSInteger totalSeconds = [[NSString stringWithFormat:@"%0.0f", duration] integerValue];
        NSInteger minutes = (totalSeconds / 60);
        NSInteger seconds = (totalSeconds % 60);
        
        NSString *timeString = [NSString stringWithFormat:@"%ld: %02ld ", (long)minutes, (long)seconds];;
        
        return timeString;
}

@end
