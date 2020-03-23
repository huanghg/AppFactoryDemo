//
//  ViewController.m
//  AppFactoryDemo
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import <DemoAdater/DemoAdater.h>
#import <IOCServiceModule/IOCServiceModule.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    id<UserCenterProtocol> userCenter = IOCServiceInstance(@protocol(UserCenterProtocol));
    NSLog(@"姓名:%@", [userCenter userInfo].name);
    
    ReactSignal *signal = observer(userCenter, loginSuccess);
    [signal subscribeNext:^(id  _Nonnull value) {
        NSLog(@"test");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestViewController *vc = [[TestViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
    id<UserCenterProtocol> userCenter = IOCServiceInstance(@protocol(UserCenterProtocol));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [userCenter loginWithStatus:YES];
    });
}

@end
