//
//  PhotoMapAnnotationView.h
//  Photo&Camera
//
//  Created by 何家瑋 on 2017/1/18.
//  Copyright © 2017年 何家瑋. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface PhotoMapAnnotationView : MKAnnotationView

@property (nonatomic) UIImageView *photoImageView;
@property (nonatomic) NSUInteger count;
@property (nonatomic, getter = isBlue) BOOL blue;
@property (nonatomic, getter = isUniqueLocation) BOOL uniqueLocation;

@end
