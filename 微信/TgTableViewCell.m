//
//  TgTableViewCell.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "TgTableViewCell.h"
#import "TgModel.h"
@implementation TgTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TgModel *)model{
    _model = model;

    _icon.image = [UIImage imageNamed:model.icon];
    _title.text = model.title;
    _price.text = model.price;
    _buycount.text = model.buycount;
}

@end
