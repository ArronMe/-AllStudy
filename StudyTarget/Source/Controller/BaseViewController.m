//
//  BaseViewController.m
//  HillhouseData
//
//  Created by 赵城林 on 16/11/22.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "BaseViewController.h"
#import <MJExtension.h>
#import <YYKit.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(E6E6E6);
}

- (NSDictionary *)tryJsonDic:(NSString *) jsonString
{
    if (jsonString.length != 0) {
        id dic = jsonString.mj_JSONObject;
        if ([dic isKindOfClass:[NSDictionary class]]){
            return dic;
        }else
        {
            return nil;
        }
        
        
    }else
    {
        return  nil;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
