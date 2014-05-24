//
//  BattleCaliculate.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define GIKO 1
#define MONAR 2
#define SYOBON 3
#define YARUO 4



@interface BattleCaliculate : UIViewController{
    AppDelegate *app;
}



//相手の通常攻撃によるダメージを計算する
-(int)damageCaliculate;

@end
