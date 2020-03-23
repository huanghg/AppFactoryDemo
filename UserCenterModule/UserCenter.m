//
//  UserCenter.m
//  UserCenterModule
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "UserCenter.h"
#import "UserInfo.h"

@interface UserCenter ()

@property (nonatomic, assign) BOOL loginSuccess;

@end

@implementation UserCenter

+ (instancetype)ioc_sharedInstance {
    static UserCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserCenter alloc] init];
    });
    return instance;
}

- (id<UserInfoProtocol>)userInfo {
    UserInfo *userInfo = [[UserInfo alloc] init];
    userInfo.name = @"小明";
    userInfo.age = 30;
    userInfo.gender = 1;
    return userInfo;
}

- (void)loginWithStatus:(BOOL)status {
    self.loginSuccess = status;
}
@end
