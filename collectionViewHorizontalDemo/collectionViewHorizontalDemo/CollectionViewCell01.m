//
//  CollectionViewCell01.m
//  collectionViewHorizontalDemo
//
//  Created by 苏墨 on 2020/7/20.
//  Copyright © 2020 SSJ. All rights reserved.
//

#import "CollectionViewCell01.h"
#import "CellModel.h"
@implementation CollectionViewCell01

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshUI:(id)model{
    if([model isKindOfClass:[CellModel class]]){
        CellModel *cellModel = (CellModel *)model;
        self.iconImageView.image = [UIImage imageNamed:cellModel.iconName];
        self.titleLabel.text = cellModel.title;
    }
}
@end
