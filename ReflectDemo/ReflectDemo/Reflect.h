//
//  Reflect.h
//  AnalysysAgent
//
//  Created by SoDo on 2019/1/2.
//  Copyright © 2019 analysys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 * @class
 * Reflect
 *
 * @abstract
 * 反射调用主包
 *
 * @discussion
 * 通过反射方式调用相应方法
 */

NS_ASSUME_NONNULL_BEGIN

@interface Reflect : NSObject

/**
 使用invocation反射调用

 @param object 对象
 @param selectorStr 方法字符串
 @return 返回值
 */
+ (id)invocationForObject:(id)object withSeletorStr:(NSString *)selectorStr;

/**
 携带参数反射调用

 @param object 对象
 @param selectorStr 方法字符串
 @param parameters 参数列表
 @return 返回值
 */
+ (id)invocationForObject:(id)object withSeletorStr:(NSString *)selectorStr andParameters:(NSArray * __nullable)parameters;

@end

NS_ASSUME_NONNULL_END

