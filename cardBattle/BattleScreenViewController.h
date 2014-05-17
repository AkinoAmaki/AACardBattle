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
#import "DeviceMotion.h"
#import "SVProgressHUD.h"
#import "GetEnemyDataFromServer.h"
#import "SendDataToServer.h"
#import "YSDeviceHelper.h"
#import "penetrateFilter.h"
#define GIKO 1
#define MONAR 2
#define SYOBON 3
#define YARUO 4
#define CARDWIDTH 34
#define CARDHEIGHT 51
#define BIGCARDWIDTH 100
#define BIGCARDHEIGHT 150
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
#define FINISHED1 syncFinished = YES;


@interface BattleScreenViewController : BattleCaliculate{
    int turnCount; //ターン数を管理
    int myDrawCount; //自分の引いたカード枚数を管理
    int enemyDrawCount; //相手の引いたカード枚数を管理
    int selectedCardOrder; //現在選択されているカードは、手札の左から数えて何番目かを管理する（1番目なら0が入る）
    BOOL costLife;//コストとしてライフを支払うことをOKとするか否かを管理する。
    int selectCardTag; //selectCardのメソッドが呼び出された時、呼び出し元のsender.view.tagを一時的に保存するタグ
    int mySelectCharacterInCharacterField; //カード効果により自分のキャラクターを選択する際のキャラクター
    int cardType; //選択カードがソーサリー・フィールド・エネルギーのどれかを管理
    BOOL syncFinished; //同期処理において、対象の被待機処理が完了したかを管理する
    BOOL doIUseCardInThisTurn; //このターン、自分がソーサリーカードかフィールドカードを使用したかを管理する
    BOOL cardIsCompletlyUsed; //このターン使用したいカードを全て使用しきったかを管理する
    //BOOL doEnemyDecideAction; //相手がカード使用・AAで選択フェイズを終えたかを管理する

    GetEnemyDataFromServer *getEnemyData;
    DeviceMotion *motion;
    SendDataToServer *sendMyData;
}

@property int myDrawCount;
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
    @property UILabel *myDamage;
    @property UILabel *enemyDamage;
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


//UIViewの背景を設定するビュー
@property UIImageView  *backGroundView;

//領域（自分（相手）の手札・自分（相手）の山札・自分（相手）の場カード・自分（相手）のエネルギーカード等）にあるカードを見るビュー
@property UIScrollView *cardInRegion;
@property UIImageView *regionView;
@property NSMutableArray *regionViewArray;

//特定の色を選ぶビュー
@property UIImageView *colorView;

//追加コストを表示するビュー
@property UIImageView *additionalCostView;

//ライフゲージ画像
@property UIImageView *myLifeImageView;
@property UIImageView *enemyLifeImageView;
@property UITextView *myLifeTextView;
@property UITextView *enemyLifeTextView;

//カード画像・テキスト
@property UIImageView *myCardImageView;
@property NSMutableArray *myCardImageViewArray; //自分の手札画像を収める配列
@property UIImageView *myCard;
@property UIImageView *enemyCardImageView;
@property NSMutableArray *enemyCardImageViewArray; //相手の手札画像を収める配列
@property UIImageView *enemyCard;

//キャラクターをまとめるビュー
@property UIImageView *myCharacterView;
@property UIImageView *enemyCharacterView;

//選択されたキャラクター・カードを縁取るカード画像
@property UIImageView *border_character;
@property UIImageView *border_middleCard;
@property UIImageView *border_usedCard;

//山札画像
@property UIImageView *myLibrary;
@property UITextView *myLibraryCount;
@property UIImageView *myGetCard;
@property UIImageView *enemyLibrary;
@property UITextView *enemyLibraryCount;
@property UIImageView *enemyGetCard;

//墓地画像
@property UIImageView *myTomb;
@property UIImageView *enemyTomb;

//フィールドカード画像
@property UIImageView *myField;
@property UIImageView *enemyField;

//エネルギー表示
@property UIImageView *myAllEnergy; //５色のエネルギーの画像とテキストをまとめる(自分)
@property UIImageView *myWhiteEnergyImage; //白色のエネルギーの画像(自分)
@property UIImageView *myBlueEnergyImage; //青色のエネルギーの画像(自分)
@property UIImageView *myBlackEnergyImage; //黒色のエネルギーの画像(自分)
@property UIImageView *myRedEnergyImage; //赤色のエネルギーの画像(自分)
@property UIImageView *myGreenEnergyImage; //緑色のエネルギーの画像(自分)
@property UITextView  *myWhiteEnergyText;  //白色のエネルギーの数値(自分)
@property UITextView  *myBlueEnergyText;  //青色のエネルギーの数値(自分)
@property UITextView  *myBlackEnergyText;  //黒色のエネルギーの数値(自分)
@property UITextView  *myRedEnergyText;  //赤色のエネルギーの数値(自分)
@property UITextView  *myGreenEnergyText;  //緑色のエネルギーの数値(自分)
@property UIImageView *enemyAllEnergy; //５色のエネルギーの画像とテキストをまとめる(相手)
@property UIImageView *enemyWhiteEnergyImage; //白色のエネルギーの画像(相手)
@property UIImageView *enemyBlueEnergyImage; //青色のエネルギーの画像(相手)
@property UIImageView *enemyBlackEnergyImage; //黒色のエネルギーの画像(相手)
@property UIImageView *enemyRedEnergyImage; //赤色のエネルギーの画像(相手)
@property UIImageView *enemyGreenEnergyImage; //緑色のエネルギーの画像(相手)
@property UITextView  *enemyWhiteEnergyText;  //白色のエネルギーの数値(相手)
@property UITextView  *enemyBlueEnergyText;  //青色のエネルギーの数値(相手)
@property UITextView  *enemyBlackEnergyText;  //黒色のエネルギーの数値(相手)
@property UITextView  *enemyRedEnergyText;  //赤色のエネルギーの数値(相手)
@property UITextView  *enemyGreenEnergyText;  //緑色のエネルギーの数値(相手)


//OKボタン・キャンセルボタン
@property UIButton *okButton;
@property UIImageView *cancelButton;

//キャラクターを選択するビュー
@property UIImageView *characterField;


//各種アラートビューを実装(ボタン押下時にアクションを起こす必要のあるものに限る)
@property UIAlertView *battleStart;
@property UIAlertView *putACardToLibraryTopOrBottom;
@property UIAlertView *doIUseSorcerycard;
@property UIAlertView *doIUseFieldcard;
@property UIAlertView *doIUseEnergycard;

- (IBAction)keisan:(id)sender;
- (void) transitView:(NSNotification *)note;

@end
