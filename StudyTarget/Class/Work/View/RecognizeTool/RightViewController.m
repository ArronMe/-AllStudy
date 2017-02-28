//
//  RightViewController.m
//  StudyTarget
//  右侧抽屉
//  Created by 杨梦 on 2017/2/28.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import "RightViewController.h"
#import "CustomRightView.h"

#define OPENCENTERX 220.0
#define DIVIDWIDTH 70.0 //OPENCENTERX 对应确认是否打开或关闭的分界线。

@interface RightViewController ()
{
    CustomRightView *customView;
}

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"抽屉" style:0 target:self action:@selector(btnClick)];
    self.navigationItem.rightBarButtonItem = btn;
    
    CGRect rect = CGRectMake(0, 0,
                             self.view.frame.size.width,
                             self.view.frame.size.height);
    
    NSLog(@"w:%f, h:%f", rect.size.width, rect.size.height);
  
    UIView *imageleft = [[UIView alloc]init];
    imageleft.frame = rect;
    imageleft.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageleft];
    
    UIView *contentView = [[UIView alloc] initWithFrame:rect];
    contentView.backgroundColor = [UIColor blueColor];
    
    customView = [[CustomRightView alloc] initWithView:contentView parentView:self.view];
    [[customView layer] setShadowOffset:CGSizeMake(10, 10)];
    [[customView layer] setShadowRadius:20];
    [[customView layer] setShadowOpacity:1];
    [[customView layer] setShadowColor:[UIColor blackColor].CGColor];
    [self.view addSubview:customView];
}

- (void)btnClick
{
    [UIView animateWithDuration:0.5
                          delay:0.01
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {         
        customView.center = CGPointMake(-DIVIDWIDTH, self.view.frame.size.height/2);
         
     }completion:^(BOOL isFinish){
         
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
