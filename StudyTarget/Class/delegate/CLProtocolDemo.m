//
//  CLProtocolDemo.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/19.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "CLProtocolDemo.h"

@implementation CLProtocolDemo

- (id) initWithObject:(id<CLProtocol>)obj
{
    _obj = obj;
    return self;
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    if (_obj) {
        NSLog(@"proxy invocation obj method : %@", NSStringFromSelector([invocation selector]));
        [invocation setTarget:_obj];
        [invocation invoke];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if ([_obj isKindOfClass:[NSObject class]]) {
        return [(NSObject *)_obj methodSignatureForSelector:sel];
    }
    return [super methodSignatureForSelector:sel];
}


- (void)doSomething {
    NSLog(@"proxy do something");//1
    [_obj doOtherThing];
}

@end
