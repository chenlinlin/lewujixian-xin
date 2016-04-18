//
//  VideoModel.h
//  乐无极限
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property(nonatomic,strong)NSString *created_at;
@property(nonatomic,strong)NSString *cdn_img;
@property(nonatomic,strong)NSString *videouri;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *profile_image;
@property(nonatomic,strong)NSString *image0;
@property(nonatomic,strong)NSString *passtime;
/**
 *播放次数
 */
@property(nonatomic,strong)NSString *playcount;
/**
 *长度
 */

@property(nonatomic,strong)NSString *videotime;
@end
