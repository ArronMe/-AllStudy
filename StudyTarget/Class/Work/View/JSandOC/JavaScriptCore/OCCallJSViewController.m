//
//  OCCallJSViewController.m
//  JavaScriptCore-Demo
//
//  Created by Jakey on 14/12/26.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "OCCallJSViewController.h"

@interface OCCallJSViewController ()

@end

@implementation OCCallJSViewController

/*******
 iOS7中加入了JavaScriptCore.framework框架。把 WebKit 的 JavaScript 引擎用 Objective-C 封装。该框架让Objective-C和JavaScript代码直接的交互变得更加的简单方便。
 
 合适时机注入交互对象
 
 什么时候UIWebView会创建JSContext环境?
 分两种方式
 
 第一在渲染网页时遇到<script标签时，就会创建JSContext环境去运行JavaScript代码。
 
 第二就是使用方法[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]去获取JSContext环境时，这时无论是否遇到<script标签，都会去创造出来一个JSContext环境，而且和遇到<script标签再创造环境是同一个。
 
 什么时候注入JSContext问题
 我通常都会在 - (void)webViewDidFinishLoad:(UIWebView *)webView中去注入交互对象，但是这时候网页还没加载完，JavaScript那边已经调用交互方法，这样就会调不到原生应用的方法而出现问题。
 
 改成在- (void)viewDidLoad中去注入交互对象，这样倒是解决了上面的问题，但是同时又引起了一个新的问题就是在一个网页内部点击链接跳转到另一个网页的时候，第二个页面需要交互，这时JSContext环境已经变化，但是- (void)viewDidLoad仅仅加载一次，跳转的时候，没有再次注入交互对象，这样就会导致第二个页面没法进行交互。当然你可以在- (void)viewDidLoad和- (void)webViewDidFinishLoad:(UIWebView *)webView都注入一次，但是一定会有更优雅的办法去解决此问题。
 
 如果上边的方案能满足需求,建议实在迫不得已再用这个方法,  就是在每次创建JSContext环境的时候，我们都去注入此交互对象这样就解决了上面的问题。具体解决办法参考了此开源库UIWebView-TS_JavaScriptContext(使用了私有API 上架会被拒绝 不建议使用)。
 
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"oc call js";
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"test"]];
    

}
- (NSString *)loadJsFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendToJS:(id)sender {
    NSNumber *inputNumber = [NSNumber numberWithInteger:[self.textField.text integerValue]];
    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];
    JSValue *result = [function callWithArguments:@[inputNumber]];
    self.showLable.text = [NSString stringWithFormat:@"%@", [result toNumber]];
}


@end
