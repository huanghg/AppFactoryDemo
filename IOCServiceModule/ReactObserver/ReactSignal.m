//
//  ReactSignal.m
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/3/6.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "ReactSignal.h"

@interface ReactSignal ()

@property (nonatomic, strong) NSArray *nextBlocks;

@end

@implementation ReactSignal

- (void)subscribeNext:(ReactSignalNextBlock)nextBlock {
    NSAssert(nextBlock != nil, @"block should not be nil");
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.nextBlocks];
    [array addObject:nextBlock];
    self.nextBlocks = array;
}

@end
