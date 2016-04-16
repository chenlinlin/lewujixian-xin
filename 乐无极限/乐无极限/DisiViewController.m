//
//  DisiViewController.m
//  乐无极限
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "DisiViewController.h"
#import "Header.h"
#import "VodeoCell.h"
#import "PlayVeiw.h"
#import "PlayViewController.h"
#import "VideoModel.h"
@interface DisiViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray *araay;
//当前页码
@property(nonatomic,assign)NSInteger  page;
@property(nonatomic,strong)UITableView *tabelView1;
//上一次请求的参数
@property(nonatomic,strong)NSDictionary *parms;
//当加载下一页需要的参数
@property(nonatomic,strong)NSString *maxtemp;
@property(nonatomic,strong)UIImageView *img;
@end

@implementation DisiViewController{
    PlayVeiw *avView;
}

-(AFHTTPSessionManager *)manager{
    if (_manager ==nil) {
        _manager =[AFHTTPSessionManager manager];
    }
    return _manager;
}
-(NSMutableArray *)araay{
    if (_araay ==nil) {
        _araay =[NSMutableArray array];
    }
    return _araay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blueColor];
//    [self data];
    [self views];
}
-(void)views{
    self.tabelView1 =[[UITableView alloc] initWithFrame:CGRectMake(0, 84, ScreenWidth, ScreenHeight-110) style:(UITableViewStylePlain)];
    self.tabelView1.delegate =self;
    self.tabelView1.dataSource=self;
    
    [self.view addSubview:self.tabelView1];
    [self.tabelView1 registerClass:[VodeoCell class] forCellReuseIdentifier:@"vodeocell"];
    
    //上刷新
    self.tabelView1 .mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    //根据拖拽距离改变透明度
    self.tabelView1.mj_header.automaticallyChangeAlpha =YES;
    //进入刷新状态
    [self.tabelView1.mj_header beginRefreshing];

    
    
    //下加载
    self.tabelView1 .mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(abc)];
    
}
-(void)loadNew{
    //结束上啦刷新
    [self.tabelView1.mj_footer endRefreshing];
    //发送请求
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =@"41";
    self.parms =params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parms !=params) return ;
        self.maxtemp =responseObject[@"info"][@"maxtime"];
        NSArray *arr =[VideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //结束刷新
        [self.tabelView1.mj_header endRefreshing];
        [self.araay addObjectsFromArray:arr];
       //清空页码
        self.page =0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabelView1 reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parms !=params) return ;
        
        //结束刷新
        [self.tabelView1.mj_header endRefreshing];
        
    }];

}

-(void)abc{
    [self.tabelView1.mj_header  endRefreshing];
    
    self.page++;
    //发送请求
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =@"41";
    params[@"page"] =@(self.page);
    params[@"maxtime"] =self.maxtemp;
    self.parms =params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parms !=params) return ;
        self.maxtemp =responseObject[@"info"][@"maxtime"];
        NSArray *arr =[VideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       [self.araay addObjectsFromArray:arr];
        //结束刷新
        [self.tabelView1.mj_footer endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabelView1 reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parms !=params) return ;
        
        //结束刷新
        [self.tabelView1.mj_footer endRefreshing];
        //恢复页数
        self.page--;
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.araay.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VodeoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"vodeocell"];
    VideoModel *model =self.araay[indexPath.row];
    cell.model =model;

    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ScreenHeight/4+15+55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    VideoModel *model =self.araay[indexPath.row];
    [avView stop];

    avView = [[PlayVeiw alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 260) url:model.videouri];
     _img =[[UIImageView alloc] initWithFrame:avView.frame];
    [_img sd_setImageWithURL:[NSURL URLWithString:model.image0] placeholderImage:Image];
    [avView play];
    [self.view addSubview:avView];
    UIButton *but =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame =CGRectMake(ScreenWidth-50, 30, 40, 40);
    [but setTitle:@"关闭" forState:(UIControlStateNormal)];
    
    [but addTarget:self action:@selector(tuichuBut) forControlEvents:UIControlEventTouchUpInside];
    [avView addSubview:but];
}
-(void)tuichuBut{
    //简单的动画效果
    [self.view addSubview:self.img];
    [avView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        _img.frame= CGRectMake(ScreenWidth/2, 0, 0, 0);
        [avView stop];
    } completion:^(BOOL finished) {
    }];
  
    
}








@end
