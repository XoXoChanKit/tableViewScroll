//
//  RHCSlideSubTableView.m
//  RenrenOfficial-iOS-Concept
//
//  Created by renren-ccbo on 14-1-2.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "RHCSlideSubTableView.h"

#import "RHCSlideTableViewGestureRecognizer.h"

@interface RHCSlideSubTableView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) RHCSlideTableViewGestureRecognizer * gesture;
@property (nonatomic, strong) UIImageView *errorView;
@end

@implementation RHCSlideSubTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.gesture = [[RHCSlideTableViewGestureRecognizer alloc] initWithTarget:self action:@selector(pageChange:)];
        self.gesture.delegate = self;
        for (UIGestureRecognizer * gesture in self.gestureRecognizers) {
            [gesture requireGestureRecognizerToFail:self.gesture];
        }
        [self addGestureRecognizer:self.gesture];
        //
        self.errorView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.errorView.userInteractionEnabled = NO;
        self.errorView.backgroundColor = [UIColor whiteColor];
        self.errorView.contentMode = UIViewContentModeCenter;
        self.errorView.image = [UIImage imageForKey:@"common_ic_wuhaoyou"];
        [self addSubview:self.errorView];
    }
    return self;
}

- (void)dealloc
{
    self.slideSubTableViewDelegate = nil;
}

- (void)pageChange:(UIGestureRecognizer *)gesture
{
    if (self.slideSubTableViewDelegate && [self.slideSubTableViewDelegate respondsToSelector:@selector(moveSubTableView:withState:)]) {
        CGFloat deltaX = self.gesture.currentPoint.x - self.gesture.lastPoint.x;
        if (gesture.state == UIGestureRecognizerStateChanged) {
            self.scrollEnabled = NO;
            NSIndexPath * path = [self indexPathForSelectedRow];
            if (path) {
                [self deselectRowAtIndexPath:path animated:YES];
            }
            [self.slideSubTableViewDelegate moveSubTableView:deltaX withState:NO];
        }
        else if (gesture.state == UIGestureRecognizerStateEnded){
            self.scrollEnabled = YES;
            [self.slideSubTableViewDelegate moveSubTableView:deltaX withState:YES];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([RLUtility isHigherIOS7]) {
        if (([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && gestureRecognizer.state != UIGestureRecognizerStateFailed) || ([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && otherGestureRecognizer.state != UIGestureRecognizerStateFailed)) {
            self.gesture.enabled = NO;
        }
        else {
            self.gesture.enabled = YES;
        }
    }
    return YES;
}

- (void)setErrorViewHide:(BOOL)hide
{
    [self.errorView setHidden:hide];
}

- (void)setGestureStatus:(BOOL)status
{
    self.gesture.enabled = status;
}
@end
