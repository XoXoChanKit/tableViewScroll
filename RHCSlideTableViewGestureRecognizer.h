//
//  RHCSlideTableViewGestureRecognizer.h
//  RenrenOfficial-iOS-Concept
//
//  Created by renren-ccbo on 14-1-2.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHCSlideTableViewGestureRecognizer : UIGestureRecognizer
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGPoint currentPoint;
@end
