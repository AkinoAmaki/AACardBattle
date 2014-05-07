//
//  BattleScreenViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "BattleScreenViewController.h"

@interface BattleScreenViewController ()

@end

@implementation BattleScreenViewController

#pragma mark 初期化

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

    turnCount = 1;
    drawCount = 0;
    selectedCardOrder = -1;
    app.myUsingCardNumber = -1;
    selectedCardTag = -1;
    selectCardTag = -1;
    syncFinished = NO;
    doIUseCardInThisTurn = NO;
    cardIsCompletlyUsed = NO;
    
    _bc = [[BattleCaliculate alloc] init];
    
    _myCardImageViewArray = [[NSMutableArray alloc] init];
    _myCardImageView_middle = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 135 - 10, 90 , 135)];
    [_allImageView addSubview:_myCardImageView_middle];
    _myCardTextView_middle = [[UITextView alloc] initWithFrame:CGRectMake(115, [[UIScreen mainScreen] bounds].size.height - 135 - 10, 135, 135)];
    [_allImageView addSubview:_myCardTextView_middle];
    _myCardTextView_middle.editable = NO;
    
    _allImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _allImageView.userInteractionEnabled = YES;
    
    _myCardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _myCardImageView.userInteractionEnabled = YES;
    [_allImageView addSubview:_myCardImageView];
    
    _border_character = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_character.png"]];
    _border_middleCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_middleCard.png"]];
    
    _additionalCostView = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 60, [[UIScreen mainScreen] bounds].size.width - 40 , 400)];
    
    _cardInRegion = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 60, [[UIScreen mainScreen] bounds].size.width - 40 , 400)];
    
    _colorView = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 60, [[UIScreen mainScreen] bounds].size.width - 40 , 400)];
    
    _okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_okButton setTitle:@"OK" forState:UIControlStateNormal];
    [_allImageView addSubview:_okButton];
    _okButton.frame = CGRectMake(_allImageView.bounds.size.width - 110, _allImageView.bounds.size.height - 130, 100, 20);
    [_okButton addTarget:self action:@selector(okButton)
          forControlEvents:UIControlEventTouchUpInside];
    
    

    UIImage *img_myGiko     = [UIImage imageNamed:@"c0r.PNG"];
    UIImage *img_myMonar     = [UIImage imageNamed:@"c5r.PNG"];
    UIImage *img_mySyobon         = [UIImage imageNamed:@"c7r.PNG"];
    UIImage *img_myYaruo     = [UIImage imageNamed:@"c1r.PNG"];
    UIImage *img_enemyGiko  = [UIImage imageNamed:@"c0r.PNG"];
    UIImage *img_enemyMonar  = [UIImage imageNamed:@"c5r.PNG"];
    UIImage *img_enemySyobon      = [UIImage imageNamed:@"c7r.PNG"];
    UIImage *img_enemyYaruo  = [UIImage imageNamed:@"c1r.PNG"];
    
    UIImageView *chara_myGiko       = [[UIImageView alloc] initWithImage:img_myGiko];
    UIImageView *chara_myMonar       = [[UIImageView alloc] initWithImage:img_myMonar];
    UIImageView *chara_mySyobon           = [[UIImageView alloc] initWithImage:img_mySyobon];
    UIImageView *chara_myYaruo       = [[UIImageView alloc] initWithImage:img_myYaruo];
    UIImageView *chara_enemyGiko    = [[UIImageView alloc] initWithImage:img_enemyGiko];
    UIImageView *chara_enemyMonar    = [[UIImageView alloc] initWithImage:img_enemyMonar];
    UIImageView *chara_enemySyobon        = [[UIImageView alloc] initWithImage:img_enemySyobon];
    UIImageView *chara_enemyYaruo    = [[UIImageView alloc] initWithImage:img_enemyYaruo];
    
    chara_myGiko.frame      = CGRectMake(48,  50,  32, 48);
    chara_myMonar.frame      = CGRectMake(48,  98,  32, 48);
    chara_mySyobon.frame          = CGRectMake(48, 146,  32, 48);
    chara_myYaruo.frame      = CGRectMake(80,  98,  32, 48);
    chara_enemyGiko.frame   = CGRectMake(240,  50,  32, 48);
    chara_enemyMonar.frame   = CGRectMake(240,  98,  32, 48);
    chara_enemySyobon.frame       = CGRectMake(240,  146, 32, 48);
    chara_enemyYaruo.frame   = CGRectMake(208,  98,  32, 48);
    
    chara_myGiko.userInteractionEnabled     = YES;
    chara_myMonar.userInteractionEnabled     = YES;
    chara_mySyobon.userInteractionEnabled         = YES;
    chara_myYaruo.userInteractionEnabled     = YES;
    chara_enemyGiko.userInteractionEnabled  = YES;
    chara_enemyMonar.userInteractionEnabled  = YES;
    chara_enemySyobon.userInteractionEnabled      = YES;
    chara_enemyYaruo.userInteractionEnabled  = YES;
    
    
    chara_myGiko.tag    = GIKO;
    chara_myMonar.tag    = MONAR;
    chara_mySyobon.tag        = SYOBON;
    chara_myYaruo.tag    = YARUO;
    /*
    chara_enemyGiko.tag = ;
    chara_enemyMonar.tag = ;
    chara_enemySYOBON.tag     = ;
    chara_enemyYaruo.tag = ;
     */
    
    [chara_myGiko addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
    [chara_myMonar addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
    [chara_mySyobon addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
    [chara_myYaruo addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
//    [chara_enemyGiko addGestureRecognizer:
//     [[UITapGestureRecognizer alloc]
//      initWithTarget:self action:@selector(touchesBegan:)]];
//    [chara_enemyMonar addGestureRecognizer:
//     [[UITapGestureRecognizer alloc]
//      initWithTarget:self action:@selector(touchesBegan:)]];
//    [chara_enemySyobon addGestureRecognizer:
//     [[UITapGestureRecognizer alloc]
//      initWithTarget:self action:@selector(touchesBegan:)]];
//    [chara_enemyYaruo addGestureRecognizer:
//     [[UITapGestureRecognizer alloc]
//      initWithTarget:self action:@selector(touchesBegan:)]];

    [_allImageView addSubview:chara_myGiko];
    [_allImageView addSubview:chara_myMonar];
    [_allImageView addSubview:chara_mySyobon];
    [_allImageView addSubview:chara_myYaruo];
    [_allImageView addSubview:chara_enemyGiko];
    [_allImageView addSubview:chara_enemyMonar];
    [_allImageView addSubview:chara_enemySyobon];
    [_allImageView addSubview:chara_enemyYaruo];
    
    
    
    
    //エネルギーの数を表示するビューを作成
    _whiteEnergyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteEnergyImage"]];
    _blueEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueEnergyImage"]];
    _blackEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackEnergyImage"]];
    _redEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redEnergyImage"]];
    _greenEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenEnergyImage"]];
    
    _allEnergy = [[UIImageView alloc] init];
    [_allEnergy addSubview:_whiteEnergyImage];
    [_allEnergy addSubview:_blueEnergyImage];
    [_allEnergy addSubview:_blackEnergyImage];
    [_allEnergy addSubview:_redEnergyImage];
    [_allEnergy addSubview:_greenEnergyImage];
    
    _whiteEnergyImage.frame = CGRectMake(0,  0, 20, 20);
    _blueEnergyImage.frame  = CGRectMake(0, 20, 20, 20);
    _blackEnergyImage.frame = CGRectMake(0, 40, 20, 20);
    _redEnergyImage.frame   = CGRectMake(0, 60, 20, 20);
    _greenEnergyImage.frame = CGRectMake(0, 80, 20, 20);

    
    _whiteEnergyText = [[UITextView alloc] init];
    _blueEnergyText = [[UITextView alloc] init];
    _blackEnergyText = [[UITextView alloc] init];
    _redEnergyText = [[UITextView alloc] init];
    _greenEnergyText = [[UITextView alloc] init];
    
    _whiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:0] intValue]];
    _blueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:1] intValue]];
    _blackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:2] intValue]];
    _redEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:3] intValue]];
    _greenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:4] intValue]];
    
    [_allEnergy addSubview:_whiteEnergyText];
    [_allEnergy addSubview:_blueEnergyText];
    [_allEnergy addSubview:_blackEnergyText];
    [_allEnergy addSubview:_redEnergyText];
    [_allEnergy addSubview:_greenEnergyText];
    
    _whiteEnergyText.frame = CGRectMake(20,  0, 40, 20);
    _blueEnergyText.frame  = CGRectMake(20, 20, 40, 20);
    _blackEnergyText.frame = CGRectMake(20, 40, 40, 20);
    _redEnergyText.frame   = CGRectMake(20, 60, 40, 20);
    _greenEnergyText.frame = CGRectMake(20, 80, 40, 20);
    
    [_allImageView addSubview: _allEnergy];
    _allEnergy.frame = CGRectMake(_allEnergy.superview.bounds.size.width - 60, _allEnergy.superview.bounds.size.height - 300, 20, 60);
    
    
    _myGiko = [[UILabel alloc] init];
    _myMonar = [[UILabel alloc] init];
    _mySyobon = [[UILabel alloc] init];
    _myYaruo = [[UILabel alloc] init];
    _enemyGiko = [[UILabel alloc] init];
    _enemyMonar = [[UILabel alloc] init];
    _enemySyobon = [[UILabel alloc] init];
    _enemyYaruo = [[UILabel alloc] init];
    
    
    
    [self.view addSubview:_allImageView];    
    
