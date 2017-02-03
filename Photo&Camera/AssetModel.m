//
//  AssetModel.m
//  Photo&Camera
//
//  Created by 何家瑋 on 2016/12/4.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import "AssetModel.h"


@implementation FetchResultModel

- (UIImage *)postImageWidth:(CGSize)width
{
        __block UIImage *postImage;
        
        [[Photo new]getAlbumPostImageWithWidth:width FetchResult:self.result completion:^(UIImage *image) {
                postImage = image;
        }];
        
        return postImage;
}

@end



@implementation AssetModel

- (void)photoImageWidth:(CGSize)width completion:(void (^) (UIImage *))completion
{
        [[Photo new]getPhotoWithWidth:width Asset:self.asset completion:completion];
}

@end

