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

    drawCount = 0;
    selectedCardOrder = -1;
    selectedCardNum = -1;
    selectedCardTag = -1;
    selectCardTag = -1;
    mySelectColor = -1;
    enemySelectColor = -1;
    
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
    
    [self.view addSubview:_allImageView];

    app.myLifeGage = 20;
    app.myCharacterAttackPower = 3;
    app.myCharacterDeffencePower = 0;
    app.enemySelectCharacter = 99;
    app.enemyLifeGage = 20;
    app.enemyCharacterAttackPower = 3;
    app.enemyCharacterDeffencePower = 0;
    app.numberOfMyCard = 3;
    app.numberOfEnemyCard = 3;
    
    
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
    [self createCharacterField:_allImageView];
}

- (void)debug2 :(UITapGestureRecognizer *)sender{
    
}

- (void)debug3 :(UITapGestureRecognizer *)sender{
    
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
            app.myCharacterAttackPower = app.myGikoAttackPower;
            app.myCharacterDeffencePower = app.myGikoDeffencePower;
            NSLog(@"選択キャラ：ギコ");
            break;
        case 2:
            
            app.mySelectCharacter = MONAR;
            app.myCharacterAttackPower = app.myMonarAttackPower;
            app.myCharacterDeffencePower = app.myMonarDeffencePower;
            NSLog(@"選択キャラ：モナー");
            break;
        case 3:
            app.mySelectCharacter = SYOBON;
            app.myCharacterAttackPower = app.mySyobonAttackPower;
            app.myCharacterDeffencePower = app.mySyobonDeffencePower;
            NSLog(@"選択キャラ：ショボン");
            break;
        case 4:
            app.mySelectCharacter = YARUO;
            app.myCharacterAttackPower = app.myYaruoAttackPower;
            app.myCharacterDeffencePower = app.myYaruoDeffencePower;
            NSLog(@"選択キャラ：やる夫");
            break;
        default:
            break;
    }
    NSLog(@"攻撃力：%d",app.myCharacterAttackPower);
    NSLog(@"防御力：%d",app.myCharacterDeffencePower);
}


