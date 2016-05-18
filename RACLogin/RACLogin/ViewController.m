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
#import "LoginViewModel.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *acount;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property(nonatomic,strong)LoginViewModel *loginView;



@end

@implementation ViewController
-(LoginViewModel *)loginView
{
  if(!_loginView)
  {
      _loginView = [[LoginViewModel alloc]init];
  }
    return _loginView;
}


- (void)viewDidLoad {
    [super viewDidLoad];


    
    // 绑定数据
     RAC(self.loginView,account)= self.acount.rac_textSignal;
     RAC(self.loginView,pwd)= self.pwd.rac_textSignal;

    
    
    // 绑定登录按钮是否可用
    RAC(_loginBtn,enabled) = self.loginView.loginBtnEnbelsignal;

    // 监听按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了登录按钮");
        
        [self.loginView.loginCommand execute:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

@end
