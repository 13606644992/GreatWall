//
//  LYShareType.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LYShareTypeMode) {
    LYShareTypeModeFriend,           // 微信好友
    LYShareTypeModeFriendCircle,     // 微信朋友圈
//    LYShareTypeModeFriend,    //
//    LYShareTypeModeFriend, //
};

/** 回调Block*/
typedef void(^ShareSelectBlock)(NSString * index);

@interface LYShareType : NSObject

@property (nonatomic, copy) ShareSelectBlock block;

+ (instancetype)shareShareType;

- (void)LYShareTypeShowMode;

- (void)LYShareTypeBackSelectBlock:(ShareSelectBlock)block;

@end
