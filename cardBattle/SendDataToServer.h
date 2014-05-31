//
//  SendDataToServer.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetEnemyDataFromServer.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "SBJson.h"

@interface SendDataToServer : NSObject{
    AppDelegate *app;
    GetEnemyDataFromServer *get;
    NSString *resultString;
}

-(NSString *)send;

@end
