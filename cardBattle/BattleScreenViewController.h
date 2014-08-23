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
#import "UIImageView+effects.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBAnimationView.h"
#import <malloc/malloc.h>
#define GIKO 1
#define MONAR 2
#define SYOBON 3
#define YARUO 4
#define CARDWIDTH 34
#define CARDHEIGHT 51
#define BIGCARDWIDTH 100
#define BIGCARDHEIGHT 150
#define ENERGYCARD 1
#define FIELDCARD 2
#define SORCERYCARD 3
#define CHARACTERWIDTH 100
#define CHARACTERHEIGHT 100
#define MYSELF 0
#define ENEMY 1
#define FINISHED1 syncFinished = YES;


@interface BattleScreenViewController : BattleCaliculate<UIScrollViewDelegate>{
    
    int cardNumber;//今選択されているカードの番号(手札タッチ時にデータが格納される)
    int turnCount; //ターン数を管理
    int myDrawCount; //自分の引いたカード枚数を管理
    int enemyDrawCount; //相手の引いたカード枚数を管理
    int selectedCardOrder; //現在選択されているカードは、手札の左から数えて何番目かを管理する（1番目なら0が入る）
    BOOL selectCardIsCanceledInCardInRegion; //browseCardsInRegionのメソッドの中で、キャンセルボタンが押されたかどうかを管理する。
    BOOL costLife;//コストとしてライフを支払うことをOKとするか否かを管理する。
    int selectCardTag; //selectCardのメソッドが呼び出された時、呼び出し元のsender.view.tagを一時的に保存するタグ
    int mySelectCharacterInCharacterField; //カード効果により自分のキャラクターを選択する際のキャラクター
    int cardType; //選択カードがソーサリー・フィールド・エネルギーのどれかを管理
    BOOL syncFinished; //同期処理において、対象の被待機処理が完了したかを管理する
    BOOL doIUseCardInThisTurn; //このターン、自分がソーサリーカードかフィールドカードを使用したかを管理する
    BOOL cardIsCompletlyUsed; //このターン使用したいカードを全て使用しきったかを管理する
    BOOL searchACardInsteadOfGetACardFromLibraryTop; //ターンの最初のドローの代わりにその他の領域からカードを引いたかを管理する（引いた場合、ターン最初のドローは無し）
    int numberOfUsingWhiteEnergy;//使用しようとしているカードに費やす白エネルギーの数
    int numberOfUsingBlueEnergy;//使用しようとしているカードに費やす青エネルギーの数
    int numberOfUsingBlackEnergy;//使用しようとしているカードに費やす黒エネルギーの数
    int numberOfUsingRedEnergy;//使用しようとしているカードに費やす赤エネルギーの数
    int numberOfUsingGreenEnergy;//使用しようとしているカードに費やす緑エネルギーの数
    UITextView *whiteNumberOfText;//使用しようとしているカードに費やす白エネルギーの数を表示するビュー
    UITextView *blueNumberOfText;//使用しようとしているカードに費やす青エネルギーの数を表示するビュー
    UITextView *blackNumberOfText;//使用しようとしているカードに費やす黒エネルギーの数を表示するビュー
    UITextView *redNumberOfText;//使用しようとしているカードに費やす赤エネルギーの数を表示するビュー
    UITextView *greenNumberOfText;//使用しようとしているカードに費やす緑エネルギーの数を表示するビュー
    
    NSMutableArray *targetedMyFieldCardInThisTurn_destroy; //このターン、自分がカードを使用し、破壊対象としたフィールドカードの一覧
    NSMutableArray *targetedMyFieldCardInThisTurn_send; //このターン、自分がカードを使用し、渡す対象としたフィールドカードの一覧
    NSMutableArray *targetedEnemyFieldCardInThisTurn_destroy; //このターン、自分がカードを使用し、破壊対象としたフィールドカードの一覧
    NSMutableArray *targetedEnemyFieldCardInThisTurn_return; //このターン、自分がカードを使用し、戻す対象としたフィールドカードの一覧
    NSMutableArray *targetedEnemyFieldCardInThisTurn_steal; //このターン、自分がカードを使用し、盗む対象としたフィールドカードの一覧
    NSMutableArray *targetedLibraryCardInThisTurn_destroy; //このターン、自分がカードを使用し、破壊対象としたライブラリのカードの一覧
    NSMutableArray *targetedMyLibraryCardInThisTurn_get; //このターン、自分がカードを使用し、取得対象としたライブラリのカードの一覧
    NSMutableArray *targetedEnemyHandCardInThisTurn_destroy; //このターン、自分がカードを使用し、破壊対象とした相手の手札のカードの一覧
    NSMutableArray *targetedMyHandCardInThisTurn_destroy; //このターン、自分がカードを使用し、破壊対象とした自分の手札のカードの一覧
    NSMutableArray *targetedMyTombCardInThisTurn_get; //このターン、自分がカードを使用し、取得対象とした墓地のカードの一覧
    NSMutableArray *targetedMyTombCardInThisTurn_return; //このターン、自分がカードを使用し、戻す対象とした墓地のカードの一覧
    UIScrollView *resultFadeinScrollView; //結果画面の表示時に使用するスクロールビュー
    
    //ボタンタップ時の効果音
    CFURLRef tapSoundURL;
    SystemSoundID tapSoundID;
    CFURLRef cancelSoundURL;
    SystemSoundID cancelSoundID;
    CFBundleRef mainBundle;
    
    //カード使用時のアニメーション
    MBAnimationView *effect1;
    MBAnimationView *effect2;
    MBAnimationView *effect3;

}

@property int myDrawCount;
@property int selectedCardOrder; //現在選択されているカードは、左から数えて何番目かを管理する（１番目なら0が入る）
@property GetEnemyDataFromServer *getEnemyData;
@property DeviceMotion *motion;
@property SendDataToServer *sendMyData;


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
@property UIImageView *imgView;
@property (nonatomic, copy)NSMutableArray *regionViewArray;

//特定の色を選ぶビュー
@property UIImageView *colorView;


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

//選択されたキャラクター・カード・色を縁取るカード画像
@property UIImageView *border_character;
@property UIImageView *border_middleCard;
@property UIImageView *border_usedCard;
@property UIImageView *border_color;

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
@property UIAlertView *battleStartView;
@property UIAlertView *putACardToLibraryTopOrBottom;
@property UIAlertView *doIUseSorcerycard;
@property UIAlertView *doIUseFieldcard;
@property UIAlertView *doIUseEnergycard;
@property UIAlertView *searchEnergyCardOrGetACard;
@property UIAlertView *loseAlert;
@property UIAlertView *winAlert;
@property UIAlertView *drawAlert;
//カードの詳細画面を見る際のイメージビュー
@property UIImageView *detailOfACard;

//カードのカットインを表示するビュー
@property UIImageView *cardUsingAnimationView;
@property UIImageView *backGround;


//BGM
@property(readwrite) CFURLRef tapSoundURL;
@property(readonly) SystemSoundID tapSoundID;
@property(readwrite) CFURLRef cancelSoundURL;
@property(readonly) SystemSoundID cancelSoundID;
@property(nonatomic,retain)AVAudioPlayer *audio;


@end
