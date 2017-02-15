//
//  HomeVc.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "HomeVc.h"
#import "CLButton.h"
#import "UIButton+Layout.h"
#define K_WIDTH  [UIScreen mainScreen].bounds.size.width
#import "CLProtocolDemo.h"
#import "CLDemo.h"

@interface HomeVc ()
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation HomeVc

@synthesize stepper = _stepper;
@synthesize timer = _timer;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进度条的初始化
    self.labeledProgressView = [[DALabeledCircularProgressView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 60.0f, 60.0f)];
    self.labeledProgressView.roundedCorners = NO;
    [self.view addSubview:self.labeledProgressView];
    
    self.labeledProgressView.trackTintColor = [UIColor grayColor];
    self.labeledProgressView.progressTintColor = [UIColor whiteColor];
    self.labeledProgressView.thicknessRatio = 1.0f;
    self.labeledProgressView.clockwiseProgress = NO;

    [self startAnimation];

       //采用继承的方式实现
    {
    CLButton * searchBtn = [CLButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索按钮图片在左边" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [searchBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    searchBtn.imageRect = CGRectMake(10, 10, 20, 20);
    searchBtn.titleRect = CGRectMake(35, 10, 120, 20);
    [self.view addSubview:searchBtn];
    searchBtn.frame = CGRectMake(K_WIDTH * 0.5 - 80, 250, 160, 40);
    searchBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:155/255.0 blue:210/255.0 alpha:1];
    }
    //使用分类的方式实现
    {
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消按钮图片在右边" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        cancelBtn.titleRect = CGRectMake(10, 10, 120, 20);
        cancelBtn.imageRect = CGRectMake(135, 10, 20, 20);
        [self.view addSubview:cancelBtn];
        cancelBtn.frame = CGRectMake(K_WIDTH * 0.5 - 80, 350, 160, 40);
        cancelBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:155/255.0 blue:210/255.0 alpha:1];
        
    }
    //动态代理模式的应用很多，特别是在不能修改被代理类的前提下，要对执行某些方法时需要打log，或者捕捉异常处理时，是一个非常方便的方法，
    id<CLProtocol>object = [[CLProtocolDemo alloc]initWithObject:[[CLDemo alloc] init]];
    [object doOtherThing];
}

- (void)progressChange
{
    // Labeled progress views
    CGFloat progress = ![self.timer isValid] ? self.stepper.value / 10.0f : self.labeledProgressView.progress + 0.01f;
    
    [self.labeledProgressView setProgress:progress animated:YES];
    
    if (self.labeledProgressView.progress >= 1.0f && [self.timer isValid]) {
        [self.labeledProgressView setProgress:0.f animated:YES];
    }
    CGFloat number= self.labeledProgressView.progress*100;
    self.labeledProgressView.progressLabel.text = [NSString stringWithFormat:@"%.f%%", number];
}

- (void)startAnimation
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                  target:self
                                                selector:@selector(progressChange)
                                                userInfo:nil
                                                 repeats:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
