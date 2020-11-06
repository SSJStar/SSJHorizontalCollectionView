# SSJHorizontalCollectionView
collectionView scrolling horizontally or vertically(横向或纵向滚动的collectionView)

- - 使用案例
 
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
