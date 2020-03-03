//
//  IOCServiceFactory.m
//  IOCServiceModule
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#import "IOCServiceFactory.h"
#include <mach-o/getsect.h>
#include <mach-o/dyld.h>
#import "IOCServiceAnnotation.h"

@implementation IOCServiceFactory

+ (void)load {
    uint32_t c = _dyld_image_count();
    for (uint32_t i = 0; i < c; i++) {
        LoadConfigAndRegisterService((const struct mach_header_t*)_dyld_get_image_header(i), _dyld_get_image_vmaddr_slide(i));
    }
}

static void LoadConfigAndRegisterService(const struct mach_header_t* mh, intptr_t vmaddr_slide) {
    size_t byteCount = 0;
    IOCService *data = (IOCService *)getsectiondata(mh,
                                                    SEG_DATA,
                                                    ServiceSectName,
                                                    &byteCount);
    if (data) {
        int idx = 0;
        IOCService *pData = data;
        while (idx++ < byteCount / sizeof(IOCService)) {
            Class cls = NSClassFromString([NSString stringWithUTF8String:pData->class_name]);
            Protocol* pro = NSProtocolFromString([NSString stringWithUTF8String:pData->protocol]);
            
            if (nil == cls || nil == pro) {
                pData++;
                continue;
            }
#ifdef DEBUG
            printf("protocol:%s,\nclass:%s,\nfile:%s,\nline:%d\n",pData->protocol, pData->class_name, pData->file, pData->line);
            
           void (^my_assert)(id obj, const char* name) = ^(id obj, const char* name){
                    NSCAssert(nil != obj, @"%s不存在, file:%s, line:%d", name, pData->file, pData->line);
            };
            
            my_assert(cls, pData->class_name);
            my_assert(pro, pData->protocol);
#endif
            if ([cls conformsToProtocol:pro]) {
                IOCRegisterService(pro, cls);
            }
            pData++;
        }
    }
}

static NSMutableDictionary *servicesDict = nil;

BOOL IOCRegisterService(Protocol *protocol, Class clazz) {
    if (nil == servicesDict) {
        servicesDict = [NSMutableDictionary dictionary];
    }
    
    NSCAssert(protocol != nil, @"协议不能为空");
    NSCAssert(clazz != nil, @"类不能为空");
    NSString *message = [NSString stringWithFormat:@"%@ 没有实现协议 %@", NSStringFromClass(clazz), NSStringFromProtocol(protocol)];
    NSCAssert([clazz conformsToProtocol:protocol], message);
    NSString* key = NSStringFromProtocol(protocol);
    NSCAssert(key.length > 0, @"协议转换为字符串失败");
    
    if ([servicesDict objectForKey:NSStringFromProtocol(protocol)]) {
        NSLog(@"%@ 协议已经被注册", key);
        return NO;
    }
    
    [servicesDict setValue:clazz forKey:NSStringFromProtocol(protocol)];
    return YES;
}

id IOCServiceInstance(Protocol *protocol) {
    Class clazz = IOCServiceClass(protocol);
    return [[clazz alloc] init];
}

id IOCServiceClass(Protocol *protocol) {
    Class clazz = servicesDict[NSStringFromProtocol(protocol)];
    NSCAssert(nil != clazz, @"协议 %@ 没有绑定成功", NSStringFromProtocol(protocol));
    return clazz;
}

@end
