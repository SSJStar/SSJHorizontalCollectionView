//
//  SSJCustomCollectionFactoryCell.h
//  SSJMap
//
//  Created by 金汕汕 on 2018/6/7.
//  Copyright © 2018年 ccs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSJCustomCollectionCellModel;
@class SSJCustomCollectionView;

@interface SSJCustomCollectionFactoryCell : UICollectionViewCell

@property (nonatomic,strong) SSJCustomCollectionView *lastSuperView;//调用本cell的view
/**
 *  block回掉刷新数据
 *
 *  @param list <#list description#>
 */
typedef void (^RefurbishBlock)(NSMutableArray <SSJCustomCollectionCellModel *>* list);
@property (nonatomic,copy) RefurbishBlock refurbishBlock;

/**
 *  添加"+"
 */
- (void)refurbishImageWithAdd;

/**
 *  刷新cell数据
 *
 *  @param model          cell模型
 *  @param everyLineCount 每一行的个数，用来确定cell内容大小
 */
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
