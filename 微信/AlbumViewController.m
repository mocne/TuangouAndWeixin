//
//  AlbumViewController.m
//  微信
//
//  Created by qingyun on 15/12/7.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define TableViewHeaderImageNum 3

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.contentSize = CGSizeMake(kScreenW * TableViewHeaderImageNum, 0);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
