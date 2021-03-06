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
@synthesize enemyPlayerID;
@synthesize enemyNickName;
@synthesize syncFinish;


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
    _dateString = [df stringFromDate:[NSDate date]];
    // ログに出力
    NSLog(@"%@", _dateString);

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
    _locationManager.distanceFilter = 999999999;
    

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
    NSLog(@"latitude:%+.6f",location.coordinate.latitude);
    NSLog(@"longitude:%+.6f",location.coordinate.longitude);
    
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
    
    
    app = [[UIApplication sharedApplication] delegate];
    
    //一旦配列に直した上でディクショナリ化する（配列１つ分のディクショナリとして格納される）。こうした場合、サーバ側の処理が楽になる。
    NSArray *locationArrayParameter_before = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:app.playerID],app.myNickName, _dateString, [NSNumber numberWithFloat:location.coordinate.latitude], [NSNumber numberWithFloat:location.coordinate.longitude], nil];
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
    int loop = 0;
    while (!result) {
        [NSThread sleepForTimeInterval:0.5];
        result= [NSURLConnection sendSynchronousRequest:request
                                      returningResponse:&response
                                                  error:&error];
        NSLog(@"再度get処理実行中...");
        if(loop == 20){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"位置情報を取得不可" message:@"位置情報を取得できませんでした。電波が弱いか、通信できません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [SVProgressHUD dismiss];
            return;
        }
        loop++;
    }
    
    NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    if([string hasPrefix:@"timeout"]){
        _notFound = [[UIAlertView alloc] initWithTitle:@"再度ぶつけてください" message:@"対戦相手が見つかりませんでした。OK再度ぶつけてください" delegate:self cancelButtonTitle:nil otherButtonTitles:@"", nil];
    }else{
        enemyPlayerID = [[string substringWithRange:NSMakeRange(9,9)] intValue];
        enemyNickName = [string substringWithRange:NSMakeRange(27, [string length] - 27)];
        [SVProgressHUD dismiss];
        _isAEnemyName = [[UIAlertView alloc] initWithTitle:@"相手プレイヤー確認" message:[NSString stringWithFormat:@"相手プレイヤーの名前は %@ で間違いないですか？",enemyNickName] delegate:self cancelButtonTitle:nil otherButtonTitles:@"そうだよ",@"ちがうよ", nil];
        [_isAEnemyName show];
        NSLog(@"%@",string);
        [self sync];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"位置情報が取得できませんでした。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
    [SVProgressHUD dismiss];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == _isAEnemyName){
        switch (buttonIndex) {
            case 0:{
                FINISHED3
                app.enemyNickName = enemyNickName;
                app.enemyPlayerID = enemyPlayerID;
                NSLog(@"ニックネーム：%@    プレイヤーID：%d",app.enemyNickName,app.enemyPlayerID);
                [SVProgressHUD dismiss];
                break;
            }
            case 1:
            {
                FINISHED3
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"やり直し" message:@"iPhoneをぶつけ合ってください！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
                return;
            }
        }
    }
}

- (void)sync{
    syncFinish = NO;
    while (!syncFinish) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}


@end
