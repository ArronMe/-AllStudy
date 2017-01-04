//
//  AppDelegate.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "AppDelegate.h"
#import "CLTabBar.h"
#import <YYKit.h>
#import "TouchViewController.h"
#import "TouchChildViewController.h"
#import "WorkVc.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[CLTabBar alloc]init];
    [self.window makeKeyAndVisible];
    //我们测试用一下
    //设置tabbar字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorHex(333333)} forState:UIControlStateNormal];
    [UITabBar appearance].translucent = NO;

    //创建应用图标上的3D touch快捷选项
    [self creatShortcutItem];

    return YES;
}


#pragma mark -- 处理3DTouch触发事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    //判断先前我们设置的唯一标识
    if([shortcutItem.type isEqualToString:@"touchShare.bundle"]){
        //设置当前的VC 为rootVC
        TouchViewController *vc =[[TouchViewController alloc] init];
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        }];
    }
    else if ([shortcutItem.type isEqualToString:@"com.mycompany.myapp.search"]){
        //进入搜索界面
        TouchChildViewController *childVC = [[TouchChildViewController alloc] init];
        [self.window.rootViewController presentViewController:childVC animated:YES completion:^{
        }];
    }
    else if ([shortcutItem.type isEqualToString:@"com.mycompany.myapp.share"])
    {//进入分享界面
        NSArray *arr = @[@"hello 3D Touch"];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        }];
    }
    else{
        NSLog(@"没有3DTouch的识别符");
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}

//创建应用图标上的3D touch快捷选项
- (void)creatShortcutItem {
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    //    //创建自定义图标的icon
    //    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"分享.png"];
    //创建快捷选项
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"com.mycompany.myapp.share" localizedTitle:@"分享" localizedSubtitle:@"分享副标题" icon:icon userInfo:nil];
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
