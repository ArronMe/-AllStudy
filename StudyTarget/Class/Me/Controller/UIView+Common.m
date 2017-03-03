//
//  UIView+Common.m
//  StudyTarget
//
//  Created by 杨梦 on 2017/3/3.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import "UIView+Common.h"

static int LoadingViewKey;

@implementation UIView (Common)

- (void)setLoadingView:(EaseLoadingView *)loadingView{
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (EaseLoadingView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)beginLoading{
//    for (UIView *aView in [self.blankPageContainer subviews]) {
//        if ([aView isKindOfClass:[EaseBlankPageView class]] && !aView.hidden) {
//            return;
//        }
//    }
    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[EaseLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    
//    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.self.edges.equalTo(self);
//    }];
    [self.loadingView startAnimating];
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopAnimating];
    }
}

@end
