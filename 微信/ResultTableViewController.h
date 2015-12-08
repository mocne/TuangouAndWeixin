//
//  ResultTableViewController.h
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *datas;

@end
