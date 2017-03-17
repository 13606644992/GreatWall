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
#import "GJAFNetWork.h"

#define Wait_Time 10.0f;//请求时间
#define urlHost    @"http://192.168.32.95:8080/api/api.do"
//#define urlHost    @"http://192.168.32.144:8080/api.do"
//#define urlHost    @"http://192.168.32.66:8080/api.do"

//#define urlHost    @"http://192.168.2.17:8082/api.do"

@implementation DataGreatWall

+(void)PostTheHomePageInfo:(NSString *)userID WithSpecialSize:(NSString *)specialSize WithTheProduct:(NSString *)product WithBlock:(HomeListBlock)block
{
//    NSString *urlstring =@"http://192.168.32.66:8080/api.do";
//    NSString *urlstring =@"http://192.168.32.144:8080/api.do?method=getHomePageInfo";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:userID forKey:@"userID"];
    [inputMethot setValue:specialSize forKey:@"specialSize"];
    [inputMethot setValue:product forKey:@"productSize"];

    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getHomePageInfo" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
//            NSLog(@"-------request---%@",output);

            HomeCellModel *model = [[HomeCellModel alloc] init];
            [model setValuesForKeysWithDictionary:output];
            
            __block NSMutableArray *scrollArray = [NSMutableArray arrayWithCapacity:0];
            [model.ads enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeScroll *Scroll = [[HomeScroll alloc] init];
                [Scroll setValuesForKeysWithDictionary:obj];
                [scrollArray addObject:Scroll];
            }];
            model.ads = scrollArray;
            __block NSMutableArray *specialArray = [NSMutableArray arrayWithCapacity:0];
            [model.productType enumerateObjectsUsingBlock:^(id  _Nonnull objspecial, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeSpecial *special = [[HomeSpecial alloc] init];
                [special setValuesForKeysWithDictionary:objspecial];
                [specialArray addObject:special];
            }];
            model.productType = specialArray;
            __block NSMutableArray *specialListArray = [NSMutableArray arrayWithCapacity:0];
            [model.specialList enumerateObjectsUsingBlock:^(id  _Nonnull objheader, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeHeader *header = [[HomeHeader alloc] init];
                [header setValuesForKeysWithDictionary:objheader];
                __block NSMutableArray *productArray = [NSMutableArray arrayWithCapacity:0];
//                NSLog(@"-------%@",header.productList);
                [header.productList enumerateObjectsUsingBlock:^(NSDictionary *objlist, NSUInteger idx, BOOL * _Nonnull stop) {
                    HomeProduct *product = [[HomeProduct alloc] init];
                    [product setValuesForKeysWithDictionary:objlist];
                    [productArray addObject:product];
                }];
                header.productList = productArray;
                [specialListArray addObject:header];
            }];
            model.specialList = specialListArray;
            __block NSMutableArray *xhbArray = [NSMutableArray arrayWithCapacity:0];
            [model.xhbMsgList enumerateObjectsUsingBlock:^(id  _Nonnull objxhb, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeXHBList *xhbList = [[HomeXHBList alloc] init];
                [xhbList setValuesForKeysWithDictionary:objxhb];
                [xhbArray addObject:xhbList];
            }];
            model.xhbMsgList = xhbArray;
            if (block) {
                block(respCode,respMsg,model,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,nil,nil,error);
        }
    }];
}
+(void)PostTheProductListWithUserID:(NSString *)userID WithpageIndex:(NSString *)index WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block
{
    NSString *urlstring =@"http://192.168.32.144:8080/api.do?method=getSpecials";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    if (userID) {
        [inputMethot setValue:userID forKey:@"userID"];
    }
    [inputMethot setValue:index forKey:@"pageIndex"];
    [inputMethot setValue:pageSize forKey:@"pageSize"];
    __block NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
    [LYAFNetworking POST:urlstring lyparameters:inputMethot lyprogress:nil lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *page_Size = output[@"pageSize"];
            NSString *total_Count = output[@"totalCount"];
            NSArray *specialList = output[@"specialList"];

            [specialList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MallModel *model = [[MallModel alloc] init];
                [model setValuesForKeysWithDictionary:obj];
                [_array addObject:model];
            }];
            if (block) {
                block(respCode,respMsg,page_Size,total_Count,_array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---------%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
//	获取保险分类列表
+(void)PostTheProductTypeWithparentId:(NSString *)parentID WithBlock:(MallProductListBlock)block
{
    NSString *urlstring =@"http://192.168.32.95:8080/api/api.do";
//    NSString *urlstring =@"http://192.168.32.144:8080/api.do?method=getProductType";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];

    [inputMethot setValue:parentID forKey:@"parentId"];
    
    
//    __block NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
    [LYAFNetworking POST:urlstring lyparameters:inputMethot lyprogress:@"getProductType" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"----	获取保险分类列表-----%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            MallProductType *productType = [[MallProductType alloc] init];
            [productType setValuesForKeysWithDictionary:output];
            __block NSMutableArray *typeListArray = [NSMutableArray arrayWithCapacity:0];
            [productType.typeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MallProductType *product = [[MallProductType alloc] init];
                [product setValuesForKeysWithDictionary:obj];
                __block NSMutableArray *smallTypeList = [NSMutableArray arrayWithCapacity:0];
                [product.typeList enumerateObjectsUsingBlock:^(id  _Nonnull objmall, NSUInteger idx, BOOL * _Nonnull stop) {
                    MallProductType *type = [[MallProductType alloc] init];
                    [type setValuesForKeysWithDictionary:objmall];
                    [smallTypeList addObject:type];
                }];
                product.typeList = smallTypeList;
                [typeListArray addObject:product];
            }];
            productType.typeList = typeListArray;
            
            if (block) {
                block(respCode,respMsg,productType,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---------%@",error);
        if (block) {
            block(nil,nil,nil,error);
        }
    }];
}
//获取专题商品
+(void)PostTheProductTypeWith:(NSString *)productType WithThePageIndex:(NSString *)pageIndex WithThePageSize:(NSString *)pageSize WithTheKey:(NSString *)key WithTheTargetID:(NSString *)targetID isGetDefault:(NSString *)isDefault WithDefaultNum:(NSString *)defaultNum WithSortCode:(NSString *)sortCode WithBenefitNum:(NSString *)benefit WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:pageIndex forKey:@"pageIndex"];
    [inputMethot setValue:pageSize forKey:@"pageSize"];
    [inputMethot setValue:productType forKey:@"productType"];
    [inputMethot setValue:key forKey:@"key"];
    [inputMethot setValue:targetID forKey:@"tagId"];
    [inputMethot setValue:isDefault forKey:@"getDefault"];
    [inputMethot setValue:defaultNum forKey:@"defaultNum"];
    [inputMethot setValue:sortCode forKey:@"sortCode"];
    [inputMethot setValue:benefit forKey:@"benefitNum"];
    [inputMethot setValue:@"" forKey:@"specialId"];
    
    
    
    NSLog(@"------inputMethot--%@",inputMethot);

        __block NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getProducts" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"---------%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *pageSize = output[@"pageSize"];
            NSString *totalPage = output[@"totalCount"];
            NSArray *productList = output[@"productList"];
            [productList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MallProduct *product = [[MallProduct alloc] init];
                [product setValuesForKeysWithDictionary:obj];
                __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                [product.benefitList enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                    MallBenefitList *list = [[MallBenefitList alloc] init];
                    [list setValuesForKeysWithDictionary:obj1];
                    [array addObject:list];
                }];
                product.benefitList = array;
                [_array addObject:product];
            }];
            if (block) {
                block(respCode,respMsg,pageSize,totalPage,_array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---------%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}

//消息接口
+(void)PostThePersionMsgWithUserID:(NSString *)userID WithMsgType:(NSString *)msgType WithSts:(NSString *)sts WithPageIndex:(NSString *)pageIndex WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block
{
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",urlHost,@"getMsgs"];
    //    NSString *urlstring =@"http://192.168.32.144:8080/api.do?method=getProductType";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:pageIndex forKey:@"pageIndex"];
    [inputMethot setValue:pageSize forKey:@"pageSize"];
    [inputMethot setValue:userID forKey:@"userId"];
    [inputMethot setValue:sts forKey:@"sts"];
    [inputMethot setValue:msgType forKey:@"msgType"];

//    NSLog(@"-000000000000000%@--",inputMethot);
    
    
    __block NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
    [LYAFNetworking POST:urlstring lyparameters:inputMethot lyprogress:nil lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"---------%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
//        NSLog(@"---respMsg------%@",respMsg);

        if ([respCode isEqualToString:@"000000"]) {
            if (responseObject[@"output"]) {
                NSDictionary *output = responseObject[@"output"];
                NSString *page = output[@"pageSize"];
                NSString *total = output[@"totalCount"];
                [output[@"msgList"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MessageModel *model = [[MessageModel alloc] init];
                    [model setValuesForKeysWithDictionary:obj];
                    [_array addObject:model];
                }];
                if (block) {
                    block(respCode,respMsg,page,total,_array,nil);
                }
            }else{
                if (block) {
                    block(respCode,respMsg,nil,nil,_array,nil);
                }
            }
            //            NSDictionary *output = responseObject[@"output"];
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,_array,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---------%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
/******************************************/
//首页未读消息数量
+(void)PostTheFirstMessageWith:(NSString *)userID Block:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    if (userID) {
        [inputMethot setValue:userID forKey:@"userID"];
    }
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getUnReadMessageCount" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"resdic-----首页未读消息数量----%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *totalCount = output[@"totalCount"];

            if (block) {
                block(respCode,respMsg,nil,totalCount,nil,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"----首页未读消息数量---request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
+(void)PostTheBannerListWith:(NSString *)userID WithBlock:(SpecialsListBlock)block
{
//    NSString *urlstring =@"http://192.168.32.144:8080/api.do";
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    if (userID) {
        [inputMethot setValue:userID forKey:@"userID"];
    }
    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getBannerInfo" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"resdic---------%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSArray *ads = output[@"ads"];
            [ads enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeScroll *scroll = [[HomeScroll alloc]init];
                [scroll setValuesForKeysWithDictionary:obj];
                [array addObject:scroll];
            }];
            
            if (block) {
                block(respCode,respMsg,nil,nil,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
//首页快捷入口
+(void)PostTheProductTypeWithTheFirst:(NSString *)userID WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    if (userID) {
        [inputMethot setValue:userID forKey:@"userID"];
    }
    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getHomePageProductType" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic----首页快捷入口-----%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];

            NSArray *productType = output[@"productType"];
            [productType enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeSpecial *xhb = [[HomeSpecial alloc]init];
                [xhb setValuesForKeysWithDictionary:obj];
                [array addObject:xhb];
            }];
            if (block) {
                block(respCode,respMsg,nil,nil,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];

}
//首页小汇报
+(void)PostTheXHBMessageWith:(NSString *)userID WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    if (userID) {
        [inputMethot setValue:userID forKey:@"userID"];
    }
    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getXhbMessageInfo" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"resdic---------%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *pageSize = output[@"pageSize"];
            NSString *totalCount = output[@"totalCount"];
            NSArray *msgList = output[@"msgList"];
            [msgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeXHBList *xhb = [[HomeXHBList alloc]init];
                [xhb setValuesForKeysWithDictionary:obj];
                [array addObject:xhb];
            }];
            
            if (block) {
                block(respCode,respMsg,pageSize,totalCount,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];

}
//首页商品
+(void)PostTheFistProductWith:(NSString *)userID WithBlcok:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    if (userID) {
        [inputMethot setValue:userID forKey:@"userID"];
    }
    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getHomePageProductList" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic---------%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];

            NSArray *specialList = output[@"specialList"];
            [specialList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeHeader *headr = [[HomeHeader alloc]init];
                [headr setValuesForKeysWithDictionary:obj];
                NSMutableArray *headers = [NSMutableArray arrayWithCapacity:0];
                [headr.productList enumerateObjectsUsingBlock:^(id  _Nonnull productList, NSUInteger idx, BOOL * _Nonnull stop) {
                    HomeProduct *product = [[HomeProduct alloc] init];
                    [product setValuesForKeysWithDictionary:productList];
                    [headers addObject:product];
                }];
                headr.productList = headers;
                [array addObject:headr];
            }];
            
            if (block) {
                block(respCode,respMsg,nil,nil,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}

//	活动列表查询
+(void)PostTheAdsListWithPageIndex:(NSString *)pageIndex WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
//    if (userID) {
//        [inputMethot setValue:userID forKey:@"userID"];
//    }
    [inputMethot setValue:pageIndex forKey:@"pageIndex"];
    [inputMethot setValue:pageSize forKey:@"pageSize"];

    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getAdsList" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic---活动列表查询------%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *totalCount = output[@"totalCount"];
            NSArray *adsList = output[@"adsList"];
            [adsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SquareModel *square = [[SquareModel alloc]init];
                [square setValuesForKeysWithDictionary:obj];
                [array addObject:square];
            }];
            
            if (block) {
                block(respCode,respMsg,nil,totalCount,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
//获取产品详情
+(void)PostTheProductContentWithProductID:(NSString *)productID WithBlock:(DescriptionBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    //    if (userID) {
    //        [inputMethot setValue:userID forKey:@"userID"];
    //    }
    [inputMethot setValue:productID forKey:@"productId"];
//    NSLog(@"-----------%@",productID);
    
//    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getProductDetail" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic----获取产品详情-----%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
//        NSLog(@"resdic----respMsg-----%@",respMsg);                                          

        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            DescriptionModel *model = [[DescriptionModel alloc] init];
            [model setValuesForKeysWithDictionary:output];
            __block NSMutableArray *planList = [NSMutableArray arrayWithCapacity:0];
            [model.planList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DescriptionPlan *plan =[[DescriptionPlan alloc] init];
                [plan setValuesForKeysWithDictionary:obj];
                __block NSMutableArray *classNameList = [NSMutableArray arrayWithCapacity:0];
                [plan.classNameList enumerateObjectsUsingBlock:^(id  _Nonnull objclass, NSUInteger idx, BOOL * _Nonnull stop) {
                    DescriptionBenefitList *list = [[DescriptionBenefitList alloc] init];
                    [list setValuesForKeysWithDictionary:objclass];
                    __block NSMutableArray *benefitList = [NSMutableArray arrayWithCapacity:0];
                    [list.benefitList enumerateObjectsUsingBlock:^(id  _Nonnull objbenefit, NSUInteger idx, BOOL * _Nonnull stop) {
                        DescriptionBenefit *benefit = [[DescriptionBenefit alloc] init];
                        [benefit setValuesForKeysWithDictionary:objbenefit];
                        [benefitList addObject:benefit];
                    }];
                    list.benefitList = benefitList;
                    NSLog(@"list.benefitList ++++++++   === %@   ------------%@",list.benefitList,plan.classNameList);
                    [classNameList addObject:list];
                }];
                plan.classNameList = classNameList;
                [planList addObject:plan];
            }];
            model.planList = planList;
            

            __block NSMutableArray *priceList = [NSMutableArray arrayWithCapacity:0];
            [model.priceList enumerateObjectsUsingBlock:^(id  _Nonnull objprice, NSUInteger idx, BOOL * _Nonnull stop) {
                DescriptionPrice *price = [[DescriptionPrice alloc]init];
                [price setValuesForKeysWithDictionary:objprice];
                [priceList addObject:price];
            }];
            model.priceList = priceList;
            

            if (block) {
                block(respCode,respMsg,model,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,error);
        }
    }];
}
//获取爆款产品列表
+(void)PostThesPecialProduct:(NSString *)pageIndex WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];

    [inputMethot setValue:pageIndex forKey:@"pageIndex"];
    
    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getSpecialProductList" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic----获取爆款产品列表-----%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *pageSize = output[@"pageSize"];
            NSString *totalCount = output[@"totalCount"];
            NSArray *productList = output[@"productList"];
            [productList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MallProduct *square = [[MallProduct alloc]init];
                [square setValuesForKeysWithDictionary:obj];
                [array addObject:square];
            }];
            
            if (block) {
                block(respCode,respMsg,pageSize,totalCount,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
//获取专题列表
+(void)PostThesPecial:(NSString *)pageIndex WithPageSize:(NSString *)pageSize WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    //    if (userID) {
    //        [inputMethot setValue:userID forKey:@"userID"];
    //    }
    [inputMethot setValue:pageIndex forKey:@"pageIndex"];
    [inputMethot setValue:pageSize forKey:@"pageSize"];
    
    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getSpecials" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic---获取专题列表------%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *totalCount = output[@"totalCount"];
            NSString *pageSize = output[@"pageSize"];
            NSArray *specialList = output[@"specialList"];
            [specialList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SquareSpecial *square = [[SquareSpecial alloc]init];
                [square setValuesForKeysWithDictionary:obj];
                [array addObject:square];
            }];
            
            if (block) {
                block(respCode,respMsg,pageSize,totalCount,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];

}
//获取保险公司
+(void)PostTheInsureWithparentId:(NSString *)parentID WithInsureID:(NSString *)insureID WithinsurerType:(NSString *)type WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    
    if (parentID) {
        [inputMethot setValue:parentID forKey:@"parentId"];
    }if (insureID) {
        [inputMethot setValue:insureID forKey:@"insurerId"];
    }
    [inputMethot setValue:type forKey:@"insurerType"];
    
    __block NSMutableArray *array = [NSMutableArray array];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getInsurers" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic-----获取保险公司----%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            NSString *pageSize = output[@"pageSize"];
            NSArray *insurerList = output[@"insurerList"];
            [insurerList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MallInsure *insure = [[MallInsure alloc]init];
                [insure setValuesForKeysWithDictionary:obj];
                [array addObject:insure];
            }];
            
            if (block) {
                block(respCode,respMsg,pageSize,nil,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
//提交订单
+(void)PostTheOrderWithTheUserID:(NSString *)userID WithTheProductID:(NSString *)productID WithThePlanID:(NSString *)planID WithThePeriod:(NSString *)period WithThePriceKeyWord:(NSString *)priceKeyWord WithaTheApplicant:(NSString *)applicant WithTheMobile:(NSString *)phone WithTheidNo:(NSString *)idNo WithTheidType:(NSString *)idType WithTheInsuredName:(NSString *)insuredName WithTheInsureNo:(NSString *)insureNo WithRelationType:(NSString *)relationType WithTheInsureType:(NSString *)insureType WithCount:(NSString *)count WithStartTime:(NSString *)startTime WithBlock:(PayOrderBlock)block
{
//    applyTrade
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    
    [inputMethot setValue:userID forKey:@"userId"];
    [inputMethot setValue:productID forKey:@"productId"];
    [inputMethot setValue:planID forKey:@"planId"];
    [inputMethot setValue:period forKey:@"period"];
    [inputMethot setValue:priceKeyWord forKey:@"priceKeyword"];
    [inputMethot setValue:applicant forKey:@"applicant"];
    [inputMethot setValue:phone forKey:@"mobile"];
    [inputMethot setValue:idNo forKey:@"idNo"];
    [inputMethot setValue:idType forKey:@"idType"];
    [inputMethot setValue:startTime forKey:@"startTime"];
    [inputMethot setValue:@"" forKey:@"endTime"];
    [inputMethot setValue:@"0" forKey:@"isExpress"];
    [inputMethot setValue:@"" forKey:@"extraInfos"];
    [inputMethot setValue:@"" forKey:@"relateTrade"];
    [inputMethot setValue:@"" forKey:@"applicantId"];
    [inputMethot setValue:@"" forKey:@"email"];
    [inputMethot setValue:@"" forKey:@"cneeName"];
    [inputMethot setValue:@"" forKey:@"cneeMobile"];
    [inputMethot setValue:@"" forKey:@"areaCode"];
    [inputMethot setValue:@"" forKey:@"address"];
    [inputMethot setValue:@"" forKey:@"referrer"];
    [inputMethot setValue:@"" forKey:@"agent"];
    [inputMethot setValue:@"2" forKey:@"classType"];

    NSMutableDictionary *insuredList = [[NSMutableDictionary alloc] init];
    [insuredList setValue:insuredName forKey:@"insuredName"];
    [insuredList setValue:insureNo forKey:@"idNo"];
    [insuredList setValue:insureType forKey:@"idType"];
    [insuredList setValue:count forKey:@"num"];
    [insuredList setValue:@"" forKey:@"insuredId"];
    [insuredList setValue:relationType forKey:@"relationType"];
    [insuredList setValue:@"" forKey:@"occupation"];

    
    NSMutableDictionary *benList = [[NSMutableDictionary alloc] init];
    [benList setValue:@"0" forKey:@"benId"];
    [benList setValue:@"100" forKey:@"benRate"];
    [benList setValue:@"1" forKey:@"relation"];

    
    [inputMethot setValue:@[insuredList] forKey:@"insuredList"];
    [inputMethot setValue:@[benList] forKey:@"benList"];

    
       NSLog(@"resdic-----提交订单----%@",inputMethot);

    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"applyTrade" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic-----提交订单----%@",responseObject);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            PayOrderModel *model = [[PayOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject[@"output"]];
            __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [model.payments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                PayTypeModel *model1 = [[PayTypeModel alloc] init];
                [model1 setValuesForKeysWithDictionary:obj];
                [array addObject:model1];
            }];
            model.payments = array;
            if (block) {
                block(respCode,respMsg,model,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,error);
        }
    }];
}
////获取订单支付信息
//+(void)PostThePayOrderMessageWithTheOrderID:(NSString *)orderId WithBlock:(PayMsgBlock)block
//{
//    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
//    
//    [inputMethot setValue:orderId forKey:@"tradeId"];
//    
////    __block NSMutableArray *array = [NSMutableArray array];
//    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getTradePayment" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"resdic---------%@",responseObject);
//        NSLog(@"resdic------*******---%@",responseObject[@"respMsg"]);
//
//        NSString *respCode = responseObject[@"respCode"];
//        NSString *respMsg = responseObject[@"respMsg"];
//        if ([respCode isEqualToString:@"000000"]) {
//            NSDictionary *output = responseObject[@"output"];
//            PayViewModel *model = [[PayViewModel alloc] init];
//            [model setValuesForKeysWithDictionary:output];
//            __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//            [model.payments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                PayTypeModel *typeModel = [[PayTypeModel alloc] init];
//                [typeModel setValuesForKeysWithDictionary:obj];
//                [array addObject:typeModel];
//            }];
//            model.payments = array;
////            
//            if (block) {
//                block(respCode,respMsg,model,nil);
//            }
//        }else{
//            if (block) {
//                block(respCode,respMsg,nil,nil);
//            }
//        }
//    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"-------request---%@",error);
//        if (block) {
//            block(nil,nil,nil,error);
//        }
//    }];
//}
//获取支付参数
+(void)postTheAliPayMessageWithTheTradeId:(NSString *)tradeId WithThePaymentId:(NSString *)paymentId WithTheUserId:(NSString *)userId WithTheacctBalanceJF:(NSString *)jf WithTheacctBalanceYE:(NSString *)yue WithThecouponCode:(NSString *)code WithTheCouponId:(NSString *)couponId WithThecouponName:(NSString *)couponName WithThecouponValue:(NSString *)couponValue WithThecouponUrl:(NSString *)couponUrl WithTheeffTime:(NSString *)effTime WithTheexp_time:(NSString *)exp_time WithThecouponDesc:(NSString *)couponDesc Withdeductible:(NSString *)deductible WithThepayDeadline:(NSString *)payDeadline WithpayPrice:(NSString *)payPrice WithThepaymentId:(NSString *)paymentIds Withquota:(NSString *)quota WithquotaUsage:(NSString *)quotaUsage WithTheProductName:(NSString *)productName WithTips:(NSString *)tips WithBlock:(PayMsgBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    
    [inputMethot setValue:tradeId forKey:@"tradeId"];
    [inputMethot setValue:paymentId forKey:@"paymentId"];
    [inputMethot setValue:userId forKey:@"userId"];
    [inputMethot setValue:jf forKey:@"acctBalanceJF"];
    [inputMethot setValue:yue forKey:@"acctBalanceYE"];
    [inputMethot setValue:code forKey:@"couponCode"];
    [inputMethot setValue:deductible forKey:@"deductible"];
    [inputMethot setValue:payDeadline forKey:@"payDeadline"];
    [inputMethot setValue:payPrice forKey:@"payPrice"];
    [inputMethot setValue:productName forKey:@"productName"];
    [inputMethot setValue:tips forKey:@"tips"];

    
    NSMutableDictionary *payments = [NSMutableDictionary dictionaryWithCapacity:0];
    [payments setValue:paymentIds forKey:@"paymentId"];
    [payments setValue:quota forKey:@"quota"];
    [payments setValue:quotaUsage forKey:@"quotaUsage"];
   
    [inputMethot setValue:@[payments] forKey:@"payments"];

//    NSMutableDictionary *couponList = [NSMutableDictionary dictionaryWithCapacity:0];
//    [couponList setValue:couponId forKey:@"couponId"];
//    [couponList setValue:couponName forKey:@"couponName"];
//    [couponList setValue:couponValue forKey:@"couponValue"];
//    [couponList setValue:couponUrl forKey:@"couponUrl"];
//    [couponList setValue:effTime forKey:@"effTime"];
//    [couponList setValue:exp_time forKey:@"exp_time"];
//    [couponList setValue:couponDesc forKey:@"couponDesc"];
//    
//    [inputMethot setValue:@[couponList] forKey:@"couponList"];
    [inputMethot setValue:@[] forKey:@"couponList"];


    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getPaySign" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic---------%@",responseObject);
        NSLog(@"resdic------*******---%@",responseObject[@"respMsg"]);
        
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *output = responseObject[@"output"];
            PayAliOrder *order = [[PayAliOrder alloc] init];
            [order setValuesForKeysWithDictionary:output];
            if (block) {
                block(respCode,respMsg,order,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"-------request---%@",error);
        if (block) {
            block(nil,nil,nil,error);
        }
    }];
}
//查看订单（保单）详情
+(void)PostTheTradeDetailWithTheTradeID:(NSString *)targetId WithTheDetailId:(NSString *)detailId WithTheBlock:(PayTradeBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:GJ_UserID forKey:@"userId"];
    [inputMethot setValue:targetId forKey:@"tradeId"];
    [inputMethot setValue:detailId forKey:@"detailId"];

        [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getTradeDetail" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"resdic---------%@",responseObject);
            NSLog(@"resdic------*******---%@",responseObject[@"respMsg"]);
            NSString *respCode = responseObject[@"respCode"];
            NSString *respMsg = responseObject[@"respMsg"];
            if ([respCode isEqualToString:@"000000"]) {
                NSDictionary *output = responseObject[@"output"];
                
                PayTrade *trade = [[PayTrade alloc] init];
                [trade setValuesForKeysWithDictionary:output];
                __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                [trade.insuredList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    OrderPersonal *person = [[OrderPersonal alloc] init];
                    [person setValuesForKeysWithDictionary:obj];
                    [array addObject:person];
                }];
                trade.insuredList = array;
                __block NSMutableArray *typeList = [NSMutableArray arrayWithCapacity:0];
                [trade.typeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    OrderType *order = [[OrderType alloc] init];
                    [order setValuesForKeysWithDictionary:obj];
                    
                    __block NSMutableArray *orderInsureList = [NSMutableArray arrayWithCapacity:0];

                    [order.insureList enumerateObjectsUsingBlock:^(id  _Nonnull order_list, NSUInteger idx, BOOL * _Nonnull stop) {
                        OrderInsureList *list = [[OrderInsureList alloc] init];
                        [list setValuesForKeysWithDictionary:order_list];
                        [orderInsureList addObject:list];
                    }];
                    order.insureList = orderInsureList;
                    [typeList addObject:order];
                }];
                trade.typeList = typeList;

                if (block) {
                    block(respCode,respMsg,trade,nil);
                }
            }else{
                if (block) {
                    block(respCode,respMsg,nil,nil);
                }
            }
        } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"-------request---%@",error);
            if (block) {
                block(nil,nil,nil,error);
            }
        }];
}
//回调
+(void)PostTheOrderIDWithtradeID:(NSString *)orderId WithAmount:(NSString *)amount
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript",@"text/plain",nil];
    
    
    [inputMethot setValue:@"TRADE_SUCCESS" forKey:@"trade_status"];
    [inputMethot setValue:orderId forKey:@"out_trade_no"];
    [inputMethot setValue:@"10" forKey:@"payChannel"];
    [inputMethot setValue:@"0000000333" forKey:@"trade_no"];
    NSDate *date = [NSDate date];
    NSDateFormatter *fommater = [[NSDateFormatter alloc] init];
    fommater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *time = [fommater stringFromDate:date];
    [inputMethot setValue:time forKey:@"gmt_payment"];
    [inputMethot setValue:amount forKey:@"total_fee"];
    
    manager.requestSerializer.timeoutInterval = 30;
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",@"http://192.168.32.95:8080/api",@"payNotify/alipay.do"];
//    //http://192.168.32.95:8080/api/payNotify/alipay.do
    
    [manager POST:urlStr parameters:inputMethot progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"-----responseObject---%@-----%@",responseObject,dataStr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--------error---%@",error);

    }];
    
}
//	判断用户是否能升B
+(void)PostTheUserUpToBWithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:GJ_UserID forKey:@"userId"];
    
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"hasUpgradeRight" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--判断用户是否能升B-------%@",responseObject);
        NSLog(@"resdic---判断用户是否能升B---*******---%@",responseObject[@"respMsg"]);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if (block) {
            block(respCode,respMsg,nil,nil,nil,nil);
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---判断用户是否能升B----request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
 
}

