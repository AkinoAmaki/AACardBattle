//
//  Deck1.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/08/23.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "DeckViewController.h"
#import <UIKit/UIKit.h>
#define IMGWIDTH  150
#define IMGHEIGHT 225
#define NUMBEROFIMAGEINRAW 2 //デッキ作成画面において、一列に入るアイコン数
#define NUMBEROFCARDS 156 //カードの総種類数

@protocol Deck1Delegate <NSObject>

// デリゲートメソッドを宣言
// （宣言だけしておいて，実装はデリゲート先でしてもらう）
- (void)returnToMainView;

@end

@interface Deck1 : DeckViewController<UITextFieldDelegate>{
    BOOL deckEditHasFinished;
    UIAlertView *deckEditHasFinishedAlert;
}

// デリゲート先で参照できるようにするためプロパティを定義しておく
@property (nonatomic, assign) id<Deck1Delegate> delegate;

@end
