//
//  CustomRightView.h
//  StudyTarget
//
//  Created by 杨梦 on 2017/2/28.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRightView : UIView
{
    CGPoint openPointCenter;
    CGPoint closePointCenter;
}
-(id)initWithView:(UIView*)contentview parentView:(UIView*) parentview;

@property (nonatomic, strong) UIView *parentView; //抽屉视图的父视图


@end
