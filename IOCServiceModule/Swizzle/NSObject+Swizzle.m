//
//  NSObject+Swizzle.m
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

- (void)swizzleSelector:(SEL)selector with:(SEL)swizzleSelector {
    
    NSString * className = [NSString stringWithFormat:@"Swizzle_%@", NSStringFromClass(self.class)];
    const char *cla = className.UTF8String;
    Class subP = objc_allocateClassPair([self class], cla, 0);
    
    if (nil != subP && ![subP isKindOfClass:[self class]]) {
        [self swizzleClass:subP method:selector swizzledSelector:swizzleSelector];
        objc_registerClassPair(subP);
    } else {
        subP = objc_getClass(cla);
    }
    object_setClass(self, subP);
    
}

- (void)swizzleClass:(Class)clazz method:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);
    
    if (originalMethod && swizzledMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
        return;
    }
    
    if (nil == swizzledMethod) {
        BOOL didAddMethod = class_addMethod(clazz,
                                            swizzledSelector,
                                            method_getImplementation(originalMethod),
                                            method_getTypeEncoding(originalMethod));
        if (didAddMethod) {
            swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);
        }
    }

    if (swizzledMethod) {
        class_replaceMethod(clazz,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
    }
}

- (void)addClass:(Class)clazz method:(SEL)selector {
    Method method = class_getInstanceMethod(clazz, selector);
    BOOL didAddMethod = class_addMethod(clazz,
                                        selector,
                                        method_getImplementation(method),
                                        method_getTypeEncoding(method));
    NSAssert(didAddMethod, @"add method failure");
}
@end