- (IBAction)keisan{
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    NSLog(@"自分の職種＿計算時：%d",app.mySelectCharacter);
    
    app.enemySelectCharacter = GIKO;
    [self resultFadeIn:_turnResultView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self moveCards];
    [self cardActivate];
    [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
    if(app.mySelectCharacter == YARUO){
        [self getACard:MYSELF];
        
    }
    
    //各種数値を初期化
    [_border_middleCard removeFromSuperview];
    [_border_character removeFromSuperview];
    selectedCardOrder = -1;
    selectedCardNum = -1;
    selectedCardTag = -1;
    selectCardTag = -1;
    mySelectColor = -1;
    enemySelectColor = -1;
    app.mySelectCharacter = -1;
    
    NSLog(@"自分の手札：%@",app.myHand);
    NSLog(@"自分の墓地：%@",app.myTomb);
    
    
    NSLog(@"-----------------------------------");
    
}

-(void)cardActivate{
    switch (selectedCardNum) {
        case 6:
            //対象キャラの防御力１ターンだけ＋３（W)
            [self deffencePowerOperate:app.myCharacterDeffencePower point:3];
            break;
        case 7:
            //対象キャラの防御力ずっと＋３（W2)
            [self deffencePowerOperate:app.myCharacterDeffencePower point:3];
            break;
        case 8:
            //自分のライフ＋３（W)
            [self HPOperate:app.myLifeGage point:3];
            break;
        case 9:
            //自分のライフ＋３、カードを一枚引く（W２）
            [self HPOperate:app.myLifeGage point:3];
            [self getACard:MYSELF];
            break;
        case 10:
            //毎ターンライフを＋１する（W２)
            [self HPOperate:app.myLifeGage point:1];
            break;
        case 11:
            //相手プレイヤーが白色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == WHITE) {
                [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 12:
            //相手プレイヤーが青色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == BLUE) {
                [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 13:
            //相手プレイヤーが黒色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == BLACK) {
                [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 14:
            //相手プレイヤーが赤色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == RED) {
                [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 15:
            //相手プレイヤーが緑色のカードを使用するたび、ライフを＋１する（W1)
            if ([self distinguishCardColor:app.enemyUsingCardNumber] == GREEN) {
                [self HPOperate:app.myLifeGage point:1];
            }
            break;
        case 16:
            //白色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == WHITE){
                [self deffencePowerOperate:app.myGikoDeffencePower point:1];
                [self deffencePowerOperate:app.myMonarDeffencePower point:1];
                [self deffencePowerOperate:app.mySyobonDeffencePower point:1];
                [self deffencePowerOperate:app.myYaruoDeffencePower point:1];
                
            }
            break;
        case 17:
            //青色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == BLUE){
                [self deffencePowerOperate:app.myGikoDeffencePower point:1];
                [self deffencePowerOperate:app.myMonarDeffencePower point:1];
                [self deffencePowerOperate:app.mySyobonDeffencePower point:1];
                [self deffencePowerOperate:app.myYaruoDeffencePower point:1];
                
            }
            break;
        case 18:
            //黒色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == BLACK){
                [self deffencePowerOperate:app.myGikoDeffencePower point:1];
                [self deffencePowerOperate:app.myMonarDeffencePower point:1];
                [self deffencePowerOperate:app.mySyobonDeffencePower point:1];
                [self deffencePowerOperate:app.myYaruoDeffencePower point:1];
                
            }
            break;
        case 19:
            //赤色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == RED){
                [self deffencePowerOperate:app.myGikoDeffencePower point:1];
                [self deffencePowerOperate:app.myMonarDeffencePower point:1];
                [self deffencePowerOperate:app.mySyobonDeffencePower point:1];
                [self deffencePowerOperate:app.myYaruoDeffencePower point:1];
                
            }
            break;
        case 20:
            //緑色からのダメージを１減らす（W1)
            if([self distinguishCardColor:app.enemyUsingCardNumber] == GREEN){
                [self deffencePowerOperate:app.myGikoDeffencePower point:1];
                [self deffencePowerOperate:app.myMonarDeffencePower point:1];
                [self deffencePowerOperate:app.mySyobonDeffencePower point:1];
                [self deffencePowerOperate:app.myYaruoDeffencePower point:1];
                
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
            //このターンを含め３ターン、相手に防御させない（WW３)
            [self forbidDeffence:app.enemyGikoDeffencePermitted];
            [self forbidDeffence:app.enemyMonarDeffencePermitted];
            [self forbidDeffence:app.enemySyobonDeffencePermitted];
            [self forbidDeffence:app.enemyYaruoDeffencePermitted];
            break;
        case 26:
            //手札のカード枚数×２のライフ回復（WW2)
            [self HPOperate:app.myLifeGage point:[app.myHand count] * 2];
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
            [self HPOperate:app.myLifeGage point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * 2];
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
            [self attackPowerOperate:app.enemyCharacterAttackPower point:-3];
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
            //特定色のフィールドカードを全てオーナーの手札に戻す（U3)
            {
                //手札に戻す色を選ぶ
                [self colorSelect];
                
                //自分の場のカードを判定
                int i1 = [app.myFieldCard count];
                int myRemoveCount = 0;
                for (int i = 0; i < i1; i++) {
                    if([self distinguishCardColor:(int)[app.myFieldCard objectAtIndex:i]] == mySelectColor){
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
        case 49:
            //一番上のカードを見て、取るか一番下に置く（U)
            [self browseLibrary:app.myDeckCardList numberOfBrowsingCard:1];
            _putACardToLibraryTopOrBottom = [[UIAlertView alloc] initWithTitle:@"選択" message:@"山札のどちらにおきますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"一番上", @"一番下", nil];
            break;
        case 50:
            //攻撃キャラギコにする（U2)
            app.enemySelectCharacter = GIKO;
            break;
        case 51:
            //攻撃キャラをモナーにする（U2)
            app.enemySelectCharacter = MONAR;
            break;
        case 52:
            //攻撃キャラをショボンにする（U2)
            app.enemySelectCharacter = SYOBON;
            break;
        case 53:
            //このターンキャラの相性関係を逆転させる（U2)
            [self reverseCaliculate:MYSELF];
            [self reverseCaliculate:ENEMY];
            
            break;
        case 54:
            //次ターン、相手にカードを使わせない（U4)
            [self dontPermitCardPlay:ENEMY cardType:ENERGYCARD];
            [self dontPermitCardPlay:ENEMY cardType:FIELDCARD];
            [self dontPermitCardPlay:ENEMY cardType:SORCERYCARD];
            break;
        case 55:
            //エネルギーカードの種類数だけカードを引く（U2)
            {
                int num = [self distinguishTheNumberOfEnergyCardColor:MYSELF];
                
                for (int i = 0; i < num; i++) {
                    [self getACard:MYSELF];
                }
            }
            break;
        case 56:
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
        case 57:
            //このターン相手が使用したカードを打ち消す（UU)
            [self denyCard:ENEMY];
            break;
        case 58:
            //このターン相手が使用した場カードを使用した場合、それを打ち消す（U)
            if([[app.cardList_type objectAtIndex:app.enemyUsingCardNumber] intValue] == FIELDCARD){
                [self denyCard:ENEMY];
            }
            break;
        case 59:
            //このターン相手が白色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == WHITE){
                [self denyCard:ENEMY];
            }
            break;
        case 60:
            //このターン相手が青色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == BLUE){
                [self denyCard:ENEMY];
            }
            break;
        case 61:
            //このターン相手が黒色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == BLACK){
                [self denyCard:ENEMY];
            }
            break;
        case 62:
            //このターン相手が赤色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == RED){
                [self denyCard:ENEMY];
            }
            break;
        case 63:
            //このターン相手が緑色のカードを使用した場合、それを打ち消す（U)
            if([[app.cardList_color objectAtIndex:app.enemyUsingCardNumber] intValue] == GREEN){
                [self denyCard:ENEMY];
            }
            break;
        case 64:
            //カードを一枚引く（U1)
            [self getACard:MYSELF];
            break;
        case 65:
            //カードを２枚引き、２枚捨てる(UU)
            [self getACard:MYSELF];
            [self getACard:MYSELF];
            [self browseCardsInRegion:app.myHand];
            [self discardFromHand:MYSELF cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            [self browseCardsInRegion:app.myHand];
            [self discardFromHand:MYSELF cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 66:
            //対象キャラの攻撃力＋３（R)
            [self attackPowerOperate:app.myCharacterAttackPower point:3];
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
            [self HPOperate:app.enemyLifeGage point:-2];
            
            break;
        case 71:
            //相手のライフに3点のダメージ（R1)
            [self HPOperate:app.enemyLifeGage point:-3];
            break;
        case 72:
            //毎ターン相手に１点のダメージ（R２)
            [self HPOperate:app.enemyLifeGage point:-1];
            break;
        case 73:
            //自分のライフを１点削り、相手に3点ダメージ（R)
            [self HPOperate:app.myLifeGage point:-1];
            [self HPOperate:app.enemyLifeGage point:-3];
            break;
        case 74:
            //自分のライフを２点削り、相手に4点ダメージ（RR)
            [self HPOperate:app.myLifeGage point:-2];
            [self HPOperate:app.enemyLifeGage point:-4];
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
                [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 78:
            //相手プレイヤーに2点ダメージ。相手がモナーを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == MONAR) {
                [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 79:
            //相手プレイヤーに2点ダメージ。相手がショボンを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == SYOBON) {
                [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 80:
            //相手プレイヤーに2点ダメージ。相手がやる夫を選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == YARUO) {
                [self HPOperate:app.enemyLifeGage point:-5];
            }else{
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 81:
            //攻撃力が＋５される代わりに防御力が０になる（R１)
            [self attackPowerOperate:app.myGikoAttackPower point:5];
            [self attackPowerOperate:app.myMonarAttackPower point:5];
            [self attackPowerOperate:app.mySyobonAttackPower point:5];
            [self attackPowerOperate:app.myYaruoAttackPower point:5];
            [self deffencePowerOperate:app.myGikoDeffencePower point:app.myGikoDeffencePower * -1];
            [self deffencePowerOperate:app.myMonarDeffencePower point:app.myMonarDeffencePower * -1];
            [self deffencePowerOperate:app.mySyobonDeffencePower point:app.mySyobonDeffencePower * -1];
            [self deffencePowerOperate:app.myYaruoDeffencePower point:app.myYaruoDeffencePower * -1];
            break;
        case 82:
            //相手がこのターンカードを使った場合、相手プレイヤーに3点のダメージ。使っていなければ1点ダメージ（RR)
            if(app.doEnemyUseCard == YES){
                [self HPOperate:app.enemyLifeGage point:-3];
            }else{
                [self HPOperate:app.enemyLifeGage point:-1];
            }
            break;
        case 83:
            //相手がこのターンカードを使わなかった場合、相手プレイヤーに5点のダメージ。使っていなければ１点ダメージ。（RR)
            if(app.doEnemyUseCard == NO){
                [self HPOperate:app.enemyLifeGage point:-4];
            }else{
                [self HPOperate:app.enemyLifeGage point:-1];
            }
            break;
        case 84:
            //相手プレイヤーに、場に出ている選んだ一色のエネルギーカードの枚数分のダメージ（R4)
            [self colorSelect];
            int num = 0;
            for (int i = 0; i < [app.myFieldCard count]; i++) {
                if([self distinguishCardColor:[[app.myFieldCard objectAtIndex:i] intValue]] == mySelectColor){
                    num++;
                }
            }
            for (int i = 0; i < [app.enemyFieldCard count]; i++) {
                if([self distinguishCardColor:[[app.enemyFieldCard objectAtIndex:i] intValue]] == mySelectColor){
                    num++;
                }
            }
            [self HPOperate:app.enemyLifeGage point:num];
            mySelectColor = -1; //mySelectCharacerを初期化
            
            break;
        case 85:
            //エネルギーカードの種類数ぶんだけ相手プレイヤーにダメージ。（R1)
            {
                int num = [self distinguishTheNumberOfEnergyCardColor:MYSELF];
                [self HPOperate:app.enemyLifeGage point:num];
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
            [self attackPowerOperate:app.enemyGikoAttackPower point:-5];
            [self attackPowerOperate:app.enemyMonarAttackPower point:-5];
            [self attackPowerOperate:app.enemySyobonAttackPower point:-5];
            [self attackPowerOperate:app.enemyYaruoAttackPower point:-5];
            
            break;
        case 88:
            //相手がギコを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == GIKO) {
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 89:
            //相手がモナーを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == MONAR) {
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 90:
            //相手がショボンを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == SYOBON) {
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 91:
            //相手がやる夫を選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == YARUO) {
                [self HPOperate:app.enemyLifeGage point:-2];
            }
            break;
        case 92:
            //毎ターン１点ダメージ（R2)
            [self HPOperate:app.enemyLifeGage point:-1];
            break;
        case 93:
            //自分の選択キャラの攻撃力−１、２点ダメージ（R)
            if (app.mySelectCharacter == GIKO) {
                [self attackPowerOperate:app.myGikoAttackPower point:-1];
                [self HPOperate:app.enemyLifeGage point:-2];
            }else if (app.mySelectCharacter == MONAR){
                [self attackPowerOperate:app.myMonarAttackPower point:-1];
                [self HPOperate:app.enemyLifeGage point:-2];
            }else if (app.mySelectCharacter == SYOBON){
                [self attackPowerOperate:app.mySyobonAttackPower point:-1];
                [self HPOperate:app.enemyLifeGage point:-2];
            }else if (app.mySelectCharacter == YARUO){
                [self attackPowerOperate:app.myYaruoAttackPower point:-1];
                [self HPOperate:app.enemyLifeGage point:-2];
            }
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
            //相手プレイヤーのライフを１削り、自分は１回復（B１)
            [self HPOperate:app.enemyLifeGage point:-1];
            [self HPOperate:app.myLifeGage point:1];
            
            break;
        case 97:
            //相手プレイヤーのライフを２削り、自分は２回復（B2)
            [self HPOperate:app.enemyLifeGage point:-2];
            [self HPOperate:app.myLifeGage point:2];
            
            break;
        case 98:
            //相手の手札をランダムで１枚減らす（B)
            {
                //TODO: 対象配列にカードがないとき、エラーが起きないようにする（カードを移動する系の他のカードも全て同じ対応が必要！）
                int rand = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand];
            }
            break;
        case 99:
            //相手の手札をランダムで２枚減らす（BB)
            {
                int rand = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand];
            
                int rand2 = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand2];
            }
            break;
        case 100:
            //相手の手札を全て減らす（BB3)
            {
                for (int i = 0; i < [app.enemyHand count]; i++) {
                    [self discardFromHand:ENEMY cardNumber:0];
                }
            }
            break;
        case 101:
            //このターンに与えたダメージ分、自分は回復（B1)
            //TODO: メソッド実装
            break;
        case 102:
            //攻撃力と防御力が−１される代わりにブロックされない（B１)
            [self attackPowerOperate:app.myCharacterAttackPower point:-1];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:-1];
            [self forbidDeffence:app.enemyGikoDeffencePermitted];
            [self forbidDeffence:app.enemyMonarDeffencePermitted];
            [self forbidDeffence:app.enemySyobonDeffencePermitted];
            [self forbidDeffence:app.enemyYaruoDeffencePermitted];
            break;
        case 103:
            //このターン、ライフを３点失う代わりに攻撃力が＋５される（BB)
            [self HPOperate:app.myLifeGage point:-3];
            [self attackPowerOperate:app.myCharacterAttackPower point:5];
            
            break;
        case 104:
            //毎ターンライフを５点失う代わりに攻撃力が＋８される（BB2)
            [self HPOperate:app.myLifeGage point:-5];
            [self attackPowerOperate:app.myCharacterAttackPower point:8];
            
            break;
        case 105:
            //自分の場カードを破壊することでカードを２枚引く（B1)
            [self browseCardsInRegion:app.myFieldCard];
            [self setCardFromXTOY:app.myFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            [self getACard:MYSELF];
            [self getACard:MYSELF];
            
            break;
        case 106:
            //エネルギーカードの種類数だけ、相手の攻撃力と防御力をマイナスさせる（B1)
            
            [self attackPowerOperate:app.enemyCharacterAttackPower point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1];
            [self deffencePowerOperate:app.enemyCharacterDeffencePower point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1];
            break;
        case 107:
            //場のカードを破壊するが、ライフを３点失う（B1)
            [self browseCardsInRegion:app.enemyFieldCard];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 108:
            //自分のターンの開始時に、相手プレイヤーはカードをランダムで１枚捨てる（BB2)
            {
                int rand = random() % [app.enemyHand count];
                [self discardFromHand:ENEMY cardNumber:rand];
            }
            break;
        case 109:
            //対象キャラの攻撃力・防御力を−１し、カードを一枚引く。（B2)
            //TODO: app.mySelectCharacterに数値が入った時は、app.myCharacterAttackPowerとapp.myCharacterDeffencePowerにも数値が入るようにする。
            //TODO: app.mySelectCharacterとapp.myCharacterAttackPowerとapp.myCharacterDeffencePowerはターン終了時に初期化する
            
            [self createCharacterField:_allImageView];
            [self attackPowerOperate:app.myCharacterAttackPower point:-1];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:-1];
            [self getACard:MYSELF];
            
            break;
        case 110:
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
        case 111:
            //相手プレイヤーがカードを使用するたび、カードを一枚引く（BB4)
            if (app.doEnemyUseCard == YES) {
                [self getACard:MYSELF];
            }
            break;
        case 112:
            //カードを一枚好きにサーチし、ライブラリを切り直す。ライフを４点失う（B1)
            [self browseCardsInRegion:app.myDeckCardList];
            [self setCardFromXTOY:app.myDeckCardList cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myHand];
            [self HPOperate:app.myLifeGage point:-4];
            
            break;
        case 113:
            //カードを一枚好きにサーチし、ライブラリを切り直す（BB2)
            [self browseCardsInRegion:app.myDeckCardList];
            [self setCardFromXTOY:app.myDeckCardList cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myHand];
            break;
        case 114:
            //相手プレイヤーのデッキからカードを一枚捨てる（B１)
            [self browseCardsInRegion:app.enemyDeckCardList];
            [self discardFromLibrary:ENEMY  tagNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 115:
            //相手プレイヤーのデッキからカードを十枚捨てる(BBB5)
            for (int i = 0; i < 10; i++) {
                [self browseCardsInRegion:app.enemyDeckCardList];
                [self discardFromLibrary:ENEMY  tagNumber:[self substituteSelectCardTagAndInitilizeIt]];
            }
            break;
        case 116:
            //攻撃力は＋３されるが、防御力が半分になる（B)
            [self attackPowerOperate:app.myCharacterAttackPower point:3];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:app.myCharacterDeffencePower / 2];
            
            break;
        case 117:
            //相手プレイヤーの手札の中にある、カードを1枚選んで捨てる（BB2)
            [self browseCardsInRegion:app.enemyHand];
            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 118:
            //相手プレイヤーの手札の中にある、カードを2枚選んで捨てる（BB2)
            [self browseCardsInRegion:app.enemyHand];
            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 119:
            //各プレイヤーの場カードを一枚ずつランダムに破壊する（B)
            {
                int rand1 = random() % [app.myFieldCard count];
                [self setCardFromXTOY:app.myFieldCard cardNumber:rand1 toField:app.myTomb];
                int rand2 = random() % [app.enemyFieldCard count];
                [self setCardFromXTOY:app.enemyFieldCard cardNumber:rand2 toField:app.enemyTomb];
            }
            break;
        case 120:
            //カードを一枚捨てる代わりに、相手のカードを好きに一枚捨てられる（B)
            [self payAdditionalCost];
            [self browseCardsInRegion:app.enemyHand];
            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 121:
            //全プレイヤーは手札を捨てる（BB3)
            
                for (int i = 0; i < [app.myHand count]; i++) {
                    [self discardFromHand:MYSELF cardNumber:0];
                }
                for (int i = 0; i < [app.enemyHand count]; i++) {
                    [self discardFromHand:ENEMY cardNumber:0];
                }
            break;
        case 122:
            //対象キャラは攻撃力＋２、防御力−２（B3)
            [self createCharacterField:_allImageView];
            [self attackPowerOperate:app.myCharacterAttackPower point:2];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:-2];
            break;
        case 123:
            //自分の場カードを破壊することで、対象プレイヤーはカードを２枚捨てる（B1)
            [self browseCardsInRegion:app.myFieldCard];
            [self setCardFromXTOY:app.myFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            [self browseCardsInRegion:app.enemyHand];
            [self setCardFromXTOY:app.enemyHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            [self browseCardsInRegion:app.enemyHand];
            [self setCardFromXTOY:app.enemyHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 124:
            //カードを２枚捨てることで、ずっと攻撃力・防御力＋２（B1)
            [self browseCardsInRegion:app.myHand];
            [self setCardFromXTOY:app.myHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            [self browseCardsInRegion:app.myHand];
            [self setCardFromXTOY:app.myHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            [self attackPowerOperate:app.myGikoAttackPower point:2];
            [self deffencePowerOperate:app.myGikoDeffencePower point:2];
            [self attackPowerOperate:app.myMonarAttackPower point:2];
            [self deffencePowerOperate:app.myMonarDeffencePower point:2];
            [self attackPowerOperate:app.mySyobonAttackPower point:2];
            [self deffencePowerOperate:app.mySyobonDeffencePower point:2];
            [self attackPowerOperate:app.myYaruoAttackPower point:2];
            [self deffencePowerOperate:app.myYaruoDeffencePower point:2];
            break;
        case 125:
            //毎ターン相手に３点ダメージ（BB3)
            [self HPOperate:app.enemyLifeGage point:-3];
            break;
        case 126:
            //対象キャラの攻撃力・防御力を１ターン＋３（G)
            [self createCharacterField:_allImageView];
            [self attackPowerOperate:app.myCharacterAttackPower point:3];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:3];
            
            break;
        case 127:
            //対象キャラの攻撃力・防御力を１ターン＋７（G3)
            [self createCharacterField:_allImageView];
            [self attackPowerOperate:app.myCharacterAttackPower point:7];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:7];
            
            break;
        case 128:
            //対象キャラの攻撃力・防御力を１ターン＋１，カードを一枚引く（G)
            [self createCharacterField:_allImageView];
            [self attackPowerOperate:app.myCharacterAttackPower point:1];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:1];
            [self getACard:MYSELF];
            
            break;
        case 129:
            //１ターンの間、対象キャラの攻撃力・防御力を＋２，攻撃力そのままをダメージにする（G2)
            [self createCharacterField:_allImageView];
            [self attackPowerOperate:app.myCharacterAttackPower point:2];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:2];
            [self deffencePowerOperate:app.enemyGikoDeffencePower point:app.enemyGikoDeffencePower * -1];
            [self deffencePowerOperate:app.enemyMonarDeffencePower point:app.enemyMonarDeffencePower * -1];
            [self deffencePowerOperate:app.enemySyobonDeffencePower point:app.enemySyobonDeffencePower * -1];
            [self deffencePowerOperate:app.enemyYaruoDeffencePower point:app.enemyYaruoDeffencePower * -1];
            
            break;
        case 130:
            //対象キャラの攻撃力・防御力を１ターン＋4（G1)
            [self createCharacterField:_allImageView];
            [self attackPowerOperate:app.myCharacterAttackPower point:4];
            [self deffencePowerOperate:app.myCharacterDeffencePower point:4];
            break;
        case 131:
            //相手がカードを一枚（エネルギーカード除く）使うたびに剣士・魔法使い・格闘家の攻撃力を＋１する（G2)
            
            break;
        case 132:
            //このターン、双方ともダメージ無効（G)
            
            break;
        case 133:
            //２ターン、双方ともダメージ無効（G2)
            
            break;
        case 134:
            //このターン、双方ともダメージ無効。次のターン攻撃させない（G1)
            
            break;
        case 135:
            //このターン攻撃力そのままをダメージにする（G)
            
            break;
        case 136:
            //ずっと攻撃力そのままをダメージにする（G４）
            
            break;
        case 137:
            //エネルギーカードを１枚サーチ（G１)
            
            break;
        case 138:
            //エネルギーカードを２枚サーチ（GG2)
            
            break;
        case 139:
            
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

- (void)resultFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    view = [[UIImageView alloc] initWithImage:img];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"自分の選択キャラ：%@",[self myCharacterType]] Rectangle:CGRectMake(20, 20, 240, 20)];
    [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"相手の選択キャラ：初期（後で実装）"] Rectangle:CGRectMake(20, 40, 240, 20)];
    [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"自分の選択カード：初期（後で実装）"] Rectangle:CGRectMake(20, 60, 240, 20)];
    [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"相手の選択カード：初期（後で実装）"] Rectangle:CGRectMake(20, 80, 240, 20)];
    [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"相手のカード効果：\n（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）（後で実装）"] Rectangle:CGRectMake(20, 80, 240, 320)];
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDidStopSelector:@selector(resultFadeOut:)];
    [UIView commitAnimations];
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

