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



@interface BattleScreenViewController : BattleCaliculate{
    BattleCaliculate *bc;
    int drawCount; //自分の引いたカード枚数を管理
    int selectedCardOrder; //現在選択されているカードは、左から数えて何番目かを管理する（１番目なら0が入る）
    int selectedCardNum; //現在選択されているカードのカード番号を管理する
    int selectedCardTag; //現在選択されているカードのタグ番号を管理する。（デッキの上から１番目から１，２，３，…と続く）
    BOOL costLife;//コストとしてライフを支払うことをOKとするか否かを管理する。
    int selectCardTag; //selectCardのメソッドが呼び出された時、呼び出し元のsender.view.tagを一時的に保存するタグ
    int mySelectColor; //特定の色を選ぶ際、自分がどの色を選んだかを管理する。
    int enemySelectColor; //特定の色を選ぶ際、相手がどの色を選んだかを管理する。

}

@property int drawCount;
@property int selectedCardOrder; //現在選択されているカードは、左から数えて何番目かを管理する（１番目なら0が入る）
@property int selectedCardNum; //現在選択されているカードのカード番号を管理する


//
@property BattleCaliculate *bc;

//全部を載せるビュー
@property UIImageView *allImageView;


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

//選択されたカードを縁取るカード画像
@property UIImageView *border_middleCard;

//山札画像
@property UIImageView *myLibrary;
@property UITextView *myLibraryCount;
@property UIImageView *myGetCard;
@property UIImageView *enemyLibrary;
@property UITextView *enemyLibraryCount;
@property UIImageView *enemyGetCard;

//キャラクターを選択するビュー
@property UIImageView *characterField;


//各種アラートビューを実装
@property UIAlertView *putACardToLibraryTopOrBottom;

- (IBAction)keisan:(id)sender;

@end