//	获取车险投保地区
+(void)PostTheAddressWithTheCompanyCode:(NSString *)companyCode WithTheAreaCode:(NSString *)areaCode WithBlock:(SpecialsListBlock)block
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:companyCode forKey:@"companyCode"];
    [inputMethot setValue:[NSString stringWithFormat:@"%@",areaCode] forKey:@"areaCode"];

    NSLog(@"---%@",inputMethot);
    
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getAvaCarAreas" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--获取车险投保地区-------%@",responseObject);
        NSLog(@"resdic--获取车险投保地区---*******---%@",responseObject[@"respMsg"]);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *outPut = responseObject[@"output"];
            NSArray *listArray = outPut[@"areaList"];
            
            __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CarNumberModel *model = [[CarNumberModel alloc] init];
                [model setValuesForKeysWithDictionary:obj];
                [array addObject:model];
            }];
            
//            NSLog(@"array++++++++=======%@",array);
            
            if (block) {
                block(respCode,respMsg,nil,nil,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---获取车险投保地区----request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];

}
//查询车辆是否可以投保
+(void)PostTheCarWithTheChEckMsgWithcompanyCode:(NSString *)companyCode WithAreaCode:(NSString *)areaCode WithThelicenseNo:(NSString *)licenseNo WithBlock:(SpecialsListBlock)block{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:companyCode forKey:@"companyCode"];
    [inputMethot setValue:areaCode forKey:@"areaCode"];
    [inputMethot setValue:licenseNo forKey:@"licenseNo"];

    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"checkCarInsState" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--查询车辆是否可以投保-------%@",responseObject);
        NSLog(@"resdic--查询车辆是否可以投保---*******---%@",responseObject[@"respMsg"]);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *outPut = responseObject[@"output"];
            
            NSString *serialId = outPut[@"serialId"];
            NSString *state = outPut[@"state"];
            
            if (block) {
                block(respCode,respMsg,state,serialId,nil,nil);
            }
        }
        
