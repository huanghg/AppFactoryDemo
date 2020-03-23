//
//  IOCSingletonProtocol.h
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IOCSingletonProtocol <NSObject>

+ (instancetype)ioc_sharedInstance;

@end

NS_ASSUME_NONNULL_END
