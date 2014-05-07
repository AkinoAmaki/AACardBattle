//
//  GetLocation.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "SVProgressHUD.h"
#import "SBJson.h"

@interface GetLocation : UIViewController<CLLocationManagerDelegate>{
    NSString *dateString;
    AppDelegate *app;
}
@property (nonatomic) CLLocationManager *locationManager;
- (void)sendLocationDataToServer;

@end
