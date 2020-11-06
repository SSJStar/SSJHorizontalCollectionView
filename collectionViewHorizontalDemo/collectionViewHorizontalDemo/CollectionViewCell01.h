//
//  CollectionViewCell01.h
//  collectionViewHorizontalDemo
//
//  Created by 苏墨 on 2020/7/20.
//  Copyright © 2020 SSJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSJHorizontalFatoryCollectionCell.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const CollectionViewCell01Iden = @"CollectionViewCell01Iden";
@interface CollectionViewCell01 : SSJHorizontalFatoryCollectionCell
@property (nonatomic , weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic , weak) IBOutlet UILabel *titleLabel;
///刷新方法
- (void)refreshUI:(id)model;
@end

NS_ASSUME_NONNULL_END
