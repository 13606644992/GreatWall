//
//  GJAFNetWork.m
//  GreatWall
//
//  Created by GJ on 2017/1/5.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "GJAFNetWork.h"
#import "Header.h"
#import <AFNetworking/AFNetworking.h>
//#import <CommonCrypto/CommonDigest.h>
@implementation GJAFNetWork
+(void)GET:(NSString *)url params:(NSDictionary *)params
   success:(GJResponseSuccess)success fail:(GJResponseFail)fail{
    
    AFHTTPSessionManager *manager = [GJAFNetWork managerWithBaseURL:nil sessionConfiguration:NO];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"height"];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [GJAFNetWork responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)GET:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params  success:(GJResponseSuccess)success fail:(GJResponseFail)fail{
        AFHTTPSessionManager *manager = [GJAFNetWork managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        id dic = [GJAFNetWork responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}

+(void)POST:(NSString *)url
     params:(NSDictionary *)params
     method:(NSString *)method
       tpye:(NSString *)type
    success:(GJResponseSuccess)success
       fail:(GJResponseFail)fail;{
    
    AFHTTPSessionManager *manager = [GJAFNetWork managerWithBaseURL:nil sessionConfiguration:NO];
    [manager.requestSerializer setValue:[[NSString stringWithFormat:@"%f", ScreenWindowHeight]substringToIndex:3] forHTTPHeaderField:@"height"];
    [manager.requestSerializer setValue:[[NSString stringWithFormat:@"%f", ScreenWindowWidth]substringToIndex:3] forHTTPHeaderField:@"width"];
    [manager.requestSerializer setValue:@"I" forHTTPHeaderField:@"osName"];
    [manager.requestSerializer setValue:@"1.0.0.0" forHTTPHeaderField:@"clientVersion"];
    [manager.requestSerializer setValue:@"10" forHTTPHeaderField:@"clientType"];
    [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"versiontype"];
    [manager.requestSerializer setValue:@"20" forHTTPHeaderField:@"deviceName"];
    [manager.requestSerializer setValue:@"20" forHTTPHeaderField:@"domainId"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //有sessionId就传
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_sessionId"]) {
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_sessionId"] forHTTPHeaderField:@"sessionId"];
        NSLog(@"%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"GJ_sessionId"]);
    }
    NSString *identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [manager.requestSerializer setValue:identifier forHTTPHeaderField:@"deviceNo"];   
    
    NSString *inputString = [self dictionaryToJson:params];
    NSString *signString = [inputString stringByAppendingString:@"md5_key"];
    NSString *signMD5Str = [self md5HexDigest:signString];
    NSDictionary *GJParams = @{@"input" : inputString, @"method" : method, @"sign" : signMD5Str};

    NSString *paramsStr = [self dictionaryToJson:GJParams];
    NSLog(@"参数 = %@", paramsStr);
    
    [manager POST:url parameters:paramsStr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [GJAFNetWork responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)POST:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
    success:(GJResponseSuccess)success fail:(GJResponseFail)fail{
    
    AFHTTPSessionManager *manager = [GJAFNetWork managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [GJAFNetWork responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)uploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(GJProgress)progress success:(GJResponseSuccess)success fail:(GJResponseFail)fail{
    
    AFHTTPSessionManager *manager = [GJAFNetWork managerWithBaseURL:nil sessionConfiguration:NO];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [GJAFNetWork responseConfiguration:responseObject];
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)uploadWithURL:(NSString *)url
             baseURL:(NSString *)baseurl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(GJProgress)progress
             success:(GJResponseSuccess)success
                fail:(GJResponseFail)fail{
    
    AFHTTPSessionManager *manager = [GJAFNetWork managerWithBaseURL:baseurl sessionConfiguration:YES];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [GJAFNetWork responseConfiguration:responseObject];
        
        success(task,dic);
        
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(GJProgress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            fail(error);
        }else{
            
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

#pragma mark - Private

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    NSURL *url;

    if (baseURL) {
        url = [NSURL URLWithString:baseURL];
    }
//    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+(id)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSString*) md5HexDigest:(NSString*)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}
@end
