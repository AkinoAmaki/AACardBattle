//
//  AppDelegate.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "SBJson.h"
#define ENERGYCARD 1
#define FIELDCARD 2
#define SORCERYCARD 3

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    int firstLaunch; //初めての起動なら0、以後は1
    int playerID; //プレイヤー固有のID
    NSArray *cardList_cardName;
    NSArray *cardList_pngName;
    NSMutableArray *myDeck; //デッキに入っているカードを管理する配列(配列番号＝カード番号)
    NSMutableArray *myDeckCardList; //デッキに入っているカードを管理する配列（配列数＝カード枚数）
    NSMutableArray *myCards; //持っているカード全てを管理する配列(配列番号＝カード番号)
}

@property (strong, nonatomic) UIWindow *window;


//双方に関係する変数

@property (nonatomic, retain) NSArray *cardList_cardName; //カードごとのカード名
@property (nonatomic, retain) NSArray *cardList_pngName; //カードごとの画像名（拡張子含む）
@property (nonatomic, retain) NSArray *cardList_type; //カードごとのカードタイプ
@property (nonatomic, retain) NSArray *cardList_cost; //カードごとのマナコスト
@property (nonatomic, retain) NSArray *cardList_color; //カードごとの色
@property (nonatomic, retain) NSArray *cardList_text; //カードごとの説明文
@property (nonatomic, retain) NSArray *fieldCardList_turnStart; //ターン開始時に効果を発揮するカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_afterCardUsed; //カード使用時に効果を発揮するカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_damageCaliculate; //ダメージ計算時に効果を発揮するカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_turnEnd;   //ターン終了時に効果を発揮するカード一覧


//自分に関係する変数
@property int myLifeGage; //自分のライフポイント
@property (nonatomic, retain) NSMutableArray *myDeck; //自分のデッキ
@property (nonatomic, retain) NSMutableArray *myCards; //自分の持っている全てのカード
@property (nonatomic, retain) NSMutableArray *myDeckCardList; //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
@property (nonatomic, retain) NSMutableArray *myHand; //自分の手札
@property int myGikoFundamentalAttackPower; //自分のギコの基本攻撃力
@property int myGikoFundamentalDeffencePower; //自分のギコの基本防御力
@property int myMonarFundamentalAttackPower; //自分のモナーの基本攻撃力
@property int myMonarFundamentalDeffencePower; //自分のモナーの基本防御力
@property int mySyobonFundamentalAttackPower; //自分のショボンの基本攻撃力
@property int mySyobonFundamentalDeffencePower; //自分のショボンの基本防御力
@property int myYaruoFundamentalAttackPower; //自分のやる夫の基本攻撃力
@property int myYaruoFundamentalDeffencePower; //自分のやる夫の基本防御力
@property int mySelectCharacter; //自分の選んだキャラクター
@property int myCharacterFundamentalAttackPower; //自分の選んだキャラクターの基本攻撃力
@property int myCharacterFundamentalDeffencePower; //自分の選んだキャラクターの基本防御力
@property int myGikoModifyingAttackPower; //自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myGikoModifyingDeffencePower; //自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myMonarModifyingAttackPower; //自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myMonarModifyingDeffencePower; //自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int mySyobonModifyingAttackPower; //自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int mySyobonModifyingDeffencePower; //自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myYaruoModifyingAttackPower; //自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myYaruoModifyingDeffencePower; //自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myCharacterModifyingAttackPower; //自分の選んだキャラクターの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myCharacterModifyingDeffencePower; //自分の選んだキャラクターの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
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
@property int mySelectColor; //自分が選んだ色
@property (nonatomic, retain) NSMutableArray *cardsIUsedInThisTurn; //このターン自分が使用したカード一覧

//相手に関係する変数
@property int enemyLifeGage; //相手のライフポイント
@property (nonatomic, retain) NSMutableArray *enemyDeckCardList; //相手のデッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
@property (nonatomic, retain) NSMutableArray *enemyHand; //相手の手札
@property int enemyGikoFundamentalAttackPower; // 相手のギコの基本攻撃力
@property int enemyGikoFundamentalDeffencePower; //相手のギコの基本防御力
@property int enemyMonarFundamentalAttackPower; //相手のモナーの基本攻撃力
@property int enemyMonarFundamentalDeffencePower; //相手のモナーの基本防御力
@property int enemySyobonFundamentalAttackPower; //相手のショボンの基本攻撃力
@property int enemySyobonFundamentalDeffencePower; //相手のショボンの基本防御力
@property int enemyYaruoFundamentalAttackPower; //相手のやる夫の基本攻撃力
@property int enemyYaruoFundamentalDeffencePower; //相手のやる夫の基本防御力
@property int enemySelectCharacter; //相手の選んだキャラクター
@property int enemyCharacterFundamentalAttackPower; //相手の選んだキャラクターの基本攻撃力
@property int enemyCharacterFundamentalDeffencePower; //相手の選んだキャラクターの基本防御力
@property int enemyGikoModifyingAttackPower; // 相手のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyGikoModifyingDeffencePower; //相手のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyMonarModifyingAttackPower; //相手のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyMonarModifyingDeffencePower; //相手のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemySyobonModifyingAttackPower; //相手のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemySyobonModifyingDeffencePower; //相手のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyYaruoModifyingAttackPower; //相手のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyYaruoModifyingDeffencePower; //相手のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyCharacterModifyingAttackPower; //相手の選んだキャラクターの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyCharacterModifyingDeffencePower; //相手の選んだキャラクターの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)

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
@property int enemySelectColor; //相手が選んだ色
@property (nonatomic, retain) NSMutableArray *cardsEnemyUsedInThisTurn; //このターン相手が使用したカード一覧


- (NSMutableArray *)shuffledArray :(NSMutableArray *)array;



@end
