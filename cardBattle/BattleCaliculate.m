//
//  BattleCaliculate.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "BattleCaliculate.h"



@interface BattleCaliculate ()

@end

@implementation BattleCaliculate


int manageCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

//自分のダメージ計算を行う
-(int)damageCaliculate{
//    app = [[UIApplication sharedApplication] delegate];
//    int result = 999;
//        if(app.enemySelectCharacter == GIKO){
//            if(app.myGikoAttackPermitted == NO){
//                NSLog(@"自分のライフ(被弾前)：%d",app.myLifeGage);
//                NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
//                NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
//                NSLog(@"自分が受けたダメージ：%d",0);
//                return 0;
//            }
//            if (app.mySelectCharacter == GIKO) {
//                result = app.enemyGikoFundamentalAttackPower + app.enemyGikoModifyingAttackPower      - (app.myGikoFundamentalDeffencePower    + app.myGikoModifyingDeffencePower);
//            }else if (app.mySelectCharacter == MONAR){
//                result = app.enemyGikoFundamentalAttackPower + app.enemyGikoModifyingAttackPower;
//            }else if (app.mySelectCharacter == SYOBON){
//                result = 0;
//            }else if (app.mySelectCharacter == YARUO){
//                result = app.enemyGikoFundamentalAttackPower + app.enemyGikoModifyingAttackPower      - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
//            }
//        }else if (app.enemySelectCharacter == MONAR){
//            if(app.enemyMonarAttackPermitted == NO){
//                NSLog(@"自分のライフ(被弾前)：%d",app.myLifeGage);
//                NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
//                NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
//                NSLog(@"自分が受けたダメージ：%d",0);
//                return 0;
//            }
//            
//            if (app.mySelectCharacter == GIKO) {
//                result = 0;
//            }else if (app.mySelectCharacter == MONAR){
//                result = app.enemyMonarFundamentalAttackPower + app.enemyMonarModifyingAttackPower    - (app.myMonarFundamentalDeffencePower   + app.myMonarModifyingDeffencePower);
//            }else if (app.mySelectCharacter == SYOBON){
//                result = app.enemyMonarFundamentalAttackPower + app.enemyMonarModifyingAttackPower;
//            }else if (app.mySelectCharacter == YARUO){
//                result = app.enemyMonarFundamentalAttackPower + app.enemyMonarModifyingAttackPower    - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
//            }
//        }else if (app.enemySelectCharacter == SYOBON){
//            if(app.enemySyobonAttackPermitted == NO){
//                NSLog(@"自分のライフ(被弾前)：%d",app.myLifeGage);
//                NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
//                NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
//                NSLog(@"自分が受けたダメージ：%d",0);
//                return 0;
//            }
//            
//            if (app.mySelectCharacter == GIKO) {
//                result = app.enemySyobonFundamentalAttackPower + app.enemySyobonModifyingAttackPower;
//            }else if (app.mySelectCharacter == MONAR){
//                result = 0;
//            }else if (app.mySelectCharacter == SYOBON){
//                result = app.enemySyobonFundamentalAttackPower + app.enemySyobonModifyingAttackPower  - (app.mySyobonFundamentalDeffencePower  + app.mySyobonModifyingDeffencePower);
//            }else if (app.mySelectCharacter == YARUO){
//                result = app.enemySyobonFundamentalAttackPower + app.enemySyobonModifyingAttackPower  - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
//            }
//        }else if (app.enemySelectCharacter == YARUO){
//            if(app.enemyYaruoAttackPermitted == NO){
//                NSLog(@"自分のライフ(被弾前)：%d",app.myLifeGage);
//                NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
//                NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
//                NSLog(@"自分が受けたダメージ：%d",0);
//                return 0;
//            }
//            
//            if (app.mySelectCharacter == GIKO) {
//                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.myGikoFundamentalDeffencePower    + app.myGikoModifyingDeffencePower);
//            }else if (app.mySelectCharacter == MONAR){
//                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.myMonarFundamentalDeffencePower   + app.myMonarModifyingDeffencePower);
//            }else if (app.mySelectCharacter == SYOBON){
//                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.mySyobonFundamentalDeffencePower  + app.mySyobonModifyingDeffencePower);
//            }else if (app.mySelectCharacter == YARUO){
//                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
//            }
//        }
//    NSLog(@"自分のライフ(被弾前)：%d",app.myLifeGage);
//    NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
//    NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
//    NSLog(@"自分が受けたダメージ：%d",result);
//
//    return result;
    
    app = [[UIApplication sharedApplication] delegate];
    int result = 999;
    if(app.mySelectCharacter == GIKO){
        if(app.myGikoAttackPermitted == NO){
            NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
            NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
            NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
            NSLog(@"相手に与えたダメージ：%d",0);
            return 0;
        }
        if (app.enemySelectCharacter == GIKO) {
            result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower      - (app.enemyGikoFundamentalDeffencePower    + app.enemyGikoModifyingDeffencePower);
        }else if (app.enemySelectCharacter == MONAR){
            result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
        }else if (app.enemySelectCharacter == SYOBON){
            result = 0;
        }else if (app.enemySelectCharacter == YARUO){
            result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower      - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
        }
    }else if (app.mySelectCharacter == MONAR){
        if(app.myMonarAttackPermitted == NO){
            NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
            NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
            NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
            NSLog(@"相手に与えたダメージ：%d",0);
            return 0;
        }
        
        if (app.enemySelectCharacter == GIKO) {
            result = 0;
        }else if (app.enemySelectCharacter == MONAR){
            result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower    - (app.enemyMonarFundamentalDeffencePower   + app.enemyMonarModifyingDeffencePower);
        }else if (app.enemySelectCharacter == SYOBON){
            result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
        }else if (app.enemySelectCharacter == YARUO){
            result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower    - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
        }
    }else if (app.mySelectCharacter == SYOBON){
        if(app.mySyobonAttackPermitted == NO){
            NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
            NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
            NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
            NSLog(@"相手に与えたダメージ：%d",0);
            return 0;
        }
        
        if (app.enemySelectCharacter == GIKO) {
            result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
        }else if (app.enemySelectCharacter == MONAR){
            result = 0;
        }else if (app.enemySelectCharacter == SYOBON){
            result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower  - (app.enemySyobonFundamentalDeffencePower  + app.enemySyobonModifyingDeffencePower);
        }else if (app.enemySelectCharacter == YARUO){
            result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower  - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
        }
    }else if (app.mySelectCharacter == YARUO){
        if(app.myYaruoAttackPermitted == NO){
            NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
            NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
            NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
            NSLog(@"相手に与えたダメージ：%d",0);
            return 0;
        }
        
        if (app.enemySelectCharacter == GIKO) {
            result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyGikoFundamentalDeffencePower    + app.enemyGikoModifyingDeffencePower);
        }else if (app.enemySelectCharacter == MONAR){
            result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyMonarFundamentalDeffencePower   + app.enemyMonarModifyingDeffencePower);
        }else if (app.enemySelectCharacter == SYOBON){
            result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemySyobonFundamentalDeffencePower  + app.enemySyobonModifyingDeffencePower);
        }else if (app.enemySelectCharacter == YARUO){
            result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
        }
    }
    NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
    NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
    NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
    NSLog(@"相手に与えたダメージ：%d",result);
    
    return result;
}
@end

