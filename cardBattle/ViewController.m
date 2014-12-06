//
//  ViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[UITextView appearance] setFont:[UIFont fontWithName:@"Tanuki-Permanent-Marker" size:12.0f]];
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Tanuki-Permanent-Marker" size:12.0f]];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    int first =  [userDefault integerForKey:@"firstLaunch_ud"];
    app = [[UIApplication sharedApplication] delegate];
    
    NSString *backGroundImagePath = [[NSBundle mainBundle] pathForResource:@"backOfACard_skelton" ofType:@"png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:backGroundImagePath]];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:imageView];
    
    battleButton = [[AAButton alloc] initWithImageAndText:@"sample-302-swords" imagePath:@"png" textString:@" 対 戦 " tag:1 CGRect:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 100, 120, 200, 40)];
    [battleButton addTarget:self action:@selector(battleButtonPushed)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:battleButton];
    
    deckButton = [[AAButton alloc] initWithImageAndText:@"glyphicons_330_blog" imagePath:@"png" textString:@" デッキ編成 " tag:1 CGRect:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 100, 200, 200, 40)];
    [deckButton addTarget:self action:@selector(deckButtonPushed)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deckButton];
    
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
    [self.view addSubview:self.nadView]; // 広告を表示
    
    //右矢印のイメージを用意
    UIImage *arrowImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"]];
    app.arrow = [[UIImageView alloc] initWithImage:arrowImage];
    
    //左矢印のイメージを用意
    UIImage *rArrowImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrowR" ofType:@"png"]];
    app.arrowR = [[UIImageView alloc] initWithImage:rArrowImage];
    
    
    
    if(first == 0){
        firstLaunchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        firstLaunchView.image = [UIImage imageNamed:@"backOfACard"];
        firstLaunchView.userInteractionEnabled = YES;
        
        UITextView *explainTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 80, [[UIScreen mainScreen] bounds].size.width - 0, 60)];
        explainTextView.text = @"アスキーアートの世界へようこそ！\nまずはあなたのニックネームを教えて下さい！";
        explainTextView.textAlignment = NSTextAlignmentCenter;
        [PenetrateFilter penetrate:explainTextView];
        [firstLaunchView addSubview:explainTextView];
        
        tf = [[UITextField alloc] initWithFrame:CGRectMake(40 ,160, [[UIScreen mainScreen] bounds].size.width - 80, 30)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.placeholder = @"ニックネームを入力";
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.returnKeyType = UIReturnKeyDone;
        tf.delegate = self;
        [firstLaunchView addSubview:tf];
        [self.view addSubview:firstLaunchView];
    }
    
    
//    NSArray *array = [[NSArray alloc] initWithObjects:deckButton, nil];
//    IntroductionTool *test = [[IntroductionTool alloc] initForHighlightingViewMethod:battleButton.frame forbidTapActionViewArray:array];
//    [self.view addSubview:test];
    
}

