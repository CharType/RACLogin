//
//  LoginViewModel.h
//  RACLogin
//
//  Created by 程倩 on 16/5/18.
//  Copyright © 2016年 CQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

@interface LoginViewModel : NSObject

@property(nonatomic,strong)NSString *account;
@property(nonatomic,strong)NSString *pwd;


//登录按钮是否可以点击
@property(nonatomic,strong)RACSignal *loginBtnEnbelsignal;

// 登录按钮命令
@property(nonatomic,strong)RACCommand *loginCommand;

@end
