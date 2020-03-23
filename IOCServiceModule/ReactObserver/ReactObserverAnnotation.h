//
//  ReactObserverAnnotation.h
//  AppFactoryDemo
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#ifndef ReactObserverAnnotation_h
#define ReactObserverAnnotation_h
#import "ReactObserver.h"
#import "ReactSignal.h"

#define observer(_target_, _keypath_) ([ReactObserver observerTarget:_target_ keypath:@(((void)(NO && ((void)_target_, NO)), # _keypath_)) observer:self]) \

#endif /* ReactObserverAnnotation_h */
