//
//  RHCSlideTableViewController.h
//  RenrenOfficial-iOS-Concept
//
//  Created by renren-ccbo on 13-12-31.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RHCSlideTableView.h"

#ifndef DailyHotsKey
#define DailyHotsKey @"DailyHotsKey"
#endif

#ifndef DailyHotsValue
#define DailyHotsValue @"DailyHotsValue"
#endif

@interface RHCSlideTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,RHCSlideTableViewDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger initPageIndex;
@property (nonatomic, strong) UIView * customerBackgroundView;
@property (nonatomic, strong) RHCSlideTableView * slideTableView;
@property (nonatomic, strong) NSMutableDictionary * dailyHotsData;// 数据结构是(index:obj),obj格式是（DailyHotsKey:keys,DailyHotsValue:values）

- (id)initWithItems:(NSArray *)items withInitPage:(NSInteger)index;
- (NSInteger)tableIndex:(UITableView *)tableView;
@end
