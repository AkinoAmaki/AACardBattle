//
//  ViewController.h
//  DeviceMotion
//
//  Created by 秋乃雨弓 on 2014/04/27.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SendDataToServer.h"
#import "GetEnemyDataFromServer.h"
#import "SBJson.h"
#define FINISHED2 syncFinished2 = YES;


@protocol deviceMotionDelegate<NSObject>

- (void)syncFinished;
- (void)stopExploringAnimation;


@end
@interface DeviceMotion :NSObject<CLLocationManagerDelegate, UITextFieldDelegate>{
    AppDelegate *app;

}
@property BOOL exploringFinished; //探索が完了していたらYESを格納する
@property BOOL syncFinished2; //同期処理において、対象の被待機処理が完了したかを管理する
@property NSString *dateString;
@property int enemyPlayerID;
@property NSString *enemyNickName;
@property (nonatomic) CLLocationManager *locationManager;
- (void)sendLocationDataToServer;
@property UIAlertView *isAEnemyNameForLocalBattle; //相手プレイヤーのニックネームを確認する際のアラートビュー(ローカル対戦)
@property UIAlertView *isAEnemyName_retry; //相手プレイヤーを見つけたが、望んだ相手出なかった場合のアラートビュー
@property UIAlertView *notFoundForLocalBattle; //相手プレイヤーが見つからなかった際のアラートビュー(ローカル対戦)
@property UIAlertView *notFoundForInternetBattle; //相手プレイヤーが見つからなかった際のアラートビュー(ネット対戦)
@property UIAlertView *feedAEnemyID; //相手プレイヤーのIDを指定して検索する際のアラートビュー
@property UIAlertView *errorAlert; //相手プレイヤーの検索でエラーが発生した際のアラートビュー
@property UITextField *enemyIDField; //相手プレイヤーのIDを指定して検索する際のアラートビュー内のテキストフィールド
@property BOOL syncFinish; //同期処理において、対象の被待機処理が完了したかを管理する
@property (nonatomic)CMMotionManager *motionManager;

// デリゲート先で参照できるようにするためプロパティを定義しておく
@property (nonatomic, assign) id<deviceMotionDelegate> delegate;

- (void)bumpForLocalBattle;
- (void)bumpForInternetBattle;


@end
