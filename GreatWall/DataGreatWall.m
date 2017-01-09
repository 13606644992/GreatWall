//
//  DataGreatWall.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "DataGreatWall.h"
#import "LYAFNetworking.h"
#import "Header.h"
#import "LYMD5.h"

#define Wait_Time 10.0f;//请求时间

@implementation DataGreatWall
+(void)PostTheHomePage:(NSString *)pageIndex WithThePageSize:(NSString *)pageSize WithTheHomeBlock:(HomeListBlock)block
{
    NSString *urlstring =@"http://192.168.32.95:8080/api/api.do?method=getSpecials";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:pageIndex forKey:@"pageIndex"];
    [inputMethot setValue:pageSize forKey:@"pageSize"];
    
    [LYAFNetworking POST:urlstring lyparameters:inputMethot lyprogress:nil lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"-------request---%@",responseObject);

    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);

    }];
}
@end