//--------------------------デバッグ用ボタン-----------------------------------
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(160, 240, 80, 20);
    [startButton setTitle:@"開始" forState:UIControlStateNormal];
    [_allImageView addSubview:startButton];
    [startButton addTarget:self action:@selector(battleStart)
          forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *getButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    getButton.frame = CGRectMake(160, 280, 80, 20);
    [getButton setTitle:@"ゲット" forState:UIControlStateNormal];
    [_allImageView addSubview:getButton];
    [getButton addTarget:self action:@selector(getACardForDebug)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *debug1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    debug1.frame = CGRectMake(160, 300, 80, 20);
    [debug1 setTitle:@"デバッグ1" forState:UIControlStateNormal];
    [_allImageView addSubview:debug1];
    [debug1 addTarget:self action:@selector(debug1:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *debug2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    debug2.frame = CGRectMake(160, 320, 80, 20);
    [debug2 setTitle:@"デバッグ2" forState:UIControlStateNormal];
    [_allImageView addSubview:debug2];
    [debug2 addTarget:self action:@selector(debug2:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *debug3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    debug3.frame = CGRectMake(160, 340, 80, 20);
    [debug3 setTitle:@"デバッグ3" forState:UIControlStateNormal];
    [_allImageView addSubview:debug3];
    [debug3 addTarget:self action:@selector(debug3:)
     forControlEvents:UIControlEventTouchUpInside];
    
    
//--------------------------デバッグ用ボタンここまで-----------------------------
    
}

//--------------------------デバッグ用ボタン実装ここから-----------------------------

-(void)getACardForDebug{
    [self getACard:MYSELF];
}

- (void)debug1 :(UITapGestureRecognizer *)sender{
    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    
    NSArray *myBattleData_parameter = [[NSArray alloc] initWithObjects:
                                       [NSNumber numberWithInt:app.playerID],
                                      [NSNumber numberWithInt:app.myLifeGage],
                                      app.myDeckCardList,
                                      app.myHand,
                                      [NSNumber numberWithInt:app.myGikoFundamentalAttackPower],
                                      [NSNumber numberWithInt:app.myGikoFundamentalDeffencePower],
                                      [NSNumber numberWithInt:app.myMonarFundamentalAttackPower],
                                      [NSNumber numberWithInt:app.myMonarFundamentalDeffencePower],
                                      [NSNumber numberWithInt:app.mySyobonFundamentalAttackPower],
                                      [NSNumber numberWithInt:app.mySyobonFundamentalDeffencePower],
                                      [NSNumber numberWithInt:app.myYaruoFundamentalAttackPower],
                                      [NSNumber numberWithInt:app.myYaruoFundamentalDeffencePower],
                                      [NSNumber numberWithInt:app.mySelectCharacter],
                                      [NSNumber numberWithInt:app.myCharacterFundamentalAttackPower],
                                      [NSNumber numberWithInt:app.myCharacterFundamentalDeffencePower],
                                      [NSNumber numberWithInt:app.myGikoModifyingAttackPower],
                                      [NSNumber numberWithInt:app.myGikoModifyingDeffencePower],
                                      [NSNumber numberWithInt:app.myMonarModifyingAttackPower],
                                      [NSNumber numberWithInt:app.myMonarModifyingDeffencePower],
                                      [NSNumber numberWithInt:app.mySyobonModifyingAttackPower],
                                      [NSNumber numberWithInt:app.mySyobonModifyingDeffencePower],
                                      [NSNumber numberWithInt:app.myYaruoModifyingAttackPower],
                                      [NSNumber numberWithInt:app.myYaruoModifyingDeffencePower],
                                      [NSNumber numberWithInt:app.myCharacterModifyingAttackPower],
                                      [NSNumber numberWithInt:app.myCharacterModifyingDeffencePower],
                                      [NSNumber numberWithBool:app.myGikoAttackPermitted],
                                      [NSNumber numberWithBool:app.myGikoDeffencePermitted],
                                      [NSNumber numberWithBool:app.myMonarAttackPermitted],
                                      [NSNumber numberWithBool:app.myMonarDeffencePermitted],
                                      [NSNumber numberWithBool:app.mySyobonAttackPermitted],
                                      [NSNumber numberWithBool:app.mySyobonDeffencePermitted],
                                      [NSNumber numberWithBool:app.myYaruoAttackPermitted],
                                      [NSNumber numberWithBool:app.myYaruoDeffencePermitted],
                                      app.myTomb,
                                      [NSNumber numberWithBool:app.doIUseCard],
                                      [NSNumber numberWithInt:app.myUsingCardNumber],
                                      app.myFieldCard,
                                      app.myEnergyCard,
                                      [NSNumber numberWithBool:app.canIPlaySorceryCard],
                                      [NSNumber numberWithBool:app.canIPlayFieldCard],
                                      [NSNumber numberWithBool:app.canIActivateFieldCard],
                                      [NSNumber numberWithBool:app.canIPlayEnergyCard],
                                      [NSNumber numberWithBool:app.canIActivateEnergyCard],
                                      [NSNumber numberWithBool:app.denymyCardPlaying],
                                      [NSNumber numberWithInt:app.myDamage],
                                      [NSNumber numberWithInt:app.mySelectColor],
                                      app.cardsIUsedInThisTurn,
                                     nil];
    
    NSArray *myBattleData_key = [[NSArray alloc] initWithObjects:
                                 @"playerID",
                                 @"myLifeGage",
                                 @"myDeckCardList",
                                 @"myHand",
                                 @"myGikoFundamentalAttackPower",
                                 @"myGikoFundamentalDeffencePower",
                                 @"myMonarFundamentalAttackPower",
                                 @"myMonarFundamentalDeffencePower",
                                 @"mySyobonFundamentalAttackPower",
                                 @"mySyobonFundamentalDeffencePower",
                                 @"myYaruoFundamentalAttackPower",
                                 @"myYaruoFundamentalDeffencePower",
                                 @"mySelectCharacter",
                                 @"myCharacterFundamentalAttackPower",
                                 @"myCharacterFundamentalDeffencePower",
                                 @"myGikoModifyingAttackPower",
                                 @"myGikoModifyingDeffencePower",
                                 @"myMonarModifyingAttackPower",
                                 @"myMonarModifyingDeffencePower",
                                 @"mySyobonModifyingAttackPower",
                                 @"mySyobonModifyingDeffencePower",
                                 @"myYaruoModifyingAttackPower",
                                 @"myYaruoModifyingDeffencePower",
                                 @"myCharacterModifyingAttackPower",
                                 @"myCharacterModifyingDeffencePower",
                                 @"myGikoAttackPermitted",
                                 @"myGikoDeffencePermitted",
                                 @"myMonarAttackPermitted",
                                 @"myMonarDeffencePermitted",
                                 @"mySyobonAttackPermitted",
                                 @"mySyobonDeffencePermitted",
                                 @"myYaruoAttackPermitted",
                                 @"myYaruoDeffencePermitted",
                                 @"myTomb",
                                 @"doIUseCard",
                                 @"myUsingCardNumber",
                                 @"myFieldCard",
                                 @"myEnergyCard",
                                 @"canIPlaySorceryCard",
                                 @"canIPlayFieldCard",
                                 @"canIActivateFieldCard",
                                 @"canIPlayEnergyCard",
                                 @"canIActivateEnergyCard",
                                 @"denymyCardPlaying",
                                 @"myDamage",
                                 @"mySelectColor",
                                 @"cardsIUsedInThisTurn",
                                 nil];
    

    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:myBattleData_parameter forKeys:myBattleData_key];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    //     //外部から接続する場合
    NSString *url = @"http://utakatanet.dip.jp:58080/test.php";
    //     //内部から接続する場合
    //NSString *url = @"http://192.168.10.176:58080/test.php";
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

- (void)debug2 :(UITapGestureRecognizer *)sender{    
    getlocation = [[GetLocation alloc] init];
    [getlocation sendLocationDataToServer];

}

- (void)debug3 :(UITapGestureRecognizer *)sender{
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
    NSString *dateString = [df stringFromDate:[NSDate date]];
    // ログに出力
    NSLog(@"%@", dateString);
}

//--------------------------デバッグ用ボタン実装ここまで-----------------------------


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchesBegan: (UITapGestureRecognizer *)sender{

    [_border_character removeFromSuperview];
    _border_character.frame = sender.view.frame;
    [_allImageView addSubview:_border_character];
    
    switch (sender.view.tag) {
        case 1:
            app.mySelectCharacter = GIKO;
            app.myCharacterFundamentalAttackPower = app.myGikoFundamentalAttackPower;
            app.myCharacterFundamentalDeffencePower = app.myGikoFundamentalDeffencePower;
            NSLog(@"選択キャラ：ギコ");
            break;
        case 2:
            
            app.mySelectCharacter = MONAR;
            app.myCharacterFundamentalAttackPower = app.myMonarFundamentalAttackPower;
            app.myCharacterFundamentalDeffencePower = app.myMonarFundamentalDeffencePower;
            NSLog(@"選択キャラ：モナー");
            break;
        case 3:
            app.mySelectCharacter = SYOBON;
            app.myCharacterFundamentalAttackPower = app.mySyobonFundamentalAttackPower;
            app.myCharacterFundamentalDeffencePower = app.mySyobonFundamentalDeffencePower;
            NSLog(@"選択キャラ：ショボン");
            break;
        case 4:
            app.mySelectCharacter = YARUO;
            app.myCharacterFundamentalAttackPower = app.myYaruoFundamentalAttackPower;
            app.myCharacterFundamentalDeffencePower = app.myYaruoFundamentalDeffencePower;
            NSLog(@"選択キャラ：やる夫");
            break;
        default:
            break;
    }
    NSLog(@"攻撃力：%d",app.myCharacterFundamentalAttackPower);
    NSLog(@"防御力：%d",app.myCharacterFundamentalDeffencePower);
}


- (IBAction)nextTurn{
    //ターン開始時
    //[self phaseNameFadeIn:[NSString stringWithFormat:@"%dターン目", turnCount]];
    [self phaseNameFadeIn:[NSString stringWithFormat:@"%dターン目　ターン開始フェイズ", turnCount++]];
    [self syncronize];
    [self activateFieldCardInTiming:0];
    [self turnStartFadeIn:_turnStartView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self syncronize];
    
    
    //カード使用後
    [self phaseNameFadeIn:@"カード使用フェイズです。使用するカードを選択してください。"];
    [self syncronize];
    
    
    //touchActionの入力を待つための同期処理
    while (cardIsCompletlyUsed == NO) {
        [self syncronize];
    }
    
    [self activateFieldCardInTiming:1];
    [self cardActivateFadeIn:_afterCardUsedView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self syncronize];

    //ダメージ計算
    [self phaseNameFadeIn:@"ダメージ計算フェイズ"];
    [self syncronize];
    [self activateFieldCardInTiming:2];
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    NSLog(@"自分の職種＿計算時：%d",app.mySelectCharacter);
    
    app.enemySelectCharacter = GIKO;
    [self damageCaliculateFadeIn:_damageCaliculateView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self syncronize];
    //ターン終了時
    [self phaseNameFadeIn:@"ターン終了フェイズ"];
    [self syncronize];
    [self activateFieldCardInTiming:3];
    [self resultFadeIn:_turnResultView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self syncronize];
    
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    NSLog(@"自分のHP：%d",app.myLifeGage);
    NSLog(@"自分のギコの基本攻撃力　　：%d　＋　自分のギコの修正攻撃力　　：%d",app.myGikoFundamentalAttackPower,app.myGikoModifyingAttackPower);
    NSLog(@"自分のモナーの基本攻撃力　：%d　＋　自分のモナーの修正攻撃力　：%d",app.myMonarFundamentalAttackPower,app.myMonarModifyingAttackPower);
    NSLog(@"自分のショボンの基本攻撃力：%d　＋　自分のショボンの修正攻撃力：%d",app.mySyobonFundamentalAttackPower,app.mySyobonModifyingAttackPower);
    NSLog(@"自分のやる夫の基本攻撃力　：%d　＋　自分のやる夫の修正攻撃力　：%d",app.myYaruoFundamentalAttackPower,app.myYaruoModifyingAttackPower);
    NSLog(@"自分のギコの基本防御力　　：%d　＋　自分のギコの修正防御力　　：%d",app.myGikoFundamentalDeffencePower,app.myGikoModifyingDeffencePower);
    NSLog(@"自分のモナーの基本防御力　：%d　＋　自分のモナーの修正防御力　：%d",app.myMonarFundamentalDeffencePower,app.myMonarModifyingDeffencePower);
    NSLog(@"自分のショボンの基本防御力：%d　＋　自分のショボンの修正防御力：%d",app.mySyobonFundamentalDeffencePower,app.mySyobonModifyingDeffencePower);
    NSLog(@"自分のやる夫の基本防御力　：%d　＋　自分のやる夫の修正防御力　：%d\n",app.myYaruoFundamentalDeffencePower,app.myYaruoModifyingDeffencePower);
    NSLog(@"相手のHP：%d",app.enemyLifeGage);
    NSLog(@"相手のギコの基本攻撃力：　　%d　＋　相手のギコの修正攻撃力　　：%d",app.enemyGikoFundamentalAttackPower,app.enemyGikoModifyingAttackPower);
    NSLog(@"相手のモナーの基本攻撃力　：%d　＋　相手のモナーの修正攻撃力　：%d",app.enemyMonarFundamentalAttackPower,app.enemyMonarModifyingAttackPower);
    NSLog(@"相手のショボンの基本攻撃力：%d　＋　相手のショボンの修正攻撃力：%d",app.enemySyobonFundamentalAttackPower,app.enemySyobonModifyingAttackPower);
    NSLog(@"相手のやる夫の基本攻撃力　：%d　＋　相手のやる夫の修正攻撃力　：%d",app.enemyYaruoFundamentalAttackPower,app.enemyYaruoModifyingAttackPower);
    NSLog(@"相手のギコの基本防御力　　：%d　＋　相手のギコの修正防御力　　：%d",app.enemyGikoFundamentalDeffencePower,app.enemyGikoModifyingDeffencePower);
    NSLog(@"相手のモナーの基本防御力　：%d　＋　相手のモナーの修正防御力　：%d",app.enemyMonarFundamentalDeffencePower,app.enemyMonarModifyingDeffencePower);
    NSLog(@"相手のショボンの基本防御力：%d　＋　相手のショボンの修正防御力：%d",app.enemySyobonFundamentalDeffencePower,app.enemySyobonModifyingDeffencePower);
    NSLog(@"相手のやる夫の基本防御力　：%d　＋　相手のやる夫の修正防御力　：%d",app.enemyYaruoFundamentalDeffencePower,app.enemyYaruoModifyingDeffencePower);
    
    NSLog(@"自分の手札：%@",app.myHand);
    NSLog(@"自分のフィールドカード置き場：%@",app.myFieldCard);
    NSLog(@"自分の墓地：%@",app.myTomb);
    NSLog(@"-----------------------------------");
    
    
    if(app.mySelectCharacter == YARUO){
        [self getACard:MYSELF];
        
    }
    [self getACard:MYSELF];
    [self intializeVariables];
    [self nextTurn];
    
    
    NSLog(@"-----------------------------------");
    
    
}
#pragma mark カード効果実装

-(void)cardActivate :(int)cardnumber{
    switch (cardnumber) {
        case 6:
            //対象キャラの防御力１ターンだけ＋３（W)
            [self createCharacterField:_allImageView];
            [self syncronize];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            
            break;
        case 7:
            //対象キャラの防御力ずっと＋３（W2)
            [self createCharacterField:_allImageView];
            [self syncronize];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:3 temporary:0];
            break;
        case 8:
            //自分のライフ＋３（W)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:3];
            break;
        case 9:
            //自分のライフ＋３、カードを一枚引く（W２）
            app.myLifeGage = [self HPOperate:app.myLifeGage point:3];
            [self getACard:MYSELF];
            break;
        case 10:
            //毎ターンライフを＋１する（W２)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:1];
            break;
        case 11:
            //相手プレイヤーが白色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == WHITE) {
                app.myLifeGage = [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 12:
            //相手プレイヤーが青色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == BLUE) {
                app.myLifeGage = [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 13:
            //相手プレイヤーが黒色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == BLACK) {
                app.myLifeGage = [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 14:
            //相手プレイヤーが赤色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == RED) {
                app.myLifeGage = [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 15:
            //相手プレイヤーが緑色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == GREEN) {
                app.myLifeGage = [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 16:
            //白色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == WHITE){
                [self myDeffencePowerOperate:GIKO point:1 temporary:1];
                [self myDeffencePowerOperate:MONAR point:1 temporary:1];
                [self myDeffencePowerOperate:SYOBON point:1 temporary:1];
                [self myDeffencePowerOperate:YARUO point:1 temporary:1];
                
            }
            break;
        case 17:
            //青色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == BLUE){
                [self myDeffencePowerOperate:GIKO point:1 temporary:1];
                [self myDeffencePowerOperate:MONAR point:1 temporary:1];
                [self myDeffencePowerOperate:SYOBON point:1 temporary:1];
                [self myDeffencePowerOperate:YARUO point:1 temporary:1];
                
            }
            break;
        case 18:
            //黒色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == BLACK){
                [self myDeffencePowerOperate:GIKO point:1 temporary:1];
                [self myDeffencePowerOperate:MONAR point:1 temporary:1];
                [self myDeffencePowerOperate:SYOBON point:1 temporary:1];
                [self myDeffencePowerOperate:YARUO point:1 temporary:1];
                
            }
            break;
        case 19:
            //赤色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == RED){
                [self myDeffencePowerOperate:GIKO point:1 temporary:1];
                [self myDeffencePowerOperate:MONAR point:1 temporary:1];
                [self myDeffencePowerOperate:SYOBON point:1 temporary:1];
                [self myDeffencePowerOperate:YARUO point:1 temporary:1];
                
            }
            break;
        case 20:
            //緑色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == GREEN){
                [self myDeffencePowerOperate:GIKO point:1 temporary:1];
                [self myDeffencePowerOperate:MONAR point:1 temporary:1];
                [self myDeffencePowerOperate:SYOBON point:1 temporary:1];
                [self myDeffencePowerOperate:YARUO point:1 temporary:1];
                
            }
            break;
        case 21:
            //このターン、相手のギコに攻撃させない（W）
            [self forbidAttack:app.enemyGikoAttackPermitted];
           
            break;
        case 22:
            //このターン、相手のモナーに攻撃させない（W）
            [self forbidAttack:app.enemyMonarAttackPermitted];
            break;
        case 23:
             //このターン、相手のショボンに攻撃させない（W）
            [self forbidAttack:app.enemySyobonAttackPermitted];
            break;
        case 24:
            //このターン、相手に防御させない（W２)
            [self forbidDeffence:app.enemyGikoDeffencePermitted];
            [self forbidDeffence:app.enemyMonarDeffencePermitted];
            [self forbidDeffence:app.enemySyobonDeffencePermitted];
            [self forbidDeffence:app.enemyYaruoDeffencePermitted];
            break;
        case 25:
            //このカードが出ている限りターン、相手に防御させない（WW３)
            [self forbidDeffence:app.enemyGikoDeffencePermitted];
            [self forbidDeffence:app.enemyMonarDeffencePermitted];
            [self forbidDeffence:app.enemySyobonDeffencePermitted];
            [self forbidDeffence:app.enemyYaruoDeffencePermitted];
            break;
        case 26:
            //手札のカード枚数×２のライフ回復（WW2)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:[app.myHand count] * 2];
            break;
        case 27:
            //自分に与えられる４点以上のダメージは３点になる（W5)
            [self decreaseDamage:app.myDamage borderOfDamage:4 damageAfterDecreasing:3];
            break;
        case 28:
            //TODO: 互いに全てのエネルギーカードを破壊する（W4)
            {
                int numberOfMyEnergy = [app.myEnergyCard count];
                for(int i = 0; i < numberOfMyEnergy; i++){
                    [self setCardFromXTOY:app.myEnergyCard cardNumber:0 toField:app.myTomb];
                }
            }
            {
                int numberOfEnemyEnergy = [app.enemyEnergyCard count];
                for (int i = 0; i < numberOfEnemyEnergy; i++) {
                    [self setCardFromXTOY:app.enemyEnergyCard cardNumber:0 toField:app.enemyTomb];
                }
            }
            
            break;
        case 29:
            //互いに与えるダメージをゼロにする
            [self damage0:app.myDamage];
            [self damage0:app.enemyDamage];
            break;
        case 30:
            //対象の場カードを破壊する
            [self browseCardsInRegion:app.enemyFieldCard];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 31:
            //クルセで攻撃できる（W2)
            [self permitAttack:app.myYaruoAttackPermitted];
            break;
        case 32:
            //相手のライブラリーを１枚削る（W)
            [self discardFromLibrary:ENEMY tagNumber:0];
            break;
        case 33:
            //相手のライブラリーを２枚削る（W１）
            [self discardFromLibrary:ENEMY tagNumber:0];
            [self discardFromLibrary:ENEMY tagNumber:0];
            break;
        case 34:
            //相手のライブラリーを半分削る（WW2)
            for (int i = 0; i < [app.enemyDeckCardList count] / 2; i++) {
                [self discardFromLibrary:ENEMY tagNumber:0];
            }
            break;
        case 35:
            //エネルギーカードの種類数×2だけライフを回復する（W）
            app.myLifeGage = [self HPOperate:app.myLifeGage point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * 2];
            break;
        case 36:
            //カードを１枚引き、１枚捨てる（U1)
            [self getACard:MYSELF];
            [self browseCardsInRegion:app.myHand];
            [self discardFromHand:MYSELF cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 37:
            //カードを２枚引く（UU1)
            [self getACard:MYSELF];
            [self getACard:MYSELF];
            break;
        case 38:
            //カードを３枚引く（UU２)
            [self getACard:MYSELF];
            [self getACard:MYSELF];
            [self getACard:MYSELF];
            break;
        case 39:
            
            break;
        case 40:
            
            break;
        case 41:
            
            break;
        case 42:
            
            break;
        case 43:
            
            break;
        case 44:
            //対象キャラの攻撃力 −３（U1)
            [self createCharacterField:_allImageView];
            [self enemyAttackPowerOperate:mySelectCharacterInCharacterField point:-3 temporary:1];
            break;
        case 45:
            //対象の場カードを手札に戻す（UU)
            [self browseCardsInRegion:app.enemyFieldCard];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyHand];
            
            break;
        case 46:
            //相手の全ての場カードとエネルギーカードをオーナーの手札に戻す（UU4)
            {
                //場カードを戻す
                int i1 = [app.enemyFieldCard count];
                for (int k = 0; k < i1; k++) {
                    [self setCardFromXTOY:app.enemyFieldCard cardNumber:0 toField:app.enemyHand];
                }
                
                //エネルギーカードを戻す
                int i2 = [app.enemyEnergyCard count];
                for (int k = 0; k < i2; k++) {
                    [self setCardFromXTOY:app.enemyEnergyCard cardNumber:0 toField:app.enemyHand];
                }
            }
            break;
        case 47:
            //対象の場カードを自分のものにする（UU3)
            [self browseCardsInRegion:app.enemyFieldCard];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyHand];
            break;
        case 48:
            //対象のカードをオーナーの手札に戻し、カードを一枚引く（UU2)
            
        case 49:
            //特定色のフィールドカードを全てオーナーの手札に戻す（U3)
        {
            //手札に戻す色を選ぶ
            [self colorSelect];
            
            //自分の場のカードを判定
            int i1 = [app.myFieldCard count];
            int myRemoveCount = 0;
            for (int i = 0; i < i1; i++) {
                if([self distinguishCardColor:(int)[app.myFieldCard objectAtIndex:i]] == app.mySelectColor){
                    [self setCardFromXTOY:app.myFieldCard cardNumber:i - myRemoveCount toField:app.myHand];
                    myRemoveCount++;
                }
            }
            
            //相手の場のカードを判定
            int i2 = [app.enemyFieldCard count];
            int enemyRemoveCount = 0;
            for (int i = 0; i < i2; i++) {
                if([self distinguishCardColor:(int)[app.enemyFieldCard objectAtIndex:i]] == [self substituteSelectColorTagAndInitilizeIt]){
                    [self setCardFromXTOY:app.enemyFieldCard cardNumber:i - enemyRemoveCount toField:app.enemyHand];
                }
            }
        }
            break;
        case 50:
            //一番上のカードを見て、取るか一番下に置く（U)
            [self browseLibrary:app.myDeckCardList numberOfBrowsingCard:1];
            _putACardToLibraryTopOrBottom = [[UIAlertView alloc] initWithTitle:@"選択" message:@"山札のどちらにおきますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"一番上", @"一番下", nil];
            break;
        case 51:
            //攻撃キャラをギコにする（U2)
            app.enemySelectCharacter = GIKO;
            break;
        case 52:
            //攻撃キャラをモナーにする（U2)
            app.enemySelectCharacter = MONAR;
            break;
        case 53:
            //攻撃キャラをショボンにする（U2)
            app.enemySelectCharacter = SYOBON;
            break;
        case 54:
            //このターンキャラの相性関係を逆転させる（U2)
            [self reverseCaliculate:MYSELF];
            [self reverseCaliculate:ENEMY];
            
            break;
        case 55:
            //次ターン、相手にカードを使わせない（U4)
            [self dontPermitCardPlay:ENEMY cardType:ENERGYCARD];
            [self dontPermitCardPlay:ENEMY cardType:FIELDCARD];
            [self dontPermitCardPlay:ENEMY cardType:SORCERYCARD];
            break;
        case 56:
            //エネルギーカードの種類数だけカードを引く（U2)
        {
            int num = [self distinguishTheNumberOfEnergyCardColor:MYSELF];
            
            for (int i = 0; i < num; i++) {
                [self getACard:MYSELF];
            }
        }
            break;
        case 57:
            //相手キャラは攻撃・防御できない。別のカードが使われたとき、これは破壊される（U1)
            [self forbidAttack:app.enemyGikoAttackPermitted];
            [self forbidAttack:app.enemyMonarAttackPermitted];
            [self forbidAttack:app.enemySyobonAttackPermitted];
            [self forbidAttack:app.enemyYaruoAttackPermitted];
            [self forbidDeffence:app.enemyGikoDeffencePermitted];
            [self forbidDeffence:app.enemyMonarDeffencePermitted];
            [self forbidDeffence:app.enemySyobonDeffencePermitted];
            [self forbidDeffence:app.enemyYaruoDeffencePermitted];
            break;
        case 58:
            //このターン相手が使用したカードを打ち消す（UU)
            [self denyCard:ENEMY];
            break;
        case 59:
            //このターン相手が使用した場カードを使用した場合、それを打ち消す（U)
            if([[app.cardList_type objectAtIndex:app.enemyUsingCardNumber] intValue] == FIELDCARD){
                [self denyCard:ENEMY];
            }
            break;
        case 60:
            //このターン相手が白色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == WHITE){
                [self denyCard:ENEMY];
            }
            break;
        case 61:
            //このターン相手が青色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == BLUE){
                [self denyCard:ENEMY];
            }
            break;
        case 62:
            //このターン相手が黒色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == BLACK){
                [self denyCard:ENEMY];
            }
            break;
        case 63:
            //このターン相手が赤色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == RED){
                [self denyCard:ENEMY];
            }
            break;
        case 64:
            //このターン相手が緑色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == GREEN){
                [self denyCard:ENEMY];
            }
            break;
        case 65:
            //カードを一枚引く（U1)
            [self getACard:MYSELF];
            break;
        case 66:
            //対象キャラの攻撃力＋３（R)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            break;
        case 67:
            //相手のエネルギーカードを破壊(RR2)
            [self browseCardsInRegion:app.enemyEnergyCard];
            [self setCardFromXTOY:app.enemyEnergyCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 68:
            //ランダムで相手のエネルギーカード破壊（R2)
            {
                int rand = random() % [app.enemyEnergyCard count];
            
                [self setCardFromXTOY:app.enemyEnergyCard cardNumber:rand toField:app.enemyTomb];
            }
            break;
        case 69:
            //TODO: 全てのエネルギーカードを破壊（R４)
            {
                int num1 = [app.myEnergyCard count];
                for (int i = 0; i < num1; i++) {
                    [self setCardFromXTOY:app.myEnergyCard cardNumber:0 toField:app.myTomb];
                }
                
                int num2 = [app.enemyEnergyCard count];
                for (int i = 0; i < num2; i++) {
                    [self setCardFromXTOY:app.enemyEnergyCard cardNumber:0 toField:app.enemyTomb];
                }
            }
            break;
        case 70:
            //相手のライフに2点のダメージ（R)
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            
            break;
        case 71:
            //相手のライフに3点のダメージ（R1)
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-3];
            break;
        case 72:
            //毎ターン相手に１点のダメージ（R２)
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-1];
            break;
        case 73:
            //自分のライフを１点削り、相手に3点ダメージ（R)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-1];
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-3];
            break;
        case 74:
            //自分のライフを２点削り、相手に4点ダメージ（RR)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-2];
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-4];
            break;
        case 75:
            //対象の場カードを破壊する（R1)
            [self browseCardsInRegion:app.enemyFieldCard];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 76:
            //対象の場カードを２枚破壊する（R3)
            [self browseCardsInRegion:app.enemyFieldCard];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 77:
            //相手プレイヤーに2点ダメージ。相手がギコを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == GIKO) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 78:
            //相手プレイヤーに2点ダメージ。相手がモナーを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == MONAR) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 79:
            //相手プレイヤーに2点ダメージ。相手がショボンを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == SYOBON) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 80:
            //相手プレイヤーに2点ダメージ。相手がやる夫を選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == YARUO) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 81:
            //攻撃力が＋５される代わりに防御力が０になる（R１)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:5 temporary:1];
            if(mySelectCharacterInCharacterField == GIKO){
                [self myDeffencePowerOperate:GIKO point:(app.myGikoFundamentalDeffencePower + app.myGikoModifyingDeffencePower) * -1 temporary:1];
            }else if (mySelectCharacterInCharacterField == MONAR){
                [self myDeffencePowerOperate:MONAR point:(app.myMonarFundamentalDeffencePower + app.myMonarModifyingDeffencePower) * -1 temporary:1];
            }else if (mySelectCharacterInCharacterField == SYOBON){
                [self myDeffencePowerOperate:SYOBON point:(app.mySyobonFundamentalDeffencePower + app.mySyobonModifyingDeffencePower) * -1 temporary:1];
            }else{
                [self myDeffencePowerOperate:YARUO point:(app.myYaruoFundamentalDeffencePower + app.myYaruoModifyingDeffencePower) * -1 temporary:1];
            }
            break;
        case 82:
            //相手がこのターンカードを使った場合、相手プレイヤーに3点のダメージ。使っていなければ1点ダメージ（RR)
            if(app.doEnemyUseCard == YES){
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-3];
            }else{
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-1];
            }
            break;
        case 83:
            //相手がこのターンカードを使わなかった場合、相手プレイヤーに5点のダメージ。使っていなければ１点ダメージ。（RR)
            if(app.doEnemyUseCard == NO){
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-1];
            }
            break;
        case 84:
            //相手プレイヤーに、場に出ている選んだ一色のエネルギーカードの枚数分のダメージ（R4)
            [self colorSelect];
            int num = 0;
            for (int i = 0; i < [app.myFieldCard count]; i++) {
                if([self distinguishCardColor:[[app.myFieldCard objectAtIndex:i] intValue]] == app.mySelectColor){
                    num++;
                }
            }
            for (int i = 0; i < [app.enemyFieldCard count]; i++) {
                if([self distinguishCardColor:[[app.enemyFieldCard objectAtIndex:i] intValue]] == app.mySelectColor){
                    num++;
                }
            }
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:num];
            app.mySelectColor = -1; //mySelectCharacerを初期化
            
            break;
        case 85:
            //エネルギーカードの種類数ぶんだけ相手プレイヤーにダメージ。（R1)
            {
                int num = [self distinguishTheNumberOfEnergyCardColor:MYSELF];
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:num];
            }
            break;
        case 86:
            //相手プレイヤーはこのターンエネルギーカードを出せない。カードを一枚引く。（R2）
            [self dontPermitCardPlay:ENEMY cardType:ENERGYCARD];
            [self getACard:MYSELF];
            break;
        case 87:
            //カードを１枚ランダムで捨てる。相手キャラの攻撃力−５（R３）
            {
                int rand = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand];
            }
            [self enemyAttackPowerOperate:GIKO point:-5 temporary:1];
            [self enemyAttackPowerOperate:MONAR point:-5 temporary:1];
            [self enemyAttackPowerOperate:SYOBON point:-5 temporary:1];
            [self enemyAttackPowerOperate:YARUO point:-5 temporary:1];
            
            break;
        case 88:
            //相手がギコを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == GIKO) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 89:
            //相手がモナーを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == MONAR) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 90:
            //相手がショボンを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == SYOBON) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 91:
            //相手がやる夫を選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == YARUO) {
                app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 92:
            //毎ターン１点ダメージ（R2)
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-1];
            break;
        case 93:
            //自分の選択キャラの攻撃力−１、２点ダメージ（R)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            break;
        case 94:
            //対象のエネルギーカードを破壊する（R2)
            [self browseCardsInRegion:app.enemyEnergyCard];
            [self setCardFromXTOY:app.enemyEnergyCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 95:
            //対象のエネルギーカードを２枚破壊する(RR3)
            [self browseCardsInRegion:app.enemyEnergyCard];
            [self setCardFromXTOY:app.enemyEnergyCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            [self browseCardsInRegion:app.enemyEnergyCard];
            [self setCardFromXTOY:app.enemyEnergyCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 96:
            //このターン、黒エネルギーを＋３（B)
            
            break;
        case 97:
            //相手プレイヤーのライフを１削り、自分は１回復（B１)
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-1];
            app.myLifeGage = [self HPOperate:app.myLifeGage point:1];
            
            break;
        case 98:
            //相手プレイヤーのライフを２削り、自分は２回復（B2)
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            app.myLifeGage = [self HPOperate:app.myLifeGage point:2];
            
            break;
        case 99:
            //相手の手札をランダムで１枚減らす（B)
            {
                //TODO: 対象配列にカードがないとき、エラーが起きないようにする（カードを移動する系の他のカードも全て同じ対応が必要！）
                int rand = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand];
            }
            break;
        case 100:
            //相手の手札をランダムで２枚減らす（BB)
            {
                int rand = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand];
            
                int rand2 = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand2];
            }
            break;
        case 101:
            //相手の手札を全て減らす（BB3)
            {
                for (int i = 0; i < [app.enemyHand count]; i++) {
                    [self discardFromHand:ENEMY cardNumber:0];
                }
            }
            break;
        case 102:
            //このターンに与えたダメージ分、自分は回復（B1)
            //TODO: メソッド実装
            break;
        case 103:
            //攻撃力と防御力が−１される代わりにブロックされない（B１)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            [self forbidDeffence:app.enemyGikoDeffencePermitted];
            [self forbidDeffence:app.enemyMonarDeffencePermitted];
            [self forbidDeffence:app.enemySyobonDeffencePermitted];
            [self forbidDeffence:app.enemyYaruoDeffencePermitted];
            break;
        case 104:
            //このターン、ライフを３点失う代わりに攻撃力が＋５される（BB)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-3];
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:5 temporary:1];
            
            break;
        case 105:
            //毎ターンライフを５点失う代わりに攻撃力が＋８される（BB2)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-5];
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:8 temporary:0];
            
            break;
        case 106:
            //自分の場カードを破壊することでカードを２枚引く（B1)
            [self browseCardsInRegion:app.myFieldCard];
            [self setCardFromXTOY:app.myFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            [self getACard:MYSELF];
            [self getACard:MYSELF];
            
            break;
        case 107:
            //エネルギーカードの種類数だけ、相手の攻撃力と防御力をマイナスさせる（B1)
            [self createCharacterField:_allImageView];
            [self enemyAttackPowerOperate:app.enemySelectCharacter point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1 temporary:1];
            [self enemyDeffencePowerOperate:app.enemySelectCharacter point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1 temporary:1];
            break;
        case 108:
            //場のカードを破壊するが、ライフを３点失う（B1)
            [self browseCardsInRegion:app.enemyFieldCard];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 109:
            //自分のターンの開始時に、相手プレイヤーはカードをランダムで１枚捨てる（BB2)
            {
                int rand = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand];
            }
            break;
        case 110:
            //対象キャラの攻撃力・防御力を−１し、カードを一枚引く。（B2)
            //TODO: app.mySelectCharacterに数値が入った時は、app.myCharacterAttackPowerとapp.myCharacterDeffencePowerにも数値が入るようにする。
            //TODO: app.mySelectCharacterとapp.myCharacterAttackPowerとapp.myCharacterDeffencePowerはターン終了時に初期化する
            
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            [self getACard:MYSELF];
            
            break;
        case 111:
            //自分のプレイヤーのターン終了時に場カードかエネルギーカードをランダムで１枚破壊（BB2)
            {
                int rand = random() % 2;
                if (rand == 0) {
                    int rand2 = random() % [app.enemyFieldCard count];
                    [self setCardFromXTOY:app.enemyFieldCard cardNumber:rand2 toField:app.enemyTomb];
                }else{
                    int rand3 = random() % [app.enemyEnergyCard count];
                    [self setCardFromXTOY:app.enemyEnergyCard cardNumber:rand3 toField:app.enemyTomb];
                }
            }
            break;
        case 112:
            //相手プレイヤーがカードを使用するたび、カードを一枚引く（BB4)
            if (app.doEnemyUseCard == YES) {
                [self getACard:MYSELF];
            }
            break;
        case 113:
            //カードを一枚好きにサーチし、ライブラリを切り直す。ライフを４点失う（B1)
            [self browseCardsInRegion:app.myDeckCardList];
            [self setCardFromXTOY:app.myDeckCardList cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myHand];
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-4];
            
            break;
        case 114:
            //カードを一枚好きにサーチし、ライブラリを切り直す（BB2)
            [self browseCardsInRegion:app.myDeckCardList];
            [self setCardFromXTOY:app.myDeckCardList cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myHand];
            break;
        case 115:
            //相手プレイヤーのデッキからカードを一枚捨てる（B１)
            [self browseCardsInRegion:app.enemyDeckCardList];
            [self discardFromLibrary:ENEMY  tagNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 116:
            //相手プレイヤーのデッキからカードを十枚捨てる(BBB5)
            for (int i = 0; i < 10; i++) {
                [self browseCardsInRegion:app.enemyDeckCardList];
                [self discardFromLibrary:ENEMY  tagNumber:[self substituteSelectCardTagAndInitilizeIt]];
            }
            break;
        case 117:
            //攻撃力は＋３されるが、防御力が半分になる（B)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            if(mySelectCharacterInCharacterField == GIKO){
                [self myDeffencePowerOperate:GIKO point:(app.myGikoFundamentalDeffencePower + app.myGikoModifyingDeffencePower) / 2 temporary:1];
            }else if (mySelectCharacterInCharacterField == MONAR){
                [self myDeffencePowerOperate:MONAR point:(app.myMonarFundamentalDeffencePower + app.myMonarModifyingDeffencePower) / 2 temporary:1];
            }else if (mySelectCharacterInCharacterField == SYOBON){
                [self myDeffencePowerOperate:SYOBON point:(app.mySyobonFundamentalDeffencePower + app.mySyobonModifyingDeffencePower) / 2 temporary:1];
            }else{
                [self myDeffencePowerOperate:YARUO point:(app.myYaruoFundamentalDeffencePower + app.myYaruoModifyingDeffencePower) / 2 temporary:1];
            }
            
            break;
        case 118:
            //相手プレイヤーの手札の中にある、カードを1枚選んで捨てる（BB2)
            [self browseCardsInRegion:app.enemyHand];
            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 119:
            //相手プレイヤーの手札の中にある、カードを2枚選んで捨てる（BB2)
            [self browseCardsInRegion:app.enemyHand];
            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 120:
            //各プレイヤーの場カードを一枚ずつランダムに破壊する（B)
            {
                int rand1 = random() % [app.myFieldCard count];
                [self setCardFromXTOY:app.myFieldCard cardNumber:rand1 toField:app.myTomb];
                int rand2 = random() % [app.enemyFieldCard count];
                [self setCardFromXTOY:app.enemyFieldCard cardNumber:rand2 toField:app.enemyTomb];
            }
            break;
        case 121:
            //カードを一枚捨てる代わりに、相手のカードを好きに一枚捨てられる（B)
            [self payAdditionalCost];
            [self browseCardsInRegion:app.enemyHand];
            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 122:
            //全プレイヤーは手札を捨てる（BB3)
            
                for (int i = 0; i < [app.myHand count]; i++) {
                    [self discardFromHand:MYSELF cardNumber:0];
                }
                for (int i = 0; i < [app.enemyHand count]; i++) {
                    [self discardFromHand:ENEMY cardNumber:0];
                }
            break;
        case 123:
            //対象キャラは攻撃力＋２、防御力−２（B3)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:2 temporary:0];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:-2 temporary:0];
             break;
        case 124:
            //自分の場カードを破壊することで、対象プレイヤーはカードを２枚捨てる（B1)
            [self browseCardsInRegion:app.myFieldCard];
            [self setCardFromXTOY:app.myFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            [self browseCardsInRegion:app.enemyHand];
            [self setCardFromXTOY:app.enemyHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            [self browseCardsInRegion:app.enemyHand];
            [self setCardFromXTOY:app.enemyHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 125:
            //カードを２枚捨てることで、ずっと攻撃力・防御力＋２（B1)
            [self browseCardsInRegion:app.myHand];
            [self setCardFromXTOY:app.myHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            [self browseCardsInRegion:app.myHand];
            [self setCardFromXTOY:app.myHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            [self myAttackPowerOperate:GIKO point:2 temporary:0];
            [self myDeffencePowerOperate:GIKO point:2 temporary:0];
            [self myAttackPowerOperate:MONAR point:2 temporary:0];
            [self myDeffencePowerOperate:MONAR point:2 temporary:0];
            [self myAttackPowerOperate:SYOBON point:2 temporary:0];
            [self myDeffencePowerOperate:SYOBON point:2 temporary:0];
            [self myAttackPowerOperate:YARUO point:2 temporary:0];
            [self myDeffencePowerOperate:YARUO point:2 temporary:0];
            break;
        case 126:
            //毎ターン相手に３点ダメージ（BB3)
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-3];
            break;
        case 127:
            //対象キャラの攻撃力・防御力を１ターン＋３（G)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            break;
        case 128:
            //対象キャラの攻撃力・防御力を１ターン＋７（G3)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:7 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:7 temporary:1];
            
            break;
        case 129:
            //対象キャラの攻撃力・防御力を１ターン＋１，カードを一枚引く（G)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:1 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:1 temporary:1];
            [self getACard:MYSELF];
            
            break;
        case 130:
            //１ターンの間、対象キャラの攻撃力・防御力を＋２，攻撃力そのままをダメージにする（G2)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            if(app.enemySelectCharacter == GIKO){
                [self enemyDeffencePowerOperate:GIKO point:(app.enemyGikoFundamentalDeffencePower + app.enemyGikoModifyingDeffencePower) * -1 temporary:1];
            }else if (app.enemySelectCharacter == MONAR){
                [self enemyDeffencePowerOperate:MONAR point:(app.enemyMonarFundamentalDeffencePower + app.enemyMonarModifyingDeffencePower) * -1 temporary:1];
            }else if (app.enemySelectCharacter == SYOBON){
                [self enemyDeffencePowerOperate:SYOBON point:(app.enemySyobonFundamentalDeffencePower + app.enemySyobonModifyingDeffencePower) * -1 temporary:1];
            }else{
                [self enemyDeffencePowerOperate:YARUO point:(app.enemyYaruoFundamentalDeffencePower + app.enemyYaruoModifyingDeffencePower) * -1 temporary:1];
            }
            
            break;
        case 131:
            //対象キャラの攻撃力・防御力を１ターン＋4（G1)
            [self createCharacterField:_allImageView];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:4 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:4 temporary:1];
            break;
        case 132:
            //相手がカードを一枚（エネルギーカード除く）使うたびに剣士・魔法使い・格闘家の攻撃力を＋１する（G2)
            
            break;
        case 133:
            //このターン、双方ともダメージ無効（G)
            
            break;
        case 134:
            //２ターン、双方ともダメージ無効（G2)
            
            break;
        case 135:
            //このターン、双方ともダメージ無効。次のターン攻撃させない（G1)
            
            break;
        case 136:
            //このターン攻撃力そのままをダメージにする（G)
            
            break;
        case 137:
            //ずっと攻撃力そのままをダメージにする（G４）
            
            break;
        case 138:
            //エネルギーカードを１枚サーチ（G１)
            
            break;
        case 139:
            //エネルギーカードを２枚サーチ（GG2)
            
            break;
        case 140:
            
            break;
        case 141:
            
            break;
        case 142:
            
            break;
        case 143:
            
            break;
        case 144:
            
            break;
        case 145:
            
            break;
        case 146:
            
            break;
        case 147:
            
            break;
        case 148:
            
            break;
        case 149:
            
            break;
        case 150:
            
            break;
        case 151:
            
            break;
        case 152:
            
            break;
        case 153:
            
            break;
        case 154:
            
            break;
        case 155:
            
            break;
        case 156:
            
            break;
        case 157:
            
            break;
        case 158:
            
            break;
        case 159:
            
            break;
        case 160:
            
            break;
        case 161:
            
            break;
        case 162:
            
            break;
        case 163:
            
            break;
        case 164:
            
            break;
        case 165:
            
            break;
        case 166:
            
            break;
        case 167:
            
            break;
        case 168:
            
            break;
        case 169:
            
            break;
        case 170:
            
            break;
        case 171:
            
            break;
        case 172:
            
            break;
        case 173:
            
            break;
        case 174:
            
            break;
        case 175:
            
            break;
        case 176:
            
            break;
        case 177:
            
            break;
        case 178:
            
            break;
        case 179:
            
            break;
        case 180:
            
            break;
        default:
            break;
    }
    
}

