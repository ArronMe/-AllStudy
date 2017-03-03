//
//  EaseLoadingView.h
//  StudyTarget
//
//  Created by 杨梦 on 2017/3/3.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EaseLoadingView : UIView

@property (strong, nonatomic) UIImageView *loopView, *monkeyView;
@property (assign, nonatomic, readonly) BOOL isLoading;
- (void)startAnimating;
- (void)stopAnimating;
@end
@interface EaseLoadingView ()
@property (nonatomic, assign) CGFloat loopAngle, monkeyAlpha, angleStep, alphaStep;

@end