//        if (block) {
//            block(respCode,respMsg,nil,nil,nil,nil);
//        }
        
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---获取车险投保地区----request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];

}
//补充车辆信息
+(void)PostTheCarMsgWithTheAddserialId:(NSString *)serialId WithextractComp:(NSString *)extractComp WithmodelType:(NSString *)modelType WithvinNo:(NSString *)vinNo WithengineNo:(NSString *)engineNo WithfirstRegDate:(NSString *)firstRegDate Withseats:(NSString *)seats WithsyStartDate:(NSString *)syStartDate WithjqStartDate:(NSString *)jqStartDate WithtransferFlag:(NSString *)transferFlag WithtransferDate:(NSString *)transferDate WithdriveName:(NSString *)driveName WithidNo:(NSString *)idNo Withmobile:(NSString *)mobile WithBlock:(SpecialsListBlock)block
{
    
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:serialId forKey:@"serialId"];
    [inputMethot setValue:extractComp forKey:@"extractComp"];
    [inputMethot setValue:modelType forKey:@"modelType"];
    [inputMethot setValue:vinNo forKey:@"vinNo"];
    [inputMethot setValue:engineNo forKey:@"engineNo"];
    [inputMethot setValue:firstRegDate forKey:@"firstRegDate"];
    [inputMethot setValue:seats forKey:@"seats"];
    [inputMethot setValue:syStartDate forKey:@"syStartDate"];
    [inputMethot setValue:jqStartDate forKey:@"jqStartDate"];
    [inputMethot setValue:transferFlag forKey:@"transferFlag"];
    [inputMethot setValue:transferDate forKey:@"transferDate"];
    [inputMethot setValue:driveName forKey:@"driveName"];
    [inputMethot setValue:idNo forKey:@"idNo"];
    [inputMethot setValue:mobile forKey:@"mobile"];
    [inputMethot setValue:@[] forKey:@"extractCarProps"];

    
    
    
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"compCarProps" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--补充车辆信息-------%@",responseObject);
        NSLog(@"resdic--补充车辆信息--*******---%@",responseObject[@"respMsg"]);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        
        if ([respCode isEqualToString:@"000000"]) {
//            NSDictionary *outPut = responseObject[@"output"];
            
        }
        
                if (block) {
                    block(respCode,respMsg,nil,nil,nil,nil);
                }
        
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---获取车险投保地区----request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
//用户升级C2B
+(void)PostUpToBWithBlock:(SpecialsListBlock)block;
{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:GJ_UserID forKey:@"userId"];
    
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"updateUpgradeB" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--用户升级C2B-------%@",responseObject);
        NSLog(@"resdic--用户升级C2B---*******---%@",responseObject[@"respMsg"]);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
