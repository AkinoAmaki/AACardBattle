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

//自分・相手どちらのライフ管理を行うか選択した上で、ダメージ計算を行う
- (int)damageCaliculate :(int)man{
    app = [[UIApplication sharedApplication] delegate];
    
    int result = 999;
    switch (man) {
        case 0:
                    if(app.mySelectCharacter == GIKO){
                        if (app.enemySelectCharacter == GIKO) {
                            result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                        }else if (app.enemySelectCharacter == MONAR){
                            result = app.enemyCharacterFundamentalAttackPower;
                        }else if (app.enemySelectCharacter == SYOBON){
                            result = 0;
                        }else if (app.enemySelectCharacter == YARUO){
                            result = 0;
                        }
                    }else if (app.mySelectCharacter == MONAR){
                        if (app.enemySelectCharacter == GIKO) {
                            result = 0;
                        }else if (app.enemySelectCharacter == MONAR){
                            result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                        }else if (app.enemySelectCharacter == SYOBON){
                            result = app.enemyCharacterFundamentalAttackPower;
                        }else if (app.enemySelectCharacter == YARUO){
                            result = 0;
                        }
                    }else if (app.mySelectCharacter == SYOBON){
                        if (app.enemySelectCharacter == GIKO) {
                            result = app.enemyCharacterFundamentalAttackPower;
                        }else if (app.enemySelectCharacter == MONAR){
                            result = 0;
                        }else if (app.enemySelectCharacter == SYOBON){
                            result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                        }else if (app.enemySelectCharacter == YARUO){
                            result = 0;
                        }
                    }else if (app.mySelectCharacter == YARUO){
                        if (app.enemySelectCharacter == GIKO) {
                            result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                        }else if (app.enemySelectCharacter == MONAR){
                            result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                        }else if (app.enemySelectCharacter == SYOBON){
                            result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                        }else if (app.enemySelectCharacter == YARUO){
                            result = 0;
                        }
                    }
            NSLog(@"自分のライフ：%d",app.myLifeGage);
            NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
            NSLog(@"自分の防御力：%d", app.myCharacterFundamentalDeffencePower);
            NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
            NSLog(@"相手の攻撃力：%d", app.enemyCharacterFundamentalAttackPower);
            
            break;
            
        case 1:
                    if(app.enemySelectCharacter == GIKO){
                        if (app.mySelectCharacter == GIKO) {
                            result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                        }else if (app.mySelectCharacter == MONAR){
                            result = app.myCharacterFundamentalAttackPower;
                        }else if (app.mySelectCharacter == SYOBON){
                            result = 0;
                        }else if (app.mySelectCharacter == YARUO){
                            result = 0;
                        }
                    }else if (app.enemySelectCharacter == MONAR){
                        if (app.mySelectCharacter == GIKO) {
                            result = 0;
                        }else if (app.mySelectCharacter == MONAR){
                            result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                        }else if (app.mySelectCharacter == SYOBON){
                            result = app.myCharacterFundamentalAttackPower;
                        }else if (app.mySelectCharacter == YARUO){
                            result = 0;
                        }
                    }else if (app.enemySelectCharacter == SYOBON){
                        if (app.mySelectCharacter == GIKO) {
                            result = app.myCharacterFundamentalAttackPower;
                        }else if (app.mySelectCharacter == MONAR){
                            result = 0;
                        }else if (app.mySelectCharacter == SYOBON){
                            result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                        }else if (app.mySelectCharacter == YARUO){
                            result = 0;
                        }
                    }else if (app.enemySelectCharacter == YARUO){
                        if (app.mySelectCharacter == GIKO) {
                            result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                        }else if (app.mySelectCharacter == MONAR){
                            result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                        }else if (app.mySelectCharacter == SYOBON){
                            result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                        }else if (app.mySelectCharacter == YARUO){
                            result = 0;
                        }
                    }
            break;
            
            
        default:
            break;
    }
    
    
    return result;
}
@end

