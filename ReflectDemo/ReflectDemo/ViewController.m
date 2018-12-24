//
//  ViewController.m
//  ReflectDemo
//
//  Created by SoDo on 2018/12/21.
//  Copyright © 2018 shaochong du. All rights reserved.
//

#import "ViewController.h"

//#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    常用反射方法:
//    FOUNDATION_EXPORT NSString *NSStringFromSelector(SEL aSelector);
//    FOUNDATION_EXPORT SEL NSSelectorFromString(NSString *aSelectorName);
//
//    FOUNDATION_EXPORT NSString *NSStringFromClass(Class aClass);
//    FOUNDATION_EXPORT Class _Nullable NSClassFromString(NSString *aClassName);
//
//    FOUNDATION_EXPORT NSString *NSStringFromProtocol(Protocol *proto) API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
//    FOUNDATION_EXPORT Protocol * _Nullable NSProtocolFromString(NSString *namestr) API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
    
    //  常用判断方法
//    - (BOOL)isKindOfClass:(Class)aClass;
//    - (BOOL)isMemberOfClass:(Class)aClass;
//    - (BOOL)conformsToProtocol:(Protocol *)aProtocol;
//    - (BOOL)respondsToSelector:(SEL)aSelector;
    
    
//    //  1. 基于 NSObject
//    [self useNSObjectReflect];
//
//    //  2. 基于 NSThread
//    [self useNSThreadReflect];
//
//    //  3. 基于 NSRunLoop
//    [self useNSRunLoopReflect];
//
//    //  4. 基于msgSend
//    [self useMsgSendReflect];
//
//    //  5. 基于函数指针
//    [self useMethodIMP];
}

/**
 * 1. 基于 NSObject 反射调用
 * 会有系统警告，可能造成内存泄露
 */
- (IBAction)useNSObjectReflect:(id)sender {
    
    [self printLine];
    
    /*  消除警告
     #pragma clang diagnostic push
     #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
     <#code#>
     #pragma clang diagnostic pop
     */
    Class p = NSClassFromString(@"Person");
    if (p) {
        //  1.1 反射调用类方法 无参数 无返回值
        SEL sel1 = NSSelectorFromString(@"printPerson");
        if (sel1) {
            [p performSelector:sel1];
        }
        
        
        // 1.2 反射调用实例方法 带有一个参数 无返回值
        SEL sel2 = NSSelectorFromString(@"printUserName:");
        if (sel2) {
            id person = [[p alloc] init];
            [person performSelector:sel2 withObject:@"张三"];
        }
        
        // 1.3 反射调用实例方法 带有两个参数 无返回值
        SEL sel3 = NSSelectorFromString(@"printUserName:age:");
        if (sel3) {
            id person = [[p alloc] init];
            [person performSelector:sel3 withObject:@"李四" withObject:[NSNumber numberWithInteger:20]];
        }
        
        // 1.4 反射调用实例方法 带参数 且 有返回值
        SEL sel11 = NSSelectorFromString(@"addressOfUser:");
        if (sel11) {
            id person = [[p alloc] init];
            NSString *address = [person performSelector:sel11 withObject:@"Lemon"];
            NSLog(@"address:%@", address);
        }
    }
    
}

/**
 * 2. 基于 NSObject 的 category 反射调用
 * 不会产生警告信息
 */
- (IBAction)useNSThreadReflect:(id)sender {
    
    [self printLine];
    
    //  2.1 反射调用类方法 无参数  无返回值
    Class p = NSClassFromString(@"Person");
    if (p) {
        SEL sel1 = NSSelectorFromString(@"printPerson");
        if (sel1) {
            [p performSelectorOnMainThread:sel1 withObject:nil waitUntilDone:YES];
        }
    }
}

/**
 * 3. 基于 NSRunLoop 反射调用
 */
