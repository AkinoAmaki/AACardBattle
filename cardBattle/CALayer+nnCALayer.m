//
//  CALayer+nnCALayer.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "CALayer+nnCALayer.h"

@implementation CALayer (nnCALayer)
-(void)pauseAnimation:(BOOL)aPause
{
    if(aPause)
    {
        CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
        self.speed = 0.0;
        self.timeOffset = pausedTime;
    }
    else
    {
        CFTimeInterval pausedTime = [self timeOffset];
        self.speed = 1.0;
        self.timeOffset = 0.0;
        self.beginTime = 0.0;
        CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.beginTime = timeSincePause;
    }
}
@end
