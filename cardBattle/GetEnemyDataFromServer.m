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
        //***app.canEnemyPlaySorceryCardFromEnemy                = [[battleDataWithoutArray objectAtIndex:30] boolValue];
        //***app.canEnemyPlayFieldCardFromEnemy                  = [[battleDataWithoutArray objectAtIndex:31] boolValue];
        //***app.canEnemyActivateFieldCardFromEnemy              = [[battleDataWithoutArray objectAtIndex:32] boolValue];
        //***app.canEnemyPlayEnergyCardFromEnemy                 = [[battleDataWithoutArray objectAtIndex:33] boolValue];
        //***app.canEnemyActivateEnergyCardFromEnemy             = [[battleDataWithoutArray objectAtIndex:34] boolValue];
        //***app.denyEnemyCardPlaying                            = [[battleDataWithoutArray objectAtIndex:35] boolValue];
        app.myDamageFromAA                                  = [[battleDataWithoutArray objectAtIndex:30] intValue];
        app.myDamageFromCard                                = [[battleDataWithoutArray objectAtIndex:31] intValue];
        app.enemySelectColor                                = [[battleDataWithoutArray objectAtIndex:32] intValue];
        app.myGikoFundamentalAttackPowerFromEnemy           = [[battleDataWithoutArray objectAtIndex:33] intValue];
        app.myGikoFundamentalDeffencePowerFromEnemy         = [[battleDataWithoutArray objectAtIndex:34] intValue];
        app.myMonarFundamentalAttackPowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:35] intValue];
        app.myMonarFundamentalDeffencePowerFromEnemy        = [[battleDataWithoutArray objectAtIndex:36] intValue];
        app.mySyobonFundamentalAttackPowerFromEnemy         = [[battleDataWithoutArray objectAtIndex:37] intValue];
        app.mySyobonFundamentalDeffencePowerFromEnemy       = [[battleDataWithoutArray objectAtIndex:38] intValue];
        app.myYaruoFundamentalAttackPowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:39] intValue];
        app.myYaruoFundamentalDeffencePowerFromEnemy        = [[battleDataWithoutArray objectAtIndex:40] intValue];
        app.myGikoModifyingAttackPowerFromEnemy             = [[battleDataWithoutArray objectAtIndex:41] intValue];
        app.myGikoModifyingDeffencePowerFromEnemy           = [[battleDataWithoutArray objectAtIndex:42] intValue];
        app.myMonarModifyingAttackPowerFromEnemy            = [[battleDataWithoutArray objectAtIndex:43] intValue];
        app.myMonarModifyingDeffencePowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:44] intValue];
        app.mySyobonModifyingAttackPowerFromEnemy           = [[battleDataWithoutArray objectAtIndex:45] intValue];
        app.mySyobonModifyingDeffencePowerFromEnemy         = [[battleDataWithoutArray objectAtIndex:46] intValue];
        app.myYaruoModifyingAttackPowerFromEnemy            = [[battleDataWithoutArray objectAtIndex:47] intValue];
        app.myYaruoModifyingDeffencePowerFromEnemy          = [[battleDataWithoutArray objectAtIndex:48] intValue];
        app.myGikoAttackPermittedFromEnemy                  = [[battleDataWithoutArray objectAtIndex:49] boolValue];
        app.myMonarAttackPermittedFromEnemy                 = [[battleDataWithoutArray objectAtIndex:50] boolValue];
        app.mySyobonAttackPermittedFromEnemy                = [[battleDataWithoutArray objectAtIndex:51] boolValue];
        app.myYaruoAttackPermittedFromEnemy                 = [[battleDataWithoutArray objectAtIndex:52] boolValue];
        app.myGikoDeffencePermittedFromEnemy                = [[battleDataWithoutArray objectAtIndex:53] boolValue];
        app.myMonarDeffencePermittedFromEnemy               = [[battleDataWithoutArray objectAtIndex:54] boolValue];
        app.mySyobonDeffencePermittedFromEnemy              = [[battleDataWithoutArray objectAtIndex:55] boolValue];
        app.myYaruoDeffencePermittedFromEnemy               = [[battleDataWithoutArray objectAtIndex:56] boolValue];
        //***app.canIPlaySorceryCardFromEnemy                    = [[battleDataWithoutArray objectAtIndex:63] boolValue];
        //***app.canIPlayFieldCardFromEnemy                      = [[battleDataWithoutArray objectAtIndex:64] boolValue];
        //***app.canIActivateFieldCardFromEnemy                  = [[battleDataWithoutArray objectAtIndex:65] boolValue];
        //***app.canIPlayEnergyCardFromEnemy                     = [[battleDataWithoutArray objectAtIndex:66] boolValue];
        //***app.canIActivateEnergyCardFromEnemy                 = [[battleDataWithoutArray objectAtIndex:67] boolValue];
        //***app.denymyCardPlaying                               = [[battleDataWithoutArray objectAtIndex:68] boolValue];
        app.mySelectCharacterFromEnemy                      = [[battleDataWithoutArray objectAtIndex:57] intValue];

    
    app.cardsEnemyUsedInThisTurn = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:1]];
    app.enemyDeckCardList = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:2]];
    app.enemyEnergyCard = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:3]];
    app.enemyFieldCard = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:4]];
    app.enemyHand = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:5]];
    app.enemyTomb = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:6]];
    app.myDeckCardListFromEnemy_plus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:7]];
    app.myHandFromEnemy_plus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:8]];
    app.myTombFromEnemy_plus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:9]];
    app.myFieldCardFromEnemy_plus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:10]];
    app.myEnergyCardFromEnemy_plus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:11]];
    app.myDeckCardListFromEnemy_minus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:12]];
    app.myHandFromEnemy_minus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:13]];
    app.myTombFromEnemy_minus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:14]];
    app.myFieldCardFromEnemy_minus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:15]];
    app.myEnergyCardFromEnemy_minus = [[NSMutableArray alloc] initWithArray:[statuses objectAtIndex:16]];
    
    //battleDataWithoutArrayを除く配列について、ブランク（nullでない！）のデータが入っている部分を削除し、nullとする。
    [app.cardsEnemyUsedInThisTurn removeObject:@""];
    [app.enemyDeckCardList removeObject:@""];
    [app.enemyEnergyCard removeObject:@""];
    [app.enemyFieldCard removeObject:@""];
    [app.enemyHand removeObject:@""];
    [app.enemyTomb removeObject:@""];
    [app.myDeckCardListFromEnemy_plus removeObject:@""];
    [app.myHandFromEnemy_plus removeObject:@""];
    [app.myTombFromEnemy_plus removeObject:@""];
    [app.myFieldCardFromEnemy_plus removeObject:@""];
    [app.myEnergyCardFromEnemy_plus removeObject:@""];
    [app.myDeckCardListFromEnemy_minus removeObject:@""];
    [app.myHandFromEnemy_minus removeObject:@""];
    [app.myTombFromEnemy_minus removeObject:@""];
    [app.myFieldCardFromEnemy_minus removeObject:@""];
    [app.myEnergyCardFromEnemy_minus removeObject:@""];
    
    //battleDataWithoutArrayを除く配列について、先頭に入っている相手プレイヤーのplayerIDを削除する
    [app.cardsEnemyUsedInThisTurn removeObjectAtIndex:0];
    [app.enemyDeckCardList removeObjectAtIndex:0];
    [app.enemyEnergyCard removeObjectAtIndex:0];
    [app.enemyFieldCard removeObjectAtIndex:0];
    [app.enemyHand removeObjectAtIndex:0];
    [app.enemyTomb removeObjectAtIndex:0];
    [app.myDeckCardListFromEnemy_plus removeObjectAtIndex:0];
    [app.myHandFromEnemy_plus removeObjectAtIndex:0];
    [app.myTombFromEnemy_plus removeObjectAtIndex:0];
    [app.myFieldCardFromEnemy_plus removeObjectAtIndex:0];
    [app.myEnergyCardFromEnemy_plus removeObjectAtIndex:0];
    [app.myDeckCardListFromEnemy_minus removeObjectAtIndex:0];
    [app.myHandFromEnemy_minus removeObjectAtIndex:0];
    [app.myTombFromEnemy_minus removeObjectAtIndex:0];
    [app.myFieldCardFromEnemy_minus removeObjectAtIndex:0];
    [app.myEnergyCardFromEnemy_minus removeObjectAtIndex:0];
    
    //相手プレイヤーによって操作された攻撃力・防御力・カード等の操作を反映する
    
    app.myGikoFundamentalAttackPower    += app.myGikoFundamentalAttackPowerFromEnemy;
    app.myGikoFundamentalDeffencePower  += app.myGikoFundamentalDeffencePowerFromEnemy;
    app.myMonarFundamentalAttackPower   += app.myMonarFundamentalAttackPowerFromEnemy;
    app.myMonarFundamentalDeffencePower += app.myMonarFundamentalDeffencePowerFromEnemy;
    app.mySyobonFundamentalAttackPower  += app.mySyobonFundamentalAttackPowerFromEnemy;
    app.mySyobonFundamentalDeffencePower+= app.mySyobonFundamentalDeffencePowerFromEnemy;
    app.myYaruoFundamentalAttackPower   += app.myYaruoFundamentalAttackPowerFromEnemy;
    app.myYaruoFundamentalDeffencePower += app.myYaruoFundamentalDeffencePowerFromEnemy;
    app.myGikoModifyingAttackPower      += app.myGikoModifyingAttackPowerFromEnemy;
    app.myGikoModifyingDeffencePower    += app.myGikoModifyingDeffencePowerFromEnemy;
    app.myMonarModifyingAttackPower     += app.myMonarModifyingAttackPowerFromEnemy;
    app.myMonarModifyingDeffencePower   += app.myMonarModifyingDeffencePowerFromEnemy;
    app.mySyobonModifyingAttackPower    += app.mySyobonModifyingAttackPowerFromEnemy;
    app.mySyobonModifyingDeffencePower  += app.mySyobonModifyingDeffencePowerFromEnemy;
    app.myYaruoModifyingAttackPower     += app.myYaruoModifyingAttackPowerFromEnemy;
    app.myYaruoModifyingDeffencePower   += app.myYaruoModifyingDeffencePowerFromEnemy;
    if(app.mySelectCharacterFromEnemy != -1) app.mySelectCharacter = app.mySelectCharacterFromEnemy;

    if(!app.denyEnemyCardPlaying){
        for (int i = 0; i < [app.myDeckCardListFromEnemy_plus count]; i++) {
            [app.myDeckCardList addObject:[app.myDeckCardListFromEnemy_plus objectAtIndex:i]];
        }
        for (int i = 0; i < [app.myHandFromEnemy_plus count]; i++) {
            [app.myHand addObject:[app.myHandFromEnemy_plus objectAtIndex:i]];
        }
        for (int i = 0; i < [app.myTombFromEnemy_plus count]; i++) {
            [app.myTomb addObject:[app.myTombFromEnemy_plus objectAtIndex:i]];
        }
        for (int i = 0; i < [app.myFieldCardFromEnemy_plus count]; i++) {
            [app.myFieldCard addObject:[app.myFieldCardFromEnemy_plus objectAtIndex:i]];
        }
        for (int i = 0; i < [app.myEnergyCardFromEnemy_plus count]; i++) {
            int x = [[app.myEnergyCard objectAtIndex:i] intValue];
            x += [[app.myEnergyCardFromEnemy_plus objectAtIndex:i] intValue];
            [app.myEnergyCard replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:x]];
        }
        for (int i = 0; i < [app.myDeckCardListFromEnemy_minus count]; i++) {
            [app.myDeckCardList removeObjectAtIndex:[GetEnemyDataFromServer indexOfObjectForNSNumber:app.myDeckCardList number:[app.myDeckCardListFromEnemy_minus objectAtIndex:i]]];
        }
        for (int i = 0; i < [app.myHandFromEnemy_minus count]; i++) {
            [app.myHand removeObjectAtIndex:[GetEnemyDataFromServer indexOfObjectForNSNumber:app.myHand number:[app.myHandFromEnemy_minus objectAtIndex:i]]];
        }
        for (int i = 0; i < [app.myTombFromEnemy_minus count]; i++) {
            [app.myTomb removeObjectAtIndex:[GetEnemyDataFromServer indexOfObjectForNSNumber:app.myTomb number:[app.myTombFromEnemy_minus objectAtIndex:i]]];
        }
        
        
        for (int i = 0; i < [app.myFieldCardFromEnemy_minus count]; i++) {
            [app.myFieldCard removeObjectAtIndex:[GetEnemyDataFromServer indexOfObjectForNSNumber:app.myFieldCard number:[app.myFieldCardFromEnemy_minus objectAtIndex:i]]];
        }
        
        for (int i = 0; i < [app.myEnergyCardFromEnemy_minus count]; i++) {
            int x = [[app.myEnergyCard objectAtIndex:i] intValue];
            x -= [[app.myEnergyCardFromEnemy_minus objectAtIndex:i] intValue];
            if(x < 0){
                x = 0;
            }
            [app.myEnergyCard replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:x]];
        }

        app.enemyDeckCardListByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyDeckCardList（差分のみ管理）
        app.enemyHandByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyHand（差分のみ管理）
        app.enemyTombByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyTomb（差分のみ管理）
        app.enemyFieldCardByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyFieldCard（差分のみ管理）
        app.enemyEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //自分が操作し、増加したenemyEnergyCard（差分のみ管理）
        app.enemyDeckCardListByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyDeckCardList（差分のみ管理）
        app.enemyHandByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyHand（差分のみ管理）
        app.enemyTombByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyTomb（差分のみ管理）
        app.enemyFieldCardByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyFieldCard（差分のみ管理）
        app.enemyEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //自分が操作し、減少したenemyEnergyCard（差分のみ管理）
    }