- (void)turnStartFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    
    view = [[UIImageView alloc] initWithImage:img];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    NSLog(@"1");
    [self insertTextViewToParentView:view Text:@"ターン開始時に発動したカード"  Rectangle:CGRectMake(80,5,180,30)];
    NSLog(@"2");
    
    
    NSMutableArray *my1 = [[NSMutableArray alloc] init]; //ターン開始時に発動する自分のフィールドカード
    NSMutableArray *enemy1 = [[NSMutableArray alloc] init]; //ターン開始時に発動する相手のフィールドカード
    
    //何枚発動するかを計算する
    for (int i = 0; i < [app.myFieldCard count]; i++) {
        for (int j = 0; j < [app.fieldCardList_turnStart count];  j++) {
            if([[app.myFieldCard objectAtIndex:i] isEqual:[app.fieldCardList_turnStart objectAtIndex:j]]){
                [my1 addObject:[app.myFieldCard objectAtIndex:i]];
            }
        }
    }
    for (int i = 0; i < [app.enemyFieldCard count]; i++) {
        for (int j = 0; j < [app.fieldCardList_turnStart count];  j++) {
            if([[app.enemyFieldCard objectAtIndex:i] isEqual:[app.fieldCardList_turnStart objectAtIndex:j]]){
                [enemy1 addObject:[app.enemyFieldCard objectAtIndex:i]];
            }
        }
    }
    
    if([my1 count] == 0){
        [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 60, 240, 20)];
        NSLog(@"3-1");
    }else{
        for (int i = 0; i < [my1 count]; i++) {
            [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"%@\n",[app.cardList_cardName objectAtIndex:[[my1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 60 + (20 * i), 240, 20)];
        }
        NSLog(@"3-2");
    }
    if ([enemy1 count] == 0) {
            [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 220, 240, 20)];
    }else{
        for (int i = 0; i < [enemy1 count]; i++) {
            [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"%@\n",[app.cardList_cardName objectAtIndex:[[enemy1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 220 + (20 * i), 240, 20)];
        }
        
    }
    
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    //[UIView setAnimationDidStopSelector:@selector(resultFadeOut:)];
    [UIView commitAnimations];
}

- (void)cardActivateFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    
    view = [[UIImageView alloc] initWithImage:img];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    
    [self insertTextViewToParentView:view Text:@"カードの使用結果" Rectangle:CGRectMake(80,5,180,30)];
    if([app.cardsIUsedInThisTurn count] == 0){
        [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"カードを使用しませんでした"] Rectangle:CGRectMake(20, 40, 240, 20)];
    }else{
        for (int i = 0; i < [app.cardsIUsedInThisTurn count]; i++) {
            [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[app.cardsIUsedInThisTurn objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 40 + (20 * i), 240, 20)];
        }
    }
    if ([app.cardsEnemyUsedInThisTurn count] == 0) {
        [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"カードを使用しませんでした"] Rectangle:CGRectMake(20, 220, 240, 20)];
    }else{
        for (int i = 0; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
            [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 220 + (20 * i), 240, 20)];
        }
    }
    
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    //[UIView setAnimationDidStopSelector:@selector(resultFadeOut:)];
    [UIView commitAnimations];
}


