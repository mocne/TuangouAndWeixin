//
//  ViewController.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "TgModel.h"
#import "TgTableViewCell.h"

#import "ResultTableViewController.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

//头部滚动视图的图片张数
#define TableViewHeaderImageNum 3

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *TgModels;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //消除tabBar对tableView的影响
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    //添加头部滚动视图
    [self addHeaderView];
    
    [self addresuleVC];
    
}

//数据转模型
- (NSMutableArray *)TgModels{
    if (_TgModels == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        
        NSArray *models = [NSArray arrayWithContentsOfFile:path];
        
        _TgModels = [NSMutableArray array];
        
        for (NSDictionary *dict in models) {
            TgModel *model = [TgModel TgModelWithDictionary:dict];
            
            [_TgModels addObject:model];
        }
    }
    return _TgModels;
}
//设置tableView的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.TgModels.count;
}

//配置行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    TgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TgCell" forIndexPath:indexPath];
    
    //配置cell
    TgModel *model = self.TgModels[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

//tableView的头部滚动视图
- (void)addHeaderView{

    //添加表格头视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    //contentSize设置为scrollView的大小，可以取消上下滑动
    scrollView.contentSize = CGSizeMake(kScreenW * TableViewHeaderImageNum, 0);
    scrollView.pagingEnabled = YES;
    for (int i = 0; i < TableViewHeaderImageNum; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW * i, 0, kScreenW, 100)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i + 1]];
        [scrollView addSubview:imageView];
    }
    
    scrollView.backgroundColor = [UIColor blackColor];
    
    UIPageControl *pageControll = [[UIPageControl alloc] initWithFrame:scrollView.frame];
    pageControll.numberOfPages = 3;
    pageControll.currentPage = 0;
    pageControll.pageIndicatorTintColor = [UIColor redColor];
    pageControll.currentPageIndicatorTintColor = [UIColor blueColor];
    [pageControll addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:pageControll];
    
    scrollView.scrollEnabled = NO;
    
    
    self.tableView.tableHeaderView = scrollView;
}

-(void)pageControlClick:(UIPageControl *)pageControl
{
//    [pageControl performSelector:@selector(pageChanged:) withObject:nil afterDelay:2];
    NSInteger page = pageControl.currentPage++;
    pageControl.currentPage = page;
}


//设置点击左barBtn事件title
- (IBAction)leftBarBtnClick:(UIBarButtonItem *)sender {
    if (_tableView.editing == NO) {
        self.navigationItem.leftBarButtonItem.title = @"完成";
        [_tableView setEditing:YES animated:YES];
    }else{
        self.navigationItem.leftBarButtonItem.title = @"编辑";
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
        [_TgModels removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

//覆盖原表格视图
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    TgModel *model = (TgModel *)_TgModels[fromIndexPath.row];
    [_TgModels removeObjectAtIndex:fromIndexPath.row];
    [_TgModels insertObject:model atIndex:toIndexPath.row];
    
}

//设置右barBtn点击事件
- (IBAction)search:(UIBarButtonItem *)sender {
    
    [self presentViewController:_searchController animated:YES completion:nil];
    
}

- (void)addresuleVC{

    //创建结果视图控制器
    ResultTableViewController *resuleVC = [[ResultTableViewController alloc] init];
    resuleVC.datas = _TgModels;
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resuleVC];
    //设置代理
    _searchController.searchResultsUpdater = resuleVC;
    
    //设置蒙版
    _searchController.dimsBackgroundDuringPresentation = YES;
    
    //设置导航栏隐藏
    _searchController.hidesNavigationBarDuringPresentation = YES;

}

@end
