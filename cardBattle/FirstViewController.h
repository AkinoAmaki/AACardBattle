//
//  FirstViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/15.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "ViewController.h"
#import "NADView.h"
#import "NADInterstitial.h"

@interface FirstViewController : UIViewController<UIAlertViewDelegate,NADViewDelegate,NADInterstitialDelegate>{
    AppDelegate *app;
    BOOL syncFinished; //同期処理において、対象の被待機処理が完了したかを管理する
    BOOL deactivateFinished;
    BOOL activateOrDeactivate; //アクティベート・ディアクティベート処理において、いずれの処理を行っているかを管理する(YESならアクティベート、NOならディアクティベート)
    UIAlertView *notFoundForInternetBattle; //アクティベート処理ができなかった際に警告するアラートビュー
}

@property (nonatomic, retain) NADView * nadView; //広告枠の設置
@property (nonatomic, assign) id<NADInterstitialDelegate> delegate;
@property (nonatomic) BOOL isOutputLog;

- (void)activate;
- (void)deactivate;

@end