- (void)viewDidAppear:(BOOL)animated{
    //メイン画面のBGMの開始(バトルボタンが押された時は、探索開始時点までストップしない。デッキ編集ボタンが押された時はその瞬間にストップする)
    NSString* path = [[NSBundle mainBundle]
                      pathForResource:@"maingamen_nc86052" ofType:@"mp3"];
    NSURL* url = [NSURL fileURLWithPath:path];
    app.audio = [[AVAudioPlayer alloc]
                 initWithContentsOfURL:url error:nil];
    app.audio.numberOfLoops = -1;
    app.audio.volume = 0.05f;
    [app.audio play];
    
    //初回起動ならプロローグを表示する
    int first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
    if (first == 1) {
        [self startAnimation132];
    }else if (first == 2){
        [self startAnimation159];
    }else{
        if (app.cardIGotInTheLastMatch != 0) {
            SocialMediaViewController *twitter = [[SocialMediaViewController alloc] init];
            [twitter postTwitter:[NSString stringWithFormat:@"%@ はNo.%d スーパーレアカード「%@」を手に入れた！  #アスキーアート大戦記",app.myNickName,app.cardIGotInTheLastMatch,[app.cardList_cardName objectAtIndex:app.cardIGotInTheLastMatch]] viewController:self];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    //広告の停止
    NSLog(@"広告を停止しました");
    [self.nadView pause];
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 -(BOOL)textFieldShouldReturn:(UITextField*)textField{
     if(textField.text.length == 0){
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未入力です" message:@"名前を入力してください。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"名前を入力する", nil];
         [alert show];
     }else{
         userDefault = [NSUserDefaults standardUserDefaults];
         [userDefault setObject:tf.text forKey:@"myNickName_ud"];
         [userDefault synchronize];
         app.myNickName = [userDefault objectForKey:@"myNickName_ud"];
         NSLog(@"ニックネーム：%@",app.myNickName);
         [tf resignFirstResponder];
         [firstLaunchView removeFromSuperview];
         //     //ニックネームの入力が終わり次第、プロローグを始める
         //     [self firstPrologue];
         [self startAnimation001];
     }
     return YES;
}

- (void)firstPrologue{
    
    animation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    animation.userInteractionEnabled = YES;
    
    UIImageView *blackBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    blackBack.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackBack" ofType:@"png"]];
    [animation addSubview:blackBack];
    
    UIImageView *animationImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100)];
    animationImage.contentMode = UIViewContentModeScaleAspectFit;
    animationImage.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    animationImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pro_a1" ofType:@"png"]];
    animationImage.tag = 1; //タグを付けておき、nextAnimationOfFirstPrologueで拾って画像を変えられるようにする。
    firstPrologueNumber = 2; //nextButtonを押すと、次に２番目の画像を表示する。
    [animation addSubview:animationImage];
    
    UIImageView *nextButton = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 100, 50, 50)];
    nextButton.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"next" ofType:@"png"]];
    nextButton.userInteractionEnabled = YES;
    [nextButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextAnimationOfFirstPrologue)]];
    [animation addSubview:nextButton];
    
    [self.view addSubview:animation];
}

