使用方法
/***

    self.ssjCo.collectionViewCellClassName = @"SSJCustomCollectionCell";
    self.ssjCo.collectionViewCellIden = @"sSJCustomCollectionCellIdentifier";
    self.ssjCo.updateHeightBlock = ^(float heightNew,NSMutableArray <SSJCustomCollectionCellModel *>*importItems){
    self.layoutHeight.constant = heightNew;
    [self.ssjCo layoutSubviews];
};

因为初始化的时候collectionView的高度获取不准确，所以建议
    - (void)viewDidAppear:(BOOL)animated{
        float ssjCOHeight = [self.ssjCo gainViewHeight];
        self.layoutHeight.constant = ssjCOHeight;
        [self.ssjCo layoutSubviews];
    }
*/

／**
    **********************
    ********* 注意 ********
    **********************

    如果需要自定义cell模版，新的cell需要继承自SSJCustomCollectionFactoryCell工厂cell

    新cell需要实现以下方法：
    1、- (void)refurbishImageWithAdd
    2、- (void)refurbishUIWithModel:(SSJCustomCollectionCellModel *)model everyLineCount:(NSInteger)everyLineCount
    3、- (float)cellHeightWithWidth:(float)wid

    需要实现block：
        refurbishBlock
*/