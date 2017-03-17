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

    /***************AFNetworking***************************/
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript",@"text/plain",nil];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.requestSerializer.timeoutInterval = Wait_Time;
    NSString *sessionID = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_sessionId"];
    
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSLog(@"---UDID----%@",udid);
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSInteger indexWidth = ScreenWindowWidth;
    NSInteger indexHeigth = ScreenWindowHeight;
    [manager.requestSerializer setValue:@"20" forHTTPHeaderField:@"deviceName"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",indexHeigth] forHTTPHeaderField:@"height"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",indexWidth]  forHTTPHeaderField:@"width"];
    [manager.requestSerializer setValue:@"I" forHTTPHeaderField:@"osName"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"clientVersion"];
    [manager.requestSerializer setValue:@"11" forHTTPHeaderField:@"clientType"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"versionType"];
    [manager.requestSerializer setValue:udid forHTTPHeaderField:@"deviceNo"];
    [manager.requestSerializer setValue:sessionID forHTTPHeaderField:@"sessionId"];
    [manager.requestSerializer setValue:@"20" forHTTPHeaderField:@"domainId"];
    
    [dictionary setValue:lyparameters forKey:@"input"];
    
    [dictionary setValue:lyuploadProgress forKey:@"method"];
//    NSLog(@"************----%@",lyparameters);
    
    NSData *methodString = [NSJSONSerialization dataWithJSONObject:lyparameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonmethodString = [[NSString alloc] initWithData:methodString encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@%@",jsonmethodString,@"md5_key"];

    
    [dictionary setValue:[LYMD5 md5:string] forKey:@"sign"];
//    NSLog(@"string-----------------%@ ----------MD5---%@",string,[LYMD5 md5:string]);



    NSData *dataString = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:dataString encoding:NSUTF8StringEncoding];
    
            NSLog(@"%@",jsonString);
    
        [manager POST:urlString parameters:jsonString progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *resdic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"---responseObject----request---%@",responseObject);
            if (lysuccess) {
                lysuccess(task,resdic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"-------requesterror---%@",error);
            if (lyfailure) {
                lyfailure(task,error);
            }
        }];
    
    
    /*******************NSMutableURLRequest********************/

//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    request.HTTPMethod = @"POST";
//    
//    // 2.设置请求头
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
//    NSInteger indexWidth = ScreenWindowWidth;
//    NSInteger indexHeigth = ScreenWindowHeight;
//    
//    [request setValue:@"20" forHTTPHeaderField:@"deviceName"];
//    [request setValue:[NSString stringWithFormat:@"%ld",indexHeigth] forHTTPHeaderField:@"height"];
//    [request setValue:[NSString stringWithFormat:@"%ld",indexWidth]  forHTTPHeaderField:@"width"];
//    [request setValue:@"I" forHTTPHeaderField:@"osName"];
//    [request setValue:@"1.0" forHTTPHeaderField:@"clientVersion"];
//    [request setValue:@"11" forHTTPHeaderField:@"clientType"];
//    [request setValue:@"1" forHTTPHeaderField:@"versionType"];
//    [request setValue:@"FBE018F2DBA74CB98DB22ED01D13046B" forHTTPHeaderField:@"deviceNo"];
//    [request setValue:@"bae91cdd89ccd070f62494c2d4108dde" forHTTPHeaderField:@"sessionId"];
//    [request setValue:@"100" forHTTPHeaderField:@"domainId"];
//    
//    [dictionary setValue:lyparameters forKey:@"input"];
//    [dictionary setValue:lyuploadProgress forKey:@"method"];
//    NSData *methodString = [NSJSONSerialization dataWithJSONObject:lyparameters options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonmethodString = [[NSString alloc] initWithData:methodString encoding:NSUTF8StringEncoding];
//    NSString *string = [NSString stringWithFormat:@"%@%@",jsonmethodString,@"md5_key"];
//    [dictionary setValue:[LYMD5 md5:string] forKey:@"sign"];
//    NSData *dataString = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
//    request.HTTPBody = dataString;
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (data) {
//            NSDictionary *resdic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"---%@--data---%@",response,resdic);
//            if (lysuccess) {
//                lysuccess(nil,resdic);
//            }
//        }
//      
//    }];
}
@end
