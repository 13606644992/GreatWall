//
//  Customer.m
//  GreatWall
//
//  Created by GJ on 2017/3/13.
//  Copyright © 2017年 GJ. All rights reserved.
//

#import "Customer.h"

@implementation Customer

-(Customer *)initWithName:(NSString *)name{
    if(self=[super init]){
        self.insuredName=name;
        self.nameIndex = [self pinyinFirstLetter:name];
    }
    return self;
}

+(Customer *)initWithName:(NSString *)name{
    Customer *customer = [[Customer alloc] initWithName:name];
    return customer;
}

+(instancetype)customerWithDict:(NSDictionary*)dict{
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        //[self setValuesForKeysWithDictionary:dict];
        self.insuredName = [dict objectForKey:@"insuredName"];
        self.nameIndex = [self pinyinFirstLetter:[dict objectForKey:@"insuredName"]];
    }
    return self;
}

//获取字符串首字母
-(NSString*)pinyinFirstLetter:(NSString*) hanzi
{
    NSString *result = @"";
    NSMutableString *ms = [[NSMutableString alloc] initWithString:hanzi];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        //        NSLog(@"pinyin1: %@", ms);
    }
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)){
        //        NSLog(@"pinyin2: %@", ms);
    }
    if (ms.length>0) {
        result = [ms substringToIndex:1];
        //        NSLog(@"pinyin3: %@", result);
    }
    return [result uppercaseString];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
