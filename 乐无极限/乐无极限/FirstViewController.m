//
//  FirstViewController.m
//  乐无极限
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "FirstViewController.h"
#import "DiyiViewController.h"
#import "DierViewController.h"
#import "DisanViewController.h"
#import "DisiViewController.h"
#import "UIView+XMGext.h"
#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen] bounds ].size.height
@interface FirstViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *crollView;

//标签栏底部的红色指示器
@property(nonatomic,strong) UIView *indicatyorView;
//当前选中 的按钮
@property(nonatomic,strong)UIButton *butt;
//顶部的所有标签
@property(nonatomic,strong)UIView *titlesView;
//底部的所有内容
@property(nonatomic,strong)UIScrollView *conrentView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];

    //初始化所有控制器
    [self view1];
    //设置标签栏
    [self setupTitlesView];
    //底部的scrolView
    [self setpContenView];
    
    
}

-(void)view1{
    
    DiyiViewController *view1 =[[DiyiViewController alloc] init];
    DierViewController*view2 =[[DierViewController alloc] init];
    DisanViewController *view3 =[[DisanViewController alloc] init];
    DisiViewController *view4 =[[DisiViewController alloc] init];
   
    [self addChildViewController:view1];
    [self addChildViewController:view2];
    [self addChildViewController:view3];
    [self addChildViewController:view4];
}
//scrollView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index =scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
    
}
//设置标签栏
-(void)setupTitlesView{
    //标签栏整体
    UIView *titlesView =[[UIView alloc] init];
    titlesView.backgroundColor =[UIColor greenColor];
    
    titlesView.frame =CGRectMake(0,64, ScreenWidth, 20);
    [self.view addSubview: titlesView];
    self.titlesView =titlesView;
    
    //底部红色指示器
    self.indicatyorView =[[UIView alloc] init];
    
    self.indicatyorView.backgroundColor =[UIColor redColor];
    self.indicatyorView.height =2;
    self.indicatyorView.tag =-1;
    self.indicatyorView.y =titlesView.height -self.indicatyorView.height;
    //内部子标签
    NSArray *titles =@[@"最新",@"段子",@"图片",@"视频"];
    CGFloat width =titlesView.width/titles.count;
    CGFloat height =titlesView.height;
    
    for (NSInteger i =0; i <4 ; i++) {
        UIButton *but =[[UIButton alloc] init];
        but.tag =i;
        but.height =height;
        but.width=width;
        but.x =i*width;
        [but setTitle:titles[i] forState:UIControlStateNormal];
        //强制布局更新子控件的fram
        //        [but layoutIfNeeded];
        [but setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [but setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        but.titleLabel.font =[UIFont systemFontOfSize:16];
        
        [but addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView addSubview:but];
        //默认点击第一个按钮
        if(i ==0){
            but.enabled =NO;
            self.butt =but;
            //让按钮内部的lebel根据文字的内容来计算尺寸
            [but.titleLabel sizeToFit];
            self.indicatyorView.width =but.titleLabel.width;
            self.indicatyorView.centerX =but.centerX;
            
        }
    }
    [titlesView addSubview:self.indicatyorView];
    
    
    
    
}
-(void)titleClick:(UIButton *)but{
    //修改按钮状态
    self.butt.enabled =YES;
    but.enabled =NO;
    self.butt =but;
    //动画
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatyorView.width =but.titleLabel.width;
        self.indicatyorView.centerX =but.centerX;
    }];
    
    //滚动
    CGPoint offset =self.conrentView.contentOffset;
    offset.x =but.tag *self.conrentView.width;
    [self.conrentView setContentOffset:offset animated:YES];
    
}
-(void)setpContenView{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets =NO;
    UIScrollView *contentView =[[UIScrollView alloc] init];
    //    contentView.frame =self.view.bounds;
    contentView.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    contentView.delegate =self;
    contentView.pagingEnabled =YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize =CGSizeMake(contentView.width *self.childViewControllers.count, 0);
    
    self.conrentView =contentView;
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //当前的索引
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    //取出自控制器
    UIViewController *vc =self.childViewControllers[index];
    vc.view.x =scrollView.contentOffset.x;
    vc.view.y =0; //设置控制器view的y值为0
    vc.view.height =scrollView.height;
    [scrollView addSubview:vc.view];
    
}
//控制器即将消失的时候



@end
