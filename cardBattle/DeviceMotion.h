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
#import "SBJson.h"
#define FINISHED2 syncFinished2 = YES;
@interface DeviceMotion :NSObject<CLLocationManagerDelegate>{
    AppDelegate *app;
    BOOL syncFinished2; //同期処理において、対象の被待機処理が完了したかを管理する
}
@property NSString *dateString;
@property int enemyPlayerID;
@property NSString *enemyNickName;
@property (nonatomic) CLLocationManager *locationManager;
- (void)sendLocationDataToServer;
@property UIAlertView *isAEnemyName; //相手プレイヤーのニックネームを確認する際のアラートビュー
@property UIAlertView *isAEnemyName_retry; //相手プレイヤーを見つけたが、望んだ相手出なかった場合のアラートビュー
@property UIAlertView *notFound; //相手プレイヤーが見つからなかった際のアラートビュー
@property BOOL syncFinish; //同期処理において、対象の被待機処理が完了したかを管理する

@property (nonatomic)CMMotionManager *motionManager;

- (void)bump;


@end
