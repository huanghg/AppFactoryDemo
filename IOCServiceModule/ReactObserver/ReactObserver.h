//
//  ReactObserver.h
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactSignal.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReactObserver : NSObject

+ (ReactSignal *)observerTarget:(id)target keypath:(NSString *)keypath observer:(id)observer;

@end

NS_ASSUME_NONNULL_END
