//
//  LXDScanCodeController.m
//  LXDScanQRCode
//
//  Created by 林欣达 on 15/10/14.
//  Copyright © 2015年 cnpayany. All rights reserved.
//

#import "LXDScanCodeController.h"
#import "LXDScanView.h"

@interface LXDScanCodeController ()<LXDScanViewDelegate>

@property (nonatomic, strong) LXDScanView * scanView;

@end

@implementation LXDScanCodeController


#pragma mark - initial
+ (instancetype)scanCodeController
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.scanView = [LXDScanView scanViewShowInController: self];
    }
    return self;
}

#pragma mark - life
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.scanView];
    [self createBackButton];
}

- (void)createBackButton
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(20, 40, 40, 15);
    [btn setTitle:@"返回" forState:0];
    btn.titleLabel.font=[UIFont fontWithName:@"PingFang" size:14];
    [btn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)backClick:(UIButton *)btn
{
    [self.scanView stop];
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.scanView start];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    self.navigationController.navigationBar.hidden=NO;
    [self.scanView stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.scanView stop];
}


#pragma mark - LXDScanCodeController
/**
 *  扫描成功时回调
 */
- (void)scanView:(LXDScanView *)scanView codeInfo:(NSString *)codeInfo
{
    NSURL * url = [NSURL URLWithString: codeInfo];
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
        [[UIApplication sharedApplication] openURL: url];
    }
    else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"%@:%@", @"无法解析的二维码", codeInfo] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}


@end
