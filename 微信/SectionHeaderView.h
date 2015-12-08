//
//  SectionHeaderView.h
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendGroup;

@interface SectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) FriendGroup *friendGroup;
@property (nonatomic, strong) void (^headerViewClick)(void);

+(instancetype)sectionHeaderViewForTableView:(UITableView *)tableView;

@end
