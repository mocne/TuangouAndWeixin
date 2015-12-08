//
//  FriendGroup.h
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendGroup : NSObject

//声明属性
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger online;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic) BOOL isopen;
//声明初始化方法
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)friendGroupWithDictionary:(NSDictionary *)dict;

@end
