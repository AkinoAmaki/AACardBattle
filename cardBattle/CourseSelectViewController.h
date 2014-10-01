//
//  CourseSelectViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/11.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GikoGikoWaintngViewController.h"
#import "NADView.h"
#import "AAButton.h"

@interface CourseSelectViewController : UIViewController<NADViewDelegate>{
    AppDelegate *app;
    UIImageView *backGroundView; //背景画像
    AAButton *course1Button;//コース1を選ぶボタン
    AAButton *course2Button;//コース2を選ぶボタン
    AAButton *course3Button;//コース3を選ぶボタン
    AAButton *course4Button;//コース4を選ぶボタン
    AAButton *course5Button;//コース5を選ぶボタン
}
//メインビューに戻るボタン
@property UIButton *returnToMainViewButton;

@property (nonatomic, retain) NADView * nadView; //広告枠の設置
@property (nonatomic, assign) id<NADInterstitialDelegate> delegate;
@property (nonatomic) BOOL isOutputLog;

@end
