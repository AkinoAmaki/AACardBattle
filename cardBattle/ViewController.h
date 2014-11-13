//
//  ViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SummonViewController.h"
#import "MBAnimationView.h"
#import "NADView.h"
#import "AAButton.h"
#import "PBImageView.h"
#import "IntroductionTool.h"
#import "SocialMediaViewController.h"
#import "UIView+Origin.h"
#import "costAddition.h"
#define FINISHED1 syncFinished = YES;

@interface ViewController : UIViewController<UITextFieldDelegate,NADViewDelegate>{
    UIImageView *firstLaunchView;
    UITextField *tf;
    NSUserDefaults *userDefault;
    AppDelegate *app;
    int firstPrologueNumber; //全画面プロローグの紙芝居が今何番まで表示されているかを管理する変数
    UIImageView *animation;  //全画面プロローグのイメージビュー
    AAButton *battleButton;
    AAButton *deckButton;
    IntroductionTool *blackBack; //プロローグ中の黒半透明の背景
}

@property (nonatomic, retain) NADView * nadView; //広告枠の設置
@property (nonatomic, assign) id<NADInterstitialDelegate> delegate;
@property (nonatomic) BOOL isOutputLog;


@end
