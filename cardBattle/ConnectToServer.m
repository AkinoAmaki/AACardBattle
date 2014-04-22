//
//  ConnectToServer.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "ConnectToServer.h"


@interface ConnectToServer ()

@end

@implementation ConnectToServer
@synthesize locationManager;
@synthesize labelLatitude;
@synthesize labelLongitude;
@synthesize labelTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//位置情報を取得し、サーバに送信する
- (void)sendDataToServer{
    locationManager = [[CLLocationManager alloc] init];
    
    //位置情報は100m間隔での精度を持ち、自動更新はしない。
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    //位置情報を取得できるかどうか確認し、無理なら警告する。
    if ([CLLocationManager locationServicesEnabled]) {
		self.locationManager.delegate = self;
		// 位置情報取得開始
		[self.locationManager startUpdatingLocation];
        //TODO: サーバに位置情報を送信する
        
	}else{
        UIAlertView *alertView =  [[UIAlertView alloc]
                                   initWithTitle:@"位置情報取得不可"
                                   message:@"設定画面から位置情報の取得を許可してください。"
                                   delegate:nil
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@"OK", nil
                                   ];
        [alertView show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    NSDate *timestamp = location.timestamp;
    labelLatitude.text = [NSString stringWithFormat:@"%+.6f", location.coordinate.latitude];
    labelLongitude.text = [NSString stringWithFormat:@"%+.6f", location.coordinate.longitude];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    labelTime.text = [df stringFromDate:timestamp];}

@end