- (void)damageCaliculateFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    
    view = [[UIImageView alloc] initWithImage:img];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    
    
    [view addSubview:_myGiko];
    [view addSubview:_myMonar];
    [view addSubview:_mySyobon];
    [view addSubview:_myYaruo];
    [view addSubview:_enemyGiko];
    [view addSubview:_enemyMonar];
    [view addSubview:_enemySyobon];
    [view addSubview:_enemyYaruo];
    
    _myGiko.frame      = CGRectMake(20,  40, view.bounds.size.width - 40, 20);
    _myMonar.frame     = CGRectMake(20,  60, view.bounds.size.width - 40, 20);
    _mySyobon.frame    = CGRectMake(20,  80, view.bounds.size.width - 40, 20);
    _myYaruo.frame     = CGRectMake(20, 100, view.bounds.size.width - 40, 20);
    _enemyGiko.frame   = CGRectMake(20, 220, view.bounds.size.width - 40, 20);
    _enemyMonar.frame  = CGRectMake(20, 240, view.bounds.size.width - 40, 20);
    _enemySyobon.frame = CGRectMake(20, 260, view.bounds.size.width - 40, 20);
    _enemyYaruo.frame  = CGRectMake(20, 280, view.bounds.size.width - 40, 20);
    
    UIFont *font = [UIFont fontWithName:@"Didot" size:12];
    _myGiko.font = font;
    _myMonar.font = font;
    _mySyobon.font = font;
    _myYaruo.font = font;
    _enemyGiko.font = font;
    _enemyMonar.font = font;
    _enemySyobon.font = font;
    _enemyYaruo.font = font;
    

    [self insertTextViewToParentView:view Text:@"ダメージ計算結果"  Rectangle:CGRectMake(80,5,180,30)];
    //TODO: 各キャラの攻撃力・防御力を表示した上で、今回選ばれているキャラクターのみ赤字にする
    _myGiko.text    = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d"  ,app.myGikoFundamentalAttackPower      , app.myGikoModifyingAttackPower     , app.myGikoFundamentalDeffencePower     , app.myGikoModifyingDeffencePower];
    _myMonar.text   = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d"  ,app.myMonarFundamentalAttackPower     , app.myMonarModifyingAttackPower    , app.myMonarFundamentalDeffencePower    , app.myMonarModifyingDeffencePower];
    _mySyobon.text  = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d"  ,app.mySyobonFundamentalAttackPower    , app.mySyobonModifyingAttackPower   , app.mySyobonFundamentalDeffencePower   , app.mySyobonModifyingDeffencePower];
    _myYaruo.text   = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d"  ,app.myYaruoFundamentalAttackPower     , app.myYaruoModifyingAttackPower    , app.myYaruoFundamentalDeffencePower    , app.myYaruoModifyingDeffencePower];
    _enemyGiko.text = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d"  ,app.enemyGikoFundamentalAttackPower   , app.enemyGikoModifyingAttackPower  , app.enemyGikoFundamentalDeffencePower  , app.enemyGikoModifyingDeffencePower];
    _enemyMonar.text = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d" ,app.enemyMonarFundamentalAttackPower  , app.enemyMonarModifyingAttackPower , app.enemyMonarFundamentalDeffencePower , app.enemyMonarModifyingDeffencePower];
    _enemySyobon.text = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d",app.enemySyobonFundamentalAttackPower , app.enemySyobonModifyingAttackPower, app.enemySyobonFundamentalDeffencePower, app.enemySyobonModifyingDeffencePower];
    _enemyYaruo.text = [NSString stringWithFormat:@"攻撃力：%d + %d  防御力：%d + %d" ,app.enemyYaruoFundamentalAttackPower  , app.enemyYaruoModifyingAttackPower , app.enemyYaruoFundamentalDeffencePower , app.enemyYaruoModifyingDeffencePower];
    
    
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    //[UIView setAnimationDidStopSelector:@selector(resultFadeOut:)];
    [UIView commitAnimations];
}

