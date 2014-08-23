//
//  DeckTabBarController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/08/23.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck1.h"
#import "Deck2.h"
#import "Deck3.h"

@interface DeckTabBarController : UITabBarController<Deck1Delegate, Deck2Delegate, Deck3Delegate>{
    //タブバーコントローラー及びそれに載せる各々のデッキのビューコントローラー
    UITabBarController *tabController;
    Deck1 *tab1;
    Deck2 *tab2;
    Deck3 *tab3;
}

//タブバーコントローラーを司るwindow
@property UIWindow *window;

//BGM,タップ音関係の変数
@property(readwrite) CFURLRef tapSoundURL;
@property(readonly) SystemSoundID tapSoundID;
@property(readwrite) CFURLRef cancelSoundURL;
@property(readonly) SystemSoundID cancelSoundID;
@property(nonatomic,retain)AVAudioPlayer *audio;

@end
