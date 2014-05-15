//
//  PenetrateFilter.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/14.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "PenetrateFilter.h"



@implementation PenetrateFilter


//ビューの背景を透明にする
+(void)penetrate:(UIView *)view{
    //背景透過を許可
    view.opaque = NO;
    view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
}

@end
