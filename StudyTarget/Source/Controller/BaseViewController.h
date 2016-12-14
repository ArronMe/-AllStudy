//
//  BaseViewController.h
//  HillhouseData
//
//  Created by 赵城林 on 16/11/22.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic ,strong) NSArray *data;
@property (nonatomic ,strong) NSString *mainUrl;
- (NSDictionary *)tryJsonDic:(NSString *) jsonString;
@end
