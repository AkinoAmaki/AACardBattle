//
//  GikoGikoWaintngViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitingForInternetBattleViewController.h"
#define FINISHED syncFinished = YES;

/*
 
 Note!!!
 ■GikoGikoWaintngViewControllerクラスは、探索コースの選択画面と実際の探索画面(WaitingForInternetBattleViewController)の中間に位置するビューです。
 ■カードを探索し終えたら、探索画面が閉じ、この画面に戻ってきます。
 ■この画面に戻ってきたら、数秒待機した後に再び探索画面に戻ります。
 ■カード探索を中止したい場合の処理はWaitingForInternetBattleViewControllerに記載してあります。（）
 
 
 
 */


@interface GikoGikoWaintngViewController : UIViewController{
    WaitingForInternetBattleViewController *waiting;
    UIAlertView *usingDeckCardList;
    BOOL syncFinished;
}

@property (nonatomic,assign) int course; //コース番号を格納し、WaitingForInternetBattleViewControllerに引き渡す（CourseSelectViewControllerにて最初にデータ格納）

@end
