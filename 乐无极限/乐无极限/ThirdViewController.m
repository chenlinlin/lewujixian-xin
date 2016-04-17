//
//  ThirdViewController.m
//  乐无极限
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "ThirdViewController.h"
#import "Header.h"
@interface ThirdViewController ()

@property(nonatomic,strong)UIView *vie11;


@property(nonatomic,strong)UIButton *but;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"3");

    self.navigationItem.title =@"第三个";
    
    
}
-(void)dealloc{
    //停止所有操作

}

//控制器即将出现的时候
-(void)viewDidAppear:(BOOL)animated{
    
    self.vie11 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.vie11.backgroundColor =[UIColor grayColor];
    self.vie11.alpha =0.6;
    [self.view addSubview:self.vie11];
    self.but=[UIButton buttonWithType:UIButtonTypeRoundedRect];

    
    self.but.backgroundColor =[UIColor redColor];
    self.but.frame =CGRectMake(80, -80, 40, 40);
    self.but.layer.cornerRadius=20;
    [self.vie11 addSubview:self.but];
    
    
    //简单的动画效果
    
    [UIView animateWithDuration:1.0 animations:^{
        self.but.frame= CGRectMake(80, 300, 40, 40);
        
    } completion:^(BOOL finished) {
    }];
}
//控制器即将消失的时候
-(void)viewWillDisappear:(BOOL)animated{
    
    NSLog(@"走了; l");
    [self.vie11 removeFromSuperview];

    
}
@end
