//
//  ViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SummonViewController.h"
#import "MBAnimationView.h"

@interface ViewController : UIViewController<UITextFieldDelegate>{
    UIImageView *firstLaunchView;
    UITextField *tf;
    NSUserDefaults *userDefault;
    AppDelegate *appdelegate;

}


@end
