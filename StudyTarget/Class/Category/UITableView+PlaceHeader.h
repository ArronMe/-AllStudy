//
//  UITableView+PlaceHeader.h
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (PlaceHeader)
@property (nonatomic ,strong) UIView *placeHeader;
@property (nonatomic ,copy)void(^reloadBlock)(void);

@end