- (void)nextAnimationOfFirstPrologue{
    if(firstPrologueNumber < 22){
        UIImageView *animationImage2 = (UIImageView *)[animation viewWithTag:1];
        animationImage2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"pro_a%d",firstPrologueNumber] ofType:@"png"]];
        firstPrologueNumber++;
    }else{
        for (UIView *v in animation.subviews) {
            [v removeFromSuperview];
        }
        [animation removeFromSuperview];
        [self startAnimation001];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //広告の再開
    NSLog(@"広告を開始しました");
    [self.nadView resume];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    app.myCards = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myCards_ud"]];
    app.myDeck1 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud1"]];
    app.myDeck2 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud2"]];
    app.myDeck3 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud3"]];

//    カード効果実装時のデバッグ用
//    app.myDeck = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:10],//10
//                          [NSNumber numberWithInt:10],
//                          [NSNumber numberWithInt:10],
//                          [NSNumber numberWithInt:10],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0], //20
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//30
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//40
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//50
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//60
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//70
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//80
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//90
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//100
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//110
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//120
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//130
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//140
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],//150
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          [NSNumber numberWithInt:0],
//                          nil];

    
#pragma mark- 対戦に関連する各種数値の初期化

    app.battleStart = NO;
    app.myHand = [[NSMutableArray alloc] init]; //自分の手札
    app.myTomb = [[NSMutableArray alloc] init]; //自分の墓地のカードナンバー
    app.myFieldCard = [[NSMutableArray alloc] initWithObjects:nil]; //自分の場カードのカードナンバー
    app.myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //自分のエネルギーカードの数
    app.myDeckCardListByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyDeckCardList（差分のみ管理）
    app.myHandByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyHand（差分のみ管理）
    app.myTombByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyTomb（差分のみ管理）
    app.myFieldCardByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyFieldCard（差分のみ管理）
    app.myEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // 自分が操作し、増加したmyEnergyCard（差分のみ管理）
    app.myDeckCardListByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyDeckCardList（差分のみ管理）
    app.myHandByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyHand（差分のみ管理）
    app.myTombByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyTomb（差分のみ管理）
    app.myFieldCardByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyFieldCard（差分のみ管理）
    app.myEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // 自分が操作し、減少したmyEnergyCard（差分のみ管理）
    app.myDeckCardListFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyDeckCardList（差分のみ管理）
    app.myHandFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyHand（差分のみ管理）
    app.myTombFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyTomb（差分のみ管理）
    app.myFieldCardFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyFieldCard（差分のみ管理）
    app.myEnergyCardFromEnemy_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //相手が操作し、増加したmyEnergyCard（差分のみ管理）
    app.myDeckCardListFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyDeckCardList（差分のみ管理）
    app.myHandFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyHand（差分のみ管理）
    app.myTombFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyTomb（差分のみ管理）
    app.myFieldCardFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyFieldCard（差分のみ管理）
    app.myEnergyCardFromEnemy_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //相手が操作し、減少したmyEnergyCard（差分のみ管理）
    app.myUsingEnergy = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //自分がこのターン使用したエネルギーの量
    app.myLifeGage = 20;
    app.myLifeGageByMyself = 0; //自分のライフポイントを自分で操作する場合の値(差分のみ管理)
    app.myAdditionalGettingCards = 0;//ターンの開始時に引くカード以外で引いた、ターン毎のカードの枚数を管理する
    app.myAdditionalDiscardingCards = 0;//ターンの終了時に捨てるカード以外で捨てた、ターン毎のカードの枚数を管理する
    app.myGikoFundamentalAttackPower = 3; //自分のギコの基本攻撃力
    app.myGikoFundamentalDeffencePower = 1; //自分のギコの基本防御力
    app.myMonarFundamentalAttackPower = 3; //自分のモナーの基本攻撃力
    app.myMonarFundamentalDeffencePower = 1; //自分のモナーの基本防御力
    app.mySyobonFundamentalAttackPower = 3; //自分のショボンの基本攻撃力
    app.mySyobonFundamentalDeffencePower = 1; //自分のショボンの基本防御力
    app.myYaruoFundamentalAttackPower = 0; //自分のやる夫の基本攻撃力
    app.myYaruoFundamentalDeffencePower = 2; //自分のやる夫の基本防御力
    app.myGikoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のギコの基本攻撃力（差分のみ管理）
    app.myGikoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のギコの基本防御力（差分のみ管理）
    app.myMonarFundamentalAttackPowerByMyself = 0; //自分が操作した自分のモナーの基本攻撃力（差分のみ管理）
    app.myMonarFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のモナーの基本防御力（差分のみ管理）
    app.mySyobonFundamentalAttackPowerByMyself = 0; //自分が操作した自分のショボンの基本攻撃力（差分のみ管理）
    app.mySyobonFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のショボンの基本防御力（差分のみ管理）
    app.myYaruoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    app.myYaruoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の基本防御力（差分のみ管理）
    app.myGikoFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のギコの基本攻撃力（差分のみ管理）
    app.myGikoFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のギコの基本防御力（差分のみ管理）
    app.myMonarFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のモナーの基本攻撃力（差分のみ管理）
    app.myMonarFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のモナーの基本防御力（差分のみ管理）
    app.mySyobonFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のショボンの基本攻撃力（差分のみ管理）
    app.mySyobonFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のショボンの基本防御力（差分のみ管理）
    app.myYaruoFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    app.myYaruoFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のやる夫の基本防御力（差分のみ管理）
    app.mySelectCharacter = -1; //自分の選んだキャラクター
    app.mySelectCharacterFromEnemy = -1;
    app.myGikoModifyingAttackPower = 0; //自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.myGikoModifyingDeffencePower = 0; //自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.myMonarModifyingAttackPower = 0; //自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.myMonarModifyingDeffencePower = 0; //自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.mySyobonModifyingAttackPower = 0; //自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.mySyobonModifyingDeffencePower = 0; //自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.myYaruoModifyingAttackPower = 0; //自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.myYaruoModifyingDeffencePower = 0; //自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.myGikoModifyingAttackPowerByMyself = 0; //自分が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingAttackPowerByMyself = 0; //自分が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingDeffencePowerByMyself = 0; //自分が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingAttackPowerByMyself = 0; //自分が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingAttackPowerByMyself = 0; //自分が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoAttackPermittedByMyself = YES; //自分のギコの攻撃許可
    app.myGikoDeffencePermittedByMyself = YES; //自分のギコの防御許可
    app.myMonarAttackPermittedByMyself = YES; //自分のモナーの攻撃許可
    app.myMonarDeffencePermittedByMyself = YES; //自分のモナーの防御許可
    app.mySyobonAttackPermittedByMyself = YES; //自分のショボンの攻撃許可
    app.mySyobonDeffencePermittedByMyself = YES; //自分のショボンの防御許可
    app.myYaruoAttackPermittedByMyself = YES; //自分のやる夫の攻撃許可
    app.myYaruoDeffencePermittedByMyself = YES; //自分のやる夫の防御許可
    app.myGikoAttackPermittedFromEnemy = YES; //相手の妨害による自分のギコの攻撃許可
    app.myGikoDeffencePermittedFromEnemy = YES; //相手の制限による自分のギコの防御許可
    app.myMonarAttackPermittedFromEnemy = YES; //相手の制限による自分のモナーの攻撃許可
    app.myMonarDeffencePermittedFromEnemy = YES; //相手の制限による自分のモナーの防御許可
    app.mySyobonAttackPermittedFromEnemy = YES; //相手の制限による自分のショボンの攻撃許可
    app.mySyobonDeffencePermittedFromEnemy = YES; //相手の制限による自分のショボンの防御許可
    app.myYaruoAttackPermittedFromEnemy = YES; //相手の制限による自分のやる夫の攻撃許可
    app.myYaruoDeffencePermittedFromEnemy = YES; //相手の制限による自分のやる夫の防御許可
    app.doIUseCard = NO; //自分がこのターンカードを使用したか
    app.myDamageInBattlePhase = 0;
    app.myDamageFromAA = 0;
    app.myDamageFromCard = 0;
    app.mySelectColor = -1; //自分が選んだ色
    app.cardsIUsedInThisTurn = [[NSMutableArray alloc] init];
    
    
    
    //相手に関係する変数
    app.enemyLifeGage = 20;
    app.enemyDeckCardList = [[NSMutableArray alloc] init]; //相手のデッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
    app.enemyHand = [[NSMutableArray alloc] init]; //相手の手札
    app.enemyDeckCardListByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyDeckCardList（差分のみ管理）
    app.enemyHandByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyHand（差分のみ管理）
    app.enemyTombByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyTomb（差分のみ管理）
    app.enemyFieldCardByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyFieldCard（差分のみ管理）
    app.enemyEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //自分が操作し、増加したenemyEnergyCard（差分のみ管理）
    app.enemyDeckCardListByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyDeckCardList（差分のみ管理）
    app.enemyHandByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyHand（差分のみ管理）
    app.enemyTombByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyTomb（差分のみ管理）
    app.enemyFieldCardByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyFieldCard（差分のみ管理）
    app.enemyEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //自分が操作し、減少したenemyEnergyCard（差分のみ管理）
    app.enemyGikoFundamentalAttackPower = 3; // 相手のギコの基本攻撃力
    app.enemyGikoFundamentalDeffencePower = 1; //相手のギコの基本防御力
    app.enemyMonarFundamentalAttackPower = 3; //相手のモナーの基本攻撃力
    app.enemyMonarFundamentalDeffencePower = 1; //相手のモナーの基本防御力
    app.enemySyobonFundamentalAttackPower = 3; //相手のショボンの基本攻撃力
    app.enemySyobonFundamentalDeffencePower = 1; //相手のショボンの基本防御力
    app.enemyYaruoFundamentalAttackPower = 0; //相手のやる夫の基本攻撃力
    app.enemyYaruoFundamentalDeffencePower = 2; //相手のやる夫の基本防御力
    app.enemyGikoFundamentalAttackPowerByMyself = 0; // 自分が操作した相手のギコの基本攻撃力（差分のみ管理）
    app.enemyGikoFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のギコの基本防御力（差分のみ管理）
    app.enemyMonarFundamentalAttackPowerByMyself = 0; //自分が操作した相手のモナーの基本攻撃力（差分のみ管理）
    app.enemyMonarFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のモナーの基本防御力（差分のみ管理）
    app.enemySyobonFundamentalAttackPowerByMyself = 0; //自分が操作した相手のショボンの基本攻撃力（差分のみ管理）
    app.enemySyobonFundamentalDeffencePowerByMyself = 0; //相自分が操作した手のショボンの基本防御力（差分のみ管理）
    app.enemyYaruoFundamentalAttackPowerByMyself = 0; //自分が操作した相手のやる夫の基本攻撃力（差分のみ管理）
    app.enemyYaruoFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のやる夫の基本防御力（差分のみ管理）
    app.enemySelectCharacter = -1; //相手の選んだキャラクター
    app.enemySelectCharacterByMyself = -1;
    app.enemyGikoModifyingAttackPower = 0; // 相手のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemyGikoModifyingDeffencePower = 0; //相手のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemyMonarModifyingAttackPower = 0; //相手のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemyMonarModifyingDeffencePower = 0; //相手のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemySyobonModifyingAttackPower = 0; //相手のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemySyobonModifyingDeffencePower = 0; //相手のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemyYaruoModifyingAttackPower = 0; //相手のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemyYaruoModifyingDeffencePower = 0; //相手のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    app.enemyGikoModifyingAttackPowerByMyself = 0; // 自分が操作した相手のギコの修正攻撃力（差分のみ管理）
    app.enemyGikoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のギコの修正防御力（差分のみ管理）
    app.enemyMonarModifyingAttackPowerByMyself = 0; //自分が操作した相手のモナーの修正攻撃力（差分のみ管理）
    app.enemyMonarModifyingDeffencePowerByMyself = 0; //自分が操作した相手のモナーの修正防御力（差分のみ管理）
    app.enemySyobonModifyingAttackPowerByMyself = 0; //自分が操作した相手のショボンの修正攻撃力（差分のみ管理）
    app.enemySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した相手のショボンの修正防御力（差分のみ管理）
    app.enemyYaruoModifyingAttackPowerByMyself = 0; //自分が操作した相手のやる夫の修正攻撃力（差分のみ管理）
    app.enemyYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のやる夫の修正防御力（差分のみ管理）
    
    app.enemyGikoAttackPermittedByMyself = YES; //相手のギコの攻撃許可
    app.enemyGikoDeffencePermittedByMyself = YES; //相手のギコの防御許可
    app.enemyMonarAttackPermittedByMyself = YES; //相手のモナーの攻撃許可
    app.enemyMonarDeffencePermittedByMyself = YES; //相手のモナーの防御許可
    app.enemySyobonAttackPermittedByMyself = YES; //相手のショボンの攻撃許可
    app.enemySyobonDeffencePermittedByMyself = YES; //相手のショボンの防御許可
    app.enemyYaruoAttackPermittedByMyself = YES; //相手のやる夫の攻撃許可
    app.enemyYaruoDeffencePermittedByMyself = YES; //相手のやる夫の防御許可
    app.enemyGikoAttackPermittedFromEnemy = YES; //相手の制限による相手のギコの攻撃許可
    app.enemyGikoDeffencePermittedFromEnemy = YES; //相手の制限による相手のギコの防御許可
    app.enemyMonarAttackPermittedFromEnemy = YES; //相手の制限による相手のモナーの攻撃許可
    app.enemyMonarDeffencePermittedFromEnemy = YES; //相手の制限による相手のモナーの防御許可
    app.enemySyobonAttackPermittedFromEnemy = YES; //相手の制限による相手のショボンの攻撃許可
    app.enemySyobonDeffencePermittedFromEnemy = YES; //相手の制限による相手のショボンの防御許可
    app.enemyYaruoAttackPermittedFromEnemy = YES; //相手の制限による相手のやる夫の攻撃許可
    app.enemyYaruoDeffencePermittedFromEnemy = YES; //相手の制限による手のやる夫の防御許可
    app.enemyTomb = [[NSMutableArray alloc] init]; //相手の墓地のカードナンバー
    app.doEnemyUseCard = NO; //相手がこのターンカードを使用したか
    app.enemyFieldCard = [[NSMutableArray alloc] init]; //相手の場カードのカードナンバー
    app.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //相手のエネルギーカードの数
    app.canEnemyPlaySorceryCardByMyself = YES; //相手が魔法カードを手札からプレイできるか
    app.canEnemyPlayFieldCardByMyself = YES; //相手が場カードを手札からプレイできるか
    app.canEnemyActivateFieldCardByMyself = YES; //相手が場カードの能力を起動できるか
    app.canEnemyPlayEnergyCardByMyself = YES; //相手がエネルギーカードを手札からプレイできるか
    app.canEnemyActivateEnergyCardByMyself = YES; //相手がエネルギーカードを起動できるか
    app.canEnemyPlaySorceryCardFromEnemy = YES; //相手の制限により相手が魔法カードを手札からプレイできるか
    app.canEnemyPlayFieldCardFromEnemy = YES; //相手の制限により相手が場カードを手札からプレイできるか
    app.canEnemyActivateFieldCardFromEnemy = YES; //相手の制限により相手が場カードの能力を起動できるか
    app.canEnemyPlayEnergyCardFromEnemy = YES; //相手の制限により相手がエネルギーカードを手札からプレイできるか
    app.canEnemyActivateEnergyCardFromEnemy = YES; //相手の制限により相手がエネルギーカードを起動できるか
    app.denyEnemyCardPlaying = NO; //相手がカードのプレイを打ち消されたか
    app.enemyDamageInBattlePhase = 0;
    app.enemyDamageFromAA = 0;
    app.enemyDamageFromCard = 0;
    app.enemySelectColor = -1; //相手が選んだ色
    app.cardsEnemyUsedInThisTurn = [[NSMutableArray alloc] init];

    NSLog(@"初期化完了");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 10;
    
    // 入力済みのテキストを取得
    NSMutableString *str = [textField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];
    
    if ([str length] > maxInputLength) {
        // ※ここに文字数制限を超えたことを通知する処理を追加
        
        return NO;
    }
    
    return YES;
}


