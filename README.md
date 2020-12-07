# SSJHorizontalCollectionView
collectionView scrolling horizontally or vertically(横向或纵向滚动的collectionView)

1、拖拽SSJHorizontalCollectionView文件夹到你的项目里

2、 使用案例
```
 - (void)viewWillAppear:(BOOL)animated{
     CellModel *model01 = [CellModel new];
    model01.iconName = @"icon01";
    model01.title = @"首页";
    
    CellModel *model02 = [CellModel new];
    model02.iconName = @"icon02";
    model02.title = @"新闻";
    
    CellModel *model03 = [CellModel new];
    model03.iconName = @"icon03";
    model03.title = @"娱乐";
    
    CellModel *model04 = [CellModel new];
    model04.iconName = @"icon01";
    model04.title = @"最新消息";
    
    CellModel *model05 = [CellModel new];
    model05.iconName = @"icon02";
    model05.title = @"通告";
    
    CellModel *model06 = [CellModel new];
    model06.iconName = @"icon03";
    model06.title = @"足球赛事";
    
    [self.datas addObjectsFromArray:@[model01,model02,model03,model04,model05,model06]];
    
    SSJCollectionView *co = [SSJCollectionView alloc];
    co.cellIdentifier = CollectionViewCell01Iden;
    co.datasource = self.datas;
    co.cellSize = CGSizeMake(self.view.frame.size.width/4.0, 60);
    co.cellNibName = @"CollectionViewCell01";
    co.cellSpacing = 0;
    co.backgroundColor = [UIColor whiteColor];
    co.scrollDirection = ScrollDirectionOfY;///这里修改滚动方向
    co.cellClickBlock = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了%ld",(long)indexPath.row);
    };
    co = [co initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 60)];
    [self.view addSubview:co];
 
     /// 补充说明一下：
     /// 需要自定义一个CollectionViewCell,继承SSJHorizontalFatoryCollectionCell，并实现refreshUI:方法
     /// CollectionViewCell01Iden是自定义cell里的唯一标识符，按照自己定义的填充就好了
     /// CellModel是自己定义的model类，你可以按照你自己的类名处理，
     /// 在refreshUI:里，model参数是id类型，需要强转一下
 }
```
