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
    //初回起動判定。初回起動であれば、プロローグを開始する。
        app = [[UIApplication sharedApplication] delegate];
    int first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
    if (first == 0) {
        //プロローグに合わせて入力する内容が変わるため、状況に応じて格納するデータを変える。
        int sendPhase =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunchSendPhase_ud"];
        sendPhase++;
        [[NSUserDefaults standardUserDefaults] setInteger:sendPhase forKey:@"firstLaunchSendPhase_ud"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        switch (sendPhase) {
            case 1:
                NSLog(@"SendData:1ターン目_ターン開始直後");
                //１ターン目ターン開始直後
                app.enemySelectCharacter                            = -1;
                app.doEnemyUseCard                                  = NO;
                app.enemyUsingCardNumber                            = 0;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                app.enemySelectColor                                = -1;
                
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil];
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1],  nil];
                break;
            case 2:
                NSLog(@"SendData:1ターン目_カード・AAを決定した直後");
                //１ターン目カード・AAを決定した直後
                app.enemySelectCharacter                            = 1; //1 = ギコ
                break;
            case 3:
                NSLog(@"SendData:1ターン目_ダメージ計算フェーズに入った直後");
                //１ターン目ダメージ計算フェーズに入った直後
                app.enemySelectCharacter                            = 1; //1 = ギコ
                break;
            case 4:
                NSLog(@"SendData:1ターン目_ダメージ計算フェーズで相手へのダメージを計算した直後");
                //１ターン目ダメージ計算フェーズで相手へのダメージを計算した直後
                app.enemyLifeGage                                   = 18;
                app.enemySelectCharacter                            = 1; //1 = ギコ
                app.myDamageFromAA                                  = 2;
                app.myDamageFromCard                                = 0;
                app.myDamageInBattlePhase                           = 2;
                app.enemyDamageInBattlePhase                        = 2;
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                break;
            case 5:
                NSLog(@"SendData:1ターン目_ターン終了フェーズに入った直後");
                //１ターン目ターン終了フェーズに入った直後
                app.enemySelectCharacter                            = 1; //1 = ギコ
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                break;
            case 6:
                NSLog(@"SendData:2ターン目_ターン開始直後");
                //２ターン目ターン開始直後
                app.enemySelectCharacter                            = -1;
                app.doEnemyUseCard                                  = NO;
                app.enemyUsingCardNumber                            = 0;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                app.enemySelectColor                                = -1;
                
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil];
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 7:
                NSLog(@"SendData:2ターン目_カード・AAを決定した直後");
                //２ターン目カード・AAを決定した直後
                
                    //相性が良くなるように相手のキャラクターを操作
                switch (app.mySelectCharacter) {
                    case GIKO:
                        app.enemySelectCharacter = MONAR;
                        break;
                    case MONAR:
                        app.enemySelectCharacter = SYOBON;
                        break;
                    case SYOBON:
                        app.enemySelectCharacter = GIKO;
                        break;
                    default:
                        break;
                }
                app.doEnemyUseCard                                  = YES;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 8:
                NSLog(@"SendData:2ターン目_ダメージ計算フェーズに入った直後");
                //２ターン目ダメージ計算フェーズに入った直後
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                break;
            case 9:
                NSLog(@"SendData:2ターン目_ダメージ計算フェーズで相手へのダメージを計算した直後");
                //２ターン目ダメージ計算フェーズで相手へのダメージを計算した直後
                app.enemyLifeGage                                   = 15;
                app.enemyUsingCardNumber                            = 1;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                app.myDamageInBattlePhase                           = 0;
                app.enemyDamageInBattlePhase                        = 3;
                break;
            case 10:
                NSLog(@"SendData:2ターン目_ターン終了フェーズに入った直後");
                //２ターン目ターン終了フェーズに入った直後
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                break;
            case 11:
                NSLog(@"SendData:3ターン目_ターン開始直後");
                //３ターン目ターン開始直後
                app.enemySelectCharacter                            = -1;
                app.doEnemyUseCard                                  = NO;
                app.enemyUsingCardNumber                            = 0;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],nil];

                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 12:
                NSLog(@"SendData:3ターン目_カード・AAを決定した直後");
                //３ターン目カード・AAを決定した直後
                
                    //相性が悪くなるように相手のキャラクターを操作
                switch (app.mySelectCharacter) {
                    case GIKO:
                        app.enemySelectCharacter = SYOBON;
                        break;
                    case MONAR:
                        app.enemySelectCharacter = GIKO;
                        break;
                    case SYOBON:
                        app.enemySelectCharacter = MONAR;
                        break;
                    default:
                        break;
                }
                app.doEnemyUseCard                                  = YES;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 13:
                NSLog(@"SendData:3ターン目_ダメージ計算フェーズに入った直後");
                //３ターン目ダメージ計算フェーズに入った直後
                app.myDamageFromAA                                  = 3;
                app.myDamageFromCard                                = 0;
                break;
            case 14:
                NSLog(@"SendData:3ターン目_ダメージ計算フェーズで相手へのダメージを計算した直後");
                //３ターン目ダメージ計算フェーズで相手へのダメージを計算した直後
                app.enemyUsingCardNumber                            = 1;
                app.myDamageFromAA                                  = 3;
                app.myDamageFromCard                                = 0;
                app.myDamageInBattlePhase                           = 3;
                app.enemyDamageInBattlePhase                        = 3;
                break;
            case 15:
                NSLog(@"SendData:3ターン目_ターン終了フェーズに入った直後");
                //３ターン目ターン終了フェーズに入った直後
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
        
                break;
            case 16:
                NSLog(@"SendData:4ターン目_ターン開始直後");
                //４ターン目ターン開始直後
                app.enemySelectCharacter                            = -1;
                app.doEnemyUseCard                                  = NO;
                app.enemyUsingCardNumber                            = 0;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],nil];
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 17:
                NSLog(@"SendData:4ターン目_カード・AAを決定した直後");
                //４ターン目カード・AAを決定した直後
                
                    //相性がよくなるよう相手のキャラクターを操作する
                switch (app.mySelectCharacter) {
                    case GIKO:
                        app.enemySelectCharacter = MONAR;
                        break;
                    case MONAR:
                        app.enemySelectCharacter = SYOBON;
                        break;
                    case SYOBON:
                        app.enemySelectCharacter = GIKO;
                        break;
                    default:
                        break;
                }
                app.doEnemyUseCard                                  = YES;
                app.enemyUsingCardNumber                            = 1;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                
            
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 18:
                NSLog(@"SendData:4ターン目_ダメージ計算フェーズに入った直後");
                //４ターン目ダメージ計算フェーズに入った直後
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                break;
            case 19:
                NSLog(@"SendData:4ターン目_ダメージ計算フェーズで相手へのダメージを計算した直後");
                //４ターン目ダメージ計算フェーズで相手へのダメージを計算した直後
                app.enemyLifeGage                                   = 12;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                app.myDamageInBattlePhase                           = 0;
                app.enemyDamageInBattlePhase                        = 3;
                break;
            case 20:
                NSLog(@"SendData:4ターン目_ターン終了フェーズに入った直後");
                //４ターン目ターン終了フェーズに入った直後
                app.enemyLifeGage                                   = 11;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                break;
            case 21:
                NSLog(@"SendData:5ターン目_ターン開始直後");
                //５ターン目ターン開始直後
                app.enemySelectCharacter                            = -1;
                app.doEnemyUseCard                                  = NO;
                app.enemyUsingCardNumber                            = 0;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],nil];
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 22:
                NSLog(@"SendData:5ターン目_カード・AAを決定した直後");
                //５ターン目カード・AAを決定した直後
                app.enemySelectCharacter                            = 1; //1 = ギコ。自分はやる夫。
                app.doEnemyUseCard                                  = NO;
                app.enemyUsingCardNumber                            = 1;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
                app.enemyHand = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
                break;
            case 23:
                NSLog(@"SendData:5ターン目_ダメージ計算フェーズに入った直後");
                //５ターン目ダメージ計算フェーズに入った直後
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                break;
            case 24:
                NSLog(@"SendData:5ターン目_ダメージ計算フェーズで相手へのダメージを計算した直後");
                //５ターン目ダメージ計算フェーズで相手へのダメージを計算した直後
                app.enemyLifeGage                                   = 1;
                app.enemySelectCharacter                            = 1;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                app.myDamageInBattlePhase                           = 0;
                app.enemyDamageInBattlePhase                        = 10;
                break;
            case 25:
                NSLog(@"SendData:5ターン目_ターン終了フェーズに入った直後");
                //５ターン目ターン終了フェーズに入った直後
                app.enemyLifeGage                                   = 0;
                app.myDamageFromAA                                  = 0;
                app.myDamageFromCard                                = 0;
                break;
            default:
                break;
        }
        
        //相手プレイヤーによって操作された攻撃力・防御力・カード等の操作を反映する
        app.myLifeGage = app.myLifeGage - (app.myDamageFromAA + app.myDamageFromCard);
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
        
        [SVProgressHUD popActivity];
        
        return resultString;
    }else{
        //初回起動でなければ、通常のデータ転送を行う。
        
        get = [[GetEnemyDataFromServer alloc] init];
        [self sendData]; //相手のカード効果等が未反映の状態のデータ（自分の効果は反映済み）を送信する
        while (!app.decideAction) {
            [get doEnemyDecideActionRoopVersion:YES];
        }
        [NSThread sleepForTimeInterval:0.5];
        [get doEnemyDecideActionRoopVersion:NO];
        [get get]; //自分のカード効果等が未反映の状態のデータ（相手の効果は反映済み）を受け取る
        
        app.myDamageInBattlePhase = app.myDamageFromAA;
        app.enemyDamageInBattlePhase = app.enemyDamageFromAA;
        app.myDamageFromAA = 0;
        app.myDamageFromCard = 0;
        app.enemyDamageFromAA = 0; //app.enemyDamageFromAAとapp.enemyDamageFromCardだけ自分が操作している変数。例外。
        app.enemyDamageFromCard = 0; //app.enemyDamageFromAAとapp.enemyDamageFromCardだけ自分が操作している変数。例外。
        
        [self sendData]; //相手のカード効果等が反映済みの状態のデータ（自分の効果は反映済み）を送信する
        while (!app.decideAction) {
            [get doEnemyDecideActionRoopVersion:YES];
        }
        [NSThread sleepForTimeInterval:0.5];
        [get doEnemyDecideActionRoopVersion:NO];
        [get get]; //自分のカード効果等が反映済みの状態のデータ（相手の効果は反映済み）を受け取る
        app.myDamageFromAA = 0;
        app.myDamageFromCard = 0;
        app.enemyDamageFromAA = 0; //app.enemyDamageFromAAとapp.enemyDamageFromCardだけ自分が操作している変数。例外。
        app.enemyDamageFromCard = 0; //app.enemyDamageFromAAとapp.enemyDamageFromCardだけ自分が操作している変数。例外。
        
        return resultString;
    }
}