//    //自分によって操作されたカードの操作を反映する
//    for (int i = 0; i < [app.myDeckCardListByMyself_plus count]; i++) {
//        [app.myDeckCardList addObject:[app.myDeckCardListByMyself_plus objectAtIndex:i]];
//    }
//    for (int i = 0; i < [app.myHandByMyself_plus count]; i++) {
//        [app.myHand addObject:[app.myHandByMyself_plus objectAtIndex:i]];
//    }
//    for (int i = 0; i < [app.myTombByMyself_plus count]; i++) {
//        [app.myTomb addObject:[app.myTombByMyself_plus objectAtIndex:i]];
//    }
//    for (int i = 0; i < [app.myFieldCardByMyself_plus count]; i++) {
//        [app.myFieldCard addObject:[app.myFieldCardByMyself_plus objectAtIndex:i]];
//    }
    for (int i = 0; i < [app.myEnergyCardByMyself_plus count]; i++) {
        int x = [[app.myEnergyCard objectAtIndex:i] intValue];
        x += [[app.myEnergyCardByMyself_plus objectAtIndex:i] intValue];
        [app.myEnergyCard replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:x]];
    }
    
    for (int i = 0; i < [app.myDeckCardListByMyself_minus count]; i++) {
        int j = [GetEnemyDataFromServer indexOfObjectForNSNumber:app.myDeckCardList number:[[app.myDeckCardListByMyself_minus objectAtIndex:i] objectAtIndex:0]];
        if(j != -1){
            [app.myDeckCardList removeObjectAtIndex:j];
            
            switch ([[[app.myDeckCardListByMyself_minus objectAtIndex:i] objectAtIndex:1] intValue]) {
                case 0:
                    [app.myHand addObject:[app.myHandByMyself_plus objectAtIndex:[[[app.myDeckCardListByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 1:
                    [app.myTomb addObject:[app.myTombByMyself_plus objectAtIndex:[[[app.myDeckCardListByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 2:
                    [app.myFieldCard addObject:[app.myFieldCardByMyself_plus objectAtIndex:[[[app.myDeckCardListByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 3:
                    [app.myDeckCardList addObject:[app.myDeckCardListByMyself_plus objectAtIndex:[[[app.myDeckCardListByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                default:
                    break;
            }
        }
    }
    for (int i = 0; i < [app.myHandByMyself_minus count]; i++) {
        int j = [GetEnemyDataFromServer indexOfObjectForNSNumber:app.myHand number:[[app.myHandByMyself_minus objectAtIndex:i] objectAtIndex:0]];
        if(j != -1){
            [app.myHand removeObjectAtIndex:j];
            
            switch ([[[app.myHandByMyself_minus objectAtIndex:i] objectAtIndex:1] intValue]) {
                case 0:
                    [app.myHand addObject:[app.myHandByMyself_plus objectAtIndex:[[[app.myHandByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 1:
                    [app.myTomb addObject:[app.myTombByMyself_plus objectAtIndex:[[[app.myHandByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 2:
                    [app.myFieldCard addObject:[app.myFieldCardByMyself_plus objectAtIndex:[[[app.myHandByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 3:
                    [app.myDeckCardList addObject:[app.myDeckCardListByMyself_plus objectAtIndex:[[[app.myHandByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                default:
                    break;
            }
        }
    }
    for (int i = 0; i < [app.myTombByMyself_minus count]; i++) {
        int j =[GetEnemyDataFromServer indexOfObjectForNSNumber:app.myTomb number:[[app.myTombByMyself_minus objectAtIndex:i] objectAtIndex:0]];
        if(j != -1){
            [app.myTomb removeObjectAtIndex:j];
            switch ([[[app.myTombByMyself_minus objectAtIndex:i] objectAtIndex:1] intValue]) {
                case 0:
                    [app.myHand addObject:[app.myHandByMyself_plus objectAtIndex:[[[app.myTombByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 1:
                    [app.myTomb addObject:[app.myTombByMyself_plus objectAtIndex:[[[app.myTombByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 2:
                    [app.myFieldCard addObject:[app.myFieldCardByMyself_plus objectAtIndex:[[[app.myTombByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 3:
                    [app.myDeckCardList addObject:[app.myDeckCardListByMyself_plus objectAtIndex:[[[app.myTombByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                default:
                    break;
            }
        }
    }
    
    
    for (int i = 0; i < [app.myFieldCardByMyself_minus count]; i++) {
        int j =[GetEnemyDataFromServer indexOfObjectForNSNumber:app.myFieldCard number:[[app.myFieldCardByMyself_minus objectAtIndex:i] objectAtIndex:0]];
        if( j != -1){
            [app.myFieldCard removeObjectAtIndex:j];
            switch ([[[app.myFieldCardByMyself_minus objectAtIndex:i] objectAtIndex:1] intValue]) {
                case 0:
                    [app.myHand addObject:[app.myHandByMyself_plus objectAtIndex:[[[app.myFieldCardByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 1:
                    [app.myTomb addObject:[app.myTombByMyself_plus objectAtIndex:[[[app.myFieldCardByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 2:
                    [app.myFieldCard addObject:[app.myFieldCardByMyself_plus objectAtIndex:[[[app.myFieldCardByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                case 3:
                    [app.myDeckCardList addObject:[app.myDeckCardListByMyself_plus objectAtIndex:[[[app.myFieldCardByMyself_minus objectAtIndex:i] objectAtIndex:2] intValue]]];
                    break;
                default:
                    break;
            }
            
        }
    }
    
    for (int i = 0; i < [app.myEnergyCardByMyself_minus count]; i++) {
        int x = [[app.myEnergyCard objectAtIndex:i] intValue];
        x -= [[app.myEnergyCardByMyself_minus objectAtIndex:i] intValue];
        if(x < 0){
            x = 0;
        }
        [app.myEnergyCard replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:x]];
    }
    
    app.enemyGikoFundamentalAttackPower     +=    app.enemyGikoFundamentalAttackPowerByMyself;
    app.enemyGikoFundamentalDeffencePower   +=    app.enemyGikoFundamentalDeffencePowerByMyself;
    app.enemyMonarFundamentalAttackPower    +=    app.enemyMonarFundamentalAttackPowerByMyself;
    app.enemyMonarFundamentalDeffencePower  +=    app.enemyMonarFundamentalDeffencePowerByMyself;
    app.enemySyobonFundamentalAttackPower   +=    app.enemySyobonFundamentalAttackPowerByMyself;
    app.enemySyobonFundamentalDeffencePower +=    app.enemySyobonFundamentalDeffencePowerByMyself;
    app.enemyYaruoFundamentalAttackPower    +=    app.enemyYaruoFundamentalAttackPowerByMyself;
    app.enemyYaruoFundamentalDeffencePower  +=    app.enemyYaruoFundamentalDeffencePowerByMyself;
    app.enemyGikoModifyingAttackPower       +=    app.enemyGikoModifyingAttackPowerByMyself;
    app.enemyGikoModifyingDeffencePower     +=    app.enemyGikoModifyingDeffencePowerByMyself;
    app.enemyMonarModifyingAttackPower      +=    app.enemyMonarModifyingAttackPowerByMyself;
    app.enemyMonarModifyingDeffencePower    +=    app.enemyMonarModifyingDeffencePowerByMyself;
    app.enemySyobonModifyingAttackPower     +=    app.enemySyobonModifyingAttackPowerByMyself;
    app.enemySyobonModifyingDeffencePower   +=    app.enemySyobonModifyingDeffencePowerByMyself;
    app.enemyYaruoModifyingAttackPower      +=    app.enemyYaruoModifyingAttackPowerByMyself;
    app.enemyYaruoModifyingDeffencePower    +=    app.enemyYaruoModifyingDeffencePowerByMyself;
    
    app.enemyGikoFundamentalAttackPowerByMyself = 0;
    app.enemyGikoFundamentalDeffencePowerByMyself = 0;
    app.enemyMonarFundamentalAttackPowerByMyself = 0;
    app.enemyMonarFundamentalDeffencePowerByMyself = 0;
    app.enemySyobonFundamentalAttackPowerByMyself = 0;
    app.enemySyobonFundamentalDeffencePowerByMyself = 0;
    app.enemyYaruoFundamentalAttackPowerByMyself = 0;
    app.enemyYaruoFundamentalDeffencePowerByMyself = 0;
    app.enemyGikoModifyingAttackPowerByMyself = 0;
    app.enemyGikoModifyingDeffencePowerByMyself = 0;
    app.enemyMonarModifyingAttackPowerByMyself = 0;
    app.enemyMonarModifyingDeffencePowerByMyself = 0;
    app.enemySyobonModifyingAttackPowerByMyself = 0;
    app.enemySyobonModifyingDeffencePowerByMyself = 0;
    app.enemyYaruoModifyingAttackPowerByMyself = 0;
    app.enemyYaruoModifyingDeffencePowerByMyself = 0;
    
    
    app.myLifeGage += app.myLifeGageByMyself;
    app.myGikoFundamentalAttackPower += app.myGikoFundamentalAttackPowerByMyself; //自分が操作した自分のギコの基本攻撃力（差分のみ管理）
    app.myGikoFundamentalDeffencePower += app.myGikoFundamentalDeffencePowerByMyself; //自分が操作した自分のギコの基本防御力（差分のみ管理）
    app.myMonarFundamentalAttackPower += app.myMonarFundamentalAttackPowerByMyself; //自分が操作した自分のモナーの基本攻撃力（差分のみ管理）
    app.myMonarFundamentalDeffencePower += app.myMonarFundamentalDeffencePowerByMyself; //自分が操作した自分のモナーの基本防御力（差分のみ管理）
    app.mySyobonFundamentalAttackPower += app.mySyobonFundamentalAttackPowerByMyself; //自分が操作した自分のショボンの基本攻撃力（差分のみ管理）
    app.mySyobonFundamentalDeffencePower += app.mySyobonFundamentalDeffencePowerByMyself; //自分が操作した自分のショボンの基本防御力（差分のみ管理）
    app.myYaruoFundamentalAttackPower += app.myYaruoFundamentalAttackPowerByMyself; //自分が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    app.myYaruoFundamentalDeffencePower += app.myYaruoFundamentalDeffencePowerByMyself; //自分が操作した自分のやる夫の基本防御力（差分のみ管理）
    app.myGikoModifyingAttackPower += app.myGikoModifyingAttackPowerByMyself; //自分が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoModifyingDeffencePower += app.myGikoModifyingDeffencePowerByMyself; //自分が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingAttackPower += app.myMonarModifyingAttackPowerByMyself; //自分が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingDeffencePower += app.myMonarModifyingDeffencePowerByMyself; //自分が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingAttackPower += app.mySyobonModifyingAttackPowerByMyself; //自分が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingDeffencePower += app.mySyobonModifyingDeffencePowerByMyself; //自分が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingAttackPower += app.myYaruoModifyingAttackPowerByMyself; //自分が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingDeffencePower += app.myYaruoModifyingDeffencePowerByMyself; //自分が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myLifeGageByMyself = 0;
    app.myGikoFundamentalAttackPowerByMyself = 0;
    app.myGikoFundamentalDeffencePowerByMyself = 0;
    app.myMonarFundamentalAttackPowerByMyself = 0;
    app.myMonarFundamentalDeffencePowerByMyself = 0;
    app.mySyobonFundamentalAttackPowerByMyself = 0;
    app.mySyobonFundamentalDeffencePowerByMyself = 0;
    app.myYaruoFundamentalAttackPowerByMyself = 0;
    app.myYaruoFundamentalDeffencePowerByMyself = 0;
    app.myGikoModifyingAttackPowerByMyself = 0;
    app.myGikoModifyingDeffencePowerByMyself = 0;
    app.myMonarModifyingAttackPowerByMyself = 0;
    app.myMonarModifyingDeffencePowerByMyself = 0;
    app.mySyobonModifyingAttackPowerByMyself = 0;
    app.mySyobonModifyingDeffencePowerByMyself = 0;
    app.myYaruoModifyingAttackPowerByMyself = 0;
    app.myYaruoModifyingDeffencePowerByMyself = 0;
    
    app.myDeckCardListByMyself_plus = [[NSMutableArray alloc] init];
    app.myHandByMyself_plus = [[NSMutableArray alloc] init];
    app.myTombByMyself_plus = [[NSMutableArray alloc] init];
    app.myFieldCardByMyself_plus = [[NSMutableArray alloc] init];
    app.myEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil];
    app.myDeckCardListByMyself_minus = [[NSMutableArray alloc] init];
    app.myHandByMyself_minus = [[NSMutableArray alloc] init];
    app.myTombByMyself_minus = [[NSMutableArray alloc] init];
    app.myFieldCardByMyself_minus = [[NSMutableArray alloc] init];
    app.myEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],  [NSNumber numberWithInt:0],nil];
    
    [SVProgressHUD dismiss];
}

-(void)doEnemyDecideAction :(BOOL)select{
    [self initWithGetEnemyDataFromServer:@"http://utakatanet.dip.jp:58080/doEnemyDecideAction.php" selectCardAndAAPhase:select];
    app.decideAction = [[statuses objectAtIndex:0] boolValue];
}

+(int)indexOfObjectForNSNumber:(NSArray *)array number:(NSNumber *)number{
    int i = [number intValue];
    for (int j = 0; j < [array count]; j++) {
        int k = [[array objectAtIndex:j] intValue];
        if (i == k) {
            return j;
        }
    }
    return -1;
}



@end
