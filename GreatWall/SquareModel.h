//
//  SquareModel.h
//  GreatWall
//
//  Created by 李阳 on 2016/12/20.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquareModel : NSObject

@property(nonatomic ,strong)NSString *adLink;//广告图片对应的链接，可以为空，表示不能点击
@property(nonatomic ,strong)NSString *adURL;//广告图片URL
@property(nonatomic ,strong)NSString *title;//标题
@property(nonatomic ,strong)NSString *keyWords;//关键字

@end

@interface SquareSpecial : NSObject
@property(nonatomic ,strong)NSString *endTime;//
@property(nonatomic ,strong)NSString *productCount;//
@property(nonatomic ,strong)NSString *productList;//
@property(nonatomic ,strong)NSString *specialContent;//
@property(nonatomic ,strong)NSString *specialId;//
@property(nonatomic ,strong)NSString *specialIntro;//
@property(nonatomic ,strong)NSString *specialLogo;//
@property(nonatomic ,strong)NSString *specialName;//
@property(nonatomic ,strong)NSString *specialType;//
@property(nonatomic ,strong)NSString *specialUrl;//
@property(nonatomic ,strong)NSString *startTime;//
@end