-(NSString *)sendData{
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
                                       //***[NSNumber numberWithBool:app.canIPlaySorceryCardByMyself],
                                       //***[NSNumber numberWithBool:app.canIPlayFieldCardByMyself],
                                       //***[NSNumber numberWithBool:app.canIActivateFieldCardByMyself],
                                       //***[NSNumber numberWithBool:app.canIPlayEnergyCardByMyself],
                                       //***[NSNumber numberWithBool:app.canIActivateEnergyCardByMyself],
                                       //***[NSNumber numberWithBool:app.denymyCardPlaying],
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
                                       //***[NSNumber numberWithBool:app.canEnemyPlaySorceryCardByMyself],
                                       //***[NSNumber numberWithBool:app.canEnemyPlayFieldCardByMyself],
                                       //***[NSNumber numberWithBool:app.canEnemyActivateFieldCardByMyself],
                                       //***[NSNumber numberWithBool:app.canEnemyPlayEnergyCardByMyself],
                                       //***[NSNumber numberWithBool:app.canEnemyActivateEnergyCardByMyself],
                                       //***[NSNumber numberWithBool:app.denyEnemyCardPlaying],
                                       [NSNumber numberWithInt:app.enemySelectCharacterByMyself],
                                       app.enemyDeckCardListByMyself_plus,
                                       app.enemyHandByMyself_plus,
                                       app.enemyTombByMyself_plus,
                                       app.enemyFieldCardByMyself_plus,
                                       app.enemyEnergyCardByMyself_plus,
                                       app.enemyDeckCardListByMyself_minus,
                                       app.enemyHandByMyself_minus,
                                       app.enemyTombByMyself_minus,
                                       app.enemyFieldCardByMyself_minus,
                                       app.enemyEnergyCardByMyself_minus,
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
                                 //***@"canIPlaySorceryCard",
                                 //***@"canIPlayFieldCard",
                                 //***@"canIActivateFieldCard",
                                 //***@"canIPlayEnergyCard",
                                 //***@"canIActivateEnergyCard",
                                 //***@"denymyCardPlaying",
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
                                 //***@"canEnemyPlaySorceryCard",
                                 //***@"canEnemyPlayFieldCard",
                                 //***@"canEnemyActivateFieldCard",
                                 //***@"canEnemyPlayEnergyCard",
                                 //***@"canEnemyActivateEnergyCard",
                                 //***@"denyEnemyCardPlaying",
                                 @"enemySelectCharacterByMyself",
                                 @"enemyDeckCardListByMyself_plus",
                                 @"enemyHandByMyself_plus",
                                 @"enemyTombByMyself_plus",
                                 @"enemyFieldCardByMyself_plus",
                                 @"enemyEnergyCardByMyself_plus",
                                 @"enemyDeckCardListByMyself_minus",
                                 @"enemyHandByMyself_minus",
                                 @"enemyTombByMyself_minus",
                                 @"enemyFieldCardByMyself_minus",
                                 @"enemyEnergyCardByMyself_minus",
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
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
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
}

@end
