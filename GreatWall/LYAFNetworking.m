//
//  LYAFNetworking.m
//  GreatWall
//
//  Created by 李阳 on 2017/1/9.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "LYAFNetworking.h"
#import "Header.h"
#import "LYMD5.h"

#define Wait_Time   10.0f;


@implementation LYAFNetworking
+(void)POST:(NSString *)urlString  lyparameters:(NSDictionary *)lyparameters lyprogress:(id)lyuploadProgress lysuccess:(AFNetBlockSuccess)lysuccess lyfailure:(AFNetBlockFail)lyfailure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
    manager.requestSerializer.timeoutInterval = Wait_Time;

    
    NSMutableDictionary *dictory = [[NSMutableDictionary alloc] init];
    NSInteger indexWidth = ScreenWindowWidth;
    NSInteger indexHeigth = ScreenWindowHeight;
    [manager.requestSerializer setValue:@"20" forHTTPHeaderField:@"deviceName"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",indexHeigth] forHTTPHeaderField:@"height"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",indexWidth]  forHTTPHeaderField:@"width"];
    [manager.requestSerializer setValue:@"I" forHTTPHeaderField:@"osName"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"clientVersion"];
    [manager.requestSerializer setValue:@"11" forHTTPHeaderField:@"clientType"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"versionType"];
    [manager.requestSerializer setValue:@"2222222" forHTTPHeaderField:@"deviceNo"];
    [dictory setValue:@"POST" forKey:@"method"];//md5_key
    

    NSData *dataString = [NSJSONSerialization dataWithJSONObject:lyparameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:dataString encoding:NSUTF8StringEncoding];
    
    
    [dictory setValue:jsonString forKey:@"input"];//md5_key
    NSString *string = [NSString stringWithFormat:@"%@%@",jsonString,@"md5_key"];
    [dictory setValue:[LYMD5 md5:string] forKey:@"sign"];
    
    [manager POST:urlString parameters:dictory progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resdic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"-------request---%@",resdic);
        if (lysuccess) {
            lysuccess(task,resdic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"-------requesterror---%@",error);
        if (lyfailure) {
            lyfailure(task,error);
        }
    }];

}
@end
