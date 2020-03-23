//
//  TestViewController.m
//  AppFactoryDemo
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "TestViewController.h"
#import <DemoAdater/DemoAdater.h>
#import <IOCServiceModule/IOCServiceModule.h>

@interface TestViewController ()

@end

@implementation TestViewController

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<UserCenterProtocol> userCenter = IOCServiceInstance(@protocol(UserCenterProtocol));
    
    ReactSignal *signal1 = observer(userCenter, loginSuccess);
    [signal1 subscribeNext:^(id  _Nonnull value) {
        NSLog(@"时间到啦，登录状态:%@", userCenter.loginSuccess ? @"已登录" : @"未登录");
    }];
    
    ReactSignal *signl2 = observer(userCenter, loginSuccess);
    [signl2 subscribeNext:^(id  _Nonnull value) {
        NSLog(@"其他地方监听");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    id<UserCenterProtocol> userCenter = IOCServiceInstance(@protocol(UserCenterProtocol));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [userCenter loginWithStatus:NO];
    });
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
