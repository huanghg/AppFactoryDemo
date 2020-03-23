//
//  RouterCenterService.h
//  AppFactoryDemo
//
//  Created by HaiguangHuang on 2020/2/27.
//  Copyright © 2020 AirPay. All rights reserved.
//

#ifndef RouterCenterService_h
#define RouterCenterService_h

typedef struct router_service {
    const char* path;
    const char* className;
#ifdef DEBUG
    const char* file;
    const int32_t line;
#endif
}RouterCenterService;

#define RouterCenterSectName "RouterCenter"

#ifdef DEBUG

#define _RouterCenterService(path, className, name) class NSObject;  \
    const RouterCenterService k##className##_##path##_service \
    __attribute__((used, section(SEG_DATA "," name))) \
= {#path, #className, __FILE__, __LINE__};

#define router(path, className) _RouterCenterService(path, className, RouterCenterSectName)

#else

#define _IOCService(service_protocol, implementation, name) protocol service_protocol;  \
    const IOCService k##service_protocol##_service \
    __attribute__((used, section(SEG_DATA "," name))) \
    = {#service_protocol, #implementation};

#define IOCService(service_protocol, implementation) _IOCService(service_protocol, implementation, RouterCenterSectName)

#endif

#endif /* RouterCenterService_h */
