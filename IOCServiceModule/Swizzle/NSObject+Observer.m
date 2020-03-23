//
//  NSObject+Observer.m
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "NSObject+Observer.h"
#import <objc/runtime.h>
#import "ReactSignal.h"

extern char * kReactObserverIdentifier;
extern char * kReactObserverHasRespondsIdentifier;

@implementation NSObject (Observer)

- (void)swizzle_observeValueForKeyPath:(NSString *)keyPath
                              ofObject:(id)object
                                change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                               context:(void *)context {
    NSDictionary *observerDic = objc_getAssociatedObject(object, &kReactObserverIdentifier);
    id value = [change objectForKey:NSKeyValueChangeNewKey];
    ReactSignal *signal = observerDic[keyPath];
    for (ReactSignalNextBlock nextBlock in signal.nextBlocks) {
        nextBlock(value);
    }
    
    BOOL hasResponds = [objc_getAssociatedObject(object, &kReactObserverHasRespondsIdentifier) boolValue];
    if (hasResponds) {
        [self swizzle_observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
