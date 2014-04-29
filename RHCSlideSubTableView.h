//
//  RHCSlideSubTableView.h
//  RenrenOfficial-iOS-Concept
//
//  Created by renren-ccbo on 14-1-2.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHCSlideSubTableViewDelegate <NSObject>

@required
- (void)moveSubTableView:(CGFloat)deltax withState:(BOOL)isEnd;

@end

@interface RHCSlideSubTableView : UITableView

@property (nonatomic, weak) id<RHCSlideSubTableViewDelegate> slideSubTableViewDelegate;

- (void)setErrorViewHide:(BOOL)hide;
- (void)setGestureStatus:(BOOL)status;
@end
