//
//  TgModel.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "TgModel.h"

@implementation TgModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)TgModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