- (void)resultFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    
    view = [[UIImageView alloc] initWithImage:img];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    [self insertTextViewToParentView:view Text:@"ターン終了時に発動したカード" Rectangle:CGRectMake(80,5,180,30)];
    
    
    NSMutableArray *my1 = [[NSMutableArray alloc] init]; //ターン終了時に発動する自分のフィールドカード
    NSMutableArray *enemy1 = [[NSMutableArray alloc] init]; //ターン終了時に発動する相手のフィールドカード
    
    //何枚発動するかを計算する
    for (int i = 0; i < [app.myFieldCard count]; i++) {
        for (int j = 0; j < [app.fieldCardList_turnEnd count];  j++) {
            if([[app.myFieldCard objectAtIndex:i] isEqual:[app.fieldCardList_turnEnd objectAtIndex:j]]){
                [my1 addObject:[app.myFieldCard objectAtIndex:i]];
            }
        }
    }
    for (int i = 0; i < [app.enemyFieldCard count]; i++) {
        for (int j = 0; j < [app.fieldCardList_turnEnd count];  j++) {
            if([[app.enemyFieldCard objectAtIndex:i] isEqual:[app.fieldCardList_turnEnd objectAtIndex:j]]){
                [enemy1 addObject:[app.enemyFieldCard objectAtIndex:i]];
            }
        }
    }
    
    if([my1 count] == 0){
        [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 60, 240, 20)];
        NSLog(@"3-1");
    }else{
        for (int i = 0; i < [my1 count]; i++) {
            [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"%@\n",[app.cardList_cardName objectAtIndex:[[my1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 60 + (20 * i), 240, 20)];
        }
        NSLog(@"3-2");
    }
    if ([enemy1 count] == 0) {
        [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 220, 240, 20)];
    }else{
        for (int i = 0; i < [enemy1 count]; i++) {
            [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"%@\n",[app.cardList_cardName objectAtIndex:[[enemy1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 220 + (20 * i), 240, 20)];
        }
        
    }
    
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    //[UIView setAnimationDidStopSelector:@selector(resultFadeOut:)]
    [UIView commitAnimations];
}


- (void)resultFadeOut:(UITapGestureRecognizer *)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    sender.view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    sender.view.center = CGPointMake( ([[UIScreen mainScreen] bounds].size.width * -2) ,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDidStopSelector:@selector(removeView:)];
    [UIView commitAnimations];
}

- (void)phaseNameFadeIn:(NSString *)phaseName{
    
    _phaseNameView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phaseName"]];
    _phaseNameView.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    [self insertTextViewToParentView:_phaseNameView Text:phaseName  Rectangle:CGRectMake(0,0,180,60)];
    [_allImageView addSubview:_phaseNameView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    _phaseNameView.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2 ,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDidStopSelector:@selector(resultFadeOutToTextField)];
    [UIView commitAnimations];
}

- (void)resultFadeOutToTextField{
    [NSThread sleepForTimeInterval:1];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    _phaseNameView.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2 ,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    _phaseNameView.center = CGPointMake( ([[UIScreen mainScreen] bounds].size.width * -2) ,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDidStopSelector:@selector(removeView:)];
    [UIView commitAnimations];
}

- (void)removeView:(UIImageView *)view{
    [view removeFromSuperview];
    FINISHED
}



- (NSString *)myCharacterType{
    NSString *st = @"初期";
    
    switch (app.mySelectCharacter) {
        case GIKO:
            st = @"ギコ";
            break;
        case MONAR:
            st = @"モナー";
            break;
        case SYOBON:
            st = @"ショボン";
            break;
        case YARUO:
            st = @"やる夫";
            break;
        default:
            break;
    }
    
    return st;
}
                                                
- (NSString *)enemyCharacterType{
    NSString *st = @"初期";
    
    switch (app.enemySelectCharacter) {
        case GIKO:
            st = @"ギコ";
            break;
        case MONAR:
            st = @"モナー";
            break;
        case SYOBON:
            st = @"ショボン";
            break;
        case YARUO:
            st = @"やる夫";
            break;
        default:
            break;
    }
    
    return st;
}

- (void)insertTextViewToParentView:(UIView *)parentView Text:(NSString *)text Rectangle:(CGRect)rect{
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = rect;
    textView.text  = text;
    textView.editable = NO;
    [parentView addSubview:textView];
}


-(void)okButton{
    if (app.mySelectCharacter == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"キャラクター未選択" message:@"キャラクターが選ばれていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"キャラクターを選択する", nil];
        [alert show];
    }else{
        cardIsCompletlyUsed = YES;
        FINISHED
    }
    
    
}

- (void)battleStart{
    while (drawCount < 5) {
        NSLog(@"ドローカウント：%d",drawCount);
        //手札のカード画像を用意する
        UIImage *card = [UIImage imageNamed:[app.cardList_pngName objectAtIndex:[[app.myDeckCardList objectAtIndex:drawCount] intValue]]];
        _myCard = [[UIImageView alloc] initWithImage:card];
        [_myCardImageViewArray addObject:_myCard];
        [_myCardImageView addSubview:_myCard];
        _myCard.userInteractionEnabled = YES;
        [_myCard addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(touchAction:)]];
        
        //手札を用意するアニメーション
        [UIView beginAnimations:nil context:nil];
        //移動前
        _myCard.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width *2, 360, CARDWIDTH, CARDHEIGHT);
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.1];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //移動後
        _myCard.frame = CGRectMake(20 + (CARDWIDTH +8) * drawCount, 360, CARDWIDTH, CARDHEIGHT);
        [UIView commitAnimations];
        

        //引いたカードの数をプラスする
        drawCount++;
        _myCard.tag = drawCount; // MARK:  タグ番号は、デッキ配列の番号+1となっていることに注意する！
        //手札が5枚になるまで繰り返す

    }
    
    for (int i = 0; i < 5; i++) {
        //手札に入れたカードを、山札の配列から手札の配列に入れておく
        [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
    }
    
        //デッキのカード画像を用意する
        UIImage *deck = [UIImage imageNamed:@"library.png"];
        _myLibrary = [[UIImageView alloc] initWithImage:deck];
        [_allImageView addSubview:_myLibrary];
        //山札を用意するアニメーション
        [UIView beginAnimations:nil context:nil];
        //移動前
        _myLibrary.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - deck.size.width - 20, [[UIScreen mainScreen] bounds].size.height + 100, deck.size.width, deck.size.height);
        //移動後
        _myLibrary.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - CARDWIDTH - 20, [[UIScreen mainScreen] bounds].size.height - CARDHEIGHT - 20, CARDWIDTH, CARDHEIGHT);
        [UIView commitAnimations];
        
        //デッキの残枚数を表示
        _myLibraryCount = [[UITextView alloc] init];
        _myLibraryCount.frame = CGRectMake(5, 10, 30, 40);
        _myLibraryCount.textAlignment = NSTextAlignmentCenter;
        _myLibraryCount.editable = NO;
        UIColor *black = [UIColor blackColor]; //ボタンの背景を透明にするため、とりあえず黒を設定（下で透明化する）
        UIColor *alphaZero = [black colorWithAlphaComponent:0.0]; //黒を透明化
        _myLibraryCount.backgroundColor = alphaZero;//テキストビューの背景を透明化
        _myLibraryCount.text = [NSString stringWithFormat:@"%d", [app.myDeckCardList count]];
        [_myLibrary addSubview:_myLibraryCount];

        NSLog(@"-----------------------------------");
        NSLog(@"%s", __func__);
        for (int i = 0; i < [app.myHand count]; i++) {
            NSLog(@"現在の手札のカードナンバー：%d枚目:%d",i + 1,[[app.myHand objectAtIndex:i] intValue]);
        }
        NSLog(@"-----------------------------------");
    
    [self nextTurn];
    
}

- (void)touchAction :(UILongPressGestureRecognizer *)sender{
    selectedCardOrder = (int)[_myCardImageViewArray indexOfObject:sender.view];
    int cardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue];
    cardType = [[app.cardList_type objectAtIndex:cardNumber - 1 ] intValue];
    app.myUsingCardNumber = cardNumber;
    app.doIUseCard = YES;
    doIUseCardInThisTurn = YES;
    
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    NSLog(@"カードナンバー：%d",cardNumber);
    switch (cardType) {
        case 1:
            NSLog(@"カードタイプ：エネルギー");
            break;
        case 2:
            NSLog(@"カードタイプ：フィールド");
            break;
        case 3:
            NSLog(@"カードタイプ：ソーサリー");
            break;
        default:
            break;
    }
    
    if([_myCardImageViewArray indexOfObject:sender.view] == NSNotFound){
        NSLog(@"手札内にカードが見つかりません");
    }else{
        NSLog(@"現在選んでいるカードは、手札の左から数えて%d番目", selectedCardOrder + 1);
    }
    NSLog(@"-----------------------------------");
    
    if (cardType == SORCERYCARD){
        if([self doIHaveEnergyToUseCard:cardNumber]){
            
        }
        else if(app.canIPlaySorceryCard == NO){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"封印" message:@"ソーサリーカードの使用は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
            [alert show];
        }else{
            [_border_middleCard removeFromSuperview];
            _border_middleCard.frame = sender.view.frame;
            [_allImageView addSubview:_border_middleCard];
            
            [_myCardImageView_middle removeFromSuperview];
            [_allImageView addSubview:_myCardImageView_middle];
            app.myUsingCardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
            selectedCardTag = (int)sender.view.tag; //デッキ内の配列番号と一致する
            
            [_myCardImageView_middle removeFromSuperview];
            _myCardImageView_middle.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",app.myUsingCardNumber]];
            [_allImageView addSubview:_myCardImageView_middle];
            [_myCardTextView_middle removeFromSuperview];
            _myCardTextView_middle.text = [NSString stringWithFormat:@"%@", [app.cardList_text objectAtIndex:app.myUsingCardNumber]];
            [_allImageView addSubview:_myCardTextView_middle];
            
            _doIUseSorcerycard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"ソーサリーカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseSorcerycard show];
            [self syncronize];
            //このターン、カードを使用していれば、効果を発動する
            if(doIUseCardInThisTurn == YES){
                [self cardActivate:app.myUsingCardNumber];
                [self setCardToCardsIUsedInThisTurn:app.myHand cardNumber:selectedCardOrder];
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                [self moveCards];
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
                doIUseCardInThisTurn = NO;
            }
        }
    }

    //フィールドカードの場合の実装
    else if (cardType == FIELDCARD){
        if([self doIHaveEnergyToUseCard:cardNumber]){
            
        }
        else if(app.canIPlayFieldCard == NO){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"封印" message:@"フィールドカードの使用は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
            [alert show];
        }else{
            [_border_middleCard removeFromSuperview];
            _border_middleCard.frame = sender.view.frame;
            [_allImageView addSubview:_border_middleCard];
            
            [_myCardImageView_middle removeFromSuperview];
            [_allImageView addSubview:_myCardImageView_middle];
            app.myUsingCardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
            selectedCardTag = (int)sender.view.tag; //デッキ内の配列番号と一致する
            
            [_myCardImageView_middle removeFromSuperview];
            _myCardImageView_middle.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",app.myUsingCardNumber]];
            [_allImageView addSubview:_myCardImageView_middle];
            [_myCardTextView_middle removeFromSuperview];
            _myCardTextView_middle.text = [NSString stringWithFormat:@"%@", [app.cardList_text objectAtIndex:app.myUsingCardNumber]];
            [_allImageView addSubview:_myCardTextView_middle];
            
            _doIUseFieldcard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"フィールドカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseFieldcard show];
            [self syncronize];
            //このターン、カードを使用していれば、効果を発動する
            if(doIUseCardInThisTurn == YES){
                [self setCardToCardsIUsedInThisTurn:app.myHand cardNumber:selectedCardOrder];
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                [self moveCards];
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myFieldCard];
                doIUseCardInThisTurn = NO;
            }
        }
    }
    
    //エネルギーカードの場合の実装
    else if (cardType == ENERGYCARD){
        if(app.canIPlayEnergyCard == NO){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"封印" message:@"エネルギーカードの使用は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
            [alert show];
        }else{
            [_border_middleCard removeFromSuperview];
            _border_middleCard.frame = sender.view.frame;
            [_allImageView addSubview:_border_middleCard];
            
            [_myCardImageView_middle removeFromSuperview];
            [_allImageView addSubview:_myCardImageView_middle];
            app.myUsingCardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
            selectedCardTag = (int)sender.view.tag; //デッキ内の配列番号と一致する
            
            [_myCardImageView_middle removeFromSuperview];
            _myCardImageView_middle.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",app.myUsingCardNumber]];
            [_allImageView addSubview:_myCardImageView_middle];
            [_myCardTextView_middle removeFromSuperview];
            _myCardTextView_middle.text = [NSString stringWithFormat:@"%@", [app.cardList_text objectAtIndex:app.myUsingCardNumber]];
            [_allImageView addSubview:_myCardTextView_middle];
            
            _doIUseEnergycard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"エネルギーカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseEnergycard show];
        }
    }
}

