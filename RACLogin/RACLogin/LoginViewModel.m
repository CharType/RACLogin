//
//  LoginViewModel.m
//  RACLogin
//
//  Created by 程倩 on 16/5/18.
//  Copyright © 2016年 CQ. All rights reserved.
//

#import "LoginViewModel.h"
#import "MBProgressHUD+CQ.h"

@implementation LoginViewModel

-(instancetype)init
{
  if(self = [super init])
  {
      [self setUp];
  }
    return  self;
}

/**
 *  初始化数据
 */
-(void)setUp
{
    // RACObserve 可以将文本的值改变包装成一个信号
    _loginBtnEnbelsignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id(NSString *account,NSString *pwd){
        
        return @(account.length&&pwd.length);
        
    }];
    
    _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"发送登录数据"];
            [subscriber sendCompleted];
            
            return  nil;
        }];
    }];
    
    //处理登录返回的结果
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //处理登录的执行过程
    [_loginCommand.executing subscribeNext:^(id x) {
        if([x boolValue])
        {
            [MBProgressHUD showMessage:@"正在登录"];
            NSLog(@"正在执行");
        }else{
            [MBProgressHUD hideHUD];
            NSLog(@"执行完成");
        }
    }];
}
@end
