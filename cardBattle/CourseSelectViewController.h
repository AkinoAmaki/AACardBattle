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


@interface CourseSelectViewController : UIViewController{
    AppDelegate *app;
    UIImageView *backGroundView; //背景画像
    UIButton *course1Button;//コース1を選ぶボタン
    UIButton *course2Button;//コース2を選ぶボタン
    UIButton *course3Button;//コース3を選ぶボタン
    UIButton *course4Button;//コース4を選ぶボタン
    UIButton *course5Button;//コース5を選ぶボタン
}

@end
