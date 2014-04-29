//
//  RHCSlideTableViewController.m
//  RenrenOfficial-iOS-Concept
//
//  Created by renren-ccbo on 13-12-31.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import "RHCSlideTableViewController.h"

#import "RHCSlideSubTableView.h"

@interface RHCSlideTableViewController ()
@end

@implementation RHCSlideTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithItems:(NSArray *)items withInitPage:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.items = items;
        self.initPageIndex = index;
        self.dailyHotsData = [NSMutableDictionary dictionary];
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    float dey = 44;
    if ([RLUtility isHigherIOS7]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        dey = 0;
    }
	self.customerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, SUBVIEWS_Y_OFFSET, self.view.frame.size.width, self.view.frame.size.height - SUBVIEWS_Y_OFFSET - dey)];
    self.customerBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customerBackgroundView];
    self.slideTableView = [[RHCSlideTableView alloc] initWithFrame:self.customerBackgroundView.bounds withItems:self.items withSVSegmentViewBackgroundImage:[UIImage imageForKey:@"userHomeContentFilterBackground"] withSVSegmentViewSelectedImage:[UIImage imageForKey:@"userHomeContentFilterSelected"] withSVSegmentViewUnselectedImage:[UIImage imageForKey:@"userHomeContentFilterSelected"] withHeadContentView:nil withInitPage:self.initPageIndex];
    [self.slideTableView setTableViewDataSource:self andDelegate:self];
    self.slideTableView.slideTableViewDelegate = self;
    [self.customerBackgroundView addSubview:self.slideTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [(RHCNavigationController *)[AppNavigator navigator].mainNav setNavPanGestureEnabled:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [(RHCNavigationController *)[AppNavigator navigator].mainNav setNavPanGestureEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    for (int i = 0; i < self.items.count; i++) {
        if (i != [self.slideTableView getCurrentContentPage]) {
            [self.dailyHotsData removeObjectForKey:@(i)];
        }
    }
    [self.slideTableView reloadData];
}

- (void)dealloc
{
    [self.slideTableView setTableViewDataSource:nil andDelegate:nil];
}

- (NSInteger)tableIndex:(UITableView *)tableView
{
    return [self.slideTableView indexOfTableView:tableView];
}

#pragma mark 可重载函数
- (void)sortSectionArray:(id)originalData byIndex:(int)index
{
    // 此函数可以重载，构造符合本控件的数据
}

- (UITableViewCell *)slideTableCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 可重载生成相应的cell
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
}

- (CGFloat)slideTable:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (CGFloat)slideTable:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)slideTable:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)slideTable:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
#pragma mark tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int theTableIndex = [self tableIndex:tableView];
    if (!self.dailyHotsData) {
        if ([tableView isKindOfClass:[RHCSlideSubTableView class]]) {
            [(RHCSlideSubTableView *)tableView setErrorViewHide:NO];
        }
        return 0;
    }
    //
    NSDictionary * dataDictionary = [self.dailyHotsData objectForKey:@(theTableIndex)];
    if (dataDictionary) {
        if ([dataDictionary objectForKey:DailyHotsKey]) {
            int sectionNumber = [[dataDictionary objectForKey:DailyHotsKey] count];
            if ([tableView isKindOfClass:[RHCSlideSubTableView class]]) {
                if (sectionNumber > 0) {
                    [(RHCSlideSubTableView *)tableView setErrorViewHide:YES];
                }
                else {
                    [(RHCSlideSubTableView *)tableView setErrorViewHide:NO];
                }
            }
            return sectionNumber;
        }
    }
    else {
        if ([tableView isKindOfClass:[RHCSlideSubTableView class]]) {
            [(RHCSlideSubTableView *)tableView setErrorViewHide:NO];
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int theTableIndex = [self tableIndex:tableView];
    if (theTableIndex == -1 || !self.dailyHotsData) {
        return 0;
    }
    //
    NSDictionary * dataDictionary = [self.dailyHotsData objectForKey:@(theTableIndex)];
    if (dataDictionary) {
        if ([dataDictionary objectForKey:DailyHotsKey]) {
            return [[[dataDictionary objectForKey:DailyHotsValue] objectForKey:[[dataDictionary objectForKey:DailyHotsKey] objectAtIndex:section]] count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self slideTableCell:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self slideTable:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self slideTable:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self slideTable:tableView heightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self slideTable:tableView viewForHeaderInSection:section];
}

#pragma mark RHCSlideTableViewDelegate
- (void)tableViewChanged
{
    [self.slideTableView stopInfiniteAnimation];
    [self.slideTableView stopPullAnimating];
}
- (void)pullRefresh
{
}
- (void)addInifiniteScrolling
{
}
- (void)popToLastController
{
}
#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.slideTableView.lockTheSlideView) {
        return;
    }
    if (!self.slideTableView.headContentView ) {
        self.slideTableView.lastCenterTablePointY = scrollView.contentOffset.y;
        return;
    }
    CGFloat currentPos = scrollView.contentOffset.y;
    CGFloat deltaY = currentPos - self.slideTableView.lastCenterTablePointY;
    if (deltaY > 0) {
        if (currentPos <= 0) {
            self.slideTableView.lastCenterTablePointY = scrollView.contentOffset.y;
            return;
        }
        if (self.slideTableView.contentOffset.y < headViewHeight) {
            [scrollView setContentOffset:CGPointMake(0, 0)];
            if (self.slideTableView.contentOffset.y + deltaY > headViewHeight) {
                deltaY = headViewHeight - self.slideTableView.contentOffset.y;
            }
            [self.slideTableView setContentOffset:CGPointMake(0, self.slideTableView.contentOffset.y + deltaY)];
            self.slideTableView.lastCenterTablePointY = 0;
            return;
        }
    }
    else if (deltaY < 0) {
        if (currentPos > 0) {
            self.slideTableView.lastCenterTablePointY = scrollView.contentOffset.y;
            return;
        }
        if (self.slideTableView.contentOffset.y > 0) {
            [scrollView setContentOffset:CGPointMake(0, 0)];
            if (self.slideTableView.contentOffset.y + deltaY < 0) {
                deltaY = -self.slideTableView.contentOffset.y;
            }
            [self.slideTableView setContentOffset:CGPointMake(0, self.slideTableView.contentOffset.y + deltaY)];
            self.slideTableView.lastCenterTablePointY = 0;
            return;
        }
    }
    self.slideTableView.lastCenterTablePointY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isKindOfClass:[RHCSlideSubTableView class]]) {
        if (!self.slideTableView.headContentView || self.slideTableView.lockTheSlideView || decelerate) {
            return;
        }
        CGFloat currentPos = self.slideTableView.contentOffset.y;
        if (currentPos > 0 && currentPos < headViewHeight) {
            if (self.slideTableView.scrollDirector) {
                [self.slideTableView setContentOffset:CGPointMake(0, headViewHeight) animated:YES];
            }
            else {
                [self.slideTableView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[RHCSlideSubTableView class]]) {
        if (!self.slideTableView.headContentView || self.slideTableView.lockTheSlideView) {
            return;
        }
        CGFloat currentPos = self.slideTableView.contentOffset.y;
        if (currentPos > 0 && currentPos < headViewHeight) {
            if (self.slideTableView.scrollDirector) {
                [self.slideTableView setContentOffset:CGPointMake(0, headViewHeight) animated:YES];
            }
            else {
                [self.slideTableView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    }
}
@end
