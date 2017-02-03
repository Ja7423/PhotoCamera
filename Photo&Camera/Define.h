//
//  Define.h
//  CoreGraphics
//
//  Created by 何家瑋 on 2016/11/21.
//  Copyright © 2016年 何家瑋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Define : NSObject

typedef NS_ENUM(NSInteger, ButtonTag)
{
        ShutterButtonTag,
        SwitchButtonTag,
        FlashButtonTag,
        CancelButtonTag,
};

typedef NS_ENUM(NSInteger, MediaType)
{
        MediaTypeImage = 1,
        MediaTypeVideo = 2,
};

typedef NS_ENUM(NSInteger, GestureTyep)
{
        GestureTypeSingleTap = 1,
        GestureTypeDoubleTap = 2,
};

@end
