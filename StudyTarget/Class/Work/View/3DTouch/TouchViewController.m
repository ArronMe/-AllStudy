//
//  TouchViewController.m
//  StudyTarget
//
//  Created by 杨梦 on 2017/1/4.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import "TouchViewController.h"
#import "TouchChildViewController.h"

@interface TouchViewController ()<UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource>
//应该判断该控制器当前是否实现了3dtouch手势 如果实现的话最好禁用长按手势
{
    UITableView *_tableView;
    NSMutableArray *_myArray;
}
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
    returnBtn.frame = CGRectMake(10, 30, 50, 20);
    [returnBtn setTitle:@"返回" forState:0];
    [returnBtn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    _myArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 20; i++) {
        [_myArray addObject:[NSString stringWithFormat:@"test%li",i]];
    }
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    }
    else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}


- (void)returnClick:(UIButton *)btn
{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = _myArray[indexPath.row];
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"3D Touch  可用!");
        //给cell注册3DTouch的peek（预览）和pop功能
        [self registerForPreviewingWithDelegate:self sourceView:cell];
        // 如果实现了长按手势要禁止
        //self.longPress.enabled = NO;
    } else {
        NSLog(@"3D Touch 无效");
        //self.longPress.enabled = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TouchChildViewController *childVC = [[TouchChildViewController alloc] init];
    childVC.str = [NSString stringWithFormat:@"我是%@,用力按一下进来",_myArray[indexPath.row]];
    [self.navigationController pushViewController:childVC animated:YES];
}


#pragma mark -- 点击进入peek(预览)模式：(一般用于cell中)
- (nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
 
    //设定预览的界面
    TouchChildViewController *childVC = [[TouchChildViewController alloc] init];
    childVC.preferredContentSize = CGSizeMake(0.0f,500.0f);
    childVC.str = [NSString stringWithFormat:@"我是%@,用力按一下进来",_myArray[indexPath.row]];
   
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,40);
    previewingContext.sourceRect = rect;
    //返回预览界面
    return childVC;
}
#pragma mark --pop继续按压进入
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
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
