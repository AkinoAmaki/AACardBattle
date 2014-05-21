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
                                       [NSNumber numberWithBool:app.myGikoAttackPermitted],
                                       [NSNumber numberWithBool:app.myGikoDeffencePermitted],
                                       [NSNumber numberWithBool:app.myMonarAttackPermitted],
                                       [NSNumber numberWithBool:app.myMonarDeffencePermitted],
                                       [NSNumber numberWithBool:app.mySyobonAttackPermitted],
                                       [NSNumber numberWithBool:app.mySyobonDeffencePermitted],
                                       [NSNumber numberWithBool:app.myYaruoAttackPermitted],
                                       [NSNumber numberWithBool:app.myYaruoDeffencePermitted],
                                       app.myTomb,
                                       [NSNumber numberWithBool:app.doIUseCard],
                                       [NSNumber numberWithInt:app.myUsingCardNumber],
                                       app.myFieldCard,
                                       app.myEnergyCard,
                                       [NSNumber numberWithBool:app.canIPlaySorceryCard],
                                       [NSNumber numberWithBool:app.canIPlayFieldCard],
                                       [NSNumber numberWithBool:app.canIActivateFieldCard],
                                       [NSNumber numberWithBool:app.canIPlayEnergyCard],
                                       [NSNumber numberWithBool:app.canIActivateEnergyCard],
                                       [NSNumber numberWithBool:app.denymyCardPlaying],
                                       [NSNumber numberWithInt:app.myDamage],
                                       [NSNumber numberWithInt:app.mySelectColor],
                                       app.cardsIUsedInThisTurn,
                                       [NSNumber numberWithBool:app.enemyGikoAttackPermitted],
                                       [NSNumber numberWithBool:app.enemyMonarAttackPermitted],
                                       [NSNumber numberWithBool:app.enemySyobonAttackPermitted],
                                       [NSNumber numberWithBool:app.enemyYaruoAttackPermitted],
                                       [NSNumber numberWithBool:app.enemyGikoDeffencePermitted],
                                       [NSNumber numberWithBool:app.enemyMonarDeffencePermitted],
                                       [NSNumber numberWithBool:app.enemySyobonDeffencePermitted],
                                       [NSNumber numberWithBool:app.enemyYaruoDeffencePermitted],
                                       nil];
    
    NSArray *myBattleData_key = [[NSArray alloc] initWithObjects:
                                 @"playerID",
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
                                 @"myDamage",
                                 @"mySelectColor",
                                 @"cardsIUsedInThisTurn",
                                 @"enemyGikoAttackPermitted",
                                    @"enemyMonarAttackPermitted",
                                    @"enemySyobonAttackPermitted",
                                    @"enemyYaruoAttackPermitted",
                                    @"enemyGikoDeffencePermitted",
                                    @"enemyMonarDeffencePermitted",
                                    @"enemySyobonDeffencePermitted",
                                    @"enemyYaruoDeffencePermitted",
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
