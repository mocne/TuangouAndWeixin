//
//  TgModel.h
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TgModel : NSObject

@property (nonatomic,strong) NSString *buycount;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)TgModelWithDictionary:(NSDictionary *)dict;

@end
