//
//  RecognizeViewController.m
//  StudyTarget
//  二维码
//  Created by 杨梦 on 2016/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "RecognizeViewController.h"
#import "LXDScanView.h"
#import "LXDScanCodeController.h"
#import <AVFoundation/AVFoundation.h>


@interface RecognizeViewController ()<LXDScanViewDelegate, LXDScanCodeControllerDelegate>

@property (nonatomic, strong) LXDScanView * scanView;

@end

@implementation RecognizeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"二维码";
    [self createBtn];
}



- (void)createBtn
{
    UIButton *btn=[[UIButton alloc] init];
    btn.frame=CGRectMake(50, 200, 80, 40);
    btn.backgroundColor=[UIColor cyanColor];
    [btn setTitle:@"直接扫描" forState:0];
    [btn addTarget:self action:@selector(scan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2=[[UIButton alloc] init];
    btn2.frame=CGRectMake(50, 300, 80, 40);
    btn2.backgroundColor=[UIColor grayColor];
    [btn2 setTitle:@"跳界面扫描" forState:0];
    [btn2 addTarget:self action:@selector(jumpToScan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    
}

#pragma mark - event
- (void)scan:(id)sender
{
    NSString *deviceString = [WTSystemInfo ObtaindeviceString];
    
    if ([deviceString isEqualToString:@"x86_64"]||[deviceString isEqualToString:@"i386"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"当前无法打开摄像头"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else{
        [self.view addSubview: self.scanView];
        [self.scanView start];

    }
}


- (void)jumpToScan:(id)sender
{
    NSString *deviceString = [WTSystemInfo ObtaindeviceString];
    
    if ([deviceString isEqualToString:@"x86_64"]||[deviceString isEqualToString:@"i386"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"当前无法打开摄像头"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else{
        [self.scanView removeFromSuperview];
        LXDScanCodeController * scanCodeController = [LXDScanCodeController scanCodeController];
        scanCodeController.scanDelegate = self;
        [self.navigationController pushViewController: scanCodeController animated: YES];
    }
}


#pragma mark - getter
/**
 *  懒加载扫描view
 */
- (LXDScanView *)scanView
{
    if (!_scanView) {
        _scanView = [LXDScanView scanViewShowInController: self];
        _scanView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    }
    return _scanView;
}


#pragma mark - LXDScanViewDelegate
/**
 *  返回扫描结果
 */
- (void)scanView:(LXDScanView *)scanView codeInfo:(NSString *)codeInfo
{
    NSURL * url = [NSURL URLWithString: codeInfo];
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
        
//        [[UIApplication sharedApplication] openURL:url options:(nonnull NSDictionary<NSString *,id> *) completionHandler:^(BOOL success) {
//            
//        }];
        
        [[UIApplication sharedApplication] openURL: url];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"%@:%@", @"无法解析的二维码", codeInfo] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}


#pragma mark - LXDScanCodeControllerDelegate
- (void)scanCodeController:(LXDScanCodeController *)scanCodeController codeInfo:(NSString *)codeInfo
{
    NSURL * url = [NSURL URLWithString: codeInfo];
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
        [[UIApplication sharedApplication] openURL: url];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"%@:%@", @"无法解析的二维码", codeInfo] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}



- (void)viewDidDisappear:(BOOL)animated
{
    NSString *deviceString = [WTSystemInfo ObtaindeviceString];
    
    if ([deviceString isEqualToString:@"x86_64"]||[deviceString isEqualToString:@"i386"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"当前无法打开摄像头"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else{
        [self.scanView stop];
    }

}


- (void)dealloc
{
    NSString *deviceString = [WTSystemInfo ObtaindeviceString];
    
    if ([deviceString isEqualToString:@"x86_64"]||[deviceString isEqualToString:@"i386"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"模拟器无法打开摄像头"] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else{
        
        [self.scanView stop];
    }
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
