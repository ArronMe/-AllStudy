//
//  TipView.m
//  StudyTarget
//
//  Created by 杨梦 on 2017/1/25.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import "TipView.h"

@implementation TipView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor grayColor];
        [self createSubViews];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionMoveIn;
        animation.subtype = kCATransitionFromBottom;
        [self.layer addAnimation:animation forKey:@"animation"];

    }
    return self;
}

- (void)createSubViews
{
    _tipLab= [[UILabel alloc] init];
    _tipLab.text = @"您的网络已切换";
    _tipLab.frame = CGRectMake(15, 0, self.width, self.height);
    _tipLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:_tipLab];
    
}

@end
