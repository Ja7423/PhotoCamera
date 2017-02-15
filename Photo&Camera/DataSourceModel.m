//
//  DataSourceModel.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2017/2/14.
//  Copyright © 2017年 何家瑋. All rights reserved.
//

#import "DataSourceModel.h"

@interface DataSourceModel ()

@property (nonatomic) Photo * photo;
@property (nonatomic, copy) NSMutableArray *photoData;

@end

@implementation DataSourceModel

- (instancetype)init
{
        self = [super init];
        
        if (self)
        {
                _photo = [[Photo alloc]init];
        }
        
        return self;
}

- (void)startLinkPhotoLibrary
{
        _photoData = [NSMutableArray arrayWithArray:[_photo getAlbumList]];
}

- (void)needUpdateData:(BOOL)update
{
        if (update && _delegate && [_delegate respondsToSelector:@selector(dataSourceModelDidChange:)])
        {
                _photoData = [NSMutableArray arrayWithArray:[_photo getAlbumList]];
                [_delegate dataSourceModelDidChange:self];
        }
}

- (void)requestFetchResult:(PHFetchResult *)fetchResult
{
        [_photo getAlbumAssetWithFetchResult:fetchResult completion:^(NSArray *photosAsset) {
                
                _photoData = [NSMutableArray arrayWithArray:photosAsset];
                
        }];
}

- (void)deletePhoto:(NSArray *)deleteAssets completion:(void (^) (BOOL success, NSError * error))completion
{
        [_photo deletePhotoAsset:deleteAssets completion:^(BOOL success, NSError *error) {
                
                if (success)
                {
                        [deleteAssets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                [_photoData removeObject:obj];
                        }];
                }
                
                if (completion)
                        completion(success, error);
        }];
}


- (NSInteger)numberOfDataAtIndex:(NSInteger)index
{
        return _photoData.count;
}

- (id)dataAtIndex:(NSInteger)index
{
        return _photoData[index];
}

- (id)photoData
{
        return _photoData;
}

@end
