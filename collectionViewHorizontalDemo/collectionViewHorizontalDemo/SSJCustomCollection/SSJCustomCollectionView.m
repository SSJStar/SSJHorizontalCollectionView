//
//  SSJCustomCollectionView.m
//  SSJMap
//
//  Created by 金汕汕 on 2018/6/7.
//  Copyright © 2018年 ccs. All rights reserved.
//

#import "SSJCustomCollectionView.h"
#import "SSJCustomCollectionFactoryCell.h"
#import "SSJCustomCollectionCell.h"
#import "SSJCustomCollectionCellModel.h"
static NSInteger everyLineCount = 4;

@interface SSJCustomCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *photo_collection;

@end
@implementation SSJCustomCollectionView
/** 获得实际view所占高度 */
- (float)gainViewHeight {
    return self.photo_collection.contentSize.height;
}

- (void)drawRect:(CGRect)rect{
    [self creatCollectionView];
    self.photo_collection.delegate=self;
    self.photo_collection.dataSource=self;
    self.photo_collection.backgroundColor=[UIColor clearColor];
    
    self.importItems=[NSMutableArray <SSJCustomCollectionCellModel *> new];
    
    [self setTableFootView];
    [self gainListRequest];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _photo_collection.frame = self.bounds;
}
//创建collectionView
-(void)creatCollectionView{
    if (!_photo_collection) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        //    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 100);
        //该方法也可以设置itemSize
        //    layout.itemSize =CGSizeMake(0, 150);
        
        //2.初始化collectionView
        _photo_collection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        [self addSubview:_photo_collection];
        _photo_collection.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
//        [_photo_collection registerClass:[SSJCustomCollectionCell class] forCellWithReuseIdentifier:self.collectionViewCellIden];
        [self.photo_collection registerNib:[UINib nibWithNibName:self.collectionViewCellClassName bundle:nil] forCellWithReuseIdentifier:self.collectionViewCellIden];
        
        //    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        //    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        //4.设置代理
        _photo_collection.delegate = self;
        _photo_collection.dataSource = self;
        [_photo_collection removeFromSuperview];
        [self addSubview:_photo_collection];
    }
    
    
}




/********************************************************************************/
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section != [self.importItems count]/everyLineCount) {//如果不是最后一行
        return everyLineCount;
    }else{
        return  [self.importItems count]+1 - section*everyLineCount ;
    }
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.importItems count]/everyLineCount+1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**< SSJCustomCollectionFactoryCell是工厂cell */
    SSJCustomCollectionFactoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.collectionViewCellIden forIndexPath:indexPath];
    cell.lastSuperView = self;
    int currentIndex =  (indexPath.section) *everyLineCount+indexPath.item;
    cell.tag = currentIndex;
    if(currentIndex==[self.importItems count]  || [self.importItems count]==0){
        NSLog(@"没有删除按钮--%d",(int)indexPath.item);
        [cell refurbishImageWithAdd];
    }else{
        if (currentIndex != self.importItems.count) {//最后一张图片的数据源不在self.importItems里
            SSJCustomCollectionCellModel *info = self.importItems[(indexPath.section) *everyLineCount+indexPath.item];
            
            [cell refurbishUIWithModel:info everyLineCount:everyLineCount];
        }else{
            
            [cell refurbishImageWithAdd];
        }
    }
    cell.refurbishBlock = ^(NSMutableArray <SSJCustomCollectionCellModel *>* list){
        [self.photo_collection reloadData];
        /**< 更新外部高度 */
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*0.1), dispatch_get_main_queue(), ^{
            if (self.updateHeightBlock) {
                self.updateHeightBlock(weakSelf.photo_collection.contentSize.height,weakSelf.importItems);
            }
        });
        
    };
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小  一行只能有everyLineCount个
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float widthFloat = (SSJSCREEN_WIDTH-15*2-20*4)/everyLineCount;
//    return CGSizeMake(widthFloat, widthFloat+20);//高度加20是为了给名字留位置
    SSJCustomCollectionFactoryCell *cell = [NSClassFromString(self.collectionViewCellClassName) new];
    return CGSizeMake(widthFloat, [cell cellHeightWithWidth:widthFloat]);
}


