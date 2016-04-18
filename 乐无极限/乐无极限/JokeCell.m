//
//  JokeCell.m
//  乐无极限
//
//  Created by 羊羊羊～咩～ on 16/4/17.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "JokeCell.h"
#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen] bounds ].size.height
@implementation JokeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self view];
    }return self;
}

-(void)view{
    self.JokeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 70)];
    [self.contentView addSubview:self.imageView];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, ScreenWidth - 120, 35)];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 35, ScreenWidth-150, 45)];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];

    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 85, ScreenWidth, 15)];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLabel];
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
