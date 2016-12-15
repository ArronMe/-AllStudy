//
//  UITableView+PlaceHeader.m
//  StudyTarget
//
//  Created by 赵城林 on 16/12/14.
//  Copyright © 2016年 com.hillhouse.news. All rights reserved.
//

#import "UITableView+PlaceHeader.h"
#import "PlaceHeaderview.h"
#import "NSObject+Swizzling.h"
@implementation UITableView (PlaceHeader)
+ (void) load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodExchangingWithOriginalSelector:@selector(reloadData) bySwizzlingSelecter:@selector(newLoadData)];
        
    });
}
- (void) checkEmpty
{
    BOOL isEmpty = YES;//flag标示
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;//默认为一个分区
    //获取当前TableViewyou多少个分区
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        //获取当前TableView各分区的行数
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:sections];        if (rows) {
            isEmpty = NO;//若行数存在，不为空
        }
    }
    if (isEmpty) {
        //若为空，加载占位图，默认占位图
        if (!self.placeHeader) {
            [self createDefaultPlaceHeaderView];
        }
        self.placeHeader.hidden = NO;
        [self addSubview:self.placeHeader];
    } else {//不为空，移除占位图
        self.placeHeader.hidden = YES;
    }

    
}
- (void) createDefaultPlaceHeaderView
{
    PlaceHeaderview *header = [[PlaceHeaderview alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    __weak typeof(self) weakSelf = self;
    header.replaceBlock = ^()
    {
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock ();
            
        }
        
    };
    self.placeHeader = header;
    
}
- (void)setPlaceHeader:(UIView *)placeHeader
{
    objc_setAssociatedObject(self, @selector(placeHeader), placeHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *) placeHeader
{
    return objc_getAssociatedObject(self, @selector(placeHeader));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock
{
    objc_setAssociatedObject(self, @selector(reloadBlock),reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}


- (void) newLoadData
{
    [self checkEmpty];
    [self newLoadData];
    
    
}

@end
