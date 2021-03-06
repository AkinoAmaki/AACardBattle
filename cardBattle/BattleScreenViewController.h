//
//  BattleScreenViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

//#import "ViewController.h"
#import "FirstViewController.h"
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
#import "CourseSelectViewController.h"
#import "PBImageView.h"
#import "AAButton.h"
#import "SocialMediaViewController.h"
#import "UILabel+kylib.h"
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


@interface BattleScreenViewController : BattleCaliculate<UIScrollViewDelegate,deviceMotionDelegate>{
    
    CourseSelectViewController *course;
    NSNotificationCenter *battleStartNotification;
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
    BOOL gameOverPhaseIsSkipped; //ゲームオーバーステップが終了したか否かの判定を行う
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
    
    //カード使用時のアニメーション
    MBAnimationView *effect1;
    MBAnimationView *effect2;
    MBAnimationView *effect3;
    MBAnimationView *effect4;
    
    //選択までの残り時間を表示する
    NSTimer *timer; //0.1秒ごとに制限時間更新のメソッドを実行させるためのNSTimer
    int seigenTime; //制限時間
    int seigenTimeMin; //制限時間のうち、「分」部分
    int seigenTimeSec; //制限時間のうち、「秒」部分
    UILabel *nokoriTime;

    
    /******初回起動用に用意した変数******/
    int first; //初回起動か否かを判定する。（0なら初回起動）
    BOOL turn5Boti; //5ターン目において、墓地の参照をキャンセルした瞬間にYESになる
    BOOL turn5Ba; //5ターン目において、フィールドの参照をキャンセルした瞬間にYESになる
    /******初回起動用に用意した変数******/
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

    //互いのキャラクターの相性を表示するビュー
    @property UIImageView *kekkaView;
    @property UIImageView *myCharacter;
    @property UIImageView *enemyCharacter;

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


//互いの名前を出すビュー
@property UILabel *myNickNameLabel;
@property UILabel *enemyNickNameLabel;

//キャラクタービュー
@property UIImageView *migiYajirushi;
@property UIImageView *hidariYajirushi;
@property UIImageView *chara_myGiko;
@property UIImageView *chara_myMonar;
@property UIImageView *chara_mySyobon;
@property UIImageView *chara_myYaruo;
@property UIImageView *chara_enemyGiko;
@property UIImageView *chara_enemyMonar;
@property UIImageView *chara_enemySyobon;
@property UIImageView *chara_enemyYaruo;
@property UIImageView *chara_hatena; //相手がキャラを選択するまえのハテナ画像

//ライフゲージ画像ビュー
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

//投了ボタン画像
@property UIImageView *goodGame;

//エネルギー表示
@property UIImageView *myAllEnergy; //５色のエネルギーの画像とテキストをまとめる(自分)
@property UIImageView *myWhiteEnergyImage; //白色のエネルギーの画像(自分)
@property UIImageView *myBlueEnergyImage; //青色のエネルギーの画像(自分)
@property UIImageView *myBlackEnergyImage; //黒色のエネルギーの画像(自分)
@property UIImageView *myRedEnergyImage; //赤色のエネルギーの画像(自分)
@property UIImageView *myGreenEnergyImage; //緑色のエネルギーの画像(自分)
@property UITextView  *myWhiteEnergyText;  //保有している白色のエネルギーの数値(自分)
@property UITextView  *myBlueEnergyText;  //保有している青色のエネルギーの数値(自分)
@property UITextView  *myBlackEnergyText;  //保有している黒色のエネルギーの数値(自分)
@property UITextView  *myRedEnergyText;  //保有している赤色のエネルギーの数値(自分)
@property UITextView  *myGreenEnergyText;  //保有している緑色のエネルギーの数値(自分)
@property UITextView  *myUsingWhiteEnergyText;  //このターン使用している白色のエネルギーの数値(自分)
@property UITextView  *myUsingBlueEnergyText;  //このターン使用している青色のエネルギーの数値(自分)
@property UITextView  *myUsingBlackEnergyText;  //このターン使用している黒色のエネルギーの数値(自分)
@property UITextView  *myUsingRedEnergyText;  //このターン使用している赤色のエネルギーの数値(自分)
@property UITextView  *myUsingGreenEnergyText;  //このターン使用している緑色のエネルギーの数値(自分)
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

//メインビューに戻るボタン
@property UIButton *returnToMainViewButton;

//ローカル対戦用開始ボタン
@property AAButton *localBattleButton;

//インターネット対戦開始ボタン
@property AAButton *internetBattleButton;

//対戦開始前の黒半透明の背景ビュー
@property UIImageView *blackBack;

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
@property UIAlertView *usingDeckCardListForInternetBattle;
@property UIAlertView *usingDeckCardListForLocalBattle;
@property UIAlertView *goodGameAlert;
//カードの詳細画面を見る際のイメージビュー
@property UIImageView *detailOfACard;

//カードのカットインを表示するビュー
@property(nonatomic) UIImageView *cardUsingAnimationView;
@property(nonatomic) UIImageView *backGround;

//各種SE
@property(readwrite) CFURLRef aisyouSyakinURL;      //相性判定画面のシャキーン
@property(readonly) SystemSoundID aisyouSyakinID;   //相性判定画面のシャキーン
@property(readwrite) CFURLRef aisyouDonURL;         //相性判定画面のドン
@property(readonly) SystemSoundID aisyouDonID;      //相性判定画面のドン
@property(readwrite) CFURLRef aisyouKatiURL;        //相性判定画面の勝ち時のSE
@property(readonly) SystemSoundID aisyouKatiID;     //相性判定画面の勝ち時のSE
@property(readwrite) CFURLRef aisyouMakeURL;        //相性判定画面の負け時のSE
@property(readonly) SystemSoundID aisyouMakeID;     //相性判定画面の負け時のSE
@property(readwrite) CFURLRef aisyouHikiwakeURL;    //相性判定画面の引き分け時のSE
@property(readonly) SystemSoundID aisyouHikiwakeID; //相性判定画面の引き分け時のSE
@property(readwrite) CFURLRef kekkaKatiURL;         //対戦結果が勝ちの時のSE
@property(readonly) SystemSoundID kekkaKatiID;      //対戦結果が勝ちの時のSE
@property(readwrite) CFURLRef kekkaMakeURL;         //対戦結果が負けの時のSE
@property(readonly) SystemSoundID kekkaMakeID;      //対戦結果が負けの時のSE
@property(readwrite) CFURLRef cardGetURL;           //カードゲット時のSE
@property(readonly) SystemSoundID cardGetID;        //カードゲット時のSE

//対戦開始メソッド
- (void)battleStart;

@end
