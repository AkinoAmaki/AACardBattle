//
//  YSDeviceHelper.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/13.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "YSDeviceHelper.h"

@implementation YSDeviceHelper
+ (BOOL)isPhone
{
    static BOOL isPhone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    });
    return isPhone;
}

+ (BOOL)isRetina
{
    static BOOL isRetina;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isRetina = [UIScreen mainScreen].scale == 2.f;
    });
    return isRetina;
}

+ (BOOL)is568h
{
    static BOOL is568h;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        is568h = height == 568.f;
    });
    return is568h;
}

+ (BOOL)isJapaneseLanguage
{
    static BOOL isJapanese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
    });
    return isJapanese;
}
@end