- (void)battleButtonPushed{
    //BGM鳴らす
    AudioServicesPlaySystemSound (app.tapSoundID);
    
    //バトル画面へ
    [self performSegueWithIdentifier:@"goToBattleView" sender:self];
}

- (void)deckButtonPushed{
    //BGM鳴らす
    AudioServicesPlaySystemSound (app.tapSoundID);
    
    //デッキ編成画面へ
    [self performSegueWithIdentifier:@"goToDeckView" sender:self];
}


//-------------------------プロローグ改定案ここから-------------------------//

- (void)startAnimation001{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"AA（アスキーアート）の世界へようこそ！" characterIsOnLeft:YES];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation002)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation002)]];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:battleButton, deckButton, nil] coveredView:self.view];
    [self.view addSubview:app.blackBack];
}

- (void)startAnimation002{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"このゲームはカードになったアスキーアート（AA）達を使って対戦するゲームだ。" characterIsOnLeft:YES];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003)]];
}
- (void)startAnimation003{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"世界中の人たちと対戦して、伝説のAAをゲットしよう！" characterIsOnLeft:YES];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003_2)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003_2)]];
}

- (void)startAnimation003_2{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"俺はこのゲームのチュートリアルを担当するギコだ。よろしくな。" characterIsOnLeft:YES];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation004)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation004)]];
}

