//
//  TouchViewController.m
//  StudyTarget
//
//  Created by 杨梦 on 2017/1/4.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import "TouchViewController.h"

@interface TouchViewController ()<UIViewControllerPreviewingDelegate>
//应该判断该控制器当前是否实现了3dtouch手势 如果实现的话最好禁用长按手势
@end

/*
 首先我们需要在Info.plist文件中加上一项
 
 [key]UIApplicationShortcutItems[/key]
    [array]
        [dict]
                 //触发3D Touch时显示的图标类型
            [key]UIApplicationShortcutItemIconType[/key]
                //显示分享的图标
            [string]UIApplicationShortcutIconTypeShare[/string]
                //显示名字的
            [key]UIApplicationShortcutItemTitle[/key]
            [string]Share[/string]
                //相当于项目中的Bundle Identifier唯一的，通过这个标示我们可以判断点相应的那一项触发相应的操作
            [key]UIApplicationShortcutItemType[/key]
            [string]-11.UITouchText.share[/string]
        [/dict]
    [/array]
 //选填项
 UIApplicationShortcutItemSubtitle 设置标签的副标题
 UIApplicationShortcutItemIconFile  设置标签的Icon文件
 */
@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(50, 100, 100, 30);
    [returnBtn setTitle:@"返回首页" forState:0];
    [returnBtn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"你的手机支持3D Touch!");
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        
        // 如果实现了长按手势要禁止
        //self.longPress.enabled = NO;
    }
    else {
        NSLog(@"你的手机暂不支持3D Touch!");
        //self.longPress.enabled = YES;
    }
}


- (void)returnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark -- 点击进入预览模式： 实现该协议方法
- (UIViewController *)previewingContext:(id)previewingContext viewControllerForLocation:(CGPoint)location
{
    return self;
}
#pragma mark -- 继续按压进入：实现该协议
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    NSLog(@"继续按压");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//预览模式上拉实现 ：
//我们预览模式下上拉 出现一个视图  该视图类 apple提供了 UIPreviewAction 该类来实现，调用
//    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
//
//        NSLog(@"Action1 triggered");
//    }];


//创建
//    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc]initWithType:@"two"localizedTitle:@"第二个标签"localizedSubtitle:@"看我哦"icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
//    //添加
//    [UIApplication sharedApplication].shortcutItems = @[item];

/*
 也可以在appdelegate 中写
 UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon1"];
 
 UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon2"];
 
 UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon3"];
 
 // create several (dynamic) shortcut items
 
 UIMutableApplicationShortcutItem
 
 *item1 = [[UIMutableApplicationShortcutItem
 
 alloc]initWithType:@"com.test.dynamic" localizedTitle:@"Dynamic
 
 Shortcut" localizedSubtitle:@"available after first launch" icon:icon1
 
 userInfo:nil];
 
 UIMutableApplicationShortcutItem
 
 *item2 = [[UIMutableApplicationShortcutItem
 
 alloc]initWithType:@"com.test.deep1" localizedTitle:@"Deep Link 1"
 
 localizedSubtitle:@"Launch Nav Controller" icon:icon2 userInfo:nil];
 
 UIMutableApplicationShortcutItem
 
 *item3 = [[UIMutableApplicationShortcutItem
 
 alloc]initWithType:@"com.test.deep2" localizedTitle:@"Deep Link 2"
 
 localizedSubtitle:@"Launch 2nd Level" icon:icon3 userInfo:nil];
 
 // add all items to an array
 
 NSArray *items = @[item1, item2, item3];
 
 // add this array to the potentially existing static UIApplicationShortcutItems
 
 NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
 
 NSArray *updatedItems = [existingItems arrayByAddingObjectsFromArray:items];
 
 [UIApplication sharedApplication].shortcutItems = updatedItems;
 
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
