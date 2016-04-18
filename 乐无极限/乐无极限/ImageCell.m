//
//  ImageCell.m
//  乐无极限
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "ImageCell.h"
#import "Header.h"
@implementation ImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 10, 100, 150)];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}
@end