- (void)startAnimation004{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"じゃあ、早速対戦をしてみよう。まずは対戦開始ボタンを押してくれ。" characterIsOnLeft:YES];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    
    app.arrow.right = battleButton.left;
    app.arrow.top = battleButton.top + 5;
    [self.view addSubview:app.arrow];
    
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:deckButton, nil] coveredView:self.view];
}

- (void)startAnimation132{
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"よし、これでバトルの解説は終わりだ。" characterIsOnLeft:NO];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation133)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation133)]];
    [app.blackBack removeFromSuperview];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:battleButton, deckButton, nil] coveredView:self.view];
    [self.view addSubview:app.blackBack];
    app.pbImage.userInteractionEnabled = YES;
}
- (void)startAnimation133{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"バトルに勝てば、必ず最上級のレアカードを手に入れられるぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134)]];}
- (void)startAnimation134{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"じゃあ早速、このカードをデッキに組み込んでみよう！" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134_2)]];}
- (void)startAnimation134_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあデッキ編成ボタンを押してくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:deckButton.frame forbidedArray:[[NSArray alloc] initWithObjects:battleButton, nil] coveredView:self.view];
}
- (void)startAnimation159{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"これでひと通りの説明は終わりだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation160)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation160)]];
    [app.blackBack removeFromSuperview];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:battleButton, deckButton, nil] coveredView:self.view];
    [self.view addSubview:app.blackBack];
}
- (void)startAnimation160{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"これからは伝説のAAゲットを目指して、どんどん対戦してくれ！" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack removeFromSuperview];
    //プロローグ終了。初回起動フラグをオフにする。
    [userDefault setInteger:3 forKey:@"firstLaunch_ud"];
    [userDefault synchronize];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: nil] coveredView:self.view];

}

