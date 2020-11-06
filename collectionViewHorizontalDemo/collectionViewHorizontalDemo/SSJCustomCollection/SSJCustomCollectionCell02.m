//
//  PhotoWithDeleteBtnCollViewself.m
//  waterPro
//
//  Created by jssName on 15/12/8.
//  Copyright © 2015年 HD. All rights reserved.
//

#import "SSJCustomCollectionCell02.h"
#import "SSJCustomCollectionCellModel.h"
#import "SSJCustomCollectionView.h"

@implementation SSJCustomCollectionCell02

- (void)awakeFromNib {
    // Initialization code
}
- (void)refurbishImageWithAdd{
    self.addLogo_imageView.image = [UIImage imageNamed:@"netpan_icon_add"];
    self.detail_imageView.image = [UIImage new];
    if (self.lastSuperView) {
        UITapGestureRecognizer *tagSingle=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        tagSingle.numberOfTapsRequired=1;
        [self removeAllUIGestureRecognizer];
        [self.detail_imageView addGestureRecognizer:tagSingle];
    }
    
    
    [self.detail_imageView setExclusiveTouch:YES];
    [self.detail_imageView setUserInteractionEnabled:YES];
    
    
    self.delete_button.hidden=TRUE;
    
    self.detail_imageView.layer.masksToBounds = NO;
    self.detail_imageView.layer.cornerRadius = 0;
    
    self.addLogo_imageView.hidden = FALSE;
}

- (void)refurbishUIWithModel:(SSJCustomCollectionCellModel *)model everyLineCount:(NSInteger)everyLineCount{
    self.detail_imageView.image = model.image;
    //给imageView画圆
    self.detail_imageView.layer.masksToBounds = YES;
    float widthFloat = (SSJSCREEN_WIDTH-15*2-20*4)/everyLineCount;
    self.detail_imageView.layer.cornerRadius = widthFloat/2;
    self.addLogo_imageView.hidden = TRUE;//隐藏加号
    self.delete_button.hidden = NO;
    
    [self setSomeThing];
}




- (void)setSomeThing{
    
    self.delete_button.hidden = FALSE;
//    [self.delete_button addTarget:self action:@selector(deleteButtonHandel:) forControlEvents:UIControlEventTouchUpInside];
    //设置tag,删除的时候就以tag值为图片对应数组所在位置
    self.delete_button.tag=1000+self.tag;
    
    // 设置放大
    UITapGestureRecognizer *tagSingle=[[UITapGestureRecognizer alloc]initWithTarget:self.lastSuperView action:@selector(singleTapImgBig:)];
    tagSingle.numberOfTapsRequired=1;
    UITapGestureRecognizer *tagDouble=[[UITapGestureRecognizer alloc]initWithTarget:self.lastSuperView action:@selector(doubleTapImgBig:)];
    tagDouble.numberOfTapsRequired=2;
    [tagSingle requireGestureRecognizerToFail:tagDouble];
    [self removeAllUIGestureRecognizer];
    [self.detail_imageView addGestureRecognizer:tagSingle];
    [self.detail_imageView addGestureRecognizer:tagDouble];
    
    [self.detail_imageView setExclusiveTouch:YES];
    [self.detail_imageView setUserInteractionEnabled:YES];
    
}


- (void)removeAllUIGestureRecognizer{
    for (UIGestureRecognizer *res in self.detail_imageView.gestureRecognizers) {
        [self.detail_imageView removeGestureRecognizer:res];
    }
}

#pragma mark - UIGestureRecognizer  点击加号 新增
-(void)singleTap:(UITapGestureRecognizer*)recognizer{
    
    SSJCustomCollectionCellModel *userList6 = [SSJCustomCollectionCellModel new];
    userList6.modelID = @"d436ad22924d4394ac397a144bfb2dec";
    userList6.image=[UIImage imageNamed:@"testImg.jpg"];
    [self.lastSuperView.importItems addObject:userList6];
//    [self changeFootview:self.photo_collection];
//    [self.photo_collection reloadData];
    if ([recognizer.view isKindOfClass:[UIImageView class]]) {
        if (self.refurbishBlock) {
            self.refurbishBlock(self.lastSuperView.importItems);
        }
        
    }
}
-(void)doubleTap:(UITapGestureRecognizer*)recognizer{
}
#pragma mark -- 点击头像
-(void)singleTapImgBig:(UITapGestureRecognizer*)recognizer{
    if ([recognizer.view isKindOfClass:[UIImageView class]]) {
        
        
    }
}
-(void)doubleTapImgBig:(UITapGestureRecognizer*)recognizer{
}

- (IBAction)deleteButtonHandel:(id)seneder{
    UIButton *clickButton = (UIButton *)seneder;
    NSInteger deleteIndex = clickButton.tag >= 1000 ?(clickButton.tag - 1000):(clickButton.tag);
    [self.lastSuperView.importItems removeObjectAtIndex:deleteIndex];
    NSLog(@"删除后个数:%d",(int)[self.lastSuperView.importItems count]);
    if (self.refurbishBlock) {
        self.refurbishBlock(self.lastSuperView.importItems);
    }
}

- (float)cellHeightWithWidth:(float)wid{
    return  wid + 8;
}
@end