- (void)moveCards{
    for (int i = selectedCardOrder; i < [_myCardImageViewArray count]; i++){
        UIImageView *imgView = [_myCardImageView.subviews objectAtIndex:i];
        imgView.frame = CGRectMake(imgView.frame.origin.x - 48, imgView.frame.origin.y, imgView.frame.size.width, imgView.frame.size.height);
    }
    NSLog(@"selectedCardTag：%d",selectedCardTag);
    [_border_middleCard removeFromSuperview];
    [_myCardImageViewArray removeObjectAtIndex:selectedCardOrder];
    [[_myCardImageView viewWithTag:selectedCardTag] removeFromSuperview];

    for (int i = 0; i < [_myCardImageViewArray count]; i++) {
        UIImageView *tmp = [[UIImageView alloc] init];
        tmp = [_myCardImageViewArray objectAtIndex:i];
        NSLog(@"残ってるカード：%d",tmp.tag);
    }
}


//TODO: 自分の手札を再描画する
//TODO: 相手の手札を再描画する
//TODO: 自分の墓地を再描画する
//TODO: 相手の墓地を再描画する
//TODO: 自分の場を再描画する
//TODO: 相手の場を再描画する





/*----------------------------------------------------------------------------------------*/

//対象プレイヤーのXという領域のカードを見る（場・エネルギー置き場・手札）
-(int)browseCardsInRegion :(NSMutableArray *)cards{
    for (int i = 0; i < [cards count]; i++) {
        UIImageView *cardImage = [[UIImageView alloc] init];
        [_cardInRegion addSubview:cardImage];
        cardImage.frame = CGRectMake(10, 10 + (CARDHEIGHT) * i + (i  * 5), CARDWIDTH, CARDHEIGHT);
        cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[cards objectAtIndex:i]]];
        cardImage.userInteractionEnabled = YES;
        cardImage.tag = i;
        [cardImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCard:)]];
        [cardImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detailOfACard:)]]; //detailOfACard:はDeckViewControllerのメソッド。エラーが出る場合は注意。
    }
    [self createOkButton:CGRectMake(10, (_cardInRegion.bounds.size.height - 100) / 2, 100, 20) parentView:_cardInRegion tag:4];
    [_allImageView addSubview:_cardInRegion];
    
    return 0;
}

//自分の対象キャラの攻撃力を操作する（対象キャラの攻撃力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)myAttackPowerOperate:(int)character point:(int)x  temporary:(BOOL)temporary{
    if(temporary == YES){
        if(character == GIKO){
            app.myGikoModifyingAttackPower += x;
        }else if (character == MONAR){
            app.myMonarModifyingAttackPower += x;
        }else if (character == SYOBON){
            app.mySyobonModifyingAttackPower += x;
        }else if (character == YARUO){
            app.myYaruoModifyingAttackPower += x;
        }
    }else{
        if(character == GIKO){
            app.myGikoFundamentalAttackPower += x;
        }else if (character == MONAR){
            app.myMonarFundamentalAttackPower += x;
        }else if (character == SYOBON){
            app.mySyobonFundamentalAttackPower += x;
        }else if (character == YARUO){
            app.myYaruoFundamentalAttackPower += x;
        }
    }
}

//自分の対象キャラの防御力を操作する（対象キャラの防御力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)myDeffencePowerOperate:(int)character point:(int)x temporary:(BOOL)temporary{
    if(temporary == YES){
        if(character == GIKO){
            app.myGikoModifyingDeffencePower += x;
        }else if (character == MONAR){
            app.myMonarModifyingDeffencePower += x;
        }else if (character == SYOBON){
            app.mySyobonModifyingDeffencePower += x;
        }else if (character == YARUO){
            app.myYaruoModifyingDeffencePower += x;
        }
    }else{
        if(character == GIKO){
            app.myGikoFundamentalDeffencePower += x;
        }else if (character == MONAR){
            app.myMonarFundamentalDeffencePower += x;
        }else if (character == SYOBON){
            app.mySyobonFundamentalDeffencePower += x;
        }else if (character == YARUO){
            app.myYaruoFundamentalDeffencePower += x;
        }
    }
}

//相手の対象キャラの攻撃力を操作する（対象キャラの攻撃力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)enemyAttackPowerOperate :(int)character point:(int)x  temporary:(BOOL)temporary{
    if(temporary == YES){
        if(character == GIKO){
            app.enemyGikoModifyingAttackPower += x;
        }else if (character == MONAR){
            app.enemyMonarModifyingAttackPower += x;
        }else if (character == SYOBON){
            app.enemySyobonModifyingAttackPower += x;
        }else if (character == YARUO){
            app.enemyYaruoModifyingAttackPower += x;
        }
    }else{
        if(character == GIKO){
            app.enemyGikoFundamentalAttackPower += x;
        }else if (character == MONAR){
            app.enemyMonarFundamentalAttackPower += x;
        }else if (character == SYOBON){
            app.enemySyobonFundamentalAttackPower += x;
        }else if (character == YARUO){
            app.enemyYaruoFundamentalAttackPower += x;
        }
    }
}

//相手の対象キャラの防御力を操作する（対象キャラの防御力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)enemyDeffencePowerOperate:(int)character point:(int)x temporary:(BOOL)temporary{
    if(temporary == YES){
        if(character == GIKO){
            app.enemyGikoModifyingDeffencePower += x;
        }else if (character == MONAR){
            app.enemyMonarModifyingDeffencePower += x;
        }else if (character == SYOBON){
            app.enemySyobonModifyingDeffencePower += x;
        }else if (character == YARUO){
            app.enemyYaruoModifyingDeffencePower += x;
        }
    }else{
        if(character == GIKO){
            app.enemyGikoFundamentalDeffencePower += x;
        }else if (character == MONAR){
            app.enemyMonarFundamentalDeffencePower += x;
        }else if (character == SYOBON){
            app.enemySyobonFundamentalDeffencePower += x;
        }else if (character == YARUO){
            app.enemyYaruoFundamentalDeffencePower += x;
        }
    }
}


//対象プレイヤーのHPを操作する（対象プレイヤーのHPを管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(int)HPOperate :(int)lifeGage point:(int)x{
    lifeGage += x;
    return lifeGage;
}

//カードの色を判断する（カードナンバー）
-(int)distinguishCardColor :(int)cardNumber{
    int colorNumber = 0;
    colorNumber = [[app.cardList_color objectAtIndex:cardNumber] intValue];
    return colorNumber;
}

//対象キャラの攻撃を許可する（対象キャラの攻撃許可区分）
-(void)permitAttack :(BOOL)permit{
    permit = YES;
}

//対象キャラの攻撃を許可しない（対象キャラの攻撃許可区分）
-(void)forbidAttack :(BOOL)permit{
    permit = NO;
}

//対象キャラの防御を許可する（対象キャラの防御許可区分）
-(void)permitDeffence :(BOOL)permit{
        permit = YES;
}

//対象キャラの防御を許可しない（対象キャラの防御許可区分）
-(void)forbidDeffence :(BOOL)permit{
    permit = NO;
}

//このターン与えられるダメージが０になる
-(void)damage0 :(int)damage{
    damage = 0;
}

//対象プレイヤーは1枚カードを引く（対象プレイヤー（０なら自分、１なら相手）
- (void)getACard :(int)man{
    if(man == 0){
        _myLibraryCount.text = [NSString stringWithFormat:@"%d", [app.myDeckCardList count]];
        
        //手札の画像を用意する
        UIImage *card = [UIImage imageNamed:[app.cardList_pngName objectAtIndex:[[app.myDeckCardList objectAtIndex:0] intValue]]];
        _myGetCard = [[UIImageView alloc] initWithImage:card];
        [_myCardImageViewArray addObject:_myGetCard];
        [_myCardImageView addSubview:_myGetCard];
        _myGetCard.userInteractionEnabled = YES;
        [_myGetCard addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(touchAction:)]];
        //移動前
        _myGetCard.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - CARDWIDTH - 20, [[UIScreen mainScreen] bounds].size.height - CARDHEIGHT - 20, CARDWIDTH, CARDHEIGHT);
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //移動後
        _myGetCard.frame = CGRectMake(20 + (CARDWIDTH + 8) * ([_myCardImageViewArray count] - 1), 360, CARDWIDTH, CARDHEIGHT);
        
        //引いたカードの数を増やす
        drawCount++;
        _myGetCard.tag = drawCount;
        NSLog(@"手札に入れたカードのタグ：%d",_myGetCard.tag);
        
        //デッキのカード枚数を減らし、手札に入れる
        [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
        
    }else{
        //TODO: 敵がカードを手に入れた際の処理
    }
}

//対象プレイヤーは1枚カードを捨てる（対象プレイヤー（０なら自分、１なら相手）・対象プレイヤーの手札・捨てるカードの番号(myHand or enemyHandの配列番号)）
- (void)discardFromHand :(int)man cardNumber:(int)cardNumber{
    if(man == 0){
        [app.myTomb addObject:[app.myHand objectAtIndex:cardNumber]];
        [app.myHand removeObjectAtIndex:cardNumber];
    }else{
        [app.enemyTomb addObject:[app.enemyHand objectAtIndex:cardNumber]];
        [app.enemyHand removeObjectAtIndex:cardNumber];
    }
}

//対象プレイヤーの山札からカードを一枚墓地に捨てる（対象プレイヤー（対象プレイヤー・タグナンバー）
- (void)discardFromLibrary :(int)man tagNumber:(int)num{
    if(man == 0){
        [app.myTomb addObject:[app.myDeckCardList objectAtIndex:num]];
        [app.myDeckCardList removeObjectAtIndex:num];
    }else{
        [app.enemyTomb addObject:[app.enemyDeckCardList objectAtIndex:num]];
        [app.enemyDeckCardList removeObjectAtIndex:num];
    }
}

//対象プレイヤーのXという場（X=場カード置き場 or エネルギーカード置き場）から対象プレイヤーYという場にZというカードを置く（対象プレイヤー・移動元の場・移動元の配列の何番目に存在するか・移動後の場）
- (void)setCardFromXTOY :(NSMutableArray *)fromField  cardNumber:(int)cardNumber toField:(NSMutableArray *)toField{
    [toField addObject:[fromField objectAtIndex:cardNumber]];
    [fromField removeObjectAtIndex:cardNumber];
}

//対象プレイヤーの山札の上からX枚のカードを見る（対象プレイヤー・見る枚数）
- (void)browseLibrary: (NSMutableArray *)deck numberOfBrowsingCard:(int)num{
    for (int i = 0; i < num; i++) {
        UIImageView *cardImage = [[UIImageView alloc] init];
        [_cardInRegion addSubview:cardImage];
        cardImage.frame = CGRectMake(10, 10 + (CARDHEIGHT) * i + (i  * 5), CARDWIDTH, CARDHEIGHT);
        cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[deck objectAtIndex:i]]];
        cardImage.userInteractionEnabled = YES;
        cardImage.tag = i;
        [cardImage addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(detailOfACard:)]]; //detailOfACard:はDeckViewControllerのメソッド。エラーが出る場合は注意。
    }
    [self createOkButton:CGRectMake(10, _cardInRegion.bounds.size.height - 100, 100, 20) parentView:_cardInRegion tag:6];
    [_allImageView addSubview:_cardInRegion];
}

//対象プレイヤーの対象カードを、そのオーナーの山札のX枚目に戻す（対象プレイヤー・対象カード・戻す番目）
- (void)returnACardToLibrary :(NSMutableArray *)fromField  cardNumber:(int)cardNumber toLibrary:(NSMutableArray *)toLibrary libraryNumber:(int)libraryNumber{
    [toLibrary insertObject:[fromField objectAtIndex:cardNumber] atIndex:libraryNumber - 1];
    [fromField removeObjectAtIndex:cardNumber];
}

//攻撃キャラを変更する（対象プレイヤー：変更後のキャラ）

- (void)changeAttackCharacter :(int)man :(int)character{
    [self createCharacterField:_allImageView];
    if (man == 0) {
        mySelectCharacterInCharacterField = character;
        app.mySelectCharacter = mySelectCharacterInCharacterField;
    }else{
        mySelectCharacterInCharacterField = character;
        app.enemySelectCharacter = mySelectCharacterInCharacterField;
    }
}

