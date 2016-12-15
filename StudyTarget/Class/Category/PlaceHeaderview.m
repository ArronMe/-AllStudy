//
//  PlaceHeaderview.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "PlaceHeaderview.h"

@interface PlaceHeaderview ()
@property (nonatomic, strong) UIButton *button;

@end

@implementation PlaceHeaderview

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}
- (void) createUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.button];
}
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 120, 120);
        _button.center = self.center;
        _button.layer.cornerRadius = 60.0;
        [_button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_button setTitle:@"暂无数据，点击重新加载!" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_button setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        CGRect rect = _button.frame;
        rect.origin.y -= 50;
        _button.frame = rect;
    }
    return _button;

    
}
- (void)buttonAction:(UIButton *) sender
{
    
    if (self.replaceBlock) {
        self.replaceBlock();
    }
}

@end
