//
//  SSJCustomCollectionView.h
//  SSJMap
//
//  Created by 金汕汕 on 2018/6/7.
//  Copyright © 2018年 ccs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSJCustomCollectionCellModel;
@interface SSJCustomCollectionView : UIView
@property (nonatomic,strong) NSMutableArray <SSJCustomCollectionCellModel *>*importItems;
/**
 *  collectionViewCell 类名字符串
 */
@property (nonatomic,strong) NSString *collectionViewCellClassName;

/**
 *  collectionViewCell  指定字符串（作为内存中的唯一标识）
 */
@property (nonatomic,strong) NSString *collectionViewCellIden;

/** 获得实际view所占高度 */
- (float)gainViewHeight;

/**
 *  告诉上一层 需要更新本view的高度
 *
 *  @param heightNew   需要更新的高度值
 *  @param importItems 当前的数据源
 */
typedef void (^UpdateHeightBlock)(float heightNew,NSMutableArray <SSJCustomCollectionCellModel *>*importItems);
@property (nonatomic,copy) UpdateHeightBlock updateHeightBlock;
@end