//対象プレイヤーに特定の種類のカードをプレイさせない（対象カードタイプ）
- (void)dontPermitCardPlay :(int)man cardType:(int)cardType{
    if (man == 0) {
        switch (cardType) {
            case ENERGYCARD:
                app.canIPlayEnergyCard = NO;
                break;
            case FIELDCARD:
                app.canIPlayFieldCard = NO;
                break;
            case SORCERYCARD:
                app.canIPlaySorceryCard = NO;
                break;
            default:
                break;
        }
    }else{
        switch (cardType) {
            case ENERGYCARD:
                app.canEnemyPlayEnergyCard = NO;
                break;
            case FIELDCARD:
                app.canEnemyPlayFieldCard = NO;
                break;
            case SORCERYCARD:
                app.canEnemyPlaySorceryCard = NO;
                break;
            default:
                break;
        }
    }
}

//対象プレイヤーに特定の種類のカードの能力を起動させない（対象カードタイプ）
- (void)dontPermitCardActivated :(int)man cardType:(int)cardType{
    if (man == 0) {
        switch (cardType) {
            case ENERGYCARD:
                app.canIActivateEnergyCard = NO;
                break;
            case FIELDCARD:
                app.canIActivateFieldCard = NO;
                break;
            default:
                break;
        }
    }else{
        switch (cardType) {
            case ENERGYCARD:
                app.canEnemyActivateEnergyCard = NO;
                break;
            case FIELDCARD:
                app.canEnemyActivateFieldCard = NO;
                break;
            default:
                break;
        }
    }
}


//対象プレイヤーが使用した対象カードを打ち消す（対象プレイヤー・対象カード）
- (void)denyCard :(int)man {
    if(man == 0){
        app.denymyCardPlaying = YES;
    }else{
        app.denyEnemyCardPlaying = YES;
    }
}

//特定の場面でカードの追加コストを要求する
- (void)payAdditionalCost{

    //TODO : カードたくさん入れるとはみ出るかも
    
    for (int i = 0; i < [app.myHand count]; i++) {
        UIImageView *cardImage = [[UIImageView alloc] init];
        [_additionalCostView addSubview:cardImage];
        cardImage.frame = CGRectMake(10, 10 + (CARDHEIGHT) * i + (i  * 5), CARDWIDTH, CARDHEIGHT);
        cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[app.myHand objectAtIndex:i]]];
        cardImage.userInteractionEnabled = YES;
        cardImage.tag = i;
        [cardImage addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(selectCard:)]];
    }
    [self createOkButton:CGRectMake(10, _additionalCostView.bounds.size.height - 100, 100, 20) parentView:_additionalCostView tag:0];
    [self createCancelButton:CGRectMake(130, _additionalCostView.bounds.size.height - 100, 100, 20) parentView:_additionalCostView tag:1];
    [_allImageView addSubview:_additionalCostView];
    

}

//特定の場面でライフの追加コストを要求する
- (void)payAdditionalLife{
    UITextView *textView = [[UITextView alloc] init];
    [_additionalCostView addSubview:textView];
    textView.frame = CGRectMake(10, 10, textView.superview.bounds.size.width -10, textView.superview.bounds.size.width -10);
    [self createOkButton:CGRectMake(10, _additionalCostView.bounds.size.height - 100, 100, 20) parentView:_additionalCostView tag:2];
    [self createCancelButton:CGRectMake(10, _additionalCostView.bounds.size.height - 100, 100, 20) parentView:_additionalCostView tag:3];
    [_allImageView addSubview:_additionalCostView];
}

- (void)selectCard :(UITapGestureRecognizer *)sender{
    [_border_middleCard removeFromSuperview];
    _border_middleCard.frame = sender.view.frame;
    selectCardTag = (int)sender.view.tag;
}


//X点以上のダメージはY点になる
- (int)decreaseDamage:(int)mountOfDamage borderOfDamage:(int)borderDamage damageAfterDecreasing:(int)damageAfterDecreasing{
    int i = mountOfDamage;
    if(mountOfDamage >= borderDamage){
        i = damageAfterDecreasing;
    }
    return i;
}


//相性を逆転させた上で、ダメージ計算を行う
- (int)reverseCaliculate :(int)man{
    app = [[UIApplication sharedApplication] delegate];
    
    int result = 999;
    switch (man) {
        case 0:
            if(app.mySelectCharacter == GIKO){
                if (app.enemySelectCharacter == GIKO) {
                    result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                }else if (app.enemySelectCharacter == MONAR){
                    result = 0;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = app.enemyCharacterFundamentalAttackPower;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.mySelectCharacter == MONAR){
                if (app.enemySelectCharacter == GIKO) {
                    result = app.enemyCharacterFundamentalAttackPower;
                }else if (app.enemySelectCharacter == MONAR){
                    result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = 0;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.mySelectCharacter == SYOBON){
                if (app.enemySelectCharacter == GIKO) {
                    result = 0;
                }else if (app.enemySelectCharacter == MONAR){
                    result = app.enemyCharacterFundamentalAttackPower;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.mySelectCharacter == YARUO){
                if (app.enemySelectCharacter == GIKO) {
                    result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                }else if (app.enemySelectCharacter == MONAR){
                    result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = app.enemyCharacterFundamentalAttackPower - app.myCharacterFundamentalDeffencePower;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }
            NSLog(@"自分のライフ：%d",app.myLifeGage);
            NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
            NSLog(@"自分の防御力：%d", app.myCharacterFundamentalDeffencePower);
            NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
            NSLog(@"相手の攻撃力：%d", app.enemyCharacterFundamentalAttackPower);
            
            break;
            
        case 1:
            if(app.enemySelectCharacter == GIKO){
                if (app.mySelectCharacter == GIKO) {
                    result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                }else if (app.mySelectCharacter == MONAR){
                    result = 0;
                }else if (app.mySelectCharacter == SYOBON){
                    result = app.myCharacterFundamentalAttackPower;;
                }else if (app.mySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.enemySelectCharacter == MONAR){
                if (app.mySelectCharacter == GIKO) {
                    result = app.myCharacterFundamentalAttackPower;;
                }else if (app.mySelectCharacter == MONAR){
                    result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                }else if (app.mySelectCharacter == SYOBON){
                    result = 0;
                }else if (app.mySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.enemySelectCharacter == SYOBON){
                if (app.mySelectCharacter == GIKO) {
                    result = 0;
                }else if (app.mySelectCharacter == MONAR){
                    result = app.myCharacterFundamentalAttackPower;;
                }else if (app.mySelectCharacter == SYOBON){
                    result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                }else if (app.mySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.enemySelectCharacter == YARUO){
                if (app.mySelectCharacter == GIKO) {
                    result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                }else if (app.mySelectCharacter == MONAR){
                    result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                }else if (app.mySelectCharacter == SYOBON){
                    result = app.myCharacterFundamentalAttackPower - app.enemyCharacterFundamentalDeffencePower;
                }else if (app.mySelectCharacter == YARUO){
                    result = 0;
                }
            }
            break;
            
            
        default:
            break;
    }
    
    
    return result;
}


//TODO: 対象のプレイヤーが何色のエネルギーカードを場においているかを判定する。
- (int)distinguishTheNumberOfEnergyCardColor:(int)man{
    int number = 0;
    
    if (man == 0) {
        if ([app.myEnergyCard containsObject:[NSNumber numberWithInt:WHITE]] == YES)number++;
        if ([app.myEnergyCard containsObject:[NSNumber numberWithInt:BLUE]] == YES)number++;
        if ([app.myEnergyCard containsObject:[NSNumber numberWithInt:BLACK]] == YES)number++;
        if ([app.myEnergyCard containsObject:[NSNumber numberWithInt:RED]] == YES)number++;
        if ([app.myEnergyCard containsObject:[NSNumber numberWithInt:GREEN]] == YES)number++;
        NSLog(@"自分のエネルギーカードの種類数：%d種類",number);
    }else{
        if ([app.enemyEnergyCard containsObject:[NSNumber numberWithInt:WHITE]] == YES)number++;
        if ([app.enemyEnergyCard containsObject:[NSNumber numberWithInt:BLUE]] == YES)number++;
        if ([app.enemyEnergyCard containsObject:[NSNumber numberWithInt:BLACK]] == YES)number++;
        if ([app.enemyEnergyCard containsObject:[NSNumber numberWithInt:RED]] == YES)number++;
        if ([app.enemyEnergyCard containsObject:[NSNumber numberWithInt:GREEN]] == YES)number++;
        NSLog(@"相手のエネルギーカードの種類数：%d種類",number);
    }
    return number;
}




/*----------------------------------------------------------------------------------------*/

- (void)createCharacterField: (UIImageView *)view{
    //キャラクター全部を載せるフィールドを生成
    _characterField = [[UIImageView alloc] init];
    _characterField.image = [UIImage imageNamed:@"characterSelect.png"];
    _characterField.userInteractionEnabled = YES;
    
    //各キャラクターのイメージビューを生成し、上記フィールドに載せる
    UIImageView *giko = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giko.png"]];
    UIImageView *monar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monar.png"]];
    UIImageView *syobon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"syobon.png"]];
    UIImageView *yaruo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yaruo.png"]];
    
    [_characterField addSubview:giko];
    [_characterField addSubview:monar];
    [_characterField addSubview:syobon];
    [_characterField addSubview:yaruo];
    
    giko.frame = CGRectMake(10, 10, CHARACTERWIDTH, CHARACTERHEIGHT);
    monar.frame = CGRectMake(10, 10 + (CHARACTERHEIGHT + 5), CHARACTERWIDTH, CHARACTERHEIGHT);
    syobon.frame = CGRectMake(10, 10 + 2 * (CHARACTERHEIGHT + 5), CHARACTERWIDTH, CHARACTERHEIGHT);
    yaruo.frame  = CGRectMake(10, 10 + 3 * (CHARACTERHEIGHT + 5), CHARACTERWIDTH, CHARACTERHEIGHT);
    
    giko.userInteractionEnabled = YES;
    monar.userInteractionEnabled = YES;
    syobon.userInteractionEnabled = YES;
    yaruo.userInteractionEnabled = YES;
    
    giko.tag = GIKO;
    monar.tag = MONAR;
    syobon.tag = SYOBON;
    yaruo.tag = YARUO;
    
    [giko addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(characterSelected:)]];
    [monar addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(characterSelected:)]];
    [syobon addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(characterSelected:)]];
    [yaruo addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(characterSelected:)]];
    [view addSubview:_characterField];
    _characterField.frame = CGRectMake(40, 40, _characterField.superview.bounds.size.width - 80, _characterField.superview.bounds.size.height - 80);

    [self createOkButton:CGRectMake(10, _characterField.bounds.size.height - 20 - 10, 100, 20) parentView:_characterField tag:7];
    [self createCancelButton:CGRectMake(_characterField.bounds.size.width - 10 - 100,  _characterField.bounds.size.height - 20 - 10, 100, 20) parentView:_characterField tag:8];

}

- (void)characterSelected:(UITapGestureRecognizer *)sender{
    [_border_middleCard removeFromSuperview];
    _border_middleCard.frame = sender.view.frame;
    [_characterField addSubview:_border_middleCard];
    NSLog(@"sender.view.tag:%d", (int)sender.view.tag);
    mySelectCharacterInCharacterField = (int)sender.view.tag;
}

- (void)createOkButton:(CGRect)rect parentView:(UIImageView *)view tag:(int)tag{
    UIImageView *okButton = [[UIImageView alloc] initWithFrame:rect];
    okButton.image = [UIImage imageNamed:@"ok.png"];
    okButton.userInteractionEnabled = YES;
    okButton.tag = tag;
    [okButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(buttonPushed:)]];
    [view addSubview:okButton];
    
}

- (void)createCancelButton:(CGRect)rect parentView:(UIImageView *)view tag:(int)tag{
    UIImageView *cancelButton = [[UIImageView alloc] init];
    [view addSubview:cancelButton];
    cancelButton.frame = rect;
    cancelButton.image = [UIImage imageNamed:@"cancel.png"];
    cancelButton.userInteractionEnabled = YES;
    cancelButton.tag = tag;
    [cancelButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(buttonPushed:)]];

}

- (void)buttonPushed :(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 0:
            //追加コストとしてカードを捨てる際のOKボタンから飛んできた場合
            //- (void)selectCardで事前設定済み
            [self discardFromHand:MYSELF cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            [_additionalCostView removeFromSuperview];
            break;
        
        case 1:
            //追加コストとしてカードを捨てる際のキャンセルボタンから飛んできた場合
            //- (void)selectCardで事前設定済み
            [_additionalCostView removeFromSuperview];
            break;
            
        case 2:
            //追加コストとしてライフを支払う際のOKボタンから飛んできた場合
            costLife = YES;
            [_additionalCostView removeFromSuperview];
            break;
            
        case 3:
            //追加コストとしてライフを支払う際のキャンセルボタンから飛んできた場合
            costLife = NO;
            [_additionalCostView removeFromSuperview];
            break;
            
        case 4:
            //ある領域のカードを見た際のOKボタンから飛んできた場合
            [_cardInRegion removeFromSuperview];
            break;

        case 5:
            break;
            
            
        case 6:
            //山札の上からX枚を見た際のOKボタンから飛んできた場合
            [_cardInRegion removeFromSuperview];
            break;
            
        case 7:
            //キャラクター選択画面のOKボタンから飛んできた場合
            if (mySelectCharacterInCharacterField == -1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"キャラクター未選択" message:@"キャラクターが選択されていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
                [alert show];
            }else{
            [_characterField removeFromSuperview];
            }
            FINISHED

            break;
            
        case 8:
            //キャラクター選択画面のキャンセルボタンから飛んできた場合
            mySelectCharacterInCharacterField = -1;
            [_characterField removeFromSuperview];
            FINISHED
            break;
            
        case 9:
            //特定の色を選択する画面のOKボタンから飛んできた場合
            [_colorView removeFromSuperview];
            break;
            
        default:
            break;
    }
}

//selectCardTagに代入されている数値を返したあと、数値を初期化する
-(int)substituteSelectCardTagAndInitilizeIt{
    int i = selectCardTag;
    selectCardTag = -1;
    return i;
}

