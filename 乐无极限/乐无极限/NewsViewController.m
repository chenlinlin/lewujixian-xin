//
//  NewsViewController.m
//  乐无极限
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 陈林林. All rights reserved.
//

#import "NewsViewController.h"
#import "NSString+Html.h"
#import "NewsModel.h"
@interface NewsViewController ()
@property(nonatomic,strong)UIWebView *myWebView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =_model.title;
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:_myWebView];
    NSURLSession *session =[NSURLSession sharedSession];
    //创建url
    NSString *urlstring =[NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.model.postid];
    NSURL *url =[NSURL URLWithString:urlstring];
    //通过URL初始化task 在block内处理数据
    NSURLSessionTask *task =[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSString *ss =[NSString stringWithFormat:@"%@",_model.docid];
        NSString *string =[NSString importStyleWithHtmlString:dic[ss][@"body"]];
        _myWebView.scalesPageToFit = NO;
        NSURL *baseURL = [NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath];
        [self.myWebView loadHTMLString:string baseURL:baseURL];
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myWebView reloadInputViews];
        });
    }];
    
    [task resume];




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
