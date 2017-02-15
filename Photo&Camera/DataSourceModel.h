//
//  DataSourceModel.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2017/2/14.
//  Copyright © 2017年 何家瑋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "AssetModel.h"

@class DataSourceModel;
@protocol DataSourceModelDelegate <NSObject>

@optional
- (void)dataSourceModelDidChange:(DataSourceModel *)dataSourceModel;

@end


@interface DataSourceModel : NSObject

- (void)startLinkPhotoLibrary;
- (void)needUpdateData:(BOOL)update;

- (void)requestFetchResult:(PHFetchResult *)fetchResult;

- (void)deletePhoto:(NSArray *)deleteAssets completion:(void (^) (BOOL success, NSError * error))completion;

- (NSInteger)numberOfDataAtIndex:(NSInteger)index;
- (id)dataAtIndex:(NSInteger)index;
- (id)photoData;

@property (nonatomic, weak) id <DataSourceModelDelegate> delegate;

@end
