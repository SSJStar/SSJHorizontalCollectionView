//
//  PhotoWithDeleteBtnCollViewCell.h
//  waterPro
//
//  Created by jssName on 15/12/8.
//  Copyright © 2015年 HD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSJCustomCollectionFactoryCell.h"
@class SSJCustomCollectionCellModel;

@interface SSJCustomCollectionCell : SSJCustomCollectionFactoryCell

/**
 *  +号图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *addLogo_imageView;
/**
 *  图片展示内容
 */
@property (strong, nonatomic) IBOutlet UIImageView *detail_imageView;
/**
 *  底部描述文字
 */
@property (strong, nonatomic) IBOutlet UILabel *name_label;
/**
 *  删除按钮
 */
@property (strong,nonatomic) IBOutlet UIButton *delete_button;



/** 显示 “+” */
- (void)refurbishImageWithAdd;

/** 刷新数据 */
- (void)refurbishUIWithModel:(SSJCustomCollectionCellModel *)model everyLineCount:(NSInteger)everyLineCount;


/**
 *  返回cell高度
 *
 *  @param wid cell已确定好的宽度
 *
 *  @return <#return value description#>
 */
- (float)cellHeightWithWidth:(float)wid;
@end
