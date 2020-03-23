//
//  IOCServiceAnnotation.h
//  AppFactoryDemo
//
//  Created by HaiguangHuang on 2020/1/14.
//  Copyright © 2020 AirPay. All rights reserved.
//

#ifndef IOCServiceAnnotation_h
#define IOCServiceAnnotation_h
#include <mach-o/loader.h>
#include <string.h>
#include <stdio.h>

typedef struct ioc_service {
    const char* protocol;
    const char* class_name;
    const char* pattern;
#ifdef DEBUG
    const char* file;
    const int32_t line;
#endif
}IOCService;

#define IOCServiceSectName "IOCService"

#ifdef DEBUG

#define _IOCService(service_protocol, implementation, pattern) protocol service_protocol; \
    const IOCService k##service_protocol##_service __attribute__((used, section(SEG_DATA "," IOCServiceSectName))) = {#service_protocol, #implementation, #pattern, __FILE__, __LINE__};

#define IOCServiceSingleton(service_protocol, implementation) _IOCService(service_protocol, implementation, Singleton)

#define IOCService(service_protocol, implementation) _IOCService(service_protocol, implementation, Once)

#else

#define _IOCService(service_protocol, implementation, name) protocol service_protocol;  \
    const IOCService k##service_protocol##_service __attribute__((used, section(SEG_DATA "," name))) = {#service_protocol, #implementation};

#define IOCService(service_protocol, implementation) _IOCService(service_protocol, implementation, IOCServiceSectName)

#endif


#endif /* IOCServiceAnnotation_h */
