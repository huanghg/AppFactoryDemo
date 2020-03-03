//
//  ViewController.m
//  AppFactoryDemo
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "ViewController.h"
#import <DemoAdater/DemoAdater.h>
#import <IOCServiceModule/IOCServiceModule.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    id<UserCenterProtocol> userCenter = IOCServiceInstance(@protocol(UserCenterProtocol));
    NSLog(@"%@", [userCenter userName]);
}


@end
