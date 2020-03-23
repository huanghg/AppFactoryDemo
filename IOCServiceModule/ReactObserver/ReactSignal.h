//
//  ReactSignal.h
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReactSignalNextBlock)(id value);

@interface ReactSignal : NSObject

@property (nonatomic, strong, readonly) NSArray *nextBlocks;

- (void)subscribeNext:(ReactSignalNextBlock)nextBlock;

@end

NS_ASSUME_NONNULL_END
