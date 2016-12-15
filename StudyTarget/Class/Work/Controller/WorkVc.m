//
//  WorkVc.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "WorkVc.h"
#import <objc/runtime.h>

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
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HomePlist" ofType:@"plist"];
    _dataSource=[[NSMutableArray alloc] initWithContentsOfFile:plistPath];
}

- (void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
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
    UIViewController *viewvc = [[type alloc]init];
    [self.navigationController pushViewController:viewvc animated:YES];
    
    //

    
//    const char *new = [VCName cStringUsingEncoding:NSASCIIStringEncoding];
//
//    Class newClass = object_getClass(VCName);
//    if (!newClass) {
//        Class superClass = [NSObject class];
//        newClass = objc_allocateClassPair(superClass, new, 0);
//        objc_registerClassPair(newClass);
//        
//    }
//    id instance = [[newClass alloc]init];
//    [self.navigationController pushViewController:instance animated:YES];
    
    
    
    
    


  
    
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
