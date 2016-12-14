//
//  CLTabBar.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "CLTabBar.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"

@interface CLTabBar ()
@property(nonatomic ,strong) NSMutableArray *controllerArray;

@end

@implementation CLTabBar
- (NSMutableArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = [NSMutableArray array];
    }
    return _controllerArray;
}
- (void) setUp
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CLTabBar" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dic in array) {
        if (dic) {
            NSString  * controllerStr = [dic objectForKey:@"vc"];
            Class type = NSClassFromString(controllerStr);
            BaseViewController *controller = [[type alloc] init];
            [self setupChildViewController:controller title:[dic objectForKey:@"title"] imageName:[dic objectForKey:@"normal"] selectedImageName:[dic objectForKey:@"selected"]];
        }
    }
    self.viewControllers = self.controllerArray;
}
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    
    UIImage * normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem =   [[UITabBarItem alloc]initWithTitle:title image:normalImage selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *navc = [[BaseNavigationController alloc]initWithRootViewController:childVc];
    childVc.navigationItem.title = title;
    [self.controllerArray addObject:navc];
    
}
- (BaseNavigationController *)subControllerFor:(nullable Class)aClass {
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:[[aClass alloc]init]];
    return nav;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
