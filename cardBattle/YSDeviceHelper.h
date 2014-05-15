//
//  YSDeviceHelper.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/13.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSDeviceHelper : NSObject
// iPhoneか
+ (BOOL)isPhone;
// Retinaディスプレイか
+ (BOOL)isRetina;
// 4inch(iPhone5)か
+ (BOOL)is568h;
// 言語環境が日本語か
+ (BOOL)isJapaneseLanguage;
@end
