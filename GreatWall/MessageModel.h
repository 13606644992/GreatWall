//
//  MessageModel.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/20.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property(nonatomic ,strong)NSString *msgContent;//消息内容
@property(nonatomic ,strong)NSString *msgId;//消息编号
@property(nonatomic ,strong)NSString *msgLink;//消息对应链接
@property(nonatomic ,strong)NSString *msgTime;//发送时间
@property(nonatomic ,strong)NSString *msgTitle;//消息标题
@property(nonatomic ,strong)NSString *msgType;//消息类型
@property(nonatomic ,strong)NSString *sts;//消息状态

@end
