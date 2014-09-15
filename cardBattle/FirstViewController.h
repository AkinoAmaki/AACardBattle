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

@interface FirstViewController : UIViewController<UIAlertViewDelegate>{
    AppDelegate *app;
    BOOL syncFinished; //同期処理において、対象の被待機処理が完了したかを管理する
    BOOL deactivateFinished;
    BOOL activateOrDeactivate; //アクティベート・ディアクティベート処理において、いずれの処理を行っているかを管理する(YESならアクティベート、NOならディアクティベート)
    UIAlertView *notFoundForInternetBattle; //アクティベート処理ができなかった際に警告するアラートビュー
}

- (void)activate;
- (void)deactivate;

@end
