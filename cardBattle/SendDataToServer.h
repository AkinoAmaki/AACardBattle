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
#define GIKO 1
#define MONAR 2
#define SYOBON 3
#define YARUO 4

@interface SendDataToServer : NSObject{
    AppDelegate *app;
    GetEnemyDataFromServer *get;
    NSString *resultString;
}

-(NSString *)send;

@end
