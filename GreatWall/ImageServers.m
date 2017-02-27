//
//  ImageServers.m
//  GreatWall
//
//  Created by GJ on 2017/2/8.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "ImageServers.h"
#import "Header.h"
#import <AFNetworking.h>
#import <AliyunOSSiOS/OSSService.h>
@implementation ImageServers
{
    OSSClient * client;
    NSString * endPoint;
    NSString * callbackAddress;
    NSMutableDictionary * uploadStatusRecorder;
    NSString * currentUploadRecordKey;
    OSSPutObjectRequest * putRequest;
    OSSGetObjectRequest * getRequest;
    
    // 简单起见，全局只维护一个断点上传任务
    OSSResumableUploadRequest * resumableRequest;
    ViewController * viewController;
    BOOL isCancelled;
    BOOL isResumeUpload;
    
    NSString *filepath;
    UIImage *headerImage;
}
- (void)updateImage:(UIImage *)image{
    headerImage = image;
    [self getToken];
}
- (void)getToken{
    NSDictionary *parameters = @{@"userId" : [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"]};
    [GJAFNetWork POST:@"http://192.168.32.68:8082/api/api.do" params:parameters method:@"getOssToken" tpye:@"post" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@", responseObject);
        if ([responseObject[@"respCode"] isEqualToString:@"000000"]) {
            OSSFederationToken * token = [OSSFederationToken new];
            NSDictionary *output = responseObject[@"output"];
            token.tAccessKey = [output objectForKey:@"accessKeyId"];
            token.tSecretKey = [output objectForKey:@"accessKeySecret"];
            token.tToken = [output objectForKey:@"securityToken"];
            token.expirationTimeInGMTFormat = [output objectForKey:@"expiration"];
            filepath = [output objectForKey:@"filePath"];
            [self uploadWithToken:token];
        }else{
//            NSLog(@"%@)
        }

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];

}
- (void)uploadWithToken:(OSSFederationToken *)token{
    //初始化
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        return token;
    }];
    client = [[OSSClient alloc] initWithEndpoint:@"http://oss-cn-hangzhou.aliyuncs.com" credentialProvider:credential];
    //上传
    putRequest = [OSSPutObjectRequest new];
    putRequest.bucketName = @"hbx-image";
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_userId"];
    putRequest.objectKey = [NSString stringWithFormat:@"%@%@.jpg",filepath, userId];
    putRequest.uploadingData = UIImageJPEGRepresentation(headerImage, 0.2);
    putRequest.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    NSString *callbackBody = [NSString stringWithFormat:@"uploadType=logo&content=%@&filename=%@.jpg", userId, userId];
    putRequest.callbackParam = @{
                                 @"callbackUrl": @"http://ebao.seaway.net.cn:9003/api/ossCallback.do",
                                 @"callbackBody": callbackBody
                                 };
    OSSTask * task = [client putObject:putRequest];
    [task continueWithBlock:^id(OSSTask *task) {
        OSSPutObjectResult * result = task.result;
        // 查看server callback是否成功
        if (!task.error) {
            NSLog(@"图片上传阿里云成功!");
          NSData *jsonData = [result.serverReturnJsonString dataUsingEncoding:NSUTF8StringEncoding];
          NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
          NSLog(@"%@", dic);
            NSString *userLogo = dic[@"output"][@"userLogo"];
            NSLog(@"%@", userLogo);
            [[NSUserDefaults standardUserDefaults]setObject:userLogo forKey:@"GJ_headURL"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } else {
            NSLog(@"上传阿里云失败, %@", task.error);
        }
        putRequest = nil;
        return nil;
    }];

}


- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
