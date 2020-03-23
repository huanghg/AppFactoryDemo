//
//  UserCenterProtocol.h
//  DemoAdater
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol UserInfoProtocol <NSObject>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int gender;

@end

@protocol UserCenterProtocol <NSObject>

@property (nonatomic, assign, readonly) BOOL loginSuccess;

- (void)loginWithStatus:(BOOL)status;

- (id<UserInfoProtocol>)userInfo;

@end



NS_ASSUME_NONNULL_END
