//
//  AppDelegate.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ENERGYCARD 1
#define FIELDCARD 2
#define SORCERYCARD 3

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    int firstLaunch; //初めての起動なら0、以後は1
    
    int mySelectCharacter;
    int myLifeGage;
    int myCharacterAttackPower;
    int myCharacterDeffencePower;
    int enemySelectCharacter;
    int enemyLifeGage;
    int enemyCharacterAttackPower;
    int enemyCharacterDeffencePower;
    int numberOfMyCard;
    int numberOfEnemyCard;
    
    NSArray *cardList_cardName;
    NSMutableArray *cardList_png;
    NSArray *cardList_pngName;
    NSMutableArray *myDeck; //デッキに入っているカードを管理する配列(配列番号＝カード番号)
    NSMutableArray *myDeckCardList; //デッキに入っているカードを管理する配列（配列数＝カード枚数）
    NSMutableArray *myCards; //持っているカード全てを管理する配列(配列番号＝カード番号)
}

@property (strong, nonatomic) UIWindow *window;
@property int myLifeGage;

@property int enemyLifeGage;

@property int numberOfMyCard;
@property int numberOfEnemyCard;



//双方に関係する変数

@property (nonatomic, retain) NSArray *cardList_cardName;
@property (nonatomic, retain) NSMutableArray *cardList_png;
@property (nonatomic, retain) NSArray *cardList_pngName;
@property (nonatomic, retain) NSArray *cardList_type; //カードごとのカードタイプ
@property (nonatomic, retain) NSArray *cardList_timing; //カードごとの発動タイミング
@property (nonatomic, retain) NSArray *cardList_cost; //カードごとのマナコスト
@property (nonatomic, retain) NSArray *cardList_color; //カードごとの色
@property (nonatomic, retain) NSArray *cardList_text; //カードごとの説明文


//自分に関係する変数
@property (nonatomic, retain) NSMutableArray *myDeck; //自分のデッキ
@property (nonatomic, retain) NSMutableArray *myCards; //自分の持っている全てのカード
@property (nonatomic, retain) NSMutableArray *myDeckCardList; //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
@property (nonatomic, retain) NSMutableArray *myHand; //自分の手札
@property int myGikoAttackPower; //自分のギコの攻撃力
@property int myGikoDeffencePower; //自分のギコの防御力
@property int myMonarAttackPower; //自分のモナーの攻撃力
@property int myMonarDeffencePower; //自分のモナーの防御力
@property int mySyobonAttackPower; //自分のショボンの攻撃力
@property int mySyobonDeffencePower; //自分のショボンの防御力
@property int myYaruoAttackPower; //自分のやる夫の攻撃力
@property int myYaruoDeffencePower; //自分のやる夫の防御力
@property int mySelectCharacter; //自分の選んだキャラクター
@property int myCharacterAttackPower; //自分の選んだキャラクターの攻撃力
@property int myCharacterDeffencePower; //自分の選んだキャラクターの防御力
@property BOOL myGikoAttackPermitted; //自分のギコの攻撃許可
@property BOOL myGikoDeffencePermitted; //自分のギコの防御許可
@property BOOL myMonarAttackPermitted; //自分のモナーの攻撃許可
@property BOOL myMonarDeffencePermitted; //自分のモナーの防御許可
@property BOOL mySyobonAttackPermitted; //自分のショボンの攻撃許可
@property BOOL mySyobonDeffencePermitted; //自分のショボンの防御許可
@property BOOL myYaruoAttackPermitted; //自分のやる夫の攻撃許可
@property BOOL myYaruoDeffencePermitted; //自分のやる夫の防御許可
@property (nonatomic, retain) NSMutableArray *myTomb; //自分の墓地のカードナンバー
@property BOOL doIUseCard; //自分がこのターンカードを使用したか
@property int myUsingCardNumber; //自分が使用したカードの番号
@property (nonatomic, retain) NSMutableArray *myFieldCard; //自分の場カードのカードナンバー
@property (nonatomic, retain) NSMutableArray *myEnergyCard; //自分のエネルギーカードの数
@property BOOL canIPlaySorceryCard; //自分が魔法カードを手札からプレイできるか
@property BOOL canIPlayFieldCard; //自分が場カードを手札からプレイできるか
@property BOOL canIActivateFieldCard; //自分が場カードの能力を起動できるか
@property BOOL canIPlayEnergyCard; //自分がエネルギーカードを手札からプレイできるか
@property BOOL canIActivateEnergyCard; //自分がエネルギーカードを起動できるか
@property BOOL denymyCardPlaying; //自分がカードのプレイを打ち消されたか
@property int myDamage; //このターン自分に与えられるダメージ



//相手に関係する変数
@property (nonatomic, retain) NSMutableArray *enemyDeckCardList; //相手のデッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
@property (nonatomic, retain) NSMutableArray *enemyHand; //相手の手札
@property int enemyGikoAttackPower; // 相手のギコの攻撃力
@property int enemyGikoDeffencePower; //相手のギコの防御力
@property int enemyMonarAttackPower; //相手のモナーの攻撃力
@property int enemyMonarDeffencePower; //相手のモナーの防御力
@property int enemySyobonAttackPower; //相手のショボンの攻撃力
@property int enemySyobonDeffencePower; //相手のショボンの防御力
@property int enemyYaruoAttackPower; //相手のやる夫の攻撃力
@property int enemyYaruoDeffencePower; //相手のやる夫の防御力
@property int enemySelectCharacter; //相手の選んだキャラクター
@property int enemyCharacterAttackPower; //相手の選んだキャラクターの攻撃力
@property int enemyCharacterDeffencePower; //相手の選んだキャラクターの防御力
@property BOOL enemyGikoAttackPermitted; //相手のギコの攻撃許可
@property BOOL enemyGikoDeffencePermitted; //相手のギコの防御許可
@property BOOL enemyMonarAttackPermitted; //相手のモナーの攻撃許可
@property BOOL enemyMonarDeffencePermitted; //相手のモナーの防御許可
@property BOOL enemySyobonAttackPermitted; //相手のショボンの攻撃許可
@property BOOL enemySyobonDeffencePermitted; //相手のショボンの防御許可
@property BOOL enemyYaruoAttackPermitted; //相手のやる夫の攻撃許可
@property BOOL enemyYaruoDeffencePermitted; //相手のやる夫の防御許可
@property (nonatomic, retain) NSMutableArray *enemyTomb; //相手の墓地のカードナンバー
@property BOOL doEnemyUseCard; //相手がこのターンカードを使用したか
@property int enemyUsingCardNumber; //相手が使用したカードの番号
@property (nonatomic, retain) NSMutableArray *enemyFieldCard; //相手の場カードのカードナンバー
@property (nonatomic, retain) NSMutableArray *enemyEnergyCard; //相手のエネルギーカードの数
@property BOOL canEnemyPlaySorceryCard; //相手が魔法カードを手札からプレイできるか
@property BOOL canEnemyPlayFieldCard; //相手が場カードを手札からプレイできるか
@property BOOL canEnemyActivateFieldCard; //相手が場カードの能力を起動できるか
@property BOOL canEnemyPlayEnergyCard; //相手がエネルギーカードを手札からプレイできるか
@property BOOL canEnemyActivateEnergyCard; //相手がエネルギーカードを起動できるか
@property BOOL denyEnemyCardPlaying; //相手がカードのプレイを打ち消されたか
@property int enemyDamage; //このターン相手に与えられるダメージ


- (NSMutableArray *)shuffledArray :(NSMutableArray *)array;

@end
