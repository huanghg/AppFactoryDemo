//
//  ReactObserver.m
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "ReactObserver.h"
#import "ReactSignal.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"

const char * kReactObserverIdentifier;
const char * kReactObserverHasRespondsIdentifier;

@implementation ReactObserver

+ (ReactSignal *)observerTarget:(id)target keypath:(NSString *)keypath observer:(id)observer {
    if (nil == target ||
        nil == keypath ||
        nil == observer) {
        NSAssert(NO, @"target & keypath & observer should not be nil");
        return nil;
    }
    
    NSDictionary *observerDic = objc_getAssociatedObject(target, &kReactObserverIdentifier);
    ReactSignal *signal = observerDic[keypath];
    
    if (nil == signal) {
        signal = [[ReactSignal alloc] init];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:observerDic];
        [tempDic setValue:signal forKey:keypath];
        observerDic = [tempDic copy];
        objc_setAssociatedObject(target, &kReactObserverIdentifier, observerDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [target addObserver:observer
                 forKeyPath:keypath
                    options:NSKeyValueObservingOptionNew
                    context:nil];
        
        SEL orignalSelector = @selector(observeValueForKeyPath:ofObject:change:context:);
        SEL swizzleSelector = @selector(swizzle_observeValueForKeyPath:ofObject:change:context:);
        BOOL hasResponds = [observer respondsToSelector:orignalSelector];
        objc_setAssociatedObject(observer, &kReactObserverHasRespondsIdentifier, @(hasResponds), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [observer swizzleSelector:orignalSelector with:swizzleSelector];
    }
    
    return signal;
}

@end
