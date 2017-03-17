//
//  LYPickerView.h
//  GreatWall
//
//  Created by 李阳 on 2017/3/15.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^PickerViewBlock)(NSString * string,NSInteger string_index);

@interface LYPickerView : NSObject

@property (nonatomic, copy) PickerViewBlock block;

+ (instancetype)shareShareType;

- (void)PickerViewShowModeWithArray:(NSArray *)shengarray;

- (void)PickerViewBackSelectBlock:(PickerViewBlock)block;

@end
