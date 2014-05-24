//
//  SendDataToServer.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "SendDataToServer.h"

@implementation SendDataToServer

-(NSString *)send{
    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    
    app = [[UIApplication sharedApplication] delegate];

    
    NSArray *myBattleData_parameter = [[NSArray alloc] initWithObjects:
                                       [NSNumber numberWithInt:app.playerID],
                                       [NSNumber numberWithInt:app.enemyPlayerID],
                                       [NSNumber numberWithInt:app.myLifeGage],
                                       app.myDeckCardList,
                                       app.myHand,
                                       [NSNumber numberWithInt:app.myGikoFundamentalAttackPower],
                                       [NSNumber numberWithInt:app.myGikoFundamentalDeffencePower],
                                       [NSNumber numberWithInt:app.myMonarFundamentalAttackPower],
                                       [NSNumber numberWithInt:app.myMonarFundamentalDeffencePower],
                                       [NSNumber numberWithInt:app.mySyobonFundamentalAttackPower],
                                       [NSNumber numberWithInt:app.mySyobonFundamentalDeffencePower],
                                       [NSNumber numberWithInt:app.myYaruoFundamentalAttackPower],
                                       [NSNumber numberWithInt:app.myYaruoFundamentalDeffencePower],
                                       [NSNumber numberWithInt:app.mySelectCharacter],
                                       [NSNumber numberWithInt:app.myGikoModifyingAttackPower],
                                       [NSNumber numberWithInt:app.myGikoModifyingDeffencePower],
                                       [NSNumber numberWithInt:app.myMonarModifyingAttackPower],
                                       [NSNumber numberWithInt:app.myMonarModifyingDeffencePower],
                                       [NSNumber numberWithInt:app.mySyobonModifyingAttackPower],
                                       [NSNumber numberWithInt:app.mySyobonModifyingDeffencePower],
                                       [NSNumber numberWithInt:app.myYaruoModifyingAttackPower],
                                       [NSNumber numberWithInt:app.myYaruoModifyingDeffencePower],
                                       [NSNumber numberWithBool:app.myGikoAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.myGikoDeffencePermittedByMyself],
                                       [NSNumber numberWithBool:app.myMonarAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.myMonarDeffencePermittedByMyself],
                                       [NSNumber numberWithBool:app.mySyobonAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.mySyobonDeffencePermittedByMyself],
                                       [NSNumber numberWithBool:app.myYaruoAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.myYaruoDeffencePermittedByMyself],
                                       app.myTomb,
                                       [NSNumber numberWithBool:app.doIUseCard],
                                       [NSNumber numberWithInt:app.myUsingCardNumber],
                                       app.myFieldCard,
                                       app.myEnergyCard,
                                       [NSNumber numberWithBool:app.canIPlaySorceryCardByMyself],
                                       [NSNumber numberWithBool:app.canIPlayFieldCardByMyself],
                                       [NSNumber numberWithBool:app.canIActivateFieldCardByMyself],
                                       [NSNumber numberWithBool:app.canIPlayEnergyCardByMyself],
                                       [NSNumber numberWithBool:app.canIActivateEnergyCardByMyself],
                                       [NSNumber numberWithBool:app.denymyCardPlaying],
                                       [NSNumber numberWithInt:app.enemyDamageFromAA],
                                       [NSNumber numberWithInt:app.enemyDamageFromCard],
                                       [NSNumber numberWithInt:app.mySelectColor],
                                       app.cardsIUsedInThisTurn,
                                       [NSNumber numberWithInt:app.enemyGikoFundamentalAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemyGikoFundamentalDeffencePowerByMyself],
                                       [NSNumber numberWithInt:app.enemyMonarFundamentalAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemyMonarFundamentalDeffencePowerByMyself],
                                       [NSNumber numberWithInt:app.enemySyobonFundamentalAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemySyobonFundamentalDeffencePowerByMyself],
                                       [NSNumber numberWithInt:app.enemyYaruoFundamentalAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemyYaruoFundamentalDeffencePowerByMyself],
                                       [NSNumber numberWithInt:app.enemyGikoModifyingAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemyGikoModifyingDeffencePowerByMyself],
                                       [NSNumber numberWithInt:app.enemyMonarModifyingAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemyMonarModifyingDeffencePowerByMyself],
                                       [NSNumber numberWithInt:app.enemySyobonModifyingAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemySyobonModifyingDeffencePowerByMyself],
                                       [NSNumber numberWithInt:app.enemyYaruoModifyingAttackPowerByMyself],
                                       [NSNumber numberWithInt:app.enemyYaruoModifyingDeffencePowerByMyself],
                                       [NSNumber numberWithBool:app.enemyGikoAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.enemyMonarAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.enemySyobonAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.enemyYaruoAttackPermittedByMyself],
                                       [NSNumber numberWithBool:app.enemyGikoDeffencePermittedByMyself],
                                       [NSNumber numberWithBool:app.enemyMonarDeffencePermittedByMyself],
                                       [NSNumber numberWithBool:app.enemySyobonDeffencePermittedByMyself],
                                       [NSNumber numberWithBool:app.enemyYaruoDeffencePermittedByMyself],
                                       [NSNumber numberWithBool:app.canEnemyPlaySorceryCardByMyself],
                                       [NSNumber numberWithBool:app.canEnemyPlayFieldCardByMyself],
                                       [NSNumber numberWithBool:app.canEnemyActivateFieldCardByMyself],
                                       [NSNumber numberWithBool:app.canEnemyPlayEnergyCardByMyself],
                                       [NSNumber numberWithBool:app.canEnemyActivateEnergyCardByMyself],
                                       [NSNumber numberWithBool:app.denyEnemyCardPlaying],
                                       nil];
    
    NSArray *myBattleData_key = [[NSArray alloc] initWithObjects:
                                 @"playerID",
                                 @"enemyPlayerID",
                                 @"myLifeGage",
                                 @"myDeckCardList",
                                 @"myHand",
                                 @"myGikoFundamentalAttackPower",
                                 @"myGikoFundamentalDeffencePower",
                                 @"myMonarFundamentalAttackPower",
                                 @"myMonarFundamentalDeffencePower",
                                 @"mySyobonFundamentalAttackPower",
                                 @"mySyobonFundamentalDeffencePower",
                                 @"myYaruoFundamentalAttackPower",
                                 @"myYaruoFundamentalDeffencePower",
                                 @"mySelectCharacter",
                                 @"myGikoModifyingAttackPower",
                                 @"myGikoModifyingDeffencePower",
                                 @"myMonarModifyingAttackPower",
                                 @"myMonarModifyingDeffencePower",
                                 @"mySyobonModifyingAttackPower",
                                 @"mySyobonModifyingDeffencePower",
                                 @"myYaruoModifyingAttackPower",
                                 @"myYaruoModifyingDeffencePower",
                                 @"myGikoAttackPermitted",
                                 @"myGikoDeffencePermitted",
                                 @"myMonarAttackPermitted",
                                 @"myMonarDeffencePermitted",
                                 @"mySyobonAttackPermitted",
                                 @"mySyobonDeffencePermitted",
                                 @"myYaruoAttackPermitted",
                                 @"myYaruoDeffencePermitted",
                                 @"myTomb",
                                 @"doIUseCard",
                                 @"myUsingCardNumber",
                                 @"myFieldCard",
                                 @"myEnergyCard",
                                 @"canIPlaySorceryCard",
                                 @"canIPlayFieldCard",
                                 @"canIActivateFieldCard",
                                 @"canIPlayEnergyCard",
                                 @"canIActivateEnergyCard",
                                 @"denymyCardPlaying",
                                 @"enemyDamageFromAA",
                                 @"enemyDamageFromCard",
                                 @"mySelectColor",
                                 @"cardsIUsedInThisTurn",
                                 @"enemyGikoFundamentalAttackPower",
                                 @"enemyGikoFundamentalDeffencePower",
                                 @"enemyMonarFundamentalAttackPower",
                                 @"enemyMonarFundamentalDeffencePower",
                                 @"enemySyobonFundamentalAttackPower",
                                 @"enemySyobonFundamentalDeffencePower",
                                 @"enemyYaruoFundamentalAttackPower",
                                 @"enemyYaruoFundamentalDeffencePower",
                                 @"enemyGikoModifyingAttackPower",
                                 @"enemyGikoModifyingDeffencePower",
                                 @"enemyMonarModifyingAttackPower",
                                 @"enemyMonarModifyingDeffencePower",
                                 @"enemySyobonModifyingAttackPower",
                                 @"enemySyobonModifyingDeffencePower",
                                 @"enemyYaruoModifyingAttackPower",
                                 @"enemyYaruoModifyingDeffencePower",
                                 @"enemyGikoAttackPermitted",
                                 @"enemyMonarAttackPermitted",
                                 @"enemySyobonAttackPermitted",
                                 @"enemyYaruoAttackPermitted",
                                 @"enemyGikoDeffencePermitted",
                                 @"enemyMonarDeffencePermitted",
                                 @"enemySyobonDeffencePermitted",
                                 @"enemyYaruoDeffencePermitted",
                                 @"canEnemyPlaySorceryCard",
                                 @"canEnemyPlayFieldCard",
                                 @"canEnemyActivateFieldCard",
                                 @"canEnemyPlayEnergyCard",
                                 @"canEnemyActivateEnergyCard",
                                 @"denyEnemyCardPlaying",
                                 nil];
    
    
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:myBattleData_parameter forKeys:myBattleData_key];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    //     //外部から接続する場合
    NSString *url = @"http://utakatanet.dip.jp:58080/test.php";
    //     //内部から接続する場合
    //NSString *url = @"http://192.168.10.176:58080/test.php";
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *result;
    result= [NSURLConnection sendSynchronousRequest:request
                                  returningResponse:&response
                                              error:&error];
    
    //データがgetできなければ、0.5秒待ったあとに再度get処理する
    
    while (!result) {
        [NSThread sleepForTimeInterval:0.5];
        result= [NSURLConnection sendSynchronousRequest:request
                                      returningResponse:&response
                                                  error:&error];
        NSLog(@"データのget処理中...");
    }
    
    NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"%@", string);
    
    return string;
    [SVProgressHUD dismiss];
}

@end