//        if ([respCode isEqualToString:@"000000"]) {
////            NSDictionary *outPut = responseObject[@"output"];
////            
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
//        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---用户升级C2B----request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];

}
//获取消息
+(void)PostTheMessageWithMsgType:(NSString *)msgType Withsts:(NSString *)sts WithpageIndex:(NSString *)pageIndex WithBlock:(MsgListBlock)block{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:GJ_UserID forKey:@"userId"];
    [inputMethot setValue:msgType forKey:@"msgType"];
    [inputMethot setValue:sts forKey:@"sts"];
    [inputMethot setValue:pageIndex forKey:@"pageIndex"];

    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getMsgs" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--获取消息-------%@",responseObject);
        NSLog(@"resdic--获取消息---*******---%@",responseObject[@"respMsg"]);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *outPut = responseObject[@"output"];
            NSString *pageSize = outPut[@"pageSize"];
            NSString *totalCount = outPut[@"totalCount"];
            NSString *unReadCount = outPut[@"unReadCount"];

            NSArray *msgList = outPut[@"msgList"];
            __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [msgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MessageModel *model = [[MessageModel alloc] init];
                [model setValuesForKeysWithDictionary:obj];
                [array addObject:model];
            }];
            if (block) {
                block(respCode,respMsg,pageSize,totalCount,unReadCount,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---获取消息---request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,nil,error);
        }
    }];
}
//阅读消息
+(void)PostTheReadMessageWithMsgId:(NSString *)msgId WithBlock:(MsgListBlock)block{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:GJ_UserID forKey:@"userId"];
    [inputMethot setValue:@"1" forKey:@"msgType"];
    [inputMethot setValue:msgId forKey:@"msgId"];
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"readMsg" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--阅读消息-------%@",responseObject);
        NSLog(@"resdic--阅读消息---*******---%@",responseObject[@"respMsg"]);
