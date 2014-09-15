//
//  DeckViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/11.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

//#import "ViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#define IMGWIDTH  150
#define IMGHEIGHT 225
#define NUMBEROFIMAGEINRAW 2 //デッキ作成画面において、一列に入るアイコン数
#define NUMBEROFCARDS 156 //カードの総種類数


@interface DeckViewController : UIViewController{
    AppDelegate *app;
    UIImageView *allImage;
    UIScrollView *scrollView;
    UIView *allTxtView; //テキストビューをまとめるビュー
    UITextView *txtView;
    UIImageView *detailOfACard;
    UIImageView *changeOfACard;
    NSMutableArray *selectedCards; //デッキに入れるときに選択されているカードを入れる配列
    NSMutableArray *isSelectedCards; //対象のカードが今何枚選択されているかどうかを管理する配列
    UITextField *deckName; //デッキ名を入力するフィールド
    
    int detailOfACardCount; //1のときはカード詳細画像が表示されており、0のときは表示されていない。
    int changeOfACardCount; //1のときはカード入れ替え画面が表示されており、0のときは表示されていない。
    
    //ボタンタップ時の効果音
    CFBundleRef mainBundle;
    CFURLRef tapSoundURL;
    SystemSoundID tapSoundID;
    CFURLRef cancelSoundURL;
    SystemSoundID cancelSoundID;
}

//OKボタン・キャンセルボタン
@property UIButton *returnToMainViewButton;
@property NSMutableArray *selectedCards;
@property NSMutableArray *isSelectedCards;
@property UIImageView *detailOfACard;

- (IBAction)returnToMainView:(id)sender;
- (void)cardSelectCancelButtonPushed;
- (void)openSmallCard:(int)i;

- (void)longTouchAcrion:(UILongPressGestureRecognizer *)sender;
- (void)putACancelButton:(CGRect)rect;


@end
