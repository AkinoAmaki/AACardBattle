//
//  ConnectToServer.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ConnectToServer : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *labelLatitude; //緯度
@property (weak, nonatomic) IBOutlet UILabel *labelLongitude;//軽度
@property (weak, nonatomic) IBOutlet UILabel *labelTime;//位置情報を入手した時間



@end
