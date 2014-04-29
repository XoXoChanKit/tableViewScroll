//
//  RHCSlideTableViewGestureRecognizer.m
//  RenrenOfficial-iOS-Concept
//
//  Created by renren-ccbo on 14-1-2.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "RHCSlideTableViewGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

@interface RHCSlideTableViewGestureRecognizer()
@end

@implementation RHCSlideTableViewGestureRecognizer

#pragma mark touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setFailedStatebyDelay) object:nil];
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
    else {
        [self setState:UIGestureRecognizerStateEnded];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setFailedStatebyDelay) object:nil];
    UITouch * touch = [touches anyObject];
    self.lastPoint = [touch previousLocationInView:self.view];
    self.currentPoint = [touch locationInView:self.view];
    if (ABS(self.currentPoint.x - self.lastPoint.x) > ABS(self.currentPoint.y - self.lastPoint.y)) {
        [self setState:UIGestureRecognizerStateChanged];
    }
    else if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setFailedStatebyDelay) object:nil];
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
    else {
        [self setState:UIGestureRecognizerStateEnded];
    }
}

@end
