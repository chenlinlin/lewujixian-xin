//
//  VodeoCell.m
//  乐无极限
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "VodeoCell.h"
#import "Header.h"
@implementation VodeoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self data];
        
    }
    return self;
}
-(void)data{
    
    self.titelLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 5,ScreenWidth-20 , 30)];
    
    [self.contentView addSubview:self.titelLabel];
    
    self.imgView0 =[[UIImageView alloc] initWithFrame:CGRectMake(20, 40, ScreenWidth-40, ScreenHeight/4)];
    [self.contentView addSubview:self.imgView0];
    
    self.shijianLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.imgView0.frame)+5, ScreenWidth-10, 15)];
    self.shijianLabel.font =[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shijianLabel];
    
    
    self.contLabel =[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.imgView0.frame)-55, 100, 15)];
    self.contLabel.textColor =[UIColor whiteColor];
    self.contLabel.font =[UIFont systemFontOfSize:12];
    [self.imgView0 addSubview:self.contLabel];
    
    self.changduLabel =[[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100,CGRectGetMaxY(self.imgView0.frame)-55, 80, 15)];
    self.changduLabel.font =[UIFont systemFontOfSize:12];
    self.changduLabel.textColor =[UIColor whiteColor];
    self.buttt =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttt.frame =CGRectMake(ScreenWidth/2-60, CGRectGetMaxY(self.imgView0.frame)/2-30, 80, 30);
    [self.buttt setTitle:@"点击播放" forState:(UIControlStateNormal)];
    
    [self.imgView0 addSubview:self.buttt];
    
    
}


-(void)setModel:(VideoModel *)model{
    
    [self.imgView0 addSubview:self.changduLabel];
    [self.imgView0 sd_setImageWithURL:[NSURL URLWithString:model.image0] placeholderImage:Image];
    self.shijianLabel.text =model.created_at;
    self.contLabel.text =[NSString stringWithFormat:@"播放次数:%@",model.playcount];
    self.titelLabel.text =model.text;
    if ([model.videotime intValue] <60) {
        self.changduLabel.text =[NSString stringWithFormat:@"%@秒",model.videotime];
    }else{
       int a =[model.videotime intValue]/60;
        int b =[model.videotime intValue]%60;
        self.changduLabel.text =[NSString stringWithFormat:@"%d分%d秒",a,b];
    }
    
}
    


@end
