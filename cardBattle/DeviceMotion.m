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
@synthesize enemyPlayerID;
@synthesize enemyNickName;
@synthesize syncFinish;
@synthesize delegate;
@synthesize isAEnemyNameForInternetBattle;
@synthesize exploringFinished;
@synthesize syncFinished2;

- (id)init
{
    if (self = [super init]) {
        // 初期処理
        exploringFinished = NO;
    }
    return self;
}

//ネット対戦のためのbump
- (void)bumpForInternetBattle{
    app = [[UIApplication sharedApplication] delegate];
    [app activate];
    
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
    
    //一旦配列に直した上でディクショナリ化する（配列１つ分のディクショナリとして格納される）。こうした場合、サーバ側の処理が楽になる。
    NSArray *arrayParameter = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:app.playerID],app.myNickName, _dateString,  nil];
    
    NSArray *arrayKey = [[NSArray alloc] initWithObjects:@"playerID", @"myNickName",@"dateString", nil];
    
    NSLog(@"%d",app.playerID);
    NSLog(@"%@",app.myNickName);
    NSLog(@"%@",_dateString);
    
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:arrayParameter forKeys:arrayKey];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = @"http://utakatanet.dip.jp:58080/enemyPlayerIDForInternetBattle.php";
    
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *result, NSError *error) {
        if(exploringFinished){
            return;
        }
        
        //データがgetできなければ、警告を発する
        if(error != nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"データ取得不能" message:@"データ取得できませんでした。電波が弱いか、通信できません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [app deactivate];
        }
        NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        if([string hasPrefix:@"timeout"]){
            _notFoundForInternetBattle = [[UIAlertView alloc] initWithTitle:@"検索できませんでした" message:@"再度検索します" delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始！", nil];
            [_notFoundForInternetBattle show];
            [app deactivate];
            [self sync];
        }else{
            enemyPlayerID = [[string substringWithRange:NSMakeRange(9,9)] intValue];
            enemyNickName = [string substringWithRange:NSMakeRange(27, [string length] - 27)];
            isAEnemyNameForInternetBattle = [[UIAlertView alloc] initWithTitle:@"相手プレイヤー確認" message:[NSString stringWithFormat:@"対戦相手が見つかりました！相手プレイヤーは %@ さんです",enemyNickName] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [self performSelectorOnMainThread:@selector(stopExploring)
                                   withObject:nil
                                waitUntilDone:NO];
            //isAEnemyNameForInternetBattleのshowはデリゲート先で実装
            [self sync];
        }
    }];
}

- (void)stopExploring{
    // 通知する
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopExploringAnimation"
                                                        object:self
                                                      userInfo:nil];
}

//ローカル対戦のためのbump
- (void)bumpForLocalBattle
{
    // インスタンスの生成
    _motionManager = [[CMMotionManager alloc] init];
    if(_motionManager.deviceMotionAvailable){
        _motionManager.deviceMotionUpdateInterval = 0.1;
        CMDeviceMotionHandler deviceMotionHandler;
        deviceMotionHandler = ^(CMDeviceMotion* motion, NSError* error){
            
//MARK: デバッグ終わったら元に戻す  if(motion.userAcceleration.x > 1.7 || motion.userAcceleration.y > 1.7 || motion.userAcceleration.z > 1.7){
            if(motion.userAcceleration.x > 0.5 || motion.userAcceleration.y > 0.5 || motion.userAcceleration.z > 0.5){
                FINISHED2
                [NSThread sleepForTimeInterval:1];
                [_motionManager stopDeviceMotionUpdates];
                NSLog(@"大きく動きました");
                [self sendLocationDataToServer:YES];

            }
        };
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:deviceMotionHandler];
        [self sync];
        
    }
}

//位置情報を取得し、サーバに送信する
- (void)sendLocationDataToServer:(BOOL)localBattle{
    
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
    
    if(localBattle){
        [self getLocation];
    }
    
}

