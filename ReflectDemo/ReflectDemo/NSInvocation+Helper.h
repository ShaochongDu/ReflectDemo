//
//  NSInvocation+Helper.h
//  AnalysysAgent
//
//  Created by analysys on 2018/4/9.
//  Copyright © 2018年 analysys. All rights reserved.
//
//  Copyright (c) 2014 Mixpanel. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSInvocation (Helper)

- (void)DCSetArgumentsFromArray:(NSArray *)argumentArray;
- (id)DCReturnValue;

@end
