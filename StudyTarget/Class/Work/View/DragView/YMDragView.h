//
//  YMDragView.h
//  StudyTarget
//
//  Created by 杨梦 on 2016/12/20.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import <UIKit/UIKit.h>

// 拖曳view的方向
typedef NS_ENUM(NSInteger, WMDragDirection) {
    WMDragDirectionAny,          /**< 任意方向 */
    WMDragDirectionHorizontal,   /**< 水平方向 */
    WMDragDirectionVertical,     /**< 垂直方向 */
};

@interface YMDragView : UIView<UIGestureRecognizerDelegate>

/**
 判断是否能能拖曳，
 */
@property (nonatomic,assign) BOOL dragEnable;

/**
 活动范围，默认为父视图的frame范围内（因为拖出父视图后无法点击，也没意义）
 如果设置了，则会在给定的范围内活动，如果没设置，则会在父视图范围内活动
 注意：设置的frame不要大于父视图范围
 注意：设置的frame为0，0，0，0表示活动的范围为默认的父视图frame，如果想要不能活动，请设置dragEnable这个属性为NO
 */
@property (nonatomic,assign) CGRect freeRect;

/**
 拖曳的方向，默认为any，任意方向
 */
@property (nonatomic,assign) WMDragDirection dragDirection;

/**
 内部的一个UIImageView，采用懒加载的方式，开发者用的时候才会创建，不用就为nil
 注意：最好不要同时使用内部的imageView和button
 */
@property (nonatomic,strong) UIImageView *imageView;

/**
 内部的一个UIButton，采用懒加载的方式，开发者用的时候才会创建，不用就为nil
 注意：最好不要同时使用内部的imageView和button
 */
@property (nonatomic,strong) UIButton *button;

/**
 内容view，命名为contentViewForDrag，因为很多第三方的库继承UIView，里面同样有contentView这个属性
 防止冲突，这里特别命名为contentViewForDrag
 */
@property (nonatomic,strong) UIView *contentViewForDrag;

/**
 点击的回调block
 */
@property (nonatomic,copy) void(^ClickDragViewBlock)(YMDragView *dragView);

/**
 开始拖动的回调block
 */
@property (nonatomic,copy) void(^BeginDragBlock)(YMDragView *dragView);

/**
 拖动中的回调block
 */
@property (nonatomic,copy) void(^DuringDragBlock)(YMDragView *dragView);

/**
 结束拖动的回调block
 */
@property (nonatomic,copy) void(^EndDragBlock)(YMDragView *dragView);

/**
 是否保持在边界，默认为NO,没有黏贴边界效果
 isKeepBounds = YES，它将自动黏贴边界，而且是最近的边界
 isKeepBounds = NO， 它将不会黏贴在边界，它是free(自由)状态，跟随手指到任意位置，但是也不可以拖出规定的范围
 */
@property (nonatomic,assign) BOOL isKeepBounds;


@end
