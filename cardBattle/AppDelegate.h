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
#define WHITE 1
#define BLUE 2
#define BLACK 3
#define RED 4
#define GREEN 5

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    int firstLaunch; //初めての起動なら0、以後は1
    NSArray *cardList_cardName;
    NSArray *cardList_pngName;
    NSMutableArray *myDeck; //デッキに入っているカードを管理する配列(配列番号＝カード番号)
    NSMutableArray *myDeckCardList; //デッキに入っているカードを管理する配列（配列数＝カード枚数）
    NSMutableArray *myCards; //持っているカード全てを管理する配列(配列番号＝カード番号)
    NSUserDefaults *ud;
}

@property (strong, nonatomic) UIWindow *window;


//双方に関係する変数及び基礎的な変数
@property int playerID; //プレイヤー固有のID
@property int enemyPlayerID; //相手プレイヤーのID
@property NSString *myNickName; //プレイヤーのニックネーム
@property NSString *enemyNickName; //相手プレイヤーのニックネーム
@property (nonatomic, retain) NSArray *cardList_cardName; //カードごとのカード名
@property (nonatomic, retain) NSArray *cardList_pngName; //カードごとの画像名（拡張子含む）
@property (nonatomic, retain) NSArray *cardList_type; //カードごとのカードタイプ
@property (nonatomic, retain) NSArray *cardList_cost; //カードごとのマナコスト
@property (nonatomic, retain) NSArray *cardList_color; //カードごとの色
@property (nonatomic, retain) NSArray *cardList_text; //カードごとの説明文
@property (nonatomic, retain) NSArray *cardList_rarelity; //カードごとのレアリティ
@property (nonatomic, retain) NSArray *sorceryCardList; //ソーサリーカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_turnStart; //ターン開始時に効果を発揮するカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_afterCardUsed; //カード使用時に効果を発揮するカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_damageCaliculate; //ダメージ計算時に効果を発揮するカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_turnEnd;   //ターン終了時に効果を発揮するカード一覧
@property (nonatomic, retain) NSArray *fieldCardList_other; //他のカード効果の発動を待ってから発動するカード一覧
@property (nonatomic, retain) NSArray *damageSourceOfWhite; //白色のカードのうち、戦闘時に直接ダメージを与えるカード一覧（戦闘時以外に与えるものは除く！）
@property (nonatomic, retain) NSArray *damageSourceOfBlue; //青色のカードのうち、戦闘時に直接ダメージを与えるカード一覧（戦闘時以外に与えるものは除く！）
@property (nonatomic, retain) NSArray *damageSourceOfBlack; //黒色のカードのうち、戦闘時に直接ダメージを与えるカード一覧（戦闘時以外に与えるものは除く！）
@property (nonatomic, retain) NSArray *damageSourceOfRed; //赤色のカードのうち、戦闘時に直接ダメージを与えるカード一覧（戦闘時以外に与えるものは除く！）
@property (nonatomic, retain) NSArray *damageSourceOfGreen; //緑色のカードのうち、戦闘時に直接ダメージを与えるカード一覧（戦闘時以外に与えるものは除く！）
@property BOOL decideAction; //自分がカードとAAをを選択し終えるとYESとなり、ターン終了時にNOに戻る

