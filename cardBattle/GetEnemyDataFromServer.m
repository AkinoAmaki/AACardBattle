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
        app.enemyLifeGage                           = [[battleDataWithoutArray objectAtIndex:1]  intValue];
        app.enemyGikoFundamentalAttackPower         = [[battleDataWithoutArray objectAtIndex:2]  intValue];
        app.enemyGikoFundamentalDeffencePower       = [[battleDataWithoutArray objectAtIndex:3]  intValue];
        app.enemyMonarFundamentalAttackPower        = [[battleDataWithoutArray objectAtIndex:4]  intValue];
        app.enemyMonarFundamentalDeffencePower      = [[battleDataWithoutArray objectAtIndex:5]  intValue];
        app.enemySyobonFundamentalAttackPower       = [[battleDataWithoutArray objectAtIndex:6]  intValue];
        app.enemySyobonFundamentalDeffencePower     = [[battleDataWithoutArray objectAtIndex:7]  intValue];
        app.enemyYaruoFundamentalAttackPower        = [[battleDataWithoutArray objectAtIndex:8]  intValue];
        app.enemyYaruoFundamentalDeffencePower      = [[battleDataWithoutArray objectAtIndex:9]  intValue];
        app.enemySelectCharacter                    = [[battleDataWithoutArray objectAtIndex:10] intValue];
        app.enemyCharacterFundamentalAttackPower    = [[battleDataWithoutArray objectAtIndex:11] intValue];
        app.enemyCharacterFundamentalDeffencePower  = [[battleDataWithoutArray objectAtIndex:12] intValue];
        app.enemyGikoModifyingAttackPower           = [[battleDataWithoutArray objectAtIndex:13] intValue];
        app.enemyGikoModifyingDeffencePower         = [[battleDataWithoutArray objectAtIndex:14] intValue];
        app.enemyMonarModifyingAttackPower          = [[battleDataWithoutArray objectAtIndex:15] intValue];
        app.enemyMonarModifyingDeffencePower        = [[battleDataWithoutArray objectAtIndex:16] intValue];
        app.enemySyobonModifyingAttackPower         = [[battleDataWithoutArray objectAtIndex:17] intValue];
        app.enemySyobonModifyingDeffencePower       = [[battleDataWithoutArray objectAtIndex:18] intValue];
        app.enemyYaruoModifyingAttackPower          = [[battleDataWithoutArray objectAtIndex:19] intValue];
        app.enemyYaruoModifyingDeffencePower        = [[battleDataWithoutArray objectAtIndex:20] intValue];
        app.enemyCharacterModifyingAttackPower      = [[battleDataWithoutArray objectAtIndex:21] intValue];
        app.enemyCharacterModifyingDeffencePower    = [[battleDataWithoutArray objectAtIndex:22] intValue];
        app.enemyGikoAttackPermitted                = [[battleDataWithoutArray objectAtIndex:23] boolValue];
        app.enemyGikoDeffencePermitted              = [[battleDataWithoutArray objectAtIndex:24] boolValue];
        app.enemyMonarAttackPermitted               = [[battleDataWithoutArray objectAtIndex:25] boolValue];
        app.enemyMonarDeffencePermitted             = [[battleDataWithoutArray objectAtIndex:26] boolValue];
        app.enemySyobonAttackPermitted              = [[battleDataWithoutArray objectAtIndex:27] boolValue];
        app.enemySyobonDeffencePermitted            = [[battleDataWithoutArray objectAtIndex:28] boolValue];
        app.enemyYaruoAttackPermitted               = [[battleDataWithoutArray objectAtIndex:29] boolValue];
        app.enemyYaruoDeffencePermitted             = [[battleDataWithoutArray objectAtIndex:30] boolValue];
        app.doEnemyUseCard                          = [[battleDataWithoutArray objectAtIndex:31] boolValue];
        app.enemyUsingCardNumber                    = [[battleDataWithoutArray objectAtIndex:32] intValue];
        app.canEnemyPlaySorceryCard                 = [[battleDataWithoutArray objectAtIndex:33] boolValue];
        app.canEnemyPlayFieldCard                   = [[battleDataWithoutArray objectAtIndex:34] boolValue];
        app.canEnemyActivateFieldCard               = [[battleDataWithoutArray objectAtIndex:35] boolValue];
        app.canEnemyPlayEnergyCard                  = [[battleDataWithoutArray objectAtIndex:36] boolValue];
        app.canEnemyActivateEnergyCard              = [[battleDataWithoutArray objectAtIndex:37] boolValue];
        app.denyEnemyCardPlaying                    = [[battleDataWithoutArray objectAtIndex:38] boolValue];
        app.enemyDamage                             = [[battleDataWithoutArray objectAtIndex:39] intValue];
        app.enemySelectColor                        = [[battleDataWithoutArray objectAtIndex:40] intValue];
    
    app.cardsEnemyUsedInThisTurn = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:1]];
    app.enemyDeckCardList = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:2]];
    app.enemyEnergyCard = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:3]];
    app.enemyFieldCard = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:4]];
    app.enemyHand = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:5]];
    app.enemyTomb = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:6]];
    
    //battleDataWithoutArrayを除く６つの配列のうち、ブランク（nullでない！）のデータが入っている部分を削除し、nullとする。
    [app.cardsEnemyUsedInThisTurn removeObject:@""];
    [app.enemyDeckCardList removeObject:@""];
    [app.enemyEnergyCard removeObject:@""];
    [app.enemyFieldCard removeObject:@""];
    [app.enemyHand removeObject:@""];
    [app.enemyTomb removeObject:@""];
    
    NSLog(@"app.cardsEnemyUsedInThisTurn:%@",app.cardsEnemyUsedInThisTurn);
    NSLog(@"app.enemyDeckCardList:%@",app.enemyDeckCardList);
    NSLog(@"app.enemyEnergyCard:%@",app.enemyEnergyCard);
    NSLog(@"app.enemyFieldCard:%@",app.enemyFieldCard);
    NSLog(@"app.enemyHand:%@",app.enemyHand);
    NSLog(@"app.enemyTomb:%@",app.enemyTomb);
    
    
    [SVProgressHUD dismiss];
}

-(void)doEnemyDecideAction :(BOOL)select{
    [self initWithGetEnemyDataFromServer:@"http://utakatanet.dip.jp:58080/doEnemyDecideAction.php" selectCardAndAAPhase:select];
    NSLog(@"あああ：%d",[[statuses objectAtIndex:0] intValue]);
    app.decideAction = [[statuses objectAtIndex:0] boolValue];
    
    
}



@end