/********************************************************************************/
// 初始化footview
-(void)setTableFootView{
    //    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
    //    UIImageView *backImag=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-94)/2, 100, 94, 98)];
    //    backImag.image=[UIImage imageNamed:@"cry"];
    //    [self.footView addSubview:backImag];
    //
    //    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 220, 200, 20)];
    //    lab.text = @"暂无数据";
    //    lab.textColor = [UIColor colorWithHexString:@"#cccccc"];
    //    lab.font = [UIFont systemFontOfSize:18];
    //    lab.textAlignment = NSTextAlignmentCenter;
    //    [self.footView addSubview:lab];
    //
    //    self.footView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 320);
    
    //    self.footView = [[ZJFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320) pictureName:@"CheckIn_icon_kl" remainStr:@"暂无数据" clickBlock:nil];
    //    [self.view addSubview:self.footView];
}

#pragma mark  footview
// 更改footview
-(void)changeFootview:(UICollectionView *)collectionView
{
    //    if (collectionView == self.photo_collection) {
    //        if (self.importItems.count == 0){
    //            self.footView.hidden=NO;
    ////            self.footView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 320);
    ////            self.photo_collection.tableFooterView = self.footView;
    //        }else{
    //            self.footView.hidden=YES;
    ////            self.footView.frame=CGRectZero;
    ////            self.myShareTB.tableFooterView=self.footView;
    //        }
    //    }
}

#pragma mark   网络请求 每次请求 服务端都会先校验当前用户是否有权限获取列表信息
// 请求数据
- (void)gainListRequest{
    SSJCustomCollectionCellModel *userList1 = [SSJCustomCollectionCellModel new];
    userList1.modelID = @"35";
    userList1.image=[UIImage imageNamed:@"testImg.jpg"];
        userList1.describeStr = @"张恒";
    //    userList1.usercount = @"23";
    //    userList1.userroleType = @"0";
    
    SSJCustomCollectionCellModel *userList2 = [SSJCustomCollectionCellModel new];
    userList2.modelID = @"36";
    userList2.image=[UIImage imageNamed:@"testImg.jpg"];
        userList2.describeStr = @"王邱";
    //    userList2.usercount = @"33";
    //    userList2.userroleType = @"1";
    
    SSJCustomCollectionCellModel *userList3 = [SSJCustomCollectionCellModel new];
    userList3.modelID = @"37";
    userList3.image=[UIImage imageNamed:@"testImg.jpg"];
        userList3.describeStr = @"林何";
    //    userList3.usercount = @"37";
    //    userList3.userroleType = @"1";
    
    SSJCustomCollectionCellModel *userList4 = [SSJCustomCollectionCellModel new];
    userList4.modelID = @"38";
    userList4.image=[UIImage imageNamed:@"testImg.jpg"];
        userList4.describeStr = @"王穆";
    //    userList4.usercount = @"56";
    //    userList4.userroleType = @"2";
    
    SSJCustomCollectionCellModel *userList5 = [SSJCustomCollectionCellModel new];
    userList5.modelID = @"39";
    userList5.image=[UIImage imageNamed:@"testImg.jpg"];
        userList5.describeStr = @"贾有钱";
    //    userList5.usercount = @"47";
    //    userList5.userroleType = @"3";
    
    SSJCustomCollectionCellModel *userList6 = [SSJCustomCollectionCellModel new];
    userList6.modelID = @"d436ad22924d4394ac397a144bfb2dec";
    userList6.image=[UIImage imageNamed:@"testImg.jpg"];
        userList6.describeStr = @"金汕汕";
    //    userList6.usercount = @"97";
    //    userList6.userroleType = @"1";
    
    
    [self.importItems addObjectsFromArray:@[userList1,userList2,userList3,userList4,userList5,userList6]];
    //    self.importItems = [NSMutableArray new];
    [self changeFootview:self.photo_collection];
    [self.photo_collection reloadData];
    /**< 更新外部高度 */
    if (self.updateHeightBlock) {
        self.updateHeightBlock(self.photo_collection.contentSize.height,self.importItems);
    }
}
@end
