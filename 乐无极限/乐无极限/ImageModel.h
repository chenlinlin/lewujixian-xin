//
//  ImageModel.h
//  乐无极限
//
//  Created by lanou3g on 16/4/17.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageModel : NSObject

@property(nonatomic,strong)NSString *image0;
//宽度
@property(nonatomic,assign)CGFloat width;

@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)NSString *text;

@property(nonatomic,strong)NSString *maxtime ;

@end