//自分に関係する変数
@property NSMutableArray *myUsingEnergy; //自分がこのターン使用したエネルギーの量
@property int myLifeGage; //自分のライフポイント
@property int myLifeGageByMyself; //自分のライフポイントを自分で操作する場合の値(差分のみ管理)
@property int myAdditionalGettingCards; //ターンの開始時に引くカード以外で引いた、ターン毎のカードの枚数を管理する
@property int myAdditionalDiscardingCards; //ターンの終了時に捨てるカード以外で捨てた、ターン毎のカードの枚数を管理する
@property (nonatomic, retain) NSMutableArray *myDeck; //自分のデッキ
@property (nonatomic, retain) NSMutableArray *myCards; //自分の持っている全てのカード
@property (nonatomic, retain) NSMutableArray *myDeckCardList; //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
@property (nonatomic, retain) NSMutableArray *myHand; //自分の手札
@property (nonatomic, retain) NSMutableArray *myTomb; //自分の墓地のカードナンバー
@property (nonatomic, retain) NSMutableArray *myFieldCard; //自分の場カードのカードナンバー
@property (nonatomic, retain) NSMutableArray *myEnergyCard; //自分のエネルギーカードの数
/***/@property (nonatomic, retain) NSMutableArray *myDeckCardListByMyself_plus; // 自分が操作し、増加したmyDeckCardList（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myHandByMyself_plus; // 自分が操作し、増加したmyHand（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myTombByMyself_plus; // 自分が操作し、増加したmyTomb（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myFieldCardByMyself_plus; // 自分が操作し、増加したmyFieldCard（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myEnergyCardByMyself_plus; // 自分が操作し、増加したmyEnergyCard（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myDeckCardListByMyself_minus; // 自分が操作し、減少したmyDeckCardList（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myHandByMyself_minus; // 自分が操作し、減少したmyHand（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myTombByMyself_minus; // 自分が操作し、減少したmyTomb（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myFieldCardByMyself_minus; // 自分が操作し、減少したmyFieldCard（差分のみ管理）
/***/@property (nonatomic, retain) NSMutableArray *myEnergyCardByMyself_minus; // 自分が操作し、減少したmyEnergyCard（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myDeckCardListFromEnemy_plus; // 相手が操作し、増加したmyDeckCardList（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myHandFromEnemy_plus; // 相手が操作し、増加したmyHand（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myTombFromEnemy_plus; // 相手が操作し、増加したmyTomb（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myFieldCardFromEnemy_plus; // 相手が操作し、増加したmyFieldCard（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myEnergyCardFromEnemy_plus; // 相手が操作し、増加したmyEnergyCard（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myDeckCardListFromEnemy_minus; // 相手が操作し、減少したmyDeckCardList（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myHandFromEnemy_minus; // 相手が操作し、減少したmyHand（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myTombFromEnemy_minus; // 相手が操作し、減少したmyTomb（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myFieldCardFromEnemy_minus; // 相手が操作し、減少したmyFieldCard（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *myEnergyCardFromEnemy_minus; // 相手が操作し、減少したmyEnergyCard（差分のみ管理）
@property int myGikoFundamentalAttackPower; //自分のギコの基本攻撃力
@property int myGikoFundamentalDeffencePower; //自分のギコの基本防御力
@property int myMonarFundamentalAttackPower; //自分のモナーの基本攻撃力
@property int myMonarFundamentalDeffencePower; //自分のモナーの基本防御力
@property int mySyobonFundamentalAttackPower; //自分のショボンの基本攻撃力
@property int mySyobonFundamentalDeffencePower; //自分のショボンの基本防御力
@property int myYaruoFundamentalAttackPower; //自分のやる夫の基本攻撃力
@property int myYaruoFundamentalDeffencePower; //自分のやる夫の基本防御力
@property int myGikoFundamentalAttackPowerByMyself; //自分が操作した自分のギコの基本攻撃力（差分のみ管理）
@property int myGikoFundamentalDeffencePowerByMyself; //自分が操作した自分のギコの基本防御力（差分のみ管理）
@property int myMonarFundamentalAttackPowerByMyself; //自分が操作した自分のモナーの基本攻撃力（差分のみ管理）
@property int myMonarFundamentalDeffencePowerByMyself; //自分が操作した自分のモナーの基本防御力（差分のみ管理）
@property int mySyobonFundamentalAttackPowerByMyself; //自分が操作した自分のショボンの基本攻撃力（差分のみ管理）
@property int mySyobonFundamentalDeffencePowerByMyself; //自分が操作した自分のショボンの基本防御力（差分のみ管理）
@property int myYaruoFundamentalAttackPowerByMyself; //自分が操作した自分のやる夫の基本攻撃力（差分のみ管理）
@property int myYaruoFundamentalDeffencePowerByMyself; //自分が操作した自分のやる夫の基本防御力（差分のみ管理）
@property int myGikoFundamentalAttackPowerFromEnemy; //相手が操作した自分のギコの基本攻撃力（差分のみ管理）
@property int myGikoFundamentalDeffencePowerFromEnemy; //相手が操作した自分のギコの基本防御力（差分のみ管理）
@property int myMonarFundamentalAttackPowerFromEnemy; //相手が操作した自分のモナーの基本攻撃力（差分のみ管理）
@property int myMonarFundamentalDeffencePowerFromEnemy; //相手が操作した自分のモナーの基本防御力（差分のみ管理）
@property int mySyobonFundamentalAttackPowerFromEnemy; //相手が操作した自分のショボンの基本攻撃力（差分のみ管理）
@property int mySyobonFundamentalDeffencePowerFromEnemy; //相手が操作した自分のショボンの基本防御力（差分のみ管理）
@property int myYaruoFundamentalAttackPowerFromEnemy; //相手が操作した自分のやる夫の基本攻撃力（差分のみ管理）
@property int myYaruoFundamentalDeffencePowerFromEnemy; //相手が操作した自分のやる夫の基本防御力（差分のみ管理）
@property int mySelectCharacter; //自分の選んだキャラクター
@property int mySelectCharacterFromEnemy; //相手に操作された自分のキャラクター
@property int myGikoModifyingAttackPower; //自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myGikoModifyingDeffencePower; //自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myMonarModifyingAttackPower; //自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myMonarModifyingDeffencePower; //自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int mySyobonModifyingAttackPower; //自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int mySyobonModifyingDeffencePower; //自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myYaruoModifyingAttackPower; //自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myYaruoModifyingDeffencePower; //自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int myGikoModifyingAttackPowerByMyself; //自分が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myGikoModifyingDeffencePowerByMyself; //自分が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myMonarModifyingAttackPowerByMyself; //自分が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myMonarModifyingDeffencePowerByMyself; //自分が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int mySyobonModifyingAttackPowerByMyself; //自分が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int mySyobonModifyingDeffencePowerByMyself; //自分が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myYaruoModifyingAttackPowerByMyself; //自分が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myYaruoModifyingDeffencePowerByMyself; //自分が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myGikoModifyingAttackPowerFromEnemy; //相手が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myGikoModifyingDeffencePowerFromEnemy; //相手が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myMonarModifyingAttackPowerFromEnemy; //相手が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myMonarModifyingDeffencePowerFromEnemy; //相手が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int mySyobonModifyingAttackPowerFromEnemy; //相手が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int mySyobonModifyingDeffencePowerFromEnemy; //相手が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myYaruoModifyingAttackPowerFromEnemy; //相手が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property int myYaruoModifyingDeffencePowerFromEnemy; //相手が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
@property BOOL myGikoAttackPermittedByMyself; //自分の制限による自分のギコの攻撃許可
@property BOOL myGikoDeffencePermittedByMyself; //自分の制限による自分のギコの防御許可
@property BOOL myMonarAttackPermittedByMyself; //自分の制限による自分のモナーの攻撃許可
@property BOOL myMonarDeffencePermittedByMyself; //自分の制限による自分のモナーの防御許可
@property BOOL mySyobonAttackPermittedByMyself; //自分の制限による自分のショボンの攻撃許可
@property BOOL mySyobonDeffencePermittedByMyself; //自分の制限による自分のショボンの防御許可
@property BOOL myYaruoAttackPermittedByMyself; //自分の制限による自分のやる夫の攻撃許可
@property BOOL myYaruoDeffencePermittedByMyself; //自分の制限による自分のやる夫の防御許可
@property BOOL myGikoAttackPermittedFromEnemy; //相手の妨害による自分のギコの攻撃許可
@property BOOL myGikoDeffencePermittedFromEnemy; //相手の制限による自分のギコの防御許可
@property BOOL myMonarAttackPermittedFromEnemy; //相手の制限による自分のモナーの攻撃許可
@property BOOL myMonarDeffencePermittedFromEnemy; //相手の制限による自分のモナーの防御許可
@property BOOL mySyobonAttackPermittedFromEnemy; //相手の制限による自分のショボンの攻撃許可
@property BOOL mySyobonDeffencePermittedFromEnemy; //相手の制限による自分のショボンの防御許可
@property BOOL myYaruoAttackPermittedFromEnemy; //相手の制限による自分のやる夫の攻撃許可
@property BOOL myYaruoDeffencePermittedFromEnemy; //相手の制限による自分のやる夫の防御許可
@property BOOL doIUseCard; //自分がこのターンカードを使用したか
@property int myUsingCardNumber; //自分が現在手札から選択しているカードの番号
@property BOOL denymyCardPlaying; //自分がカードのプレイを打ち消されたか
@property int myDamageFromAA; //このターンAAから自分に与えられるダメージ
@property int myDamageFromCard; //このターン相手の使用したカードから自分に与えられるダメージ
@property int mySelectColor; //自分が選んだ色
@property (nonatomic, retain) NSMutableArray *cardsIUsedInThisTurn; //このターン自分が使用したカード一覧

