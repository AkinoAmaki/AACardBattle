//
//  ViewController.h
//  DeviceMotion
//
//  Created by 秋乃雨弓 on 2014/04/27.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "GetLocation.h"
#define FINISHED2 syncFinished2 = YES;

@interface DeviceMotion :NSObject{
    BOOL syncFinished2; //同期処理において、対象の被待機処理が完了したかを管理する
    GetLocation *location;
}


@property (nonatomic)CMMotionManager *motionManager;

- (void)bump;


@end
