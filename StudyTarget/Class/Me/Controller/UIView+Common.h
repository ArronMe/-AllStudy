//
//  UIView+Common.h
//  StudyTarget
//
//  Created by 杨梦 on 2017/3/3.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseLoadingView.h"

@interface UIView (Common)

#pragma mark LoadingView
@property (strong, nonatomic) EaseLoadingView *loadingView;
- (void)beginLoading;
- (void)endLoading;

@end
