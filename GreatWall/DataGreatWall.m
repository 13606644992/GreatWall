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
+(void)PostTheHomeSpecialAndProductList:(NSString *)pageIndex WithThePageSize:(NSString *)pageSize WithTheProductSize:(NSString *)productSize WithBlock:(HomeListBlock)block
{
    NSString *urlstring =@"http://192.168.32.95:8080/api/api.do?method=getSpecialsAndProductsList";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:pageIndex forKey:@"pageIndex"];
    [inputMethot setValue:pageSize forKey:@"pageSize"];
    [inputMethot setValue:productSize forKey:@"productSize"];

    [LYAFNetworking POST:urlstring lyparameters:inputMethot lyprogress:nil lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"-------request---%@",responseObject);
        
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        
    }];
}
+(void)PostTheScrollAndTheTypeTitle:(NSString *)userID WithBlock:(HomeListBlock)block
{
    NSString *urlstring =@"http://192.168.32.95:8080/api/api.do?method=getHomePageInfo";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:@"" forKey:@"userID"];
    
    [LYAFNetworking POST:urlstring lyparameters:inputMethot lyprogress:nil lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"-------request---%@",responseObject);
        
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        
    }];
}
+(void)PostTheHomePageInfo:(NSString *)userID WithSpecialSize:(NSString *)specialSize WithTheProduct:(NSString *)product WithBlock:(HomeListBlock)block
{
    NSString *urlstring =@"http://192.168.32.95:8080/api/api.do?method=getHomePageInfo";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:userID forKey:@"userID"];
    [inputMethot setValue:specialSize forKey:@"specialSize"];
    [inputMethot setValue:product forKey:@"productSize"];

    [LYAFNetworking POST:urlstring lyparameters:inputMethot lyprogress:nil lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"-------request---%@",responseObject);
        NSDictionary *output = responseObject[@"output"];
        NSArray *xhbMsgList = output[@"xhbMsgList"];
        [xhbMsgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSLog(@"--msgContent--%@------msgTitle-----%@",obj[@"msgContent"],obj[@"msgTitle"]);
            
        }];
        
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        
    }];
}
@end
