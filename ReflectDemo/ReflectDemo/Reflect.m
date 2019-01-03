//
//  ANSReflect.m
//  AnalysysAgent
//
//  Created by SoDo on 2019/1/2.
//  Copyright © 2019 analysys. All rights reserved.
//

#import "Reflect.h"
#import "NSInvocation+Helper.h"

@implementation Reflect

+ (id)invocationForObject:(id)object withSeletorStr:(NSString *)selectorStr {
    return [self invocationForObject:object withSeletorStr:selectorStr andParameters:nil];
}

+ (id)invocationForObject:(id)object withSeletorStr:(NSString *)selectorStr andParameters:(NSArray * __nullable)parameters {
    SEL selector = NSSelectorFromString(selectorStr);
    NSMethodSignature *signature = [object methodSignatureForSelector:selector];
    if (signature == nil) {
        NSLog(@"签名失败");
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = object;
    invocation.selector = selector;
    
    if (parameters.count) {
        [invocation DCSetArgumentsFromArray:parameters];
//        NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd
//        paramsCount = MIN(paramsCount, parameters.count);
//        for (NSInteger i = 0; i < paramsCount; i++) {
//            id object = parameters[i];
//            if ([object isKindOfClass:[NSNull class]]) continue;
//            [invocation setArgument:&object atIndex:i + 2];
//        }
    }
    
    [invocation invoke];
    
    id returnValue = nil;
    if (signature.methodReturnLength) {
        returnValue = [invocation DCReturnValue];
    }
    
    return returnValue;
}


@end


