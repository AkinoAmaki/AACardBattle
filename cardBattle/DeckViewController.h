//
//  DeckViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/11.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#define IMGWIDTH  50
#define IMGHEIGHT 50
#define NUMBEROFIMAGEINRAW 5 //デッキ作成画面において、一列に入るアイコン数



@interface DeckViewController : ViewController{
    AppDelegate *app;
    UIImageView *allImage;
    UIScrollView *scrollView;
    UIView *allTxtView; //テキストビューをまとめるビュー
    UITextView *txtView;
    UIImageView *detailOfACard;
    UIImageView *changeOfACard;
    NSMutableArray *selectedCards; //デッキに入れるときに選択されているカードを入れる配列
    NSMutableArray *isSelectedCards; //対象のカードが今何枚選択されているかどうかを管理する配列
    
    int detailOfACardCount; //1のときはカード詳細画像が表示されており、0のときは表示されていない。
    int changeOfACardCount; //1のときはカード入れ替え画面が表示されており、0のときは表示されていない。
    
    //ボタンタップ時の効果音
    CFURLRef tapSoundURL;
    SystemSoundID tapSoundID;
    CFURLRef cancelSoundURL;
    SystemSoundID cancelSoundID;
    
    CFBundleRef mainBundle;
}

//OKボタン・キャンセルボタン
@property UIButton *returnToMainViewButton;

@property NSMutableArray *selectedCards;
@property NSMutableArray *isSelectedCards;
@property UIImageView *detailOfACard;
@property(readwrite) CFURLRef tapSoundURL;
@property(readonly) SystemSoundID tapSoundID;
@property(readwrite) CFURLRef cancelSoundURL;
@property(readonly) SystemSoundID cancelSoundID;
@property(nonatomic,retain)AVAudioPlayer *audio;
- (IBAction)returnToMainView:(id)sender;

- (void)longTouchAcrion:(UILongPressGestureRecognizer *)sender;
- (void)putACancelButton:(CGRect)rect;

@end
