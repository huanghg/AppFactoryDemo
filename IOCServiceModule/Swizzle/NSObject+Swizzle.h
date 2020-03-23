//
//  NSObject+Swizzle.h
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)

- (void)swizzleSelector:(SEL)selector with:(SEL)swizzleSelector;

@end

NS_ASSUME_NONNULL_END