//特定の色を選択する画面を生成
-(void)colorSelect{
    
    UIImageView *whiteImage = [[UIImageView alloc] init];
    UIImageView *blueImage = [[UIImageView alloc] init];
    UIImageView *blackImage = [[UIImageView alloc] init];
    UIImageView *redImage = [[UIImageView alloc] init];
    UIImageView *greenImage = [[UIImageView alloc] init];
    
    [_colorView addSubview:whiteImage];
    [_colorView addSubview:blueImage];
    [_colorView addSubview:blackImage];
    [_colorView addSubview:redImage];
    [_colorView addSubview:greenImage];
    
    whiteImage.frame = CGRectMake(10, 10, 40, 60);
    blueImage.frame = CGRectMake(10, 60, 40, 60);
    blackImage.frame = CGRectMake(10, 110, 40, 60);
    redImage.frame = CGRectMake(10, 160, 40, 60);
    greenImage.frame = CGRectMake(10, 210, 40, 60);

    whiteImage.image = [UIImage imageNamed:@"white.png"];
    blueImage.image = [UIImage imageNamed:@""];
    blackImage.image = [UIImage imageNamed:@""];
    redImage.image = [UIImage imageNamed:@""];
    greenImage.image = [UIImage imageNamed:@""];
    
    whiteImage.userInteractionEnabled = YES;
    blueImage.userInteractionEnabled = YES;
    blackImage.userInteractionEnabled = YES;
    redImage.userInteractionEnabled = YES;
    greenImage.userInteractionEnabled = YES;
    
    whiteImage.tag = WHITE;
    blueImage.tag = BLUE;
    blackImage.tag = BLACK;
    redImage.tag = RED;
    greenImage.tag = GREEN;
    
    [whiteImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectColor:)]];
    [blueImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectColor:)]];
    [blackImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectColor:)]];
    [redImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectColor:)]];
    [greenImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectColor:)]];
    [self createOkButton:CGRectMake(10, (_colorView.bounds.size.height - 100) / 2, 100, 20) parentView:_colorView tag:9];
    [_allImageView addSubview:_colorView];

}

- (void) selectColor :(UITapGestureRecognizer *)sender{
    [_border_middleCard removeFromSuperview];
    _border_middleCard.frame = sender.view.frame;
    app.mySelectColor = (int)sender.view.tag;
}

-(int)substituteSelectColorTagAndInitilizeIt{
    int i = app.mySelectColor;
    app.mySelectColor = -1;
    return i;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == _putACardToLibraryTopOrBottom){
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
                //カードのcase49から飛んでくる。
                [self returnACardToLibrary:app.myDeckCardList cardNumber:[self substituteSelectCardTagAndInitilizeIt] toLibrary:app.myDeckCardList libraryNumber:[app.myDeckCardList count]];
                break;
        }
    }else if (alertView == _doIUseEnergycard){
        switch (buttonIndex) {
            case 0:
                
                [self setCardToCardsIUsedInThisTurn:app.myHand cardNumber:selectedCardOrder];
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                
                //エネルギーカードを使用する場合は、手札からエネルギーカードをエネルギー置き場に移したうえでエネルギーをプラスする
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
                if(app.myUsingCardNumber == 1){
                    [app.myEnergyCard replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:0] intValue] + 1]];
                    NSLog(@"白エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:0] intValue]);
                }else if (app.myUsingCardNumber == 2){
                    [app.myEnergyCard replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:1] intValue] + 1]];
                    NSLog(@"青エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:1] intValue]);
                }else if (app.myUsingCardNumber == 3){
                    [app.myEnergyCard replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:2] intValue] + 1]];
                    NSLog(@"黒エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:2] intValue]);
                }else if (app.myUsingCardNumber == 4){
                    [app.myEnergyCard replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:3] intValue] + 1]];
                    NSLog(@"赤エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:3] intValue]);
                }else if (app.myUsingCardNumber == 5){
                    [app.myEnergyCard replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:4] intValue] + 1]];
                    NSLog(@"緑エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:4] intValue]);
                }
                
                [self moveCards];
                
                _whiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:0] intValue]];
                _blueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:1] intValue]];
                _blackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:2] intValue]];
                _redEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:3] intValue]];
                _greenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:4] intValue]];
                
                
                //後続でソーサリー・フィールドカードを使用する場合があるため、各種カード関係の変数を初期化しておく
                selectedCardTag = -1;
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.myUsingCardNumber = -1;
                app.doIUseCard = NO;

                NSLog(@"selectCardNum:%d",app.myUsingCardNumber);
                NSLog(@"手札の内容：%@",app.myHand);
                NSLog(@"墓地の内容：%@",app.myTomb);
                
                break;
            case 1:
                //キャンセルボタンの場合は数値のみ初期化
                selectedCardTag = -1;
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.myUsingCardNumber = -1;
                app.doIUseCard = NO;
        }
    }else if (alertView == _doIUseSorcerycard){
        switch (buttonIndex) {
            case 0:
                FINISHED
                break;
            case 1:
                selectedCardTag = -1;
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.myUsingCardNumber = -1;
                app.doIUseCard = NO;
                doIUseCardInThisTurn = NO;
                break;
            default:
                break;
        }
    }else if (alertView == _doIUseFieldcard){
        switch (buttonIndex) {
            case 0:
                FINISHED
                break;
            case 1:
                selectedCardTag = -1;
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.myUsingCardNumber = -1;
                app.doIUseCard = NO;
                doIUseCardInThisTurn = NO;
                break;
            default:
                break;
        }
    }

}


//対象のカードのエネルギーコストを配列に収める（カードナンバー）
- (NSArray *)caliculateEnergyCost:(int)cardNumber{
    
    int whiteNumber = 0;//必要な白エネルギーの数を集計する
    int blueNumber = 0;//必要な青エネルギーの数を集計する
    int blackNumber = 0;//必要な黒エネルギーの数を集計する
    int redNumber = 0;//必要な赤エネルギーの数を集計する
    int greenNumber = 0;//必要な緑エネルギーの数を集計する
    int otherNumber = 0;//任意の色でよいエネルギーの数を集計する
    
    NSMutableArray *array = [[NSMutableArray alloc] init]; //白・青・黒・赤・緑・無色の配列順でコストがどれだけかかるかを管理する。
    NSString *energyCost = [app.cardList_cost objectAtIndex:cardNumber - 1]; //コストの文字列を取得
    int costLength = [energyCost length];
    NSLog(@"コストの長さ：%d",costLength);
    for (int i = 0; i < costLength; i++) {
        if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"W"]){
            whiteNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"U"]){
            blueNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"B"]){
            blackNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"R"]){
            redNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"G"]){
            greenNumber++;
        }else{
            otherNumber += [[energyCost substringWithRange:NSMakeRange(i, 1)] intValue];
        }
    }
    
    [array addObject:[NSNumber numberWithInt:whiteNumber]];
    [array addObject:[NSNumber numberWithInt:blueNumber]];
    [array addObject:[NSNumber numberWithInt:blackNumber]];
    [array addObject:[NSNumber numberWithInt:redNumber]];
    [array addObject:[NSNumber numberWithInt:greenNumber]];
    [array addObject:[NSNumber numberWithInt:otherNumber]];
    
    NSLog(@"白：%d",[[array objectAtIndex: 0] intValue]);
    NSLog(@"青：%d",[[array objectAtIndex: 1] intValue]);
    NSLog(@"黒：%d",[[array objectAtIndex: 2] intValue]);
    NSLog(@"赤：%d",[[array objectAtIndex: 3] intValue]);
    NSLog(@"緑：%d",[[array objectAtIndex: 4] intValue]);
    NSLog(@"他：%d",[[array objectAtIndex: 5] intValue]);
    
    return  array;
}

//対象のカードを使用するのに必要なエネルギーがあるか判定する（カードナンバー）
- (BOOL)doIHaveEnergyToUseCard :(int)cardNumber{
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    NSArray *cardCost = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:cardNumber]];
    int whiteNumber = [[app.myEnergyCard objectAtIndex:0] intValue] - [[cardCost objectAtIndex:0] intValue];
    int blueNumber = [[app.myEnergyCard objectAtIndex:1] intValue] - [[cardCost objectAtIndex:1] intValue];
    int blackeNumber = [[app.myEnergyCard objectAtIndex:2] intValue] - [[cardCost objectAtIndex:2] intValue];
    int redNumber = [[app.myEnergyCard objectAtIndex:3] intValue] - [[cardCost objectAtIndex:3] intValue];
    int greenNumber = [[app.myEnergyCard objectAtIndex:4] intValue] - [[cardCost objectAtIndex:4] intValue];

    if(whiteNumber < 0 || blueNumber < 0 || blackeNumber < 0 || redNumber < 0 || greenNumber < 0 || whiteNumber + blueNumber + blackeNumber + redNumber + greenNumber < [[cardCost objectAtIndex:5] intValue]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エネルギー不足" message:@"エネルギーが足りません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"カードを選択しなおす", nil];
        [alert show];
        
        NSLog(@"-----------------------------------");
        return YES;
    }
    NSLog(@"エネルギー足りてます");
    NSLog(@"-----------------------------------");
    return NO;
}

//山札を切り直す
- (void)shuffleLibrary{
    app.myDeckCardList = [app shuffledArray:app.myDeckCardList];
}

//ターン終了時に各種変数を初期化する
- (void)intializeVariables{
    
    //常に初期化するもの
    
        //自分に関係する変数
        [_border_middleCard removeFromSuperview];
        [_border_character removeFromSuperview];
        selectedCardOrder = -1;
        selectedCardTag = -1;
        selectCardTag = -1;
        costLife = NO;
        app.mySelectCharacter = -1;; //自分の選んだキャラクター
        app.myCharacterFundamentalAttackPower = 0; //自分の選んだキャラクターの攻撃力
        app.myCharacterFundamentalDeffencePower = 0; //自分の選んだキャラクターの防御力
        app.doIUseCard = NO;//自分がこのターンカードを使用したか
        app.myUsingCardNumber = -1; //自分が使用したカードの番号
        app.myDamage = 0; //このターン自分に与えられるダメージ
        app.mySelectColor = -1; //自分が選んだ色
        app.denymyCardPlaying = NO; //自分がカードのプレイを打ち消されたか
        app.myGikoModifyingAttackPower = 0;
        app.myGikoModifyingDeffencePower = 0;
        app.myMonarModifyingAttackPower = 0;
        app.myMonarModifyingDeffencePower = 0;
        app.mySyobonModifyingAttackPower = 0;
        app.mySyobonModifyingDeffencePower = 0;
        app.myYaruoModifyingAttackPower = 0;
        app.myYaruoModifyingDeffencePower = 0;
        app.myCharacterModifyingAttackPower = 0;
        app.myCharacterModifyingDeffencePower = 0;
        mySelectCharacterInCharacterField = -1;
        cardIsCompletlyUsed = NO;
        doIUseCardInThisTurn = NO;
        [app.cardsIUsedInThisTurn removeAllObjects];

    
        //相手に関係する変数
        app.enemySelectCharacter = -1; //相手の選んだキャラクター
        app.enemyCharacterFundamentalAttackPower = 0; //相手の選んだキャラクターの攻撃力
        app.enemyCharacterFundamentalDeffencePower = 0; //相手の選んだキャラクターの防御力
        app.doEnemyUseCard = NO; //相手がこのターンカードを使用したか
        app.enemyUsingCardNumber = -1; //相手が使用したカードの番号
        app.enemyDamage = 0; //このターン相手に与えられるダメージ
        app.enemySelectColor = -1; //相手が選んだ色
        app.denyEnemyCardPlaying = NO; //相手がカードのプレイを打ち消されたか
        app.enemyGikoModifyingAttackPower = 0;
        app.enemyGikoModifyingDeffencePower = 0;
        app.enemyMonarModifyingAttackPower = 0;
        app.enemyMonarModifyingDeffencePower = 0;
        app.enemySyobonModifyingAttackPower = 0;
        app.enemySyobonModifyingDeffencePower = 0;
        app.enemyYaruoModifyingAttackPower = 0;
        app.enemyYaruoModifyingDeffencePower = 0;
        app.enemyCharacterModifyingAttackPower = 0;
        app.enemyCharacterModifyingDeffencePower = 0;
        [app.cardsEnemyUsedInThisTurn removeAllObjects];
    
    
    //TODO: 条件付きで初期化するものの場合分けを行う
        //自分に関係する変数
        app.myGikoAttackPermitted = YES; //自分のギコの攻撃許可
        app.myGikoDeffencePermitted = YES; //自分のギコの防御許可
        app.myMonarAttackPermitted = YES; //自分のモナーの攻撃許可
        app.myMonarDeffencePermitted = YES; //自分のモナーの防御許可
        app.mySyobonAttackPermitted = YES; //自分のショボンの攻撃許可
        app.mySyobonDeffencePermitted = YES; //自分のショボンの防御許可
        app.myYaruoAttackPermitted = NO; //自分のやる夫の攻撃許可
        app.myYaruoDeffencePermitted = YES; //自分のやる夫の防御許可
        app.canIPlaySorceryCard = YES; //自分が魔法カードを手札からプレイできるか
        app.canIPlayFieldCard = YES; //自分が場カードを手札からプレイできるか
        app.canIActivateFieldCard = YES; //自分が場カードの能力を起動できるか
        app.canIPlayEnergyCard = YES; //自分がエネルギーカードを手札からプレイできるか
        app.canIActivateEnergyCard = YES; //自分がエネルギーカードを起動できるか
    
        //相手に関係する変数
        app.enemyGikoAttackPermitted = YES; //相手のギコの攻撃許可
        app.enemyGikoDeffencePermitted = YES; //相手のギコの防御許可
        app.enemyMonarAttackPermitted = YES; //相手のモナーの攻撃許可
        app.enemyMonarDeffencePermitted = YES; //相手のモナーの防御許可
        app.enemySyobonAttackPermitted = YES; //相手のショボンの攻撃許可
        app.enemySyobonDeffencePermitted = YES; //相手のショボンの防御許可
        app.enemyYaruoAttackPermitted = NO; //相手のやる夫の攻撃許可
        app.enemyYaruoDeffencePermitted = YES; //相手のやる夫の防御許可
        app.canEnemyPlaySorceryCard = YES; //相手が魔法カードを手札からプレイできるか
        app.canEnemyPlayFieldCard = YES; //相手が場カードを手札からプレイできるか
        app.canEnemyActivateFieldCard = YES; //相手が場カードの能力を起動できるか
        app.canEnemyPlayEnergyCard = YES; //相手がエネルギーカードを手札からプレイできるか
        app.canEnemyActivateEnergyCard = YES; //相手がエネルギーカードを起動できるか

}

- (void)syncronize{
    syncFinished = NO;
    int i = 0;
    while (!syncFinished) {
        //NSLog(@"ループ中：%d",++i);
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}

//フィールドカードを定期的に発動させるメソッドを実装する
-(void) activateFieldCardInTiming :(int)timing{
    //発動タイミング毎に発動させるカードを変える。
    switch (timing) {
        //ターン開始時
        case 0:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_turnStart containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue]];
                }
            }
            break;
        //カード使用時
        case 1:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_afterCardUsed containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue]];
                }
            }
            break;
        //ダメージ計算時
        case 2:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_damageCaliculate containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue]];
                }
            }
            break;
        //ターン終了時
        case 3:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_turnEnd containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue]];
                }
            }
            break;
        default:
            break;
    }
}


- (void)setCardToCardsIUsedInThisTurn:(NSMutableArray *)fromField  cardNumber:(int)cardNumber{
    [app.cardsIUsedInThisTurn addObject:[fromField objectAtIndex:cardNumber]];
}

@end
