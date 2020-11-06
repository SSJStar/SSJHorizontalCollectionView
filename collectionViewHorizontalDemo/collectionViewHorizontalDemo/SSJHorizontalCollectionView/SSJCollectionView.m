//
//  SSJHorizontalCollectionView.m
//  collectionViewHorizontalDemo
//
//  Created by SSJ on 2020/7/20.
//  Copyright © 2020 SSJ. All rights reserved.
//

#import "SSJCollectionView.h"
#import "SSJHorizontalFatoryCollectionCell.h"

@interface SSJCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSString *cellIdentifierDefault;
@end
@implementation SSJCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = self.cellSpacing;
        //设置collectionView滚动方向
        if(self.scrollDirection == ScrollDirectionOfX){
            [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        }else if(self.scrollDirection == ScrollDirectionOfY){
            [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        }else{
            [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        }
        //2.初始化collectionView
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        //3.注册collectionViewCell
        if(self.cellNibName.length > 0){
            [self.collectionView registerNib:[UINib nibWithNibName:self.cellNibName bundle:nil] forCellWithReuseIdentifier:self.cellIdentifier];
        }
        //4.设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        self.cellIdentifierDefault = @"cellIdentifierDefault";
    }
    return self;
}


/********************************************************************************/
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/////消除警告：“Undeclared selector 'cellRefreshMethodName:”
//#pragma GCC diagnostic ignored "-Wundeclared-selector"

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**< SSJHorizontalFatoryCollectionCell是工厂cell */
    if (self.cellIdentifier.length > 0) {
        self.cellIdentifierDefault = self.cellIdentifier;
    }
    SSJHorizontalFatoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
//    NSArray *co = @[[UIColor yellowColor],
//                    [UIColor orangeColor],
//                    [UIColor blueColor],
//                    [UIColor groupTableViewBackgroundColor],];
//    cell.backgroundColor = co[indexPath.row];
    ///刷新cell数据
    [cell refreshUI:self.datasource[indexPath.row]];
//    if(self.cellRefreshMethodName.length > 0 && [cell respondsToSelector:NSSelectorFromString(self.cellRefreshMethodName)]){
//        ///方式1
////        SEL sel = NSSelectorFromString(self.cellRefreshMethodName);
////         [cell performSelector:sel withObject:self.datasource[indexPath.row]];
//        ///方式2 使用上面这种方式会报警告
////        SEL selector = NSSelectorFromString(self.cellRefreshMethodName);
////        IMP imp = [cell methodForSelector:selector];
////        void (*func)(id, SEL) = (void *)imp;
////        func(cell, selector);
//        ///方式3
////        SEL selector = NSSelectorFromString(@"processRegion:ofView:");
////        SEL selector = NSSelectorFromString(self.cellRefreshMethodName);
////        IMP imp = [cell methodForSelector:selector];
//////        CGRect (*func)(id, SEL, CGRect, UIView *) = (void *)imp;
//////        CGRect result = func(cell, selector, someRect, someView);
////        CGRect (*func)(id, SEL, id) = (void *)imp;
////        func(cell, selector, self.datasource[indexPath.row]);
//
//    }
    
    return cell;
}

///点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellClickBlock) {
        self.cellClickBlock(collectionView, indexPath);
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小  一行只能有everyLineCount个
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.cellSize.width > 0 && self.cellSize.height > 0) {
        return self.cellSize;
    }
    return CGSizeMake(80, 80);
}



@end
