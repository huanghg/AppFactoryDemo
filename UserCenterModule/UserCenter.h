//
//  UserCenter.h
//  UserCenterModule
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DemoAdater/DemoAdater.h>
#import <IOCServiceModule/IOCServiceModule.h>

NS_ASSUME_NONNULL_BEGIN

@IOCService(UserCenterProtocol, UserCenter)
@interface UserCenter : NSObject <UserCenterProtocol, IOCSingletonProtocol>

@end

NS_ASSUME_NONNULL_END
