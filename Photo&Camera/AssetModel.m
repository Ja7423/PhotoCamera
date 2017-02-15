//
//  AssetModel.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/4.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "AssetModel.h"


@implementation FetchResultModel

- (void)postImageSize:(CGSize)size completion:(void (^) (UIImage *))completion
{
        [[Photo new]getAlbumPostImageWithSize:size FetchResult:self.result completion:completion];
}

- (NSUInteger)count
{
        PHFetchResult* result = _result;
        return result.count;
}

@end



@implementation AssetModel

- (void)photoImageSize:(CGSize)size completion:(void (^) (UIImage *))completion
{
        [[Photo new]getPhotoWithSize:size Asset:self.asset completion:completion];
}

@end

