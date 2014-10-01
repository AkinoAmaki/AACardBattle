//
//  ViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SummonViewController.h"
#import "MBAnimationView.h"
#import "NADView.h"
#import "AAButton.h"
#define FINISHED1 syncFinished = YES;

@interface ViewController : UIViewController<UITextFieldDelegate,NADViewDelegate>{
    UIImageView *firstLaunchView;
    UITextField *tf;
    NSUserDefaults *userDefault;
    AppDelegate *appdelegate;
}

@property (nonatomic, retain) NADView * nadView; //広告枠の設置
@property (nonatomic, assign) id<NADInterstitialDelegate> delegate;
@property (nonatomic) BOOL isOutputLog;


@end
