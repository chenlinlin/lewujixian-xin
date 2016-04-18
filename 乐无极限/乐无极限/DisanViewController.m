//
//  DisanViewController.m
//  乐无极限
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "DisanViewController.h"
#import "Header.h"
#import "ImageModel.h"
#import "ImageCell.h"
@interface DisanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)AFHTTPSessionManager *manager;
//当加载下一页需要的参数
@property(nonatomic,strong)NSString *maxtemp;
@property(nonatomic,strong)UITableView *tabelView1;

@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation DisanViewController

-(AFHTTPSessionManager *)manager{
    if (_manager ==nil) {
        _manager =[AFHTTPSessionManager manager];
    }
    return _manager;
}
-(NSMutableArray *)array{
    if (_array ==nil) {
        _array =[NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor =[UIColor grayColor];
    self.tabelView1 =[[UITableView alloc] initWithFrame:CGRectMake(0, 84, ScreenWidth, ScreenHeight-128) style:(UITableViewStylePlain)];
    self.tabelView1.delegate=self;
    self.tabelView1.dataSource =self;
    [self.tabelView1 registerClass:[ImageCell class] forCellReuseIdentifier:@"imagecell"];
    [self.view addSubview:self.tabelView1];
    [self data];
}

-(void)data{
    //发送请求
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =@"10";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        self.maxtemp =responseObject[@"info"][@"maxtime"];
        NSArray *arr =[ImageModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //结束刷新
        [self.array addObjectsFromArray:arr];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabelView1 reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //结束刷新
        [self.tabelView1.mj_header endRefreshing];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"imagecell"];
    ImageModel *model =self.array[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.image0] placeholderImage:Image];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}




@end
