//
//  WaitingForInternetBattleViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DeviceMotion.h"
#import "GetEnemyDataFromServer.h"
#import "MBAnimationView.h"
#import "CALayer+nnCALayer.h"
#import "PenetrateFilter.h"
#define FINISHED3 syncFinished = YES;



@interface WaitingForInternetBattleViewController : UIViewController<deviceMotionDelegate>{
    AppDelegate *app;
    NSUserDefaults *ud;
    DeviceMotion *dev;
    MBAnimationView *gikoAnimationView;
    UIImageView *backgroundImageView1;
    UIImageView *backgroundImageView2;
    MBAnimationView *cardBoxAnimationView;
    UIImageView *cardBox_closed;
    UIImageView *cardImageView;
    NSDate *walkingStartTime;//ギコが歩き始めた時刻を格納する
    UITextView *walkingMeter; //ギコがカードゲットまでに必要な残り距離を表示する
    int allWalkingTime; //総待機時間を格納する
    int remainedWalkingTime; //カードゲットまでに必要な残り時間を格納する
    int gettingCardNumber; //ゲットしたカードナンバーを格納する
    UIAlertView *walkingStartAlertView; //待機開始時に出すアラートビュー
    UIAlertView *getACardAlertView; //カードゲット時に出すアラートビュー
    NSTimer *timer;//宝箱を開けるアニメーションを待つためのタイマー
    UIButton *stopExplorationButton; //探索を中止するボタン
    BOOL stopWalking; //対戦相手が見つかったか、探索を中止した際にYESとなる
}

@property (nonatomic, assign) int course;//コース番号を格納する（CourseSelectViewControllerにて最初にデータ格納）

@end
