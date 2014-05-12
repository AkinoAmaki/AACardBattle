//
//  ViewController.m
//  DeviceMotion
//
//  Created by 秋乃雨弓 on 2014/04/27.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "DeviceMotion.h"

@interface DeviceMotion ()

@end

@implementation DeviceMotion

- (void)bump
{
    
    // インスタンスの生成
    _motionManager = [[CMMotionManager alloc] init];
    if(_motionManager.deviceMotionAvailable){
        _motionManager.deviceMotionUpdateInterval = 0.1;
        CMDeviceMotionHandler deviceMotionHandler;
        deviceMotionHandler = ^(CMDeviceMotion* motion, NSError* error){
            
            if(motion.userAcceleration.x > 1.7 || motion.userAcceleration.y > 1.7 || motion.userAcceleration.z > 1.7){
                FINISHED2
                [NSThread sleepForTimeInterval:1];
                [_motionManager stopDeviceMotionUpdates];
                NSLog(@"大きく動きました");
                location = [[GetLocation alloc] init];
                [location sendLocationDataToServer];

            }
        };
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:deviceMotionHandler];
        [self sync];
    }
}

- (void)sync{
    syncFinished2 = NO;
    while (!syncFinished2) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}

@end