//相手に関係する変数
@property int enemyLifeGage; //相手のライフポイント
@property (nonatomic, retain) NSMutableArray *enemyDeckCardList; //相手のデッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
@property (nonatomic, retain) NSMutableArray *enemyHand; //相手の手札
@property (nonatomic, retain) NSMutableArray *enemyTomb; //相手の墓地のカードナンバー
@property (nonatomic, retain) NSMutableArray *enemyFieldCard; //相手の場カードのカードナンバー
@property (nonatomic, retain) NSMutableArray *enemyEnergyCard; //相手のエネルギーカードの数
@property (nonatomic, retain) NSMutableArray *enemyDeckCardListByMyself_plus; // 自分が操作し、増加したmyDeckCardList（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyHandByMyself_plus; // 自分が操作し、増加したmyHand（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyTombByMyself_plus; // 自分が操作し、増加したmyTomb（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyFieldCardByMyself_plus; // 自分が操作し、増加したmyFieldCard（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyEnergyCardByMyself_plus; // 自分が操作し、増加したmyEnergyCard（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyDeckCardListByMyself_minus; // 自分が操作し、減少したmyDeckCardList（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyHandByMyself_minus; // 自分が操作し、減少したmyHand（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyTombByMyself_minus; // 自分が操作し、減少したmyTomb（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyFieldCardByMyself_minus; // 自分が操作し、減少したmyFieldCard（差分のみ管理）
@property (nonatomic, retain) NSMutableArray *enemyEnergyCardByMyself_minus; // 自分が操作し、減少したmyEnergyCard（差分のみ管理）
@property int enemyGikoFundamentalAttackPower; // 相手のギコの基本攻撃力
@property int enemyGikoFundamentalDeffencePower; //相手のギコの基本防御力
@property int enemyMonarFundamentalAttackPower; //相手のモナーの基本攻撃力
@property int enemyMonarFundamentalDeffencePower; //相手のモナーの基本防御力
@property int enemySyobonFundamentalAttackPower; //相手のショボンの基本攻撃力
@property int enemySyobonFundamentalDeffencePower; //相手のショボンの基本防御力
@property int enemyYaruoFundamentalAttackPower; //相手のやる夫の基本攻撃力
@property int enemyYaruoFundamentalDeffencePower; //相手のやる夫の基本防御力
@property int enemyGikoFundamentalAttackPowerByMyself; // 自分が操作した相手のギコの基本攻撃力（差分のみ管理）
@property int enemyGikoFundamentalDeffencePowerByMyself; //自分が操作した相手のギコの基本防御力（差分のみ管理）
@property int enemyMonarFundamentalAttackPowerByMyself; //自分が操作した相手のモナーの基本攻撃力（差分のみ管理）
@property int enemyMonarFundamentalDeffencePowerByMyself; //自分が操作した相手のモナーの基本防御力（差分のみ管理）
@property int enemySyobonFundamentalAttackPowerByMyself; //自分が操作した相手のショボンの基本攻撃力（差分のみ管理）
@property int enemySyobonFundamentalDeffencePowerByMyself; //相自分が操作した手のショボンの基本防御力（差分のみ管理）
@property int enemyYaruoFundamentalAttackPowerByMyself; //自分が操作した相手のやる夫の基本攻撃力（差分のみ管理）
@property int enemyYaruoFundamentalDeffencePowerByMyself; //自分が操作した相手のやる夫の基本防御力（差分のみ管理）
@property int enemySelectCharacter; //相手の選んだキャラクター
@property int enemySelectCharacterByMyself; //自分が操作した相手キャラクター
@property int enemyGikoModifyingAttackPower; // 相手のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyGikoModifyingDeffencePower; //相手のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyMonarModifyingAttackPower; //相手のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyMonarModifyingDeffencePower; //相手のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemySyobonModifyingAttackPower; //相手のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemySyobonModifyingDeffencePower; //相手のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyYaruoModifyingAttackPower; //相手のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyYaruoModifyingDeffencePower; //相手のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
@property int enemyGikoModifyingAttackPowerByMyself; // 自分が操作した相手のギコの修正攻撃力（差分のみ管理）
@property int enemyGikoModifyingDeffencePowerByMyself; //自分が操作した相手のギコの修正防御力（差分のみ管理）
@property int enemyMonarModifyingAttackPowerByMyself; //自分が操作した相手のモナーの修正攻撃力（差分のみ管理）
@property int enemyMonarModifyingDeffencePowerByMyself; //自分が操作した相手のモナーの修正防御力（差分のみ管理）
@property int enemySyobonModifyingAttackPowerByMyself; //自分が操作した相手のショボンの修正攻撃力（差分のみ管理）
@property int enemySyobonModifyingDeffencePowerByMyself; //自分が操作した相手のショボンの修正防御力（差分のみ管理）
@property int enemyYaruoModifyingAttackPowerByMyself; //自分が操作した相手のやる夫の修正攻撃力（差分のみ管理）
@property int enemyYaruoModifyingDeffencePowerByMyself; //自分が操作した相手のやる夫の修正防御力（差分のみ管理）
@property BOOL enemyGikoAttackPermittedByMyself; //自分の制限による相手のギコの攻撃許可
@property BOOL enemyGikoDeffencePermittedByMyself; //自分の制限による相手のギコの防御許可
@property BOOL enemyMonarAttackPermittedByMyself; //自分の制限による相手のモナーの攻撃許可
@property BOOL enemyMonarDeffencePermittedByMyself; //自分の制限による相手のモナーの防御許可
@property BOOL enemySyobonAttackPermittedByMyself; //自分の制限による相手のショボンの攻撃許可
@property BOOL enemySyobonDeffencePermittedByMyself; //自分の制限による相手のショボンの防御許可
@property BOOL enemyYaruoAttackPermittedByMyself; //自分の制限による相手のやる夫の攻撃許可
@property BOOL enemyYaruoDeffencePermittedByMyself; //自分の制限による手のやる夫の防御許可
@property BOOL enemyGikoAttackPermittedFromEnemy; //相手の制限による相手のギコの攻撃許可
@property BOOL enemyGikoDeffencePermittedFromEnemy; //相手の制限による相手のギコの防御許可
@property BOOL enemyMonarAttackPermittedFromEnemy; //相手の制限による相手のモナーの攻撃許可
@property BOOL enemyMonarDeffencePermittedFromEnemy; //相手の制限による相手のモナーの防御許可
@property BOOL enemySyobonAttackPermittedFromEnemy; //相手の制限による相手のショボンの攻撃許可
@property BOOL enemySyobonDeffencePermittedFromEnemy; //相手の制限による相手のショボンの防御許可
@property BOOL enemyYaruoAttackPermittedFromEnemy; //相手の制限による相手のやる夫の攻撃許可
@property BOOL enemyYaruoDeffencePermittedFromEnemy; //相手の制限による手のやる夫の防御許可
@property BOOL doEnemyUseCard; //相手がこのターンカードを使用したか
@property int enemyUsingCardNumber; //相手が使用したカードの番号
@property BOOL canEnemyPlaySorceryCardByMyself; //自分の制限により相手が魔法カードを手札からプレイできるか
@property BOOL canEnemyPlayFieldCardByMyself; //自分の制限により相手が場カードを手札からプレイできるか
@property BOOL canEnemyActivateFieldCardByMyself; //自分の制限により相手が場カードの能力を起動できるか
@property BOOL canEnemyPlayEnergyCardByMyself; //自分の制限により相手がエネルギーカードを手札からプレイできるか
@property BOOL canEnemyActivateEnergyCardByMyself; //自分の制限により相手がエネルギーカードを起動できるか
@property BOOL canEnemyPlaySorceryCardFromEnemy; //相手の制限により相手が魔法カードを手札からプレイできるか
@property BOOL canEnemyPlayFieldCardFromEnemy; //相手の制限により相手が場カードを手札からプレイできるか
@property BOOL canEnemyActivateFieldCardFromEnemy; //相手の制限により相手が場カードの能力を起動できるか
@property BOOL canEnemyPlayEnergyCardFromEnemy; //相手の制限により相手がエネルギーカードを手札からプレイできるか
@property BOOL canEnemyActivateEnergyCardFromEnemy; //相手の制限により相手がエネルギーカードを起動できるか
@property BOOL denyEnemyCardPlaying; //相手がカードのプレイを打ち消されたか
@property int enemyDamageFromAA; //このターンAAから相手に与えられるダメージ
@property int enemyDamageFromCard; //このターン自分の使用したカードから自分に与えられるダメージ
@property int enemySelectColor; //相手が選んだ色
@property (nonatomic, retain) NSMutableArray *cardsEnemyUsedInThisTurn; //このターン相手が使用したカード一覧


+ (NSMutableArray *)shuffledArray :(NSMutableArray *)array;




@end
