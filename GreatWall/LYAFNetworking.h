//
//  LYAFNetworking.h
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <UIKit/UIKit.h>


typedef void(^AFNetBlockSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^AFNetBlockFail)(NSURLSessionDataTask *task, NSError *error);

@interface LYAFNetworking : NSObject

+(void)POST:(NSString *)urlString  lyparameters:(NSDictionary *)lyparameters lyprogress:(id)lyuploadProgress lysuccess:(AFNetBlockSuccess)lysuccess lyfailure:(AFNetBlockFail)lyfailure;



@end
