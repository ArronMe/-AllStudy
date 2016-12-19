//
//  NSObject+Swizzling.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "NSObject+Swizzling.h"

@implementation NSObject (Swizzling)

+ (void) methodExchangingWithOriginalSelector:(SEL)originalSelector bySwizzlingSelecter:(SEL)SwizzlingSelector
{
    Class newClass  = [self class];
    Method originalMethod = class_getInstanceMethod(newClass, originalSelector);
    Method swizzingMethod = class_getInstanceMethod(newClass, SwizzlingSelector);
    
    //给当前类添加一个originalSelector方法，实现是swizzingMethod
    BOOL added = class_addMethod(newClass, originalSelector, method_getImplementation(swizzingMethod), method_getTypeEncoding(swizzingMethod));
    if (added) {
        class_replaceMethod(newClass, SwizzlingSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else
    {
        method_exchangeImplementations(originalMethod, swizzingMethod);
        
    }
    
    
}

@end
