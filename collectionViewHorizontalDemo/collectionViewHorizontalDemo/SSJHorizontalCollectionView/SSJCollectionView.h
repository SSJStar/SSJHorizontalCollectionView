//
//  SSJCollectionView.h
//  collectionViewHorizontalDemo
//
//  Created by SSJ on 2020/7/20.
//  Copyright © 2020 SSJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ScrollDirection) {
    ///横向滚动
    ScrollDirectionOfX = 1,
    ///纵向滚动
    ScrollDirectionOfY = 2,
};
NS_ASSUME_NONNULL_BEGIN

@interface SSJCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
///cell在内存里的唯一标识符
@property (nonatomic , strong) NSString *cellIdentifier;
///cell Xib名字，需要和cell类名统一
@property (nonatomic , strong) NSString *cellNibName;
///cell宽高，默认(80,80)
@property (nonatomic , assign) CGSize cellSize;
///cell之间的间距,默认0
@property (nonatomic , assign) float cellSpacing;
///数据源
@property (nonatomic , strong) NSArray *datasource;
///滚动方向
@property (nonatomic,assign) ScrollDirection scrollDirection;
///cell点击触发block回调
typedef void (^CellClickBlock)(UICollectionView *collectionView,NSIndexPath *indexPath);
@property (nonatomic , copy) CellClickBlock cellClickBlock;

@end

NS_ASSUME_NONNULL_END

/** 使用案例
 
 - (void)viewWillAppear:(BOOL)animated{
     CellModel *model01 = [CellModel new];
     model01.iconName = @"";
     model01.title = @"首页";
     CellModel *model02 = [CellModel new];
     model02.iconName = @"";
     model02.title = @"新闻";
     [self.datas addObjectsFromArray:@[model01,model02]];
     
     SSJHorizontalCollectionView *co = [SSJHorizontalCollectionView alloc];
     co.cellIdentifier = CollectionViewCell01Iden;
     co.datasource = self.datas;
     co.cellNibName = @"CollectionViewCell01";
     co.cellSpacing = 0;
     co.backgroundColor = [UIColor whiteColor];
     co.scrollDirection = ScrollDirectionOfY;///这里修改滚动方向
     co.cellClickBlock = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
         NSLog(@"点击了%ld",(long)indexPath.row);
     };
     co = [co initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 80)];
     [self.view addSubview:co];
 
     /// 补充说明一下：
     /// 需要自定义一个CollectionViewCell,继承SSJHorizontalFatoryCollectionCell，并实现refreshUI:方法
     /// CollectionViewCell01Iden是自定义cell里的唯一标识符，按照自己定义的填充就好了
     /// CellModel是自己定义的model类，你可以按照你自己的类名处理，
     /// 在refreshUI:里，model参数是id类型，需要强转一下
 }
 
 /// 这样封装的意义在于，针对不同的cell业务逻辑，只要在相应的自定义cell里面进行处理即可，不需要每次都写一遍CollectionView
 */
