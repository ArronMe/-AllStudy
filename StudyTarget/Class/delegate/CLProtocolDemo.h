//
//  CLProtocolDemo.h
//  StudyTarget
//
//  Created by 赵城林 on 16/12/19.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLProtocol.h"
@interface CLProtocolDemo : NSProxy <CLProtocol>
{

@private
id<CLProtocol> _obj;
}
- (id) initWithObject:(id <CLProtocol>)obj;


@end
