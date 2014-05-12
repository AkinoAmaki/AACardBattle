//
//  GetLocation.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "SVProgressHUD.h"
#import "SBJson.h"
#define FINISHED3 syncFinish = YES;


@interface GetLocation : UIViewController<CLLocationManagerDelegate>{
    AppDelegate *app;
}
@property NSString *dateString;
@property int enemyPlayerID;
@property NSString *enemyNickName;
@property (nonatomic) CLLocationManager *locationManager;
- (void)sendLocationDataToServer;
@property UIAlertView *isAEnemyName; //相手プレイヤーのニックネームを確認する際のアラートビュー
@property BOOL syncFinish; //同期処理において、対象の被待機処理が完了したかを管理する

@end
