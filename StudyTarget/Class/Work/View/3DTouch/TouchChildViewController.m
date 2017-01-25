//
//  TouchChildViewController.m
//  StudyTarget
//
//  Created by 杨梦 on 2017/1/4.
//  Copyright © 2017年 com.hillhouse.news. All rights reserved.
//

#import "TouchChildViewController.h"

@interface TouchChildViewController ()
{
    UILabel *_moveLab;
}

@end

@implementation TouchChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(50, 400, 100, 40);
    [returnBtn setTitle:@"返回" forState:0];
    [returnBtn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];

    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(50, 100, 200, 50);
    label.text = @"用不同力度按我试试";
    label.backgroundColor = [UIColor blueColor];
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled=YES;
    label.enabled = YES;
    label.tag =105;
    [self.view addSubview:label];
    
    _moveLab = [[UILabel alloc] init];
    _moveLab.frame=CGRectMake(50, 200, 200, 40);
    _moveLab.backgroundColor = [UIColor redColor];
    _moveLab.text =@"压力";
    _moveLab.textColor = [UIColor whiteColor];
    [self.view addSubview:_moveLab];
    
    _lab = [[UILabel alloc] init];
    _lab.frame = CGRectMake(50, 300, 200, 30);
    _lab.text = _str;
    _lab.textColor = [UIColor whiteColor];
    [self.view addSubview:_lab];

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
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Aciton1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton1");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Aciton2" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton2");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Aciton3" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton3");
    }];
    
    NSArray *actions = @[action1,action2,action3];
    
    // and return them (return the array of actions instead to see all items ungrouped)
    return actions;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 105) {
        NSLog(@"Began压力 ＝ %f",touch.force);
        _moveLab.text =[NSString stringWithFormat:@"压力：%f",touch.force];
        _bottom.constant = ((UITouch *)[arrayTouch lastObject]).force * 100;
    }
}

//按住移动or压力值改变时的回调
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    //通过tag确定按压的是哪个view，注意：如果按压的是label，将label的userInteractionEnabled属性设置为YES
    if (touch.view.tag == 105) {
        NSLog(@"move压力 ＝ %f",touch.force);
        _moveLab.text =[NSString stringWithFormat:@"压力：%f",touch.force];
        //红色背景的label上移的高度＝压力值*100
        _bottom.constant = ((UITouch *)[arrayTouch lastObject]).force * 100;
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 105) {
        NSLog(@"End压力 ＝ %f",touch.force);
        _moveLab.text =[NSString stringWithFormat:@"压力：%f",touch.force];
        _bottom.constant = ((UITouch *)[arrayTouch lastObject]).force * 100;
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 105) {
        NSLog(@"Cancel压力 ＝ %f",touch.force);
        _moveLab.text =[NSString stringWithFormat:@"压力：%f",touch.force];
        NSLog(@"压力所在view的tag ＝ %li",touch.view.tag);
        _bottom.constant = ((UITouch *)[arrayTouch lastObject]).force * 100;
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
