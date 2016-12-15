//
//  NSObject+Swizzling.h
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Swizzling)

+ (void)methodExchangingWithOriginalSelector:(SEL) originalSelector bySwizzlingSelecter:(SEL)SwizzlingSelector;


@end
