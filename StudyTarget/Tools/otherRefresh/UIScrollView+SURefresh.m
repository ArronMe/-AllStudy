//
//  UIScrollView+SURefresh.m
//  CircleProgressView
//
//  Created by 杨梦 on 2017/2/2.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import "UIScrollView+SURefresh.h"
#import <objc/runtime.h>
#import "SURefreshHeader.h"

@implementation UIScrollView (SURefresh)

- (void)addRefreshHeaderWithHandle:(void (^)())handle {
    SURefreshHeader * header = [[SURefreshHeader alloc]init];
    header.handle = handle;
    self.header = header;
    [self insertSubview:header atIndex:0];
}

#pragma mark - Associate
- (void)setHeader:(SURefreshHeader *)header {
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_ASSIGN);
}

- (SURefreshHeader *)header {
    return objc_getAssociatedObject(self, @selector(header));
}

#pragma mark - Swizzle
+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method swizzleMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"su_dealloc"));
    method_exchangeImplementations(originalMethod, swizzleMethod);
}

- (void)su_dealloc {
    self.header = nil;
    [self su_dealloc];
}

@end
