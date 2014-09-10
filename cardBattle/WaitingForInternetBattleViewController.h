//
//  WaitingForInternetBattleViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBAnimationView.h"
#import "CALayer+nnCALayer.h"
#define FINISHED3 syncFinished = YES;

@protocol WaitingForInternetBattleViewControllerDelegate <NSObject>

// デリゲートメソッドを宣言
// （宣言だけしておいて，実装はデリゲート先でしてもらう）
- (void)dismissViewController;

@end


@interface WaitingForInternetBattleViewController : UIViewController{
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
    NSUserDefaults *ud;
    UIAlertView *walkingStartAlertView; //待機開始時に出すアラートビュー
    UIAlertView *getACardAlertView; //カードゲット時に出すアラートビュー
    NSTimer *timer;//宝箱を開けるアニメーションを待つためのタイマー
    UIButton *stopExplorationButton; //探索を中止するボタン
}

// デリゲート先で参照できるようにするためプロパティを定義しておく
@property (nonatomic, assign) id<WaitingForInternetBattleViewControllerDelegate> delegate;


@end
