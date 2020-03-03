//
//  IOCServiceFactory.h
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IOCServiceFactory : NSObject

id IOCServiceInstance(Protocol *protocol);

id IOCServiceClass(Protocol *protocol);

@end

NS_ASSUME_NONNULL_END
