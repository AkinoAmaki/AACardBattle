//
//  ConnectToServer.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "GetLocation.h"


@interface GetLocation ()

@end

@implementation GetLocation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//位置情報を取得し、サーバに送信する
- (void)sendLocationDataToServer{
    //対戦開始時の相手検索を行う
    
    //バンプ時のタイムスタンプを取得
    // NSDateFormatter を用意
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    // カレンダーを西暦（グレゴリオ暦）で用意
    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    // カレンダーをセット
    [df setCalendar:cal];
    // タイムロケールをシステムロケールでセット（24時間表示のため）
    [df setLocale:[NSLocale systemLocale]];
    // タイムスタンプ書式をセット
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 現在日時から文字列を生成
    dateString = [df stringFromDate:[NSDate date]];
    // ログに出力
    NSLog(@"%@", dateString);

    //
    // NotDetermined、Authorized以外（つまりDenied、Restricted）の時は、
    // 設定画面で位置情報サービスをオンすることをうながすAlertを表示する
    //
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (!((status == kCLAuthorizationStatusNotDetermined) ||
          (status == kCLAuthorizationStatusAuthorized))) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:NSLocalizedString(@"設定->プライバシー->位置情報サービスから、このアプリの位置情報の利用を許可してください", nil)
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
        return;
    }
    
    
    _locationManager = [[CLLocationManager alloc] init];
    
    //位置情報は100m間隔での精度を持ち、自動更新はしない。
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    

    // 位置情報取得開始
    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    [_locationManager startUpdatingLocation];
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
    
    [_locationManager stopUpdatingLocation];
    NSLog(@"latitude:%+.6f",location.coordinate.latitude);
    NSLog(@"longitude:%+.6f",location.coordinate.longitude);
    
    app = [[UIApplication sharedApplication] delegate];
    
    //一旦配列に直した上でディクショナリ化する（配列１つ分のディクショナリとして格納される）。こうした場合、サーバ側の処理が楽になる。
    NSArray *locationArrayParameter_before = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:app.playerID],app.nickName, dateString, [NSNumber numberWithFloat:location.coordinate.latitude], [NSNumber numberWithFloat:location.coordinate.longitude], nil];
    NSArray *locationArrayParameter = [[NSArray alloc] initWithObjects:locationArrayParameter_before, nil];
    
    NSArray *locationArrayKey = [[NSArray alloc] initWithObjects:@"locationArrayKey", nil];
    
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:locationArrayParameter forKeys:locationArrayKey];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    //     //外部から接続する場合
    NSString *url = @"http://utakatanet.dip.jp:58080/enemyPlayerID.php";
    //     //内部から接続する場合
    //NSString *url = @"http://192.168.10.176:58080/enemyPlayerID.php";
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *result;
    result= [NSURLConnection sendSynchronousRequest:request
                                  returningResponse:&response
                                              error:&error];
    
    //データがgetできなければ、0.5秒待ったあとに再度get処理する
    while (!result) {
        [NSThread sleepForTimeInterval:0.5];
        result= [NSURLConnection sendSynchronousRequest:request
                                      returningResponse:&response
                                                  error:&error];
        NSLog(@"とおりました");
    }
    
    NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"%@", string);
    
    [SVProgressHUD dismiss];
}



@end