- (IBAction)useNSRunLoopReflect:(id)sender {
    
    [self printLine];
    
    Class p = NSClassFromString(@"Person");
    if (p) {
        //  3.1 反射调用类方法 无参数  无返回值
        SEL sel1 = NSSelectorFromString(@"printPerson");
        if (sel1) {
            [p performSelector:sel1 withObject:nil afterDelay:0];
        }
        
    }
}

/**
 * 4. 基于 objc_msgSend 方式
 * 导入 <objc/message.h>
 * 工程设置搜索 objc_msgSend 设置为 NO
 */
- (IBAction)useMsgSendReflect:(id)sender {

    [self printLine];
    
    //  第一个参数：对象 第二个参数：SEL 之后为参数列表
    //    objc_msgSend(<#id  _Nullable self#>, <#SEL  _Nonnull op, ...#>)
    
    Class p = NSClassFromString(@"Person");
    id person = [[p alloc] init];
    
    //  无参 无返回值
    SEL sel = NSSelectorFromString(@"logInfo");
    objc_msgSend(person, sel);
    
    //  有参 无返回值
    SEL sel2 = NSSelectorFromString(@"printUserName:");
    objc_msgSend(person, sel2, @"objc_msgSend user");
    
    //  多参 有返回值
    SEL sel3 = NSSelectorFromString(@"logName:address:");
    NSString *info = objc_msgSend(person, sel3, @"张三", @"china");
    NSLog(@"info:%@", info);
}

/**
 5. 基于IMP调用
 1. method_getImplementation(Method)
 2. methodForSelector(SEL)
 3. class_getMethodImplementation(Class, SEL)
 */
- (IBAction)useMethodIMP:(id)sender {
    
    [self printLine];

    Class p = NSClassFromString(@"Person");
    id person = [[p alloc] init];
    
    //  1. Method获取IMP指针 method_getImplementation(Method)
    //  有参数 无返回值
    SEL sel1 = NSSelectorFromString(@"printUserName:");
    Method method = class_getInstanceMethod(p, sel1);
    IMP imp1 = method_getImplementation(method);
    void *(*func)(id, SEL, NSString*) = (void *)imp1;
    func(person, sel1, @"李四-----");
    // 或 直接调用
//    ((void(*)(id, SEL, NSString *))imp1)(person, sel1, @"直接调用");
    
    //  2. 实例调用 methodForSelector(SEL) 获取 IMP 指针
    // 多参数 有返回值
    SEL sel2 = NSSelectorFromString(@"logName:address:");
    IMP imp2 = [person methodForSelector:sel2];
    NSString *(*func2)(id, SEL, NSString*, NSString*) = (void *)imp2;
    NSString *info = func2(person, sel2, @"王五", @"海南");
    NSLog(@"info----%@",info);
    // 或直接调用
//    NSString *info1 = ((NSString*(*)(id, SEL, NSString*, NSString*))imp2)(person, sel2, @"aaaa", @"bbbb");
//    NSLog(@"info1:%@",info1);
    
    // 3. class_getMethodImplementation(Class, SEL)
    //  多参数 无返回值
    SEL sel3 = NSSelectorFromString(@"printUserName:age:");
    IMP imp3 = class_getMethodImplementation(p, sel3);
    NSString *(*func3)(id, SEL, NSString*, NSInteger) = (void *)imp3;
    func3(person, sel2, @"王五", @18);
    
    // 4. 使用block
    typedef void(^CompletionBlock)(NSString *, NSString*);
    CompletionBlock block = ^(NSString *str1, NSString *str2) {
        NSLog(@"str1:%@ ----- str2:%@", str1, str2);
    };
    SEL sel4 = NSSelectorFromString(@"printInfoBlock:");
    IMP imp4 = [person methodForSelector:sel4];
    void *(*func4)(id, SEL, CompletionBlock) = (void *)imp4;
    func4(person, sel4, block);
    // 或直接调用
    
}

- (void)printLine {
    NSLog(@"---------------------");
}


@end
