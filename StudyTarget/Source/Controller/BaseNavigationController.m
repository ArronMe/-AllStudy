//
//  BaseNavigationController.m
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BaseNavigationController.h"
#import <YYKit.h>
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void) initialize
{
    [super initialize];
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont fontWithName:@"PingFang SC" size:18],NSFontAttributeName,
                                 [UIColor whiteColor],NSForegroundColorAttributeName,
                                 //                                 [NSValue valueWithCGSize:CGSizeMake(2.0, 2.0)], NSShadowAttributeName ,
                                 //                                 [UIColor whiteColor],NSShadowAttributeName ,
                                 nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navTitleArr];

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
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
