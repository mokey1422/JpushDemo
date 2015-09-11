//
//  ViewController.m
//  JpushTest
//
//  Created by 张国兵 on 15/8/31.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "ViewController.h"
#import "CUSFlashLabel.h"
#import "APService.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CUSFlashLabel*label=[[CUSFlashLabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/2-50, self.view.bounds.size.width, 100)];
    label.text=@"极光推送测试";
    [label setContentMode:UIViewContentModeTop];
    label.font=[UIFont boldSystemFontOfSize:50];
    label.textAlignment=NSTextAlignmentCenter;
    [label startAnimating];
    [self.view addSubview:label];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    
    NSLog(@"推送的内容-->%@",content);
    NSLog(@"用户自定义参数-->%@",customizeField1);
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
