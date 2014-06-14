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
@synthesize reverse;

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

//相手のダメージ計算を行う
-(int)damageCaliculate{
    app = [[UIApplication sharedApplication] delegate];
    int result = 999;
    
    if (reverse) {
        if(app.mySelectCharacter == GIKO){
            if(app.myGikoAttackPermittedByMyself == NO || app.myGikoAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            if (app.enemySelectCharacter == GIKO) {
                if(app.enemyGikoDeffencePermittedByMyself == NO || app.enemyGikoDeffencePermittedFromEnemy == NO){
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
                }else{
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower      - (app.enemyGikoFundamentalDeffencePower    + app.enemyGikoModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == MONAR){
                if (app.enemyMonarDeffencePermittedByMyself == NO || app.enemyMonarDeffencePermittedFromEnemy == NO) {
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
                }else{
                    result = 0;
                }
            }else if (app.enemySelectCharacter == SYOBON){
                result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
                }else{
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower      - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }else if (app.mySelectCharacter == MONAR){
            if(app.myMonarAttackPermittedByMyself == NO || app.myMonarAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            
            if (app.enemySelectCharacter == GIKO) {
                result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
            }else if (app.enemySelectCharacter == MONAR){
                if(app.enemyMonarDeffencePermittedByMyself == NO || app.enemyMonarDeffencePermittedFromEnemy == NO){
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
                }else{
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower    - (app.enemyMonarFundamentalDeffencePower   + app.enemyMonarModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == SYOBON){
                if(app.enemySyobonDeffencePermittedByMyself == NO || app.enemySyobonDeffencePermittedFromEnemy == NO){
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
                }else{
                    result = 0;
                }
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
                }else{
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower    - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }else if (app.mySelectCharacter == SYOBON){
            if(app.mySyobonAttackPermittedByMyself == NO || app.mySyobonAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            
            if (app.enemySelectCharacter == GIKO) {
                if(app.enemyGikoDeffencePermittedByMyself == NO || app.enemyGikoDeffencePermittedFromEnemy == NO){
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
                }else{
                    result = 0;
                }
            }else if (app.enemySelectCharacter == MONAR){
                result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
            }else if (app.enemySelectCharacter == SYOBON){
                if(app.enemySyobonDeffencePermittedByMyself == NO || app.enemySyobonDeffencePermittedFromEnemy == NO){
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
                }else{
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower  - (app.enemySyobonFundamentalDeffencePower  + app.enemySyobonModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
                }else{
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower  - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }else if (app.mySelectCharacter == YARUO){
            if(app.myYaruoAttackPermittedByMyself == NO || app.myYaruoAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            
            if (app.enemySelectCharacter == GIKO) {
                if(app.enemyGikoDeffencePermittedByMyself == NO || app.enemyGikoDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyGikoFundamentalDeffencePower    + app.enemyGikoModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == MONAR){
                if(app.enemyMonarDeffencePermittedByMyself == NO || app.enemyMonarDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyMonarFundamentalDeffencePower   + app.enemyMonarModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == SYOBON){
                if(app.enemySyobonDeffencePermittedByMyself == NO || app.enemySyobonDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemySyobonFundamentalDeffencePower  + app.enemySyobonModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }

    }else{
        if(app.mySelectCharacter == GIKO){
            if(app.myGikoAttackPermittedByMyself == NO || app.myGikoAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            if (app.enemySelectCharacter == GIKO) {
                if(app.enemyGikoDeffencePermittedByMyself == NO || app.enemyGikoDeffencePermittedFromEnemy == NO){
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
                }else{
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower      - (app.enemyGikoFundamentalDeffencePower    + app.enemyGikoModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == MONAR){
                result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
            }else if (app.enemySelectCharacter == SYOBON){
                if (app.enemySyobonDeffencePermittedByMyself == NO || app.enemySyobonDeffencePermittedFromEnemy == NO) {
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
                }else{
                    result = 0;
                }
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower;
                }else{
                    result = app.myGikoFundamentalAttackPower + app.myGikoModifyingAttackPower      - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }else if (app.mySelectCharacter == MONAR){
            if(app.myMonarAttackPermittedByMyself == NO || app.myMonarAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            
            if (app.enemySelectCharacter == GIKO) {
                if(app.enemyGikoDeffencePermittedByMyself == NO || app.enemyGikoDeffencePermittedFromEnemy == NO){
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
                }else{
                    result = 0;
                }
            }else if (app.enemySelectCharacter == MONAR){
                if(app.enemyMonarDeffencePermittedByMyself == NO || app.enemyMonarDeffencePermittedFromEnemy == NO){
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
                }else{
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower    - (app.enemyMonarFundamentalDeffencePower   + app.enemyMonarModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == SYOBON){
                result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower;
                }else{
                    result = app.myMonarFundamentalAttackPower + app.myMonarModifyingAttackPower    - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }else if (app.mySelectCharacter == SYOBON){
            if(app.mySyobonAttackPermittedByMyself == NO || app.mySyobonAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            
            if (app.enemySelectCharacter == GIKO) {
                result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
            }else if (app.enemySelectCharacter == MONAR){
                if(app.enemyMonarDeffencePermittedByMyself == NO || app.enemyMonarDeffencePermittedFromEnemy == NO){
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
                }else{
                    result = 0;
                }
            }else if (app.enemySelectCharacter == SYOBON){
                if(app.enemySyobonDeffencePermittedByMyself == NO || app.enemySyobonDeffencePermittedFromEnemy == NO){
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
                }else{
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower  - (app.enemySyobonFundamentalDeffencePower  + app.enemySyobonModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower;
                }else{
                    result = app.mySyobonFundamentalAttackPower + app.mySyobonModifyingAttackPower  - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }else if (app.mySelectCharacter == YARUO){
            if(app.myYaruoAttackPermittedByMyself == NO || app.myYaruoAttackPermittedFromEnemy == NO){
                NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
                NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
                NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
                NSLog(@"相手に与えたダメージ：%d",0);
                return 0;
            }
            
            if (app.enemySelectCharacter == GIKO) {
                if(app.enemyGikoDeffencePermittedByMyself == NO || app.enemyGikoDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyGikoFundamentalDeffencePower    + app.enemyGikoModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == MONAR){
                if(app.enemyMonarDeffencePermittedByMyself == NO || app.enemyMonarDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyMonarFundamentalDeffencePower   + app.enemyMonarModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == SYOBON){
                if(app.enemySyobonDeffencePermittedByMyself == NO || app.enemySyobonDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemySyobonFundamentalDeffencePower  + app.enemySyobonModifyingDeffencePower);
                }
            }else if (app.enemySelectCharacter == YARUO){
                if(app.enemyYaruoDeffencePermittedByMyself == NO || app.enemyYaruoDeffencePermittedFromEnemy == NO){
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower;
                }else{
                    result = app.myYaruoFundamentalAttackPower + app.myYaruoModifyingAttackPower    - (app.enemyYaruoFundamentalDeffencePower   + app.enemyYaruoModifyingDeffencePower);
                }
            }
        }
    }
    NSLog(@"相手のライフ(被弾前)：%d",app.enemyLifeGage);
    NSLog(@"相手の選択キャラ：%d",app.enemySelectCharacter);
    NSLog(@"自分の選択キャラ：%d", app.mySelectCharacter);
    NSLog(@"相手に与えたダメージ：%d",result);
    
    if(result < 0) result = 0;
    return result;
}
@end

