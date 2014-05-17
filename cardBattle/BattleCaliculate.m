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
    app = [[UIApplication sharedApplication] delegate];
    
    int result = 999;
        if(app.enemySelectCharacter == GIKO){
            if (app.mySelectCharacter == GIKO) {
                result = app.enemyGikoFundamentalAttackPower + app.enemyGikoModifyingAttackPower      - (app.myGikoFundamentalDeffencePower    + app.myGikoModifyingDeffencePower);
            }else if (app.mySelectCharacter == MONAR){
                result = app.enemyGikoFundamentalAttackPower + app.enemyGikoModifyingAttackPower;
            }else if (app.mySelectCharacter == SYOBON){
                result = 0;
            }else if (app.mySelectCharacter == YARUO){
                result = app.enemyGikoFundamentalAttackPower + app.enemyGikoModifyingAttackPower      - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
            }
        }else if (app.enemySelectCharacter == MONAR){
            if (app.mySelectCharacter == GIKO) {
                result = 0;
            }else if (app.mySelectCharacter == MONAR){
                result = app.enemyMonarFundamentalAttackPower + app.enemyMonarModifyingAttackPower    - (app.myMonarFundamentalDeffencePower   + app.myMonarModifyingDeffencePower);
            }else if (app.mySelectCharacter == SYOBON){
                result = app.enemyMonarFundamentalAttackPower + app.enemyMonarModifyingAttackPower;
            }else if (app.mySelectCharacter == YARUO){
                result = app.enemyMonarFundamentalAttackPower + app.enemyMonarModifyingAttackPower    - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
            }
        }else if (app.enemySelectCharacter == SYOBON){
            if (app.mySelectCharacter == GIKO) {
                result = app.enemySyobonFundamentalAttackPower + app.enemySyobonModifyingAttackPower;
            }else if (app.mySelectCharacter == MONAR){
                result = 0;
            }else if (app.mySelectCharacter == SYOBON){
                result = app.enemySyobonFundamentalAttackPower + app.enemySyobonModifyingAttackPower  - (app.mySyobonFundamentalDeffencePower  + app.mySyobonModifyingDeffencePower);
            }else if (app.mySelectCharacter == YARUO){
                result = app.enemySyobonFundamentalAttackPower + app.enemySyobonModifyingAttackPower  - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
            }
        }else if (app.enemySelectCharacter == YARUO){
            if (app.mySelectCharacter == GIKO) {
                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.myGikoFundamentalDeffencePower    + app.myGikoModifyingDeffencePower);
            }else if (app.mySelectCharacter == MONAR){
                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.myMonarFundamentalDeffencePower   + app.myMonarModifyingDeffencePower);
            }else if (app.mySelectCharacter == SYOBON){
                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.mySyobonFundamentalDeffencePower  + app.mySyobonModifyingDeffencePower);
            }else if (app.mySelectCharacter == YARUO){
                result = app.enemyYaruoFundamentalAttackPower + app.enemyYaruoModifyingAttackPower    - (app.myYaruoFundamentalDeffencePower   + app.myYaruoModifyingDeffencePower);
            }
        }
    NSLog(@"自分のライフ：%d",app.myLifeGage - result);
    NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
    NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
    NSLog(@"相手に与えたダメージ：%d",result);

    return result;
}
@end

