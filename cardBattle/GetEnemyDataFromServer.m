//
//  GetEnemyDataFromServer.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "GetEnemyDataFromServer.h"

@implementation GetEnemyDataFromServer

-(void)initWithGetEnemyDataFromServer:(NSString *)URLString selectCardAndAAPhase:(BOOL)select{
    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    app = [[UIApplication sharedApplication] delegate];
    //相手プレイヤーのID等を送信
    enemyPlayerID_parameter = [[NSArray alloc] initWithObjects:
                               [NSNumber numberWithInt:app.enemyPlayerID],[NSNumber numberWithInt:app.playerID],[NSNumber numberWithBool:select],nil];
    enemyPlayerID_key = [[NSArray alloc] initWithObjects:
                         @"enemyPlayerID",@"playerID",@"selectCardAndAAPhase",nil];
    
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:enemyPlayerID_parameter forKeys:enemyPlayerID_key];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    //     //外部から接続する場合
    NSString *url = URLString;
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
    
    
    //相手プレイヤーのデータを受信
    // URLからJSONデータを取得(NSData)
    NSData *response2 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // JSONで解析するために、NSDataをNSStringに変換。
    NSString *json_string = [[NSString alloc] initWithData:response2 encoding:NSUTF8StringEncoding];
    // JSONデータをパースする。
    // ここではJSONデータが配列としてパースされるので、NSArray型でデータ取得
    statuses = [json_string JSONValue];
}