//        NSString *respCode = responseObject[@"respCode"];
//        NSString *respMsg = responseObject[@"respMsg"];
//        if ([respCode isEqualToString:@"000000"]) {
//            NSDictionary *outPut = responseObject[@"output"];
//            NSString *pageSize = outPut[@"pageSize"];
//            NSString *totalCount = outPut[@"totalCount"];
//            NSString *unReadCount = outPut[@"unReadCount"];
//            
//            NSArray *msgList = outPut[@"msgList"];
//            __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//            [msgList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                MessageModel *model = [[MessageModel alloc] init];
//                [model setValuesForKeysWithDictionary:obj];
//                [array addObject:model];
//            }];
//            if (block) {
//                block(respCode,respMsg,pageSize,totalCount,unReadCount,array,nil);
//            }
//        }else{
//            if (block) {
//                block(respCode,respMsg,nil,nil,nil,nil,nil);
//            }
//        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---阅读消息---request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,nil,error);
        }
    }];
}
//获取系统搜索热词
+(void)PostTheSetHotKeysWithBlock:(SpecialsListBlock)block{
    NSMutableDictionary *inputMethot = [[NSMutableDictionary alloc] init];
    [inputMethot setValue:@"1" forKey:@"pageIndex"];
    [inputMethot setValue:@"10" forKey:@"pageSize"];
    
    [LYAFNetworking POST:urlHost lyparameters:inputMethot lyprogress:@"getHotKeys" lysuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"resdic--获取系统搜索热词-------%@",responseObject);
        NSLog(@"resdic--获取系统搜索热词---*******---%@",responseObject[@"respMsg"]);
        NSString *respCode = responseObject[@"respCode"];
        NSString *respMsg = responseObject[@"respMsg"];
        if ([respCode isEqualToString:@"000000"]) {
            NSDictionary *outPut = responseObject[@"output"];
            NSString *pageSize = outPut[@"pageSize"];
            NSString *totalCount = outPut[@"totalCount"];
//
            NSArray *keyList = outPut[@"keyList"];
            __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            [keyList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SearchModel *model = [[SearchModel alloc] init];
                [model setValuesForKeysWithDictionary:obj];
                [array addObject:model];
            }];
            if (block) {
                block(respCode,respMsg,pageSize,totalCount,array,nil);
            }
        }else{
            if (block) {
                block(respCode,respMsg,nil,nil,nil,nil);
            }
        }
    } lyfailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"---获取消息---request---%@",error);
        if (block) {
            block(nil,nil,nil,nil,nil,error);
        }
    }];
}
@end
