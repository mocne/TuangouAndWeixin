//
//  TXLViewController.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "TXLViewController.h"
#import "Friend.h"
#import "FriendGroup.h"
#import "TXLTableViewCell.h"
#import "SectionHeaderView.h"


@interface TXLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *fritnds;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TXLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //消除tabBar对tableView的影响
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // Do any additional setup after loading the view.
}


//懒加载
-(NSMutableArray *)fritnds{
    if (_fritnds == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            FriendGroup *friendGroup = [FriendGroup friendGroupWithDictionary:dict];
            [models addObject:friendGroup];
        }
        _fritnds = models;
    }
    return _fritnds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.fritnds.count;
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FriendGroup *friendGroup = self.fritnds[section];
    if (friendGroup.isopen) {
        return friendGroup.friends.count;
    }
    return 0;
}
//单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    TXLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TXLTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    FriendGroup *friendGroup = self.fritnds[indexPath.section];
    Friend *friend = friendGroup.friends[indexPath.row];
    cell.friend = friend;
    return cell;
}

//section头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
//section头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //创建自定义的section的头视图
    SectionHeaderView *headerView = [SectionHeaderView sectionHeaderViewForTableView:tableView];
    FriendGroup *friendGroup = self.fritnds[section];
    headerView.friendGroup = friendGroup;
    
    headerView.headerViewClick = ^{
        
        [tableView reloadData];
    };
    
    return headerView;
}

//设置点击左barBtn事件title
- (IBAction)rightBarBtnClick:(UIBarButtonItem *)sender {
    if (_tableView.editing == NO) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        [_tableView setEditing:YES animated:YES];
    }else{
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [_tableView setEditing:NO animated:YES];
    }
}

//配置编辑许可
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

//配置编辑模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


//编辑表格视图重写
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [_fritnds removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

//覆盖原表格视图
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    FriendGroup *model = (FriendGroup *)_fritnds[fromIndexPath.row];
    [_fritnds removeObjectAtIndex:fromIndexPath.row];
    [_fritnds insertObject:model atIndex:toIndexPath.row];
    
}


@end
