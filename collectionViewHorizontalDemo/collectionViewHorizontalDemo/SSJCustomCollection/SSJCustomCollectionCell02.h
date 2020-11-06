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


@interface SSJCustomCollectionCell02 : SSJCustomCollectionFactoryCell


@property (strong, nonatomic) IBOutlet UIImageView *addLogo_imageView;
@property (strong, nonatomic) IBOutlet UIImageView *detail_imageView;

@property (strong,nonatomic) IBOutlet UIButton *delete_button;


/** 刷新数据 */
- (void)refurbishUIWithModel:(SSJCustomCollectionCellModel *)model everyLineCount:(NSInteger)everyLineCount;

- (void)refurbishImageWithAdd;



/**
 *  返回cell高度
 *
 *  @param wid cell已确定好的宽度
 *
 *  @return <#return value description#>
 */
- (float)cellHeightWithWidth:(float)wid;
@end