//-------------------------プロローグ改定案ここまで-------------------------//

//- (void)startAnimation001{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro1" imagePath:@"png" textString:@"きたおー！" characterIsOnLeft:YES];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation002)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation002)]];
//    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:battleButton, deckButton, nil] coveredView:self.view];
//    [self.view addSubview:app.blackBack];
//}
//
//- (void)startAnimation002{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro2" imagePath:@"png" textString:@"って、なんだおこの画面は" characterIsOnLeft:YES];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003)]];
//}
//- (void)startAnimation003{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"お前がうちに来る間に色々調べてみたんだが、" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003_2)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation003_2)]];
//}
//
//- (void)startAnimation003_2{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"AAがカード化される現象は世界中に広がっているらしい。" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation004)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation004)]];
//}
//
//
//
//- (void)startAnimation004{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro4" imagePath:@"png" textString:@"大変だお！やる夫たちもカード化されてしまうお！" characterIsOnLeft:YES];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation005)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation005)]];
//}
//- (void)startAnimation005{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro5" imagePath:@"png" textString:@"だが、良いニュースもある。" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation006)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation006)]];
//}
//- (void)startAnimation006{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro6" imagePath:@"png" textString:@"なんだお？" characterIsOnLeft:YES];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation007)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation007)]];
//}
//- (void)startAnimation007{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro7" imagePath:@"png" textString:@"どうやらカード化されたAAは特殊な能力を持つようだ。" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation007_2)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation007_2)]];
//}
//
//- (void)startAnimation007_2{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro7" imagePath:@"png" textString:@"そのカードを使ってカードバトルをすれば、新しくカードを手に入るらしい。" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation008)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation008)]];
//}
//
//- (void)startAnimation008{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro8" imagePath:@"png" textString:@"……………………" characterIsOnLeft:YES];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation009)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation009)]];
//}
//- (void)startAnimation009{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro9" imagePath:@"png" textString:@"そうだお！カードバトルをして、みんなのカードを集めるお！" characterIsOnLeft:YES];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation010)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation010)]];
//}
//- (void)startAnimation010{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro10" imagePath:@"png" textString:@"ああ。カード化現象の解消方法はまだ分からないが、" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation010_2)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation010_2)]];
//}
//
//- (void)startAnimation010_2{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro10" imagePath:@"png" textString:@"ひとまずカード化されてしまったみんなを集めておいたほうが良いだろう。" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation011)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation011)]];
//}
//
//- (void)startAnimation011{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro11" imagePath:@"png" textString:@"それじゃあ早速バトルをしてみよう。まずは対戦ボタンを押してみろ。" characterIsOnLeft:NO];    [self.view addSubview:app.pbImage];    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation012)]];    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation012)]];
//}
//- (void)startAnimation012{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro12" imagePath:@"png" textString:@"押すお。" characterIsOnLeft:YES];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:battleButton.frame forbidedArray:[[NSArray alloc] initWithObjects:deckButton, nil] coveredView:self.view];
//}

