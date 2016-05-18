//
//  ViewController.m
//  RACLogin
//
//  Created by 程倩 on 16/5/18.
//  Copyright © 2016年 CQ. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "MBProgressHUD+CQ.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *acount;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 处理文本框业务逻辑
    RACSignal *loginBtnEnbelsignal = [RACSignal combineLatest:@[_acount.rac_textSignal,_pwd.rac_textSignal] reduce:^id(NSString *account,NSString *pwd){
        
        return @(account.length&&pwd.length);
        
    }];
    
    // 绑定登录按钮是否可用
    RAC(_loginBtn,enabled) = loginBtnEnbelsignal;
    
    // 创建登录命令
    RACCommand *loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"发送登录数据"];
            [subscriber sendCompleted];
            
            return  nil;
        }];
    }];
    
    //获取命令中的信号源
    [loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //监听命令执行的过程
    
    [loginCommand.executing subscribeNext:^(id x) {
        if([x boolValue])
        {
            [MBProgressHUD showMessage:@"正在登录"];
            NSLog(@"正在执行");
        }else{
            [MBProgressHUD hideHUD];
            NSLog(@"执行完成");
        }
    }];
    
    
    
    
    // 监听按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了登录按钮");
        
        [loginCommand execute:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

@end
