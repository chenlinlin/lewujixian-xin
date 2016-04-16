//
//  VodeoCell.h
//  乐无极限
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface VodeoCell : UITableViewCell

@property(nonatomic,strong)VideoModel *model;
@property(nonatomic,strong)UILabel *titelLabel;

@property(nonatomic,strong)UILabel *shijianLabel;

@property(nonatomic,strong)UIImageView *imgView0;

@property(nonatomic,strong)UILabel *contLabel;
@property(nonatomic,strong)UIButton *buttt;

@property(nonatomic,strong)UILabel *changduLabel;
@end
