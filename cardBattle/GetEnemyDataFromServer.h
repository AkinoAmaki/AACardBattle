//
//  GetEnemyDataFromServer.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "SBJson.h"

@interface GetEnemyDataFromServer : NSObject{
    AppDelegate *app;
    NSArray *enemyPlayerID_parameter;
    NSArray *enemyPlayerID_key;
    NSArray *statuses;
}

-(void)get;
-(void)doEnemyDecideAction :(BOOL)select;


@end