- (void)insertTextViewToParentView:(UIView *)parentView Text:(NSString *)text Rectangle:(CGRect)rect{
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = rect;
    textView.text  = text;
    textView.editable = NO;
    [parentView addSubview:textView];
}

- (void)resultFadeOut:(UITapGestureRecognizer *)sender{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    sender.view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    sender.view.center = CGPointMake( ([[UIScreen mainScreen] bounds].size.width * -2) ,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView commitAnimations];
    [UIView setAnimationDidStopSelector:@selector(removeView:)];
}

- (void)removeView:(UIImageView *)view{
    [view removeFromSuperview];
}

-(void)okButton{
    if (app.mySelectCharacter == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"キャラクター未選択" message:@"キャラクターが選ばれていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"キャラクターを選択する", nil];
        [alert show];
    }else{
        [self keisan];
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
}

- (void)touchAction :(UILongPressGestureRecognizer *)sender{
    selectedCardOrder = (int)[_myCardImageViewArray indexOfObject:sender.view];
    int cardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue];
    int cardType = [[app.cardList_type objectAtIndex:cardNumber - 1 ] intValue];
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
    
    
    if(cardType == SORCERYCARD){
        //ソーサリーカードが選択された場合、使用するのに足るエネルギーを持っているか確認し、足りなければ弾く。加えて許可区分を確認し、不許可なら弾く。
        if([self doIHaveEnergyToUseCard:cardNumber]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エネルギー不足" message:@"エネルギーが足りません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
            [alert show];
        }
        else if(app.canIPlaySorceryCard == NO){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"封印" message:@"ソーサリーカードの使用は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
            [alert show];
        }else{
            if (sender.view.tag == selectedCardTag) {
                selectedCardTag = -1;
                selectedCardNum = -1;
                selectedCardOrder = -1;
                [_border_middleCard removeFromSuperview];
                NSLog(@"カードの選択をキャンセル");
                [_myCardImageView_middle removeFromSuperview];
                [_myCardTextView_middle removeFromSuperview];
            }else{
                [_border_middleCard removeFromSuperview];
                _border_middleCard.frame = sender.view.frame;
                [_allImageView addSubview:_border_middleCard];
                selectedCardNum = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
                selectedCardTag = (int)sender.view.tag; //デッキの配列番号と一致
                
                [_myCardImageView_middle removeFromSuperview];
                _myCardImageView_middle.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",selectedCardNum]];
                [_allImageView addSubview:_myCardImageView_middle];
                
                [_myCardTextView_middle removeFromSuperview];
                _myCardTextView_middle.text = [NSString stringWithFormat:@"%@", [app.cardList_text objectAtIndex:selectedCardNum]];
                [_allImageView addSubview:_myCardTextView_middle];
            }

        }
    }
    
    //フィールドカードの場合の実装
    else if (cardType == FIELDCARD){
        //フィールドカードが選択された場合、使用するのに足るエネルギーを持っているか確認し、足りなければ弾く。加えて許可区分を確認し、不許可なら弾く。
        if([self doIHaveEnergyToUseCard:cardNumber]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エネルギー不足" message:@"エネルギーが足りません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
            [alert show];
        }
        else if (app.canIPlayFieldCard == NO){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"封印" message:@"フィールドカードの使用は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
            [alert show];
        }else{
            if (sender.view.tag == selectedCardTag) {
                selectedCardTag = -1;
                selectedCardNum = -1;
                selectedCardOrder = -1;
                [_border_middleCard removeFromSuperview];
                NSLog(@"カードの選択をキャンセル");
                [_myCardImageView_middle removeFromSuperview];
                [_myCardTextView_middle removeFromSuperview];
            }else{
                [_border_middleCard removeFromSuperview];
                _border_middleCard.frame = sender.view.frame;
                [_allImageView addSubview:_border_middleCard];
                selectedCardNum = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
                selectedCardTag = (int)sender.view.tag; //デッキ内の配列番号と一致
                
                [_myCardImageView_middle removeFromSuperview];
                _myCardImageView_middle.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",selectedCardNum]];
                [_allImageView addSubview:_myCardImageView_middle];
                
                [_myCardTextView_middle removeFromSuperview];
                _myCardTextView_middle.text = [NSString stringWithFormat:@"%@", [app.cardList_text objectAtIndex:selectedCardNum]];
                [_allImageView addSubview:_myCardTextView_middle];
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
            selectedCardNum = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
            selectedCardTag = (int)sender.view.tag; //デッキ内の配列番号と一致する
            
            [_myCardImageView_middle removeFromSuperview];
            _myCardImageView_middle.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",selectedCardNum]];
            [_allImageView addSubview:_myCardImageView_middle];
            [_myCardTextView_middle removeFromSuperview];
            _myCardTextView_middle.text = [NSString stringWithFormat:@"%@", [app.cardList_text objectAtIndex:selectedCardNum]];
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

//対象キャラの攻撃力を操作する（対象キャラの攻撃力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)attackPowerOperate :(int)character point:(int)x{
    character += x;
}

//対象キャラの防御力を操作する（対象キャラの防御力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)deffencePowerOperate :(int)character point:(int)x{
    character += x;
}

//対象プレイヤーのHPを操作する（対象プレイヤーのHPを管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)HPOperate :(int)lifeGage point:(int)x{
    lifeGage += x;
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
    if (man == 0) {
        app.mySelectCharacter = character;
    }else{
        app.enemySelectCharacter = character;
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
                    result = app.enemyCharacterAttackPower - app.myCharacterDeffencePower;
                }else if (app.enemySelectCharacter == MONAR){
                    result = 0;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = app.enemyCharacterAttackPower;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.mySelectCharacter == MONAR){
                if (app.enemySelectCharacter == GIKO) {
                    result = app.enemyCharacterAttackPower;
                }else if (app.enemySelectCharacter == MONAR){
                    result = app.enemyCharacterAttackPower - app.myCharacterDeffencePower;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = 0;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.mySelectCharacter == SYOBON){
                if (app.enemySelectCharacter == GIKO) {
                    result = 0;
                }else if (app.enemySelectCharacter == MONAR){
                    result = app.enemyCharacterAttackPower;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = app.enemyCharacterAttackPower - app.myCharacterDeffencePower;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.mySelectCharacter == YARUO){
                if (app.enemySelectCharacter == GIKO) {
                    result = app.enemyCharacterAttackPower - app.myCharacterDeffencePower;
                }else if (app.enemySelectCharacter == MONAR){
                    result = app.enemyCharacterAttackPower - app.myCharacterDeffencePower;
                }else if (app.enemySelectCharacter == SYOBON){
                    result = app.enemyCharacterAttackPower - app.myCharacterDeffencePower;
                }else if (app.enemySelectCharacter == YARUO){
                    result = 0;
                }
            }
            NSLog(@"自分のライフ：%d",app.myLifeGage);
            NSLog(@"自分の選択キャラ：%d",app.mySelectCharacter);
            NSLog(@"自分の防御力：%d", app.myCharacterDeffencePower);
            NSLog(@"相手の選択キャラ：%d", app.enemySelectCharacter);
            NSLog(@"相手の攻撃力：%d", app.enemyCharacterAttackPower);
            
            break;
            
        case 1:
            if(app.enemySelectCharacter == GIKO){
                if (app.mySelectCharacter == GIKO) {
                    result = app.myCharacterAttackPower - app.enemyCharacterDeffencePower;
                }else if (app.mySelectCharacter == MONAR){
                    result = 0;
                }else if (app.mySelectCharacter == SYOBON){
                    result = app.myCharacterAttackPower;;
                }else if (app.mySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.enemySelectCharacter == MONAR){
                if (app.mySelectCharacter == GIKO) {
                    result = app.myCharacterAttackPower;;
                }else if (app.mySelectCharacter == MONAR){
                    result = app.myCharacterAttackPower - app.enemyCharacterDeffencePower;
                }else if (app.mySelectCharacter == SYOBON){
                    result = 0;
                }else if (app.mySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.enemySelectCharacter == SYOBON){
                if (app.mySelectCharacter == GIKO) {
                    result = 0;
                }else if (app.mySelectCharacter == MONAR){
                    result = app.myCharacterAttackPower;;
                }else if (app.mySelectCharacter == SYOBON){
                    result = app.myCharacterAttackPower - app.enemyCharacterDeffencePower;
                }else if (app.mySelectCharacter == YARUO){
                    result = 0;
                }
            }else if (app.enemySelectCharacter == YARUO){
                if (app.mySelectCharacter == GIKO) {
                    result = app.myCharacterAttackPower - app.enemyCharacterDeffencePower;
                }else if (app.mySelectCharacter == MONAR){
                    result = app.myCharacterAttackPower - app.enemyCharacterDeffencePower;
                }else if (app.mySelectCharacter == SYOBON){
                    result = app.myCharacterAttackPower - app.enemyCharacterDeffencePower;
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
    app.mySelectCharacter = (int)sender.view.tag;
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
            if (app.mySelectCharacter == -1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"キャラクター未選択" message:@"キャラクターが選択されていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選びなおす", nil];
                [alert show];
            }else{
            [_characterField removeFromSuperview];
            }

            break;
            
        case 8:
            //キャラクター選択画面のキャンセルボタンから飛んできた場合
            app.mySelectCharacter = -1;
            [_characterField removeFromSuperview];
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
    mySelectColor = (int)sender.view.tag;
}

-(int)substituteSelectColorTagAndInitilizeIt{
    int i = mySelectColor;
    mySelectColor = -1;
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
                //エネルギーカードを使用する場合は、手札からエネルギーカードをエネルギー置き場に移したうえでエネルギーをプラスする
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
                if(selectedCardNum == 1){
                    [app.myEnergyCard replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:0] intValue] + 1]];
                    NSLog(@"白エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:0] intValue]);
                }else if (selectedCardNum == 2){
                    [app.myEnergyCard replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:1] intValue] + 1]];
                    NSLog(@"青エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:1] intValue]);
                }else if (selectedCardNum == 3){
                    [app.myEnergyCard replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:2] intValue] + 1]];
                    NSLog(@"黒エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:2] intValue]);
                }else if (selectedCardNum == 4){
                    [app.myEnergyCard replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:3] intValue] + 1]];
                    NSLog(@"赤エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:3] intValue]);
                }else if (selectedCardNum == 5){
                    [app.myEnergyCard replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:4] intValue] + 1]];
                    NSLog(@"緑エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:4] intValue]);
                }
                
                [self moveCards];
                
                _whiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:0] intValue]];
                _blueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:1] intValue]];
                _blackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:2] intValue]];
                _redEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:3] intValue]];
                _greenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:4] intValue]];
                
                NSLog(@"selectCardNum:%d",selectedCardNum);
                NSLog(@"手札の内容：%@",app.myHand);
                NSLog(@"墓地の内容：%@",app.myTomb);
                
                break;
            case 1:
                //キャンセルボタンの場合は何もしない
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


@end
