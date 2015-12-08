//
//  TXLTableViewCell.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "TXLTableViewCell.h"
#import "Friend.h"

@implementation TXLTableViewCell

-(void)setFriend:(Friend *)friend{
    _friend = friend;
    
    self.textLabel.text = friend.name;
    self.detailTextLabel.text = friend.status;
    self.imageView.image = [UIImage imageNamed:friend.icon];
    self.textLabel.textColor = friend.vip ? [UIColor redColor] : [UIColor blackColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
