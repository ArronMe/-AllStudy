//
//  SURefreshHeader.h
//  CircleProgressView
//
//  Created by 杨梦 on 2017/2/2.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIScrollView+SURefresh.h"

@interface SURefreshHeader : UIView

UIKIT_EXTERN const CGFloat SURefreshHeaderHeight;
UIKIT_EXTERN const CGFloat SURefreshPointRadius;

@property (nonatomic, copy) void(^handle)();

#pragma mark - 停止动画
- (void)endRefreshing;

@end
