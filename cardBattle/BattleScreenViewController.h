//
//  BattleScreenViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DeckViewController.h"
#import "BattleCaliculate.h"
#import "DeckViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "SVProgressHUD.h"
#import "SBJson.h"
#import "GetLocation.h"
#import "SendDataToServer.h"
#import "GetEnemyDataFromServer.h"
#define GIKO 1
#define MONAR 2
#define SYOBON 3
#define YARUO 4
#define CARDWIDTH 40
#define CARDHEIGHT 60
#define WHITE 1
#define BLUE 2
#define BLACK 3
#define RED 4
#define GREEN 5
#define ENERGYCARD 1
#define FIELDCARD 2
#define SORCERYCARD 3
#define CHARACTERWIDTH 100
#define CHARACTERHEIGHT 100
#define MYSELF 0
#define ENEMY 1
#define FINISHED syncFinished = YES;


@interface BattleScreenViewController : BattleCaliculate{
    BattleCaliculate *bc;
    int turnCount; //ターン数を管理
    int drawCount; //自分の引いたカード枚数を管理
    int selectedCardOrder; //現在選択されているカードは、手札の左から数えて何番目かを管理する（1番目なら0が入る）
    int selectedCardTag; //現在選択されているカードのタグ番号を管理する。（デッキの上から１番目から1，2，3，…と続く）
    BOOL costLife;//コストとしてライフを支払うことをOKとするか否かを管理する。
    int selectCardTag; //selectCardのメソッドが呼び出された時、呼び出し元のsender.view.tagを一時的に保存するタグ
    int mySelectCharacterInCharacterField; //カード効果により自分のキャラクターを選択する際のキャラクター
    int cardType; //選択カードがソーサリー・フィールド・エネルギーのどれかを管理
    BOOL syncFinished; //同期処理において、対象の被待機処理が完了したかを管理する
    BOOL doIUseCardInThisTurn; //このターン、自分がソーサリーカードかフィールドカードを使用したかを管理する
    BOOL cardIsCompletlyUsed; //このターン使用したいカードを全て使用しきったかを管理する
    GetLocation *getlocation;
}

@property int drawCount;
@property int selectedCardOrder; //現在選択されているカードは、左から数えて何番目かを管理する（１番目なら0が入る）


//
@property BattleCaliculate *bc;

//全部を載せるビュー
@property UIImageView *allImageView;

//各タイミングでの状況を管理するビュー等
    //フェイズ名を管理するビュー
    @property UIImageView *phaseNameView;

    //ターン開始時の状況を管理するビュー
    @property UIImageView *turnStartView;

    //カード使用後の状況を管理するビュー
    @property UIImageView *afterCardUsedView;

    //ダメージ計算時の状況を管理するビュー
    @property UIImageView *damageCaliculateView;
    @property UILabel *myGiko;
    @property UILabel *myMonar;
    @property UILabel *mySyobon;
    @property UILabel *myYaruo;
    @property UILabel *enemyGiko;
    @property UILabel *enemyMonar;
    @property UILabel *enemySyobon;
    @property UILabel *enemyYaruo;

    //ターン終了時の状況を管理するビュー
    @property UIImageView *turnResultView;
    @property UIImage *turnResult;

//領域（自分（相手）の手札・自分（相手）の山札・自分（相手）の場カード・自分（相手）のエネルギーカード等）にあるカードを見るビュー
@property UIImageView *cardInRegion;

//特定の色を選ぶビュー
@property UIImageView *colorView;

//追加コストを表示するビュー
@property UIImageView *additionalCostView;

//ライフゲージ画像
@property UIImageView *myLifeImageView;
@property UIImageView *enemyLifeImageView;

//カード画像・テキスト
@property UIImageView *myCardImageView;
@property NSMutableArray *myCardImageViewArray; //自分の手札画像を収める配列
@property UIImageView *myCardImageView_middle; //左下に設置している、中くらいの大きさのカード画像
@property UITextView *myCardTextView_middle;//左下に設置している、中くらいの大きさのカードのテキスト
@property UIImageView *myCard;

//選択されたキャラクター・カードを縁取るカード画像
@property UIImageView *border_character;
@property UIImageView *border_middleCard;

//山札画像
@property UIImageView *myLibrary;
@property UITextView *myLibraryCount;
@property UIImageView *myGetCard;
@property UIImageView *enemyLibrary;
@property UITextView *enemyLibraryCount;
@property UIImageView *enemyGetCard;

//エネルギー表示
@property UIImageView *allEnergy; //５色のエネルギーの画像とテキストをまとめる
@property UIImageView *whiteEnergyImage; //白色のエネルギーの画像
@property UIImageView *blueEnergyImage; //青色のエネルギーの画像
@property UIImageView *blackEnergyImage; //黒色のエネルギーの画像
@property UIImageView *redEnergyImage; //赤色のエネルギーの画像
@property UIImageView *greenEnergyImage; //緑色のエネルギーの画像
@property UITextView  *whiteEnergyText;  //白色のエネルギーの数値
@property UITextView  *blueEnergyText;  //青色のエネルギーの数値
@property UITextView  *blackEnergyText;  //黒色のエネルギーの数値
@property UITextView  *redEnergyText;  //赤色のエネルギーの数値
@property UITextView  *greenEnergyText;  //緑色のエネルギーの数値


//OKボタン
@property UIButton *okButton;

//キャラクターを選択するビュー
@property UIImageView *characterField;


//各種アラートビューを実装(ボタン押下時にアクションを起こす必要のあるものに限る)
@property UIAlertView *putACardToLibraryTopOrBottom;
@property UIAlertView *doIUseSorcerycard;
@property UIAlertView *doIUseFieldcard;
@property UIAlertView *doIUseEnergycard;

- (IBAction)keisan:(id)sender;






@end