-(void)get{
    [self initWithGetEnemyDataFromServer:@"http://utakatanet.dip.jp:58080/enemyData.php" selectCardAndAAPhase:NO];
    //相手プレイヤーの各種データを変数に格納する
    NSArray *battleDataWithoutArray = [[NSArray alloc] initWithArray:[statuses objectAtIndex:0]];
        app.enemyPlayerID                                   = [[battleDataWithoutArray objectAtIndex:0]  intValue];
        app.enemyLifeGage                                   = [[battleDataWithoutArray objectAtIndex:2]  intValue];
        app.enemyGikoFundamentalAttackPower                 = [[battleDataWithoutArray objectAtIndex:3]  intValue];
        app.enemyGikoFundamentalDeffencePower               = [[battleDataWithoutArray objectAtIndex:4]  intValue];
        app.enemyMonarFundamentalAttackPower                = [[battleDataWithoutArray objectAtIndex:5]  intValue];
        app.enemyMonarFundamentalDeffencePower              = [[battleDataWithoutArray objectAtIndex:6]  intValue];
        app.enemySyobonFundamentalAttackPower               = [[battleDataWithoutArray objectAtIndex:7]  intValue];
        app.enemySyobonFundamentalDeffencePower             = [[battleDataWithoutArray objectAtIndex:8]  intValue];
        app.enemyYaruoFundamentalAttackPower                = [[battleDataWithoutArray objectAtIndex:9]  intValue];
        app.enemyYaruoFundamentalDeffencePower              = [[battleDataWithoutArray objectAtIndex:10]  intValue];
        app.enemySelectCharacter                            = [[battleDataWithoutArray objectAtIndex:11] intValue];
        app.enemyGikoModifyingAttackPower                   = [[battleDataWithoutArray objectAtIndex:12] intValue];
        app.enemyGikoModifyingDeffencePower                 = [[battleDataWithoutArray objectAtIndex:13] intValue];
        app.enemyMonarModifyingAttackPower                  = [[battleDataWithoutArray objectAtIndex:14] intValue];
        app.enemyMonarModifyingDeffencePower                = [[battleDataWithoutArray objectAtIndex:15] intValue];
        app.enemySyobonModifyingAttackPower                 = [[battleDataWithoutArray objectAtIndex:16] intValue];
        app.enemySyobonModifyingDeffencePower               = [[battleDataWithoutArray objectAtIndex:17] intValue];
        app.enemyYaruoModifyingAttackPower                  = [[battleDataWithoutArray objectAtIndex:18] intValue];
        app.enemyYaruoModifyingDeffencePower                = [[battleDataWithoutArray objectAtIndex:19] intValue];
        app.enemyGikoAttackPermittedFromEnemy               = [[battleDataWithoutArray objectAtIndex:20] boolValue];
        app.enemyGikoDeffencePermittedFromEnemy             = [[battleDataWithoutArray objectAtIndex:21] boolValue];
        app.enemyMonarAttackPermittedFromEnemy              = [[battleDataWithoutArray objectAtIndex:22] boolValue];
        app.enemyMonarDeffencePermittedFromEnemy            = [[battleDataWithoutArray objectAtIndex:23] boolValue];
        app.enemySyobonAttackPermittedFromEnemy             = [[battleDataWithoutArray objectAtIndex:24] boolValue];
        app.enemySyobonDeffencePermittedFromEnemy           = [[battleDataWithoutArray objectAtIndex:25] boolValue];
        app.enemyYaruoAttackPermittedFromEnemy              = [[battleDataWithoutArray objectAtIndex:26] boolValue];
        app.enemyYaruoDeffencePermittedFromEnemy            = [[battleDataWithoutArray objectAtIndex:27] boolValue];
        app.doEnemyUseCard                                  = [[battleDataWithoutArray objectAtIndex:28] boolValue];
        app.enemyUsingCardNumber                            = [[battleDataWithoutArray objectAtIndex:29] intValue];
        app.canEnemyPlaySorceryCardFromEnemy                = [[battleDataWithoutArray objectAtIndex:30] boolValue];
        app.canEnemyPlayFieldCardFromEnemy                  = [[battleDataWithoutArray objectAtIndex:31] boolValue];
        app.canEnemyActivateFieldCardFromEnemy              = [[battleDataWithoutArray objectAtIndex:32] boolValue];
        app.canEnemyPlayEnergyCardFromEnemy                 = [[battleDataWithoutArray objectAtIndex:33] boolValue];
        app.canEnemyActivateEnergyCardFromEnemy             = [[battleDataWithoutArray objectAtIndex:34] boolValue];
        app.denyEnemyCardPlaying                            = [[battleDataWithoutArray objectAtIndex:35] boolValue];
        app.myDamageFromAA                                  = [[battleDataWithoutArray objectAtIndex:36] intValue];
        app.myDamageFromCard                                = [[battleDataWithoutArray objectAtIndex:37] intValue];
        app.enemySelectColor                                = [[battleDataWithoutArray objectAtIndex:38] intValue];
        app.myGikoFundamentalAttackPowerFromEnemy           = [[battleDataWithoutArray objectAtIndex:39] intValue];
        app.myGikoFundamentalDeffencePowerFromEnemy         = [[battleDataWithoutArray objectAtIndex:40] intValue];
        app.myMonarFundamentalAttackPowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:41] intValue];
        app.myMonarFundamentalDeffencePowerFromEnemy        = [[battleDataWithoutArray objectAtIndex:42] intValue];
        app.mySyobonFundamentalAttackPowerFromEnemy         = [[battleDataWithoutArray objectAtIndex:43] intValue];
        app.mySyobonFundamentalDeffencePowerFromEnemy       = [[battleDataWithoutArray objectAtIndex:44] intValue];
        app.myYaruoFundamentalAttackPowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:45] intValue];
        app.myYaruoFundamentalDeffencePowerFromEnemy        = [[battleDataWithoutArray objectAtIndex:46] intValue];
        app.myGikoModifyingAttackPowerFromEnemy             = [[battleDataWithoutArray objectAtIndex:47] intValue];
        app.myGikoModifyingDeffencePowerFromEnemy           = [[battleDataWithoutArray objectAtIndex:48] intValue];
        app.myMonarModifyingAttackPowerFromEnemy            = [[battleDataWithoutArray objectAtIndex:49] intValue];
        app.myMonarModifyingDeffencePowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:50] intValue];
        app.mySyobonModifyingAttackPowerFromEnemy           = [[battleDataWithoutArray objectAtIndex:51] intValue];
        app.mySyobonModifyingDeffencePowerFromEnemy         = [[battleDataWithoutArray objectAtIndex:52] intValue];
        app.myYaruoModifyingAttackPowerFromEnemy            = [[battleDataWithoutArray objectAtIndex:53] intValue];
        app.myYaruoModifyingDeffencePowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:54] intValue];
        app.myGikoAttackPermittedFromEnemy                  = [[battleDataWithoutArray objectAtIndex:55] intValue];
        app.myMonarAttackPermittedFromEnemy                 = [[battleDataWithoutArray objectAtIndex:56] intValue];
        app.mySyobonAttackPermittedFromEnemy                = [[battleDataWithoutArray objectAtIndex:57] intValue];
        app.myYaruoAttackPermittedFromEnemy                 = [[battleDataWithoutArray objectAtIndex:58] intValue];
        app.myGikoDeffencePermittedFromEnemy                = [[battleDataWithoutArray objectAtIndex:59] intValue];
        app.myMonarDeffencePermittedFromEnemy               = [[battleDataWithoutArray objectAtIndex:60] intValue];
        app.mySyobonDeffencePermittedFromEnemy              = [[battleDataWithoutArray objectAtIndex:61] intValue];
        app.myYaruoDeffencePermittedFromEnemy               = [[battleDataWithoutArray objectAtIndex:62] intValue];
        app.canIPlaySorceryCardFromEnemy                    = [[battleDataWithoutArray objectAtIndex:63] intValue];
        app.canIPlayFieldCardFromEnemy                      = [[battleDataWithoutArray objectAtIndex:64] intValue];
        app.canIActivateFieldCardFromEnemy                  = [[battleDataWithoutArray objectAtIndex:65] intValue];
        app.canIPlayEnergyCardFromEnemy                     = [[battleDataWithoutArray objectAtIndex:66] intValue];
        app.canIActivateEnergyCardFromEnemy                 = [[battleDataWithoutArray objectAtIndex:67] intValue];
        app.denymyCardPlaying                               = [[battleDataWithoutArray objectAtIndex:68] intValue];
    
    app.cardsEnemyUsedInThisTurn = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:1]];
    app.enemyDeckCardList = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:2]];
    app.enemyEnergyCard = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:3]];
    app.enemyFieldCard = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:4]];
    app.enemyHand = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:5]];
    app.enemyTomb = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:6]];
    
    //battleDataWithoutArrayを除く６つの配列について、ブランク（nullでない！）のデータが入っている部分を削除し、nullとする。
    [app.cardsEnemyUsedInThisTurn removeObject:@""];
    [app.enemyDeckCardList removeObject:@""];
    [app.enemyEnergyCard removeObject:@""];
    [app.enemyFieldCard removeObject:@""];
    [app.enemyHand removeObject:@""];
    [app.enemyTomb removeObject:@""];
    
    //battleDataWithoutArrayを除く６つの配列について、先頭に入っている相手プレイヤーのplayerIDを削除する
    [app.cardsEnemyUsedInThisTurn removeObjectAtIndex:0];
    [app.enemyDeckCardList removeObjectAtIndex:0];
    [app.enemyEnergyCard removeObjectAtIndex:0];
    [app.enemyFieldCard removeObjectAtIndex:0];
    [app.enemyHand removeObjectAtIndex:0];
    [app.enemyTomb removeObjectAtIndex:0];
    
    [SVProgressHUD dismiss];
}

-(void)doEnemyDecideAction :(BOOL)select{
    [self initWithGetEnemyDataFromServer:@"http://utakatanet.dip.jp:58080/doEnemyDecideAction.php" selectCardAndAAPhase:select];
    app.decideAction = [[statuses objectAtIndex:0] boolValue];
}



@end
