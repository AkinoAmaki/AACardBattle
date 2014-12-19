//
//  FirstViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/15.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app = [[UIApplication sharedApplication] delegate];
    deactivateFinished = NO;
    
    NSString *backGroundImagePath = [[NSBundle mainBundle] pathForResource:@"backOfACard" ofType:@"png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:backGroundImagePath]];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToMainView)]];
    [self.view addSubview:imageView];
    
    //トップ画面のBGMの開始
    NSString* path = [[NSBundle mainBundle]
                      pathForResource:@"topgamen_nc7400" ofType:@"mp3"];
    NSURL* url = [NSURL fileURLWithPath:path];
    app.audio = [[AVAudioPlayer alloc]
                 initWithContentsOfURL:url error:nil];
    app.audio.numberOfLoops = -1;
    [app.audio play];
    
    //  NADViewの作成
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, 320, 100)];
    //  ログ出力の指定
    [self.nadView setIsOutputLog:NO];
    //  set apiKey, spotId.
    [self.nadView setNendID:@"17df8518f899a6d562f10eb8532b19d48af66209"
                     spotID:@"237832"];
    //　デリゲートの設定
    [self.nadView setDelegate:self];
    //　広告の読み込み
    [self.nadView load]; //(6)
    [self.view addSubview:self.nadView]; // 最初から表示する場合

    [NADInterstitial sharedInstance].delegate = self;
    
}

- (void) didFinishLoadInterstitialAdWithStatus:(NADInterstitialStatusCode)status
{
    switch ( status )
    {
        case SUCCESS:
            NSLog(@"広告のロードに成功しました。");
            //初回起動判定。初回起動であれば、広告は表示しない
            int first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
            if (first != 0) {
                [[NADInterstitial sharedInstance] showAd];
            }else{
                NSLog(@"初回起動なので広告は表示しない");
            }
            
            break;
        case INVALID_RESPONSE_TYPE:
            NSLog(@"不正な広告タイプです。");
            break;
        case FAILED_AD_REQUEST:
            NSLog(@"抽選リクエストに失敗しました。");
            break;
        case FAILED_AD_DOWNLOAD:
            NSLog(@"広告のロードに失敗しました。");
            break;
    }
}
- (void) didClickWithType:(NADInterstitialClickType)type
{
    switch ( type )
    {
        case DOWNLOAD:
            NSLog(@"ダウンロードボタンがクリックされました。");
            break;
        case CLOSE:
            NSLog(@"閉じるボタンあるいは広告範囲外の領域がクリックされました。");
            break;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    //広告の停止
    NSLog(@"広告を停止しました");
    [self.nadView pause];
    
    //BGMの停止
    [app.audio stop];
}

- (void)viewWillAppear:(BOOL)animated {
    //広告の再開
    NSLog(@"広告を開始しました");
    [self.nadView resume];
}

- (void)moveToMainView{
//    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    [self performSelector:@selector(moveToMainView2) withObject:nil afterDelay:0.1];
}

- (void)moveToMainView2{
//    [self deactivate];
    [self performSegueWithIdentifier:@"goToMainView" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)activate{
    NSLog(@"あくてぃべーと");
    activateOrDeactivate = YES;
    [self activateFunction:YES];
}

-(void)deactivate{
    NSLog(@"でぃあくてぃべーと");
    activateOrDeactivate = NO;
    [self activateFunction:NO];
}

- (void)activateFunction:(BOOL)activate{
    
    //一旦配列に直した上でディクショナリ化する（配列１つ分のディクショナリとして格納される）。こうした場合、サーバ側の処理が楽になる。
    NSArray *arrayParameter = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:app.playerID],[NSNumber numberWithBool:activate],  nil];
    
    NSArray *arrayKey = [[NSArray alloc] initWithObjects:@"playerID",@"activate", nil];
    
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:arrayParameter forKeys:arrayKey];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = @"http://utakatanet.dip.jp:58080/activate.php";
    
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
        NSLog(@"通信できませんでした。データのget処理を再度実行中...");
        if(loop == 10){
            [SVProgressHUD popActivity];
            notFoundForInternetBattle = [[UIAlertView alloc] initWithTitle:@"通信不能" message:@"通信できませんでした。電波が弱いか、サーバが応答していません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [notFoundForInternetBattle show];
            return;
        }
        loop++;
    }
    
    NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    if([string hasPrefix:@"timeout"]){
        [SVProgressHUD popActivity];
        notFoundForInternetBattle = [[UIAlertView alloc] initWithTitle:@"通信不能" message:@"通信できませんでした。電波が弱いか、サーバが応答していません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [notFoundForInternetBattle show];
    }else{
        NSLog(@"アクティベート or ディアクティベート完了");
        deactivateFinished = YES;
        [SVProgressHUD popActivity];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == notFoundForInternetBattle){
        FINISHED1
        if(activateOrDeactivate){
            [self activate];
        }else{
            [self deactivate];
        }
    }
}

- (void)sync{
    syncFinished = NO;
    while (!syncFinished) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}

-(void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"delegate nadViewDidFinishLoad:広告が読み込まれました");
}

-(void)nadViewDidReceiveAd:(NADView *)adView {
    NSLog(@"delegate nadViewDidReceiveAd:広告受信に成功しました");
}

-(void)nadViewDidFailToReceiveAd:(NADView *)adView {
    NSLog(@"delegate nadViewDidFailToLoad:");
    // エラーごとに分岐する
    NSError* error = adView.error;
    NSString* domain = error.domain;
    int errorCode = error.code;
    // isOutputLog = NOでも、domain を利用してアプリ側で任意出力が可能
    NSLog(@"log %d", adView.isOutputLog);
    NSLog(@"%@",[NSString stringWithFormat: @"code=%d, message=%@",
                 errorCode, domain]);
    switch (errorCode) {
        case NADVIEW_AD_SIZE_TOO_LARGE:
            // 広告サイズがディスプレイサイズよりも大きい
            NSLog(@"広告サイズがディスプレイサイズよりも大きい");
            break;
        case NADVIEW_INVALID_RESPONSE_TYPE:
            // 不明な広告ビュータイプ
            NSLog(@"不明な広告ビュータイプ");
            break;
        case NADVIEW_FAILED_AD_REQUEST:
            // 広告取得失敗
            NSLog(@"広告取得失敗(ネットワークエラー、サーバエラー、在庫切れなど)");
            break;
        case NADVIEW_FAILED_AD_DOWNLOAD:
            // 広告画像の取得失敗
            NSLog(@"広告画像の取得失敗");
            break;
        case NADVIEW_AD_SIZE_DIFFERENCES:
            // リクエストしたサイズと取得したサイズが異なる
            NSLog(@"リクエストしたサイズと取得したサイズが異なる");
            break;
        default:
            break;
    }
}

- (void)nadViewDidClickAd:(NADView *)adView {
    NSLog(@"delegate nadViewDidClickAd:広告がタップされました。但し、電波状況によってはサーバ側のカウントとは異なる可能性があります");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