//- (void)startAnimation132{
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro132" imagePath:@"png" textString:@"よし、これでバトルの解説は終わりだ。" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation133)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation133)]];
//    [app.blackBack removeFromSuperview];
//    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:battleButton, deckButton, nil] coveredView:self.view];
//    [self.view addSubview:app.blackBack];
//    app.pbImage.userInteractionEnabled = YES;
//}
//- (void)startAnimation133{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro133" imagePath:@"png" textString:@"やったお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134)]];}
//- (void)startAnimation134{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro134" imagePath:@"png" textString:@"バトルに勝てば、カードを手に入れることができる。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation134_2)]];}
//- (void)startAnimation134_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro134" imagePath:@"png" textString:@"さっき手に入れたカードはスーパーレアカードだったな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation136)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation136)]];}
//- (void)startAnimation136{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro135" imagePath:@"png" textString:@"やったお！超レアだお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation137)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation137)]];}
//- (void)startAnimation137{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro136" imagePath:@"png" textString:@"そういえば、まだカードのレアリティについて話していなかったな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation138)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation138)]];}
//- (void)startAnimation138{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro137" imagePath:@"png" textString:@"カードのレアリティは、レア度の低い方からノーマル・レア・スーパーレアと分かれている。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation139)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation139)]];}
//- (void)startAnimation139{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro138" imagePath:@"png" textString:@"今回手に入れたのはスーパーレアだから、一番良いカードだな！" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation140)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation140)]];}
//- (void)startAnimation140{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro139" imagePath:@"png" textString:@"やったお！さすがやる夫の運だお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation141)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation141)]];}
//- (void)startAnimation141{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro140" imagePath:@"png" textString:@"じゃあ早速、このカードをデッキに組み込んでみるか！" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation141_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation141_2)]];
//}
//- (void)startAnimation141_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro140" imagePath:@"png" textString:@"それじゃあデッキ編成ボタンを押してくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:deckButton.frame forbidedArray:[[NSArray alloc] initWithObjects:battleButton, nil] coveredView:self.view];
//}
//
//- (void)startAnimation159{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro158" imagePath:@"png" textString:@"これでひと通りの説明は終わりだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation160)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation160)]];
//    [app.blackBack removeFromSuperview];
//    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:battleButton, deckButton, nil] coveredView:self.view];
//    [self.view addSubview:app.blackBack];
//}
//- (void)startAnimation160{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro159" imagePath:@"png" textString:@"ありがとうだお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation161)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation161)]];}
//- (void)startAnimation161{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro160" imagePath:@"png" textString:@"これからどんどんカードバトルをこなして、カード化されたみんなを助けに行くお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack removeFromSuperview];
//    //プロローグ終了。初回起動フラグをオフにする。
//    [userDefault setInteger:3 forKey:@"firstLaunch_ud"];
//    [userDefault synchronize];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: nil] coveredView:self.view];
//}


- (void)removeViewOnPrologue:(UITapGestureRecognizer *)sender{
    for (UIView *view in app.pbImage.subviews) {
        [view removeFromSuperview];
    }
    [app.pbImage removeFromSuperview];
}



@end