-(void)getLocation{
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
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.distanceFilter = 999999999;
    
    
    // 位置情報取得開始
    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    [_locationManager startUpdatingLocation];
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
    [self searchAEnemyIDOnServer:@"http://utakatanet.dip.jp:58080/enemyPlayerID.php" dictionaryParameter:locationArrayParameter dictionaryKey:locationArrayKey];//
    //内部から接続する場合
    //NSString *url = @"http://192.168.10.176:58080/enemyPlayerID.php";
    
}

- (void)searchAEnemyIDOnServer:(NSString *)URLString dictionaryParameter:(NSArray *)dicPar dictionaryKey:(NSArray *)dicKey{
    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:dicPar forKeys:dicKey];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = URLString;
    
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"位置情報取得不能" message:@"位置情報を取得できませんでした。電波が弱いか、通信できません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [SVProgressHUD popActivity];
            return;
        }
        loop++;
    }
    
    NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    if([string hasPrefix:@"timeout"]){
        [SVProgressHUD popActivity];
        _notFoundForLocalBattle = [[UIAlertView alloc] initWithTitle:@"検索できませんでした" message:@"対戦相手が見つかりませんでした。IDが間違っているか、存在しないプレイヤーです" delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始！",@"IDを入力して指定する", nil];
        [_notFoundForLocalBattle show];
    }else{
        [SVProgressHUD popActivity];
        enemyPlayerID = [[string substringWithRange:NSMakeRange(9,9)] intValue];
        enemyNickName = [string substringWithRange:NSMakeRange(27, [string length] - 27)];
        [SVProgressHUD popActivity];
        _isAEnemyNameForLocalBattle = [[UIAlertView alloc] initWithTitle:@"相手プレイヤー確認" message:[NSString stringWithFormat:@"相手プレイヤーの名前は %@ で間違いないですか？",enemyNickName] delegate:self cancelButtonTitle:nil otherButtonTitles:@"そうだよ",@"ちがうよ", nil];
        [_isAEnemyNameForLocalBattle show];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"位置情報が取得できませんでした。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
    [SVProgressHUD popActivity];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == _isAEnemyNameForLocalBattle){
        switch (buttonIndex) {
            case 0:{
                FINISHED2
                app.enemyNickName = enemyNickName;
                app.enemyPlayerID = enemyPlayerID;
                NSLog(@"ニックネーム：%@    プレイヤーID：%d",app.enemyNickName,app.enemyPlayerID);
                GetEnemyDataFromServer *get = [[GetEnemyDataFromServer alloc] init];
                app.decideAction = NO;
                //相手の入力待ち(app.decideAction = YESとなれば先に進む)
                while (!app.decideAction) {
                    [get doEnemyDecideActionNonRoopVersion:YES];
                }
                [NSThread sleepForTimeInterval:0.5];
                [get doEnemyDecideActionRoopVersion:NO];
                //相手プレイヤーとの接続確立に失敗し、データを受け取れなかった場合は再度相手プレイヤーの検索を行わせる。()
                if(app.doEnemyActivate){
                    [SVProgressHUD popActivity];
                    SendDataToServer *sendData = [[SendDataToServer alloc] init];
                    [sendData send];
                    [self.delegate syncFinished];
                }else{
                    [SVProgressHUD popActivity];
                    _notFoundForLocalBattle = [[UIAlertView alloc] initWithTitle:@"検索できませんでした" message:@"対戦相手が応答しませんでした。戦闘開始ボタンを押した後に再度ぶつけるか、相手プレイヤーのIDを直接入力してください" delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始！",@"IDを入力して指定する", nil];
                    [_notFoundForLocalBattle show];
                    //[self sync];
                }
                
                break;
            }
            case 1:
            {
                FINISHED2
                _isAEnemyName_retry = [[UIAlertView alloc] initWithTitle:@"やり直し" message:@"戦闘開始ボタンを押した後に再度ぶつけるか、相手プレイヤーのIDを直接入力してください" delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始！",@"IDを入力して指定する", nil];
                [_isAEnemyName_retry show];
                return;
            }
        }
    }else if (alertView == _notFoundForLocalBattle){
        switch (buttonIndex) {
            case 0:
                //対戦相手検索のやり直し
                FINISHED2
                [self bumpForLocalBattle];
                break;
            case 1:
                FINISHED2
                //ID入力方式による対戦相手の指定の実装
                _feedAEnemyID = [[UIAlertView alloc] initWithTitle:@"ID入力" message:[NSString stringWithFormat:@"相手プレイヤーのIDを入力してください。(あなたのIDは %d です)",app.playerID] delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始！", nil];
                _feedAEnemyID.alertViewStyle = UIAlertViewStylePlainTextInput;
                _feedAEnemyID.frame = CGRectMake(0, 50, 300, 300);
                
                _enemyIDField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
                _enemyIDField.placeholder = @"IDを入力";
                _enemyIDField.delegate = self;
                [_enemyIDField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                [_enemyIDField reloadInputViews];
                _enemyIDField = [_feedAEnemyID textFieldAtIndex:0];
                [_feedAEnemyID addSubview:_enemyIDField];
                [_feedAEnemyID show];
                break;
            default:
                break;
        }
    }else if (alertView == _isAEnemyName_retry){
        switch (buttonIndex) {
            case 0:
                [self bumpForLocalBattle];
                break;
                
            case 1:
                //ID入力方式による対戦相手の指定の実装
                _feedAEnemyID = [[UIAlertView alloc] initWithTitle:@"ID入力" message:[NSString stringWithFormat:@"相手プレイヤーのIDを入力してください。(あなたのIDは %d です)",app.playerID] delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始！", nil];
                _feedAEnemyID.alertViewStyle = UIAlertViewStylePlainTextInput;
                _feedAEnemyID.frame = CGRectMake(0, 50, 300, 300);
                
                _enemyIDField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
                _enemyIDField.placeholder = @"IDを入力";
                _enemyIDField.delegate = self;
                [_enemyIDField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                [_enemyIDField reloadInputViews];
                _enemyIDField = [_feedAEnemyID textFieldAtIndex:0];
                [_feedAEnemyID addSubview:_enemyIDField];
                [_feedAEnemyID show];
            default:
                break;
        }
    }else if (alertView == _feedAEnemyID){
        switch (buttonIndex) {
            case 0:{
                app.enemyPlayerID = [_enemyIDField.text intValue];
                NSArray *enemyIDParameter = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:app.enemyPlayerID], nil];
                NSArray *enemyIDKey = [[NSArray alloc] initWithObjects:@"enemyIDKey", nil];
                [self searchAEnemyIDOnServer:@"http://utakatanet.dip.jp:58080/enemyPlayerIDByHandInput.php" dictionaryParameter:enemyIDParameter dictionaryKey:enemyIDKey];
            }
                break;
                
            default:
                break;
        }
    }else if (alertView == _notFoundForInternetBattle){
        switch (buttonIndex) {
            case 0:
                FINISHED2
                [self bumpForInternetBattle];
                break;
                
            default:
                break;
        }
    }else if (alertView == isAEnemyNameForInternetBattle){
        switch (buttonIndex) {
            case 0:
            {
                FINISHED2
                app.enemyNickName = enemyNickName;
                app.enemyPlayerID = enemyPlayerID;
                app.battleStart = YES;
                
                [self performSelectorOnMainThread:@selector(BattleStartPost)
                                       withObject:nil
                                    waitUntilDone:NO];
                NSLog(@"ニックネーム：%@    プレイヤーID：%d",app.enemyNickName,app.enemyPlayerID);
            }
                break;
        }
    }
}

- (void)BattleStartPost{
    // 通知する
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BattleStartPost"
                                               object:self
                                             userInfo:nil];
}

- (void)sync{
    syncFinished2 = NO;
    while (!syncFinished2) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }
}

@end
