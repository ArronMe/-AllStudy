//
//  WorkVc.m
//  StudyTarget
//  首页
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "WorkVc.h"
#import "UITableView+PlaceHeader.h"
#import <objc/runtime.h>
#import "UIWebViewJSViewController.h"
#import "LXDScanView.h"
#import "LXDScanCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "TouchChildViewController.h"


@interface WorkVc () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}

@end

@implementation WorkVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    

    _dataSource=[[NSMutableArray alloc] initWithContentsOfFile:@""];
}

- (void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    __weak typeof(_tableView) weakTable = _tableView;
    [_tableView setReloadBlock:^{

        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HomePlist" ofType:@"plist"];
        _dataSource=[[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        [weakTable reloadData];
        
    }];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:@"identifyCell"];
    if (Cell==nil) {
        Cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifyCell"];
    }
    Cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dict=_dataSource[indexPath.row];
    Cell.textLabel.text=[dict objectForKey:@"title"];
    return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict =_dataSource[indexPath.row];
    
    NSString *VCName=[NSString stringWithFormat:@"%@",[dict objectForKey:@"VC"]];
    Class type = NSClassFromString(VCName);
    UIViewController *viewvc ;

    if ([VCName containsString:@"WebViewJS"]) {
        viewvc = [[type alloc]initWithNibName:VCName bundle:nil];
    }
    else if (indexPath.row==0){
        NSString *deviceString = [WTSystemInfo ObtaindeviceString];
        
        if ([deviceString isEqualToString:@"x86_64"]||[deviceString isEqualToString:@"i386"]) {
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"当前无法打开摄像头"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
            [alertView show];
        }
        else{
            NSString *deviceString = [WTSystemInfo ObtaindeviceString];
            
            if ([deviceString isEqualToString:@"x86_64"]||[deviceString isEqualToString:@"i386"]) {
                
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"当前无法打开摄像头"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
                [alertView show];
            }
            else{
                LXDScanCodeController * scanCodeController = [LXDScanCodeController scanCodeController];
                [scanCodeController setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController: scanCodeController animated: YES];
            }
        }
    }
    else{
        viewvc = [[type alloc]init];
            }
    [self.navigationController pushViewController:viewvc animated:YES];

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
