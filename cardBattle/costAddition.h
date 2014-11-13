//
//  costAddition.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/11/13.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#define FINISHED syncFinished = YES;

@interface costAddition : NSObject<UIAlertViewDelegate>{
    AppDelegate *app;
    BOOL syncFinished;
}

-(void)getCostImageView:(int)cardNum; //入力したカードナンバーの画像（コスト表示・カードナンバー表示なし）にコストとカードナンバーを付加して/Users/AkinoAmaki/Downloads/tempにダウンロードする

@end
