//
//  Friend.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "Friend.h"

@implementation Friend

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)friendWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

@end
