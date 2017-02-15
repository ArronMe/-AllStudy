//
//  UIScrollView+SURefresh.h
//  CircleProgressView
//
//  Created by 杨梦 on 2017/2/2.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SURefreshHeader;
@interface UIScrollView (SURefresh)

@property (nonatomic, weak, readonly) SURefreshHeader * header;

- (void)addRefreshHeaderWithHandle:(void (^)())handle;

@end
