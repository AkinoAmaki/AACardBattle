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
@synthesize myLifeImageView;
@synthesize myLifeTextView;
@synthesize enemyLifeImageView;
@synthesize enemyLifeTextView;
@synthesize sendMyData;
@synthesize motion;
@synthesize getEnemyData;
@synthesize regionViewArray;
@synthesize searchEnergyCardOrGetACard;
@synthesize detailOfACard;
@synthesize myDrawCount;
@synthesize selectedCardOrder;
@synthesize backGround;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    app = [[UIApplication sharedApplication] delegate];
    
    
    /*****初回起動用の変数*****/
    first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
    turn5Boti = NO;
    turn5Ba = NO;
    /***********************/
    
    turnCount = 0;
    myDrawCount = 0;
    enemyDrawCount = 0;
    selectedCardOrder = -1;
    app.myUsingCardNumber = -1;
    selectCardTag = -1;
    selectCardIsCanceledInCardInRegion = NO;
    syncFinished = NO;
    doIUseCardInThisTurn = NO;
    cardIsCompletlyUsed = NO;
    searchACardInsteadOfGetACardFromLibraryTop = NO;
    
    numberOfUsingWhiteEnergy    = 0;//使用しようとしているカードに費やす白エネルギーの数
    numberOfUsingBlueEnergy     = 0;//使用しようとしているカードに費やす青エネルギーの数
    numberOfUsingBlackEnergy    = 0;//使用しようとしているカードに費やす黒エネルギーの数
    numberOfUsingRedEnergy      = 0;//使用しようとしているカードに費やす赤エネルギーの数
    numberOfUsingGreenEnergy    = 0;//使用しようとしているカードに費やす緑エネルギーの数
    whiteNumberOfText   = [[UITextView alloc] init];//使用しようとしているカードに費やす白エネルギーの数を表示するビュー
    blueNumberOfText    = [[UITextView alloc] init];//使用しようとしているカードに費やす青エネルギーの数を表示するビュー
    blackNumberOfText   = [[UITextView alloc] init];//使用しようとしているカードに費やす黒エネルギーの数を表示するビュー
    redNumberOfText     = [[UITextView alloc] init];//使用しようとしているカードに費やす赤エネルギーの数を表示するビュー
    greenNumberOfText   = [[UITextView alloc] init];//使用しようとしているカードに費やす緑エネルギーの数を表示するビュー
    
    
    
    targetedEnemyFieldCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedLibraryCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedEnemyHandCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedMyHandCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedMyTombCardInThisTurn_get = [[NSMutableArray alloc] init];
    targetedMyLibraryCardInThisTurn_get = [[NSMutableArray alloc] init];
    targetedEnemyFieldCardInThisTurn_return = [[NSMutableArray alloc] init];
    targetedMyTombCardInThisTurn_return = [[NSMutableArray alloc] init];
    targetedEnemyFieldCardInThisTurn_steal = [[NSMutableArray alloc] init];
    targetedMyFieldCardInThisTurn_send = [[NSMutableArray alloc] init];
    
    _bc = [[BattleCaliculate alloc] init];
    getEnemyData = [[GetEnemyDataFromServer alloc] init];
    sendMyData = [[SendDataToServer alloc] init];
    detailOfACard = [[UIImageView alloc] init];
    detailOfACard.userInteractionEnabled = YES;
    [detailOfACard addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeDetailOfACard)]];
    
    
    
    
    
    /*----------------------------------------------*/
    
    _myCardImageViewArray = [[NSMutableArray alloc] init];
    
    _allImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _allImageView.userInteractionEnabled = YES;
    
    _myCardImageView = [[UIImageView alloc] init];
    _myCardImageView.userInteractionEnabled = YES;
    [_allImageView addSubview:_myCardImageView];
    
    
    _enemyCardImageView = [[UIImageView alloc] init];
    _enemyCardImageView.userInteractionEnabled = YES;
    [_allImageView addSubview:_enemyCardImageView];
    
    _border_middleCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_middleCard.png"]];
    _border_character = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_middleCard.png"]];
    
    _backGroundView = [[UIImageView alloc] init];
    _backGroundView.userInteractionEnabled = YES;
    regionViewArray =[[NSMutableArray alloc] init];
    
    
    resultFadeinScrollView = [[UIScrollView alloc] init];
    resultFadeinScrollView.delegate = self;
    resultFadeinScrollView.userInteractionEnabled = YES;
    
    [resultFadeinScrollView addSubview:_backGroundView];
    resultFadeinScrollView.bounces = NO;
    
    _colorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fadeinImage"]];
    
    _colorView.userInteractionEnabled = YES;
    
    
    _okButton = [[UIButton alloc] init];
    [_okButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [_allImageView addSubview:_okButton];
    [_okButton addTarget:self action:@selector(okButtonPushed)
        forControlEvents:UIControlEventTouchUpInside];
    
    myLifeImageView = [[UIImageView alloc] init];
    myLifeImageView.image = [UIImage imageNamed:@"1ha-to.png"];
    myLifeTextView = [[UITextView alloc] init];
    myLifeTextView.text = [NSString stringWithFormat:@"%d",app.myLifeGage];
    myLifeTextView.editable = NO;
    myLifeTextView.textAlignment = NSTextAlignmentCenter;
    myLifeTextView.textColor = [UIColor whiteColor];
    [PenetrateFilter penetrate:myLifeTextView];
    [myLifeImageView addSubview: myLifeTextView];
    [_allImageView addSubview:myLifeImageView];
    
    enemyLifeImageView = [[UIImageView alloc] init];
    enemyLifeImageView.image = [UIImage imageNamed:@"1ha-to.png"];
    enemyLifeTextView = [[UITextView alloc] init];
    enemyLifeTextView.text = [NSString stringWithFormat:@"%d",app.enemyLifeGage];
    enemyLifeTextView.editable = NO;
    enemyLifeTextView.textAlignment = NSTextAlignmentCenter;
    enemyLifeTextView.textColor = [UIColor whiteColor];
    
    [PenetrateFilter penetrate:enemyLifeTextView];
    [enemyLifeImageView addSubview: enemyLifeTextView];
    [_allImageView addSubview:enemyLifeImageView];
    
    _myCharacterView = [[UIImageView alloc] init];
    _enemyCharacterView = [[UIImageView alloc] init];
    [_allImageView addSubview:_myCharacterView];
    [_allImageView addSubview:_enemyCharacterView];
    _myCharacterView.userInteractionEnabled = YES;
    _enemyCharacterView.userInteractionEnabled = YES;
    
    _chara_myGiko       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giko.png"]];
    _chara_myMonar       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monar.png"]];
    _chara_mySyobon           = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"syobon.png"]];
    _chara_myYaruo       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yaruo.png"]];
    _chara_enemyGiko    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giko.png"]];
    _chara_enemyMonar    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monar.png"]];
    _chara_enemySyobon        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"syobon.png"]];
    _chara_enemyYaruo    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yaruo.png"]];
    
    
    _chara_myGiko.userInteractionEnabled         = YES;
    _chara_myMonar.userInteractionEnabled        = YES;
    _chara_mySyobon.userInteractionEnabled       = YES;
    _chara_myYaruo.userInteractionEnabled        = YES;
    _chara_enemyGiko.userInteractionEnabled      = YES;
    _chara_enemyMonar.userInteractionEnabled     = YES;
    _chara_enemySyobon.userInteractionEnabled    = YES;
    _chara_enemyYaruo.userInteractionEnabled     = YES;
    
    
    _chara_myGiko.tag    = GIKO;
    _chara_myMonar.tag   = MONAR;
    _chara_mySyobon.tag  = SYOBON;
    _chara_myYaruo.tag   = YARUO;
    /*
     chara_enemyGiko.tag = ;
     chara_enemyMonar.tag = ;
     chara_enemySYOBON.tag     = ;
     chara_enemyYaruo.tag = ;
     */
    
    [_chara_myGiko addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
    [_chara_myMonar addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
    [_chara_mySyobon addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
    [_chara_myYaruo addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchesBegan:)]];
    
    [_myCharacterView addSubview:_chara_myGiko];
    [_myCharacterView addSubview:_chara_myMonar];
    [_myCharacterView addSubview:_chara_mySyobon];
    [_myCharacterView addSubview:_chara_myYaruo];
    [_enemyCharacterView addSubview:_chara_enemyGiko];
    [_enemyCharacterView addSubview:_chara_enemyMonar];
    [_enemyCharacterView addSubview:_chara_enemySyobon];
    [_enemyCharacterView addSubview:_chara_enemyYaruo];
    
    
    
    //墓地を表示するビューを作成
    _myTomb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tomb"]];
    _myTomb.userInteractionEnabled = YES;
    [_myTomb addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(myTombTouched:)]];
    [_allImageView addSubview:_myTomb];
    
    _enemyTomb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tomb"]];
    _enemyTomb.userInteractionEnabled = YES;
    [_enemyTomb addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(enemyTombTouched:)]];
    [_allImageView addSubview:_enemyTomb];
    
    
    //フィールドカード置き場を表示するビューを作成
    _myField = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"field"]];
    _myField.userInteractionEnabled = YES;
    [_myField addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(myFieldTouched:)]];
    [_allImageView addSubview:_myField];
    
    _enemyField = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"field"]];
    _enemyField.userInteractionEnabled = YES;
    [_enemyField addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(enemyFieldTouched:)]];
    [_allImageView addSubview:_enemyField];
    
    //投了ボタンを表示するビューを作成
    _goodGame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"field"]];
    _goodGame.userInteractionEnabled = YES;
    [_goodGame addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(goodGameButtonTouched)]];
    [_allImageView addSubview:_goodGame];
    
    //エネルギーの数を表示するビューを作成
    //自分側
    _myWhiteEnergyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteEnergyImage"]];
    _myBlueEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueEnergyImage"]];
    _myBlackEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackEnergyImage"]];
    _myRedEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redEnergyImage"]];
    _myGreenEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenEnergyImage"]];
    
    _myAllEnergy = [[UIImageView alloc] init];
    [_myAllEnergy addSubview:_myWhiteEnergyImage];
    [_myAllEnergy addSubview:_myBlueEnergyImage];
    [_myAllEnergy addSubview:_myBlackEnergyImage];
    [_myAllEnergy addSubview:_myRedEnergyImage];
    [_myAllEnergy addSubview:_myGreenEnergyImage];
    
    _myWhiteEnergyText = [[UITextView alloc] init];
    _myBlueEnergyText = [[UITextView alloc] init];
    _myBlackEnergyText = [[UITextView alloc] init];
    _myRedEnergyText = [[UITextView alloc] init];
    _myGreenEnergyText = [[UITextView alloc] init];
    
    _myWhiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:0] intValue]];
    _myBlueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:1] intValue]];
    _myBlackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:2] intValue]];
    _myRedEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:3] intValue]];
    _myGreenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:4] intValue]];
    
    [PenetrateFilter penetrate:_myWhiteEnergyText];
    [PenetrateFilter penetrate:_myBlueEnergyText];
    [PenetrateFilter penetrate:_myBlackEnergyText];
    [PenetrateFilter penetrate:_myRedEnergyText];
    [PenetrateFilter penetrate:_myGreenEnergyText];
    
    [_myAllEnergy addSubview:_myWhiteEnergyText];
    [_myAllEnergy addSubview:_myBlueEnergyText];
    [_myAllEnergy addSubview:_myBlackEnergyText];
    [_myAllEnergy addSubview:_myRedEnergyText];
    [_myAllEnergy addSubview:_myGreenEnergyText];
    
    _myWhiteEnergyText.textColor = [UIColor blueColor];
    _myBlueEnergyText.textColor = [UIColor blueColor];
    _myBlackEnergyText.textColor = [UIColor blueColor];
    _myRedEnergyText.textColor = [UIColor blueColor];
    _myGreenEnergyText.textColor = [UIColor blueColor];
    
    _myUsingWhiteEnergyText = [[UITextView alloc] init];
    _myUsingBlueEnergyText = [[UITextView alloc] init];
    _myUsingBlackEnergyText = [[UITextView alloc] init];
    _myUsingRedEnergyText = [[UITextView alloc] init];
    _myUsingGreenEnergyText = [[UITextView alloc] init];
    
    _myUsingWhiteEnergyText.text    = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:0] intValue]];
    _myUsingBlueEnergyText.text     = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:1] intValue]];
    _myUsingBlackEnergyText.text    = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:2] intValue]];
    _myUsingRedEnergyText.text      = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:3] intValue]];
    _myUsingGreenEnergyText.text    = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:4] intValue]];
    
    [PenetrateFilter penetrate:_myUsingWhiteEnergyText];
    [PenetrateFilter penetrate:_myUsingBlueEnergyText];
    [PenetrateFilter penetrate:_myUsingBlackEnergyText];
    [PenetrateFilter penetrate:_myUsingRedEnergyText];
    [PenetrateFilter penetrate:_myUsingGreenEnergyText];
    
    [_myAllEnergy addSubview:_myUsingWhiteEnergyText];
    [_myAllEnergy addSubview:_myUsingBlueEnergyText];
    [_myAllEnergy addSubview:_myUsingBlackEnergyText];
    [_myAllEnergy addSubview:_myUsingRedEnergyText];
    [_myAllEnergy addSubview:_myUsingGreenEnergyText];
    
    _myUsingWhiteEnergyText.textColor = [UIColor redColor];
    _myUsingBlueEnergyText.textColor  = [UIColor redColor];
    _myUsingBlackEnergyText.textColor = [UIColor redColor];
    _myUsingRedEnergyText.textColor   = [UIColor redColor];
    _myUsingGreenEnergyText.textColor = [UIColor redColor];
    
    [_allImageView addSubview: _myAllEnergy];
    
    //相手側
    _enemyWhiteEnergyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteEnergyImage"]];
    _enemyBlueEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueEnergyImage"]];
    _enemyBlackEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackEnergyImage"]];
    _enemyRedEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redEnergyImage"]];
    _enemyGreenEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenEnergyImage"]];
    
    _enemyAllEnergy = [[UIImageView alloc] init];
    [_enemyAllEnergy addSubview:_enemyWhiteEnergyImage];
    [_enemyAllEnergy addSubview:_enemyBlueEnergyImage];
    [_enemyAllEnergy addSubview:_enemyBlackEnergyImage];
    [_enemyAllEnergy addSubview:_enemyRedEnergyImage];
    [_enemyAllEnergy addSubview:_enemyGreenEnergyImage];
    
    _enemyWhiteEnergyText = [[UITextView alloc] init];
    _enemyBlueEnergyText = [[UITextView alloc] init];
    _enemyBlackEnergyText = [[UITextView alloc] init];
    _enemyRedEnergyText = [[UITextView alloc] init];
    _enemyGreenEnergyText = [[UITextView alloc] init];
    
    _enemyWhiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:0] intValue]];
    _enemyBlueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:1] intValue]];
    _enemyBlackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:2] intValue]];
    _enemyRedEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:3] intValue]];
    _enemyGreenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:4] intValue]];
    
    [_enemyAllEnergy addSubview:_enemyWhiteEnergyText];
    [_enemyAllEnergy addSubview:_enemyBlueEnergyText];
    [_enemyAllEnergy addSubview:_enemyBlackEnergyText];
    [_enemyAllEnergy addSubview:_enemyRedEnergyText];
    [_enemyAllEnergy addSubview:_enemyGreenEnergyText];
    
    [_allImageView addSubview: _enemyAllEnergy];
    
    _myGiko = [[UILabel alloc] init];
    _myMonar = [[UILabel alloc] init];
    _mySyobon = [[UILabel alloc] init];
    _myYaruo = [[UILabel alloc] init];
    _myDamage = [[UILabel alloc] init];
    _enemyGiko = [[UILabel alloc] init];
    _enemyMonar = [[UILabel alloc] init];
    _enemySyobon = [[UILabel alloc] init];
    _enemyYaruo = [[UILabel alloc] init];
    _enemyDamage = [[UILabel alloc] init];
    
    //ターン開始時に発動したカードのビューを初期化
    _turnStartView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fadeinImage" ofType:@"png"]]];
    _turnStartView.userInteractionEnabled = YES;
    
    _damageCaliculateView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fadeinImage" ofType:@"png"]]];
    _damageCaliculateView.userInteractionEnabled = YES;
    
    _turnResultView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fadeinImage" ofType:@"png"]]];
    _turnResultView.userInteractionEnabled = YES;

    
    
    _myNickNameLabel = [[UILabel alloc] init];
    [_allImageView addSubview:_myNickNameLabel];
    _enemyNickNameLabel = [[UILabel alloc] init];
    [_allImageView addSubview:_enemyNickNameLabel];
    
    [self.view addSubview:_allImageView];
    
    //iPhone5ならYES,それ以外ならNOに行く
    if([YSDeviceHelper is568h]){
        detailOfACard.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        detailOfACard.contentMode = UIViewContentModeCenter;
        
        _myCardImageView.frame = CGRectMake(0, _myCardImageView.superview.bounds.size.height - 90, _myCardImageView.superview.bounds.size.width - 60, CARDHEIGHT);
        _enemyCardImageView.frame = CGRectMake(10, 40, _enemyCardImageView.superview.bounds.size.width, CARDHEIGHT);
        
        
        resultFadeinScrollView.frame = CGRectMake(20, 50, 240 , 350);
        
        _colorView.frame = CGRectMake(20, 20, 280 , 440);
        
        _okButton.frame = CGRectMake(_okButton.superview.bounds.size.width - 60, _okButton.superview.bounds.size.height - 300, 50, 50);
        
        myLifeImageView.frame = CGRectMake(myLifeImageView.superview.bounds.size.width - 60, myLifeImageView.superview.bounds.size.height - 60, 50, 50);
        myLifeTextView.frame = CGRectMake(0, 10, myLifeTextView.superview.bounds.size.width, myLifeTextView.superview.bounds.size.height - 10);
        enemyLifeImageView.frame = CGRectMake(10, 10, 50, 50);
        enemyLifeTextView.frame = CGRectMake(0, 10, enemyLifeTextView.superview.bounds.size.width, enemyLifeTextView.superview.bounds.size.height - 10);
        
        _myCharacterView.frame = CGRectMake(20, _myCharacterView.superview.bounds.size.height - 150, 200, 50);
        _enemyCharacterView.frame = CGRectMake(100, 100, 200, 50);
        
        _chara_myGiko.frame          = CGRectMake(  0, 0, 50, 50);
        _chara_myMonar.frame         = CGRectMake( 50, 0, 50, 50);
        _chara_mySyobon.frame        = CGRectMake(100, 0, 50, 50);
        _chara_myYaruo.frame         = CGRectMake(150, 0, 50, 50);
        _chara_enemyGiko.frame       = CGRectMake(  0, 0, 50, 50);
        _chara_enemyMonar.frame      = CGRectMake( 50, 0, 50, 50);
        _chara_enemySyobon.frame     = CGRectMake(100, 0, 50, 50);
        _chara_enemyYaruo.frame      = CGRectMake(150, 0, 50, 50);
        
        _myTomb.frame = CGRectMake(_myTomb.superview.bounds.size.width - 60, _myTomb.superview.bounds.size.height - 180, 50, 50);
        _enemyTomb.frame = CGRectMake(10, 130, 50, 50);
        
        _myField.frame = CGRectMake(_myField.superview.bounds.size.width - 60, _myField.superview.bounds.size.height - 240, 50, 50);
        _enemyField.frame = CGRectMake(10, 190, 50, 50);
        
        _goodGame.frame = CGRectMake(10, 250, 50, 50);
        
        _myWhiteEnergyImage.frame = CGRectMake(  0,  10, 20, 20);
        _myBlueEnergyImage.frame  = CGRectMake( 50,  10, 20, 20);
        _myBlackEnergyImage.frame = CGRectMake(100,  10, 20, 20);
        _myRedEnergyImage.frame   = CGRectMake(150,  10, 20, 20);
        _myGreenEnergyImage.frame = CGRectMake(200,  10, 20, 20);
        
        _myWhiteEnergyText.frame = CGRectMake( 20, 15, 30, 20);
        _myBlueEnergyText.frame  = CGRectMake( 70, 15, 30, 20);
        _myBlackEnergyText.frame = CGRectMake(120, 15, 30, 20);
        _myRedEnergyText.frame   = CGRectMake(170, 15, 30, 20);
        _myGreenEnergyText.frame = CGRectMake(220, 15, 30, 20);
        
        _myUsingWhiteEnergyText.frame   = CGRectMake(  20, 0, 30, 20);
        _myUsingBlueEnergyText.frame    = CGRectMake(  70, 0, 30, 20);
        _myUsingBlackEnergyText.frame   = CGRectMake( 120, 0, 30, 20);
        _myUsingRedEnergyText.frame     = CGRectMake( 170, 0, 30, 20);
        _myUsingGreenEnergyText.frame   = CGRectMake( 220, 0, 30, 20);
        
        _myAllEnergy.frame = CGRectMake(10, _myAllEnergy.superview.bounds.size.height - 40, 250, 40);
        
        _enemyWhiteEnergyImage.frame = CGRectMake(  0,  0, 20, 20);
        _enemyBlueEnergyImage.frame  = CGRectMake( 50,  0, 20, 20);
        _enemyBlackEnergyImage.frame = CGRectMake(100,  0, 20, 20);
        _enemyRedEnergyImage.frame   = CGRectMake(150,  0, 20, 20);
        _enemyGreenEnergyImage.frame = CGRectMake(200,  0, 20, 20);
        
        _enemyWhiteEnergyText.frame = CGRectMake( 20, 0, 30, 20);
        _enemyBlueEnergyText.frame  = CGRectMake( 70, 0, 30, 20);
        _enemyBlackEnergyText.frame = CGRectMake(120, 0, 30, 20);
        _enemyRedEnergyText.frame   = CGRectMake(170, 0, 30, 20);
        _enemyGreenEnergyText.frame = CGRectMake(220, 0, 30, 20);
        
        _enemyAllEnergy.frame = CGRectMake(_enemyAllEnergy.superview.bounds.size.width - 250, 10, 250, 20);
    }else{
        detailOfACard.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        detailOfACard.contentMode = UIViewContentModeCenter;
        
        _myCardImageView.frame = CGRectMake(0, _myCardImageView.superview.bounds.size.height - 90, _myCardImageView.superview.bounds.size.width - 60, CARDHEIGHT);
        _enemyCardImageView.frame = CGRectMake(10, _enemyCardImageView.superview.bounds.size.height - 440, _enemyCardImageView.superview.bounds.size.width, CARDHEIGHT);
        
        resultFadeinScrollView.frame = CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 430, 240 , 350);
        
        _colorView.frame = CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 460, 280 , 440);
        
        _okButton.frame = CGRectMake(_okButton.superview.bounds.size.width - 60, _okButton.superview.bounds.size.height - 300, 50, 50);
        
        myLifeImageView.frame = CGRectMake(myLifeImageView.superview.bounds.size.width - 60, myLifeImageView.superview.bounds.size.height - 60, 50, 50);
        myLifeTextView.frame = CGRectMake(0, 10, myLifeTextView.superview.bounds.size.width, myLifeTextView.superview.bounds.size.height - 10);
        enemyLifeImageView.frame = CGRectMake(10, 10, 50, 50);
        enemyLifeTextView.frame = CGRectMake(0, 10, enemyLifeTextView.superview.bounds.size.width, enemyLifeTextView.superview.bounds.size.height - 10);
        
        _myCharacterView.frame = CGRectMake(20, _myCharacterView.superview.bounds.size.height - 150, 200, 50);
        _enemyCharacterView.frame = CGRectMake(100, _enemyCharacterView.superview.bounds.size.height - 380, 200, 50);
        
        _chara_myGiko.frame          = CGRectMake(  0, 0, 50, 50);
        _chara_myMonar.frame         = CGRectMake( 50, 0, 50, 50);
        _chara_mySyobon.frame        = CGRectMake(100, 0, 50, 50);
        _chara_myYaruo.frame         = CGRectMake(150, 0, 50, 50);
        _chara_enemyGiko.frame       = CGRectMake(  0, 0, 50, 50);
        _chara_enemyMonar.frame      = CGRectMake( 50, 0, 50, 50);
        _chara_enemySyobon.frame     = CGRectMake(100, 0, 50, 50);
        _chara_enemyYaruo.frame      = CGRectMake(150, 0, 50, 50);
        
        _myTomb.frame = CGRectMake(_myTomb.superview.bounds.size.width - 60, _myTomb.superview.bounds.size.height - 180, 50, 50);
        _enemyTomb.frame = CGRectMake(10, 130, 50, 50);
        
        _myField.frame = CGRectMake(_myField.superview.bounds.size.width - 60, _myField.superview.bounds.size.height - 240, 50, 50);
        _enemyField.frame = CGRectMake(10, 190, 50, 50);
        
        _goodGame.frame = CGRectMake(10, 250, 50, 50);
        
        _myWhiteEnergyImage.frame = CGRectMake(  0,  10, 20, 20);
        _myBlueEnergyImage.frame  = CGRectMake( 50,  10, 20, 20);
        _myBlackEnergyImage.frame = CGRectMake(100,  10, 20, 20);
        _myRedEnergyImage.frame   = CGRectMake(150,  10, 20, 20);
        _myGreenEnergyImage.frame = CGRectMake(200,  10, 20, 20);
        
        _myWhiteEnergyText.frame = CGRectMake( 20, 15, 30, 20);
        _myBlueEnergyText.frame  = CGRectMake( 70, 15, 30, 20);
        _myBlackEnergyText.frame = CGRectMake(120, 15, 30, 20);
        _myRedEnergyText.frame   = CGRectMake(170, 15, 30, 20);
        _myGreenEnergyText.frame = CGRectMake(220, 15, 30, 20);
        
        _myUsingWhiteEnergyText.frame   = CGRectMake(  20, 0, 30, 20);
        _myUsingBlueEnergyText.frame    = CGRectMake(  70, 0, 30, 20);
        _myUsingBlackEnergyText.frame   = CGRectMake( 120, 0, 30, 20);
        _myUsingRedEnergyText.frame     = CGRectMake( 170, 0, 30, 20);
        _myUsingGreenEnergyText.frame   = CGRectMake( 220, 0, 30, 20);
        
        _myAllEnergy.frame = CGRectMake(10, _myAllEnergy.superview.bounds.size.height - 40, 250, 40);
        
        _enemyWhiteEnergyImage.frame = CGRectMake(  0,  0, 20, 20);
        _enemyBlueEnergyImage.frame  = CGRectMake( 50,  0, 20, 20);
        _enemyBlackEnergyImage.frame = CGRectMake(100,  0, 20, 20);
        _enemyRedEnergyImage.frame   = CGRectMake(150,  0, 20, 20);
        _enemyGreenEnergyImage.frame = CGRectMake(200,  0, 20, 20);
        
        _enemyWhiteEnergyText.frame = CGRectMake( 20, 0, 30, 20);
        _enemyBlueEnergyText.frame  = CGRectMake( 70, 0, 30, 20);
        _enemyBlackEnergyText.frame = CGRectMake(120, 0, 30, 20);
        _enemyRedEnergyText.frame   = CGRectMake(170, 0, 30, 20);
        _enemyGreenEnergyText.frame = CGRectMake(220, 0, 30, 20);
        
        _enemyAllEnergy.frame = CGRectMake(_enemyAllEnergy.superview.bounds.size.width - 250, _enemyAllEnergy.superview.bounds.size.height - 470, 250, 20);
    }
    
    //アプリがアクティブ・非アクティブになった際の挙動を規定する
    //アクティブになったとき
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(activate)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    //非アクティブになったとき
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deactivate)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    //当初はボタンのタッチを禁止する
    [self forbidTouchAction];
    
    
    _blackBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _blackBack.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackBack" ofType:@"png"]];
    _blackBack.alpha = 0.6f;
    [_allImageView addSubview:_blackBack];
    
    //メインビューに戻るボタンを実装
    _returnToMainViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_returnToMainViewButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_allImageView addSubview:_returnToMainViewButton];
    _returnToMainViewButton.frame = CGRectMake(10,65, 50, 50);
    [_returnToMainViewButton addTarget:self action:@selector(returnToMainView)
                      forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%d",app.battleStart);
    if(!app.battleStart){
        //ローカル対戦開始のボタンを実装
        _localBattleButton = [[AAButton alloc] initWithImageAndText:@"triggering-50" imagePath:@"png" textString:@"隣の人と対戦" tag:1 CGRect:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 125 , 160, 250, 40)];
        [_localBattleButton addTarget:self action:@selector(battleStartForLocalBattle)
                     forControlEvents:UIControlEventTouchUpInside];
        [_allImageView addSubview:_localBattleButton];
    }
    
    //インターネット対戦開始のボタンを実装
    _internetBattleButton = [[AAButton alloc] initWithImageAndText:@"triggering-50" imagePath:@"png" textString:@"インターネット対戦" tag:1 CGRect:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 125 , 240, 250, 40)];
    [_internetBattleButton addTarget:self action:@selector(startInternetBattle:)
                 forControlEvents:UIControlEventTouchUpInside];
    [_allImageView addSubview:_internetBattleButton];
    
    
    
    //初回起動判定。初回起動であれば、プロローグを開始する。
    if (first == 0) {
        [self startAnimation013];
    }
    
    //--------------------------デバッグ用ボタン-----------------------------------
    
//    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    startButton.frame = CGRectMake(160, 240, 80, 20);
//    [startButton setTitle:@"開始" forState:UIControlStateNormal];
//    [_allImageView addSubview:startButton];
//    [startButton addTarget:self action:@selector(battleStartForLocalBattle)
//          forControlEvents:UIControlEventTouchUpInside];
//    
    UIButton *debug1Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    debug1Button.frame = CGRectMake(160, 300, 80, 20);
    [debug1Button setTitle:@"デバッグ1" forState:UIControlStateNormal];
    [_allImageView addSubview:debug1Button];
    [debug1Button addTarget:self action:@selector(debug1:)
           forControlEvents:UIControlEventTouchUpInside];

    UIButton *debug2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    debug2Button.frame = CGRectMake(160, 360, 80, 20);
    [debug2Button setTitle:@"デバッグ2" forState:UIControlStateNormal];
    [_allImageView addSubview:debug2Button];
    [debug2Button addTarget:self action:@selector(debug2:)
           forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton *debug3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    debug3Button.frame = CGRectMake(160, 420, 80, 20);
//    [debug3Button setTitle:@"デバッグ3" forState:UIControlStateNormal];
//    [_allImageView addSubview:debug3Button];
//    [debug3Button addTarget:self action:@selector(debug3:)
//           forControlEvents:UIControlEventTouchUpInside];
    
    
    //--------------------------デバッグ用ボタンここまで-----------------------------
}

- (void)viewDidAppear:(BOOL)animated{
    //app.battleStartがYESになったときに対戦開始する。app.battleStartは、DeviceMotionにおいてインターネット対戦の対戦相手が決まった際にYESとなる。
    if(app.battleStart){
        NSLog(@"対戦開始");
        [self battleStartForInternetBattle];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [app.arrow removeFromSuperview];
}

//--------------------------デバッグ用ボタン実装ここから-----------------------------

-(void)getACardForDebug{
    [self getACard:MYSELF];
}

- (void)debug1 :(UITapGestureRecognizer *)sender{
    app.mySelectCharacter = GIKO;
    app.enemySelectCharacter = GIKO;
    [self jankenHantei];
}

- (void)debug2 :(UITapGestureRecognizer *)sender{
    app.myLifeGage = 0;
    [self isGameOver];
}


- (void)startInternetBattle :(UITapGestureRecognizer *)sender{
    //BGM鳴らす
    AudioServicesPlaySystemSound (app.tapSoundID);
    
    //デッキを選択させる
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _usingDeckCardListForInternetBattle = [[UIAlertView alloc] initWithTitle:@"デッキ選択" message:@"使用するデッキを選んでください" delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@", [ud stringForKey:@"deckName1"]], [NSString stringWithFormat:@"%@", [ud stringForKey:@"deckName2"]], [NSString stringWithFormat:@"%@", [ud stringForKey:@"deckName3"]], nil];
    [_usingDeckCardListForInternetBattle show];
    
    [self sync];
    course = [[CourseSelectViewController alloc] init];
    
    // 通知センターにオブザーバ（通知を受け取るオブジェクト）を追加
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(battleStartForInternetBattle) name:@"BattleStartPost" object:nil];
    
    [self presentViewController:course animated:YES completion:nil];
}

//--------------------------デバッグ用ボタン実装ここまで-----------------------------


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchesBegan: (UITapGestureRecognizer *)sender{
    AudioServicesPlaySystemSound (app.tapSoundID);
    
    
    switch (sender.view.tag) {
        case 1:
            if(app.myGikoAttackPermittedByMyself == NO){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"ギコの選択は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }else{
                [_border_character removeFromSuperview];
                [_myCharacterView addSubview: _border_character];
                _border_character.frame = sender.view.frame;
                app.mySelectCharacter = GIKO;
                NSLog(@"選択キャラ：ギコ");
                if (first == 0) {
                    [app.arrowR removeFromSuperview];
                    app.arrow.frame = CGRectMake(_okButton.frame.origin.x - app.arrow.frame.size.width, _okButton.frame.origin.y + 10, app.arrow.image.size.width, app.arrow.image.size.height);
                    [self.view addSubview:app.arrow];
                }
                
            }
            break;
        case 2:
            if(app.myMonarAttackPermittedByMyself == NO){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"モナーの選択は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }else{
                [_border_character removeFromSuperview];
                [_myCharacterView addSubview: _border_character];
                _border_character.frame = sender.view.frame;
                app.mySelectCharacter = MONAR;
                NSLog(@"選択キャラ：モナー");
            }
            break;
        case 3:
            if(app.mySyobonAttackPermittedByMyself == NO){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"ショボンの選択は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }else{
                [_border_character removeFromSuperview];
                [_myCharacterView addSubview: _border_character];
                _border_character.frame = sender.view.frame;
                app.mySelectCharacter = SYOBON;
                NSLog(@"選択キャラ：ショボン");
            }
            break;
        case 4:
            if(app.myYaruoAttackPermittedByMyself == NO){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"やる夫の選択は封じられています" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }else{
                [_border_character removeFromSuperview];
                [_myCharacterView addSubview: _border_character];
                _border_character.frame = sender.view.frame;
                app.mySelectCharacter = YARUO;
                NSLog(@"選択キャラ：やる夫");
            }
            break;
        default:
            break;
    }
}



#pragma mark- ターン処理
- (IBAction)nextTurn{
    
    
    //ターン開始時
    NSLog(@"ターン開始フェイズ");
    //手札・キャラクター・ネクストボタン・フィールドカードボタン・墓地カードボタンのタッチを禁止する
    [self forbidTouchAction];
    [self activateCardInTiming:0];
    

    //初回起動（プロローグ）でない場合
    if(first != 0){
        while (!app.decideAction) {
            [getEnemyData doEnemyDecideActionRoopVersion:YES];
        }
        //!!! :相手のdecideActionを受け取ってから自分のdecideActionをNOにするまでの時間を短くした。片方の端末ではフェーズが進み、もう片方の端末では進まない場合、スリープ時間が短すぎる可能性があるため、1秒程度まで伸ばせば良い。(ターンのレスポンスは悪化するが。)
        [NSThread sleepForTimeInterval:0.5];
        [getEnemyData doEnemyDecideActionRoopVersion:NO];
        [self activateCardInTiming:99];
        //1ターン目はターン開始フェイズを飛ばす
        turnCount++;
        if(turnCount != 1){
            [self phaseNameFadeIn:[NSString stringWithFormat:@"%dターン目　ターン開始フェイズ", turnCount]];
            [self sync];
        }
        if(!searchACardInsteadOfGetACardFromLibraryTop){
            //１ターン目はカードを手札に入れない
            if(turnCount != 1){
                [self getACard:MYSELF];
            }
        }
        for (int i = 0; i < app.myAdditionalGettingCards; i++) {
            [self getACard:MYSELF];
        }
        [sendMyData send];
        [self refleshView];
        app.myAdditionalGettingCards = 0;
        if (turnCount != 1) {
            [self turnStartFadeIn:_turnStartView animaImage:[UIImage imageNamed:@"fadeinImage"]];
            [self sync];
            if([self isGameOver]){
                return;
            }
        }
        
        
        
        //カード使用後
        NSLog(@"カード使用・AA選択フェーズ");
        NSLog(@"でっきのなかみ：%@",app.myDeckCardList);
        [self phaseNameFadeIn:@"カード使用・AAで選択フェイズです。\n使用するカード及びAAを選択してください。"];
        [self sync];
        //手札・キャラクター・ネクストボタン・フィールドカードボタン・墓地カードボタンのタッチを許可する
        [self permitTouchAction];
        
        //touchActionの入力を待つための同期処理
        while (cardIsCompletlyUsed == NO) {
            [self sync];
        }
        [self activateCardInTiming:1];
        
        //手札・キャラクター・ネクストボタン・フィールドカードボタン・墓地カードボタンのタッチを禁止する
        [self forbidTouchAction];
        
        //相手の入力待ち(app.decideAction = YESとなれば先に進む)
        while (!app.decideAction) {
            [getEnemyData doEnemyDecideActionRoopVersion:YES];
        }
        [getEnemyData doEnemyDecideActionRoopVersion:NO];
        [sendMyData send];
        [SVProgressHUD dismiss];
        [self activateCardInTiming:99];
        [self refleshView];
        [self cardUsingAnimation:app.cardsIUsedInThisTurn man:MYSELF];
        [self sync];
        [self cardUsingAnimation:app.cardsEnemyUsedInThisTurn man:ENEMY];
        [self sync];
        //ダメージ計算
        NSLog(@"ダメージ計算フェーズ");
        [self phaseNameFadeIn:@"ダメージ計算フェイズ"];
        [self sync];
        
        NSLog(@"-----------------------------------");
        NSLog(@"%s",__func__);
        [self activateCardInTiming:2];
        while (!app.decideAction) {
            [getEnemyData doEnemyDecideActionRoopVersion:YES];
        }
        //!!! :相手のdecideActionを受け取ってから自分のdecideActionをNOにするまでの時間を短くした。片方の端末ではフェーズが進み、もう片方の端末では進まない場合、スリープ時間が短すぎる可能性があるため、1秒程度まで伸ばせば良い。
        [NSThread sleepForTimeInterval:0.5];
        [getEnemyData doEnemyDecideActionRoopVersion:NO];
        [sendMyData send];
        [self activateCardInTiming:99];
        //カード効果でカードを引いたら処理する
        for (int i = 0; i < app.myAdditionalGettingCards; i++) {
            [self getACard:MYSELF];
        }
        app.myAdditionalGettingCards = 0;
        //カード効果でカードを捨てたら処理する
        for (int i = 0; i < app.myAdditionalDiscardingCards; i++) {
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) longtapSelector:@selector(detailOfACard:) string:@"捨てるカードを一枚選んでください"];
            [self sync];
        }
        app.enemyDamageFromAA = [_bc damageCaliculate];
        while (!app.decideAction) {
            [getEnemyData doEnemyDecideActionRoopVersion:YES];
        }
        //!!! :相手のdecideActionを受け取ってから自分のdecideActionをNOにするまでの時間を短くした。片方の端末ではフェーズが進み、もう片方の端末では進まない場合、スリープ時間が短すぎる可能性があるため、1秒程度まで伸ばせば良い。
        [NSThread sleepForTimeInterval:0.5];
        [getEnemyData doEnemyDecideActionRoopVersion:NO];
        [sendMyData send];
        NSLog(@"app.enemyLifeGage:%d",app.enemyLifeGage);
        [self refleshView];
        [self damageCaliculateFadeIn:_damageCaliculateView animaImage:[UIImage imageNamed:@"fadeinImage"]];
        [self sync];
        if([self isGameOver]){
            return;
//            [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        //ターン終了時
        NSLog(@"ターン終了フェイズ");
        [self phaseNameFadeIn:@"ターン終了フェイズ"];
        [self sync];
        [self activateCardInTiming:3];
        [self activateCardInTiming:99];
        while (!app.decideAction) {
            [getEnemyData doEnemyDecideActionRoopVersion:YES];
        }
        //!!! :相手のdecideActionを受け取ってから自分のdecideActionをNOにするまでの時間を短くした。片方の端末ではフェーズが進み、もう片方の端末では進まない場合、スリープ時間が短すぎる可能性があるため、1秒程度まで伸ばせば良い。
        [NSThread sleepForTimeInterval:0.5];
        [getEnemyData doEnemyDecideActionRoopVersion:NO];
        [sendMyData send];
        [self refleshView];
        [self resultFadeIn:_turnResultView animaImage:[UIImage imageNamed:@"fadeinImage"]];
        [self sync];
        if([self isGameOver]){
            return;
//            [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        
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
        NSLog(@"自分のやる夫の基本防御力　：%d　＋　自分のやる夫の修正防御力　：%d",app.myYaruoFundamentalDeffencePower,app.myYaruoModifyingDeffencePower);
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
        
        while([app.myHand count] > 5){
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandInTurnEndPhaseSelector:) longtapSelector:@selector(detailOfACard:) string:@"手札の所持枚数が5枚を超えました。\n捨てるカードを一枚選んでください"];
            [self sync];
        }
        [self initializeVariables];
        [self nextTurn];
        
        
        NSLog(@"-----------------------------------");
    }else{
     //初回起動（プロローグ）の場合
        //1ターン目はターン開始フェイズを飛ばす
        turnCount++;
        if(turnCount != 1){
            [self phaseNameFadeIn:[NSString stringWithFormat:@"%dターン目　ターン開始フェイズ", turnCount]];
            [self sync];
        }
        if(!searchACardInsteadOfGetACardFromLibraryTop){
            //１ターン目はカードを手札に入れない
            if(turnCount != 1){
                [self getACard:MYSELF];
            }
        }
        for (int i = 0; i < app.myAdditionalGettingCards; i++) {
            [self getACard:MYSELF];
        }
        [sendMyData send];
        [self refleshView];
        app.myAdditionalGettingCards = 0;
        if (turnCount != 1) {
            [self turnStartFadeIn:_turnStartView animaImage:[UIImage imageNamed:@"fadeinImage"]];
            [self sync];
            if([self isGameOver]){
                return;
            }
        }
        
        
        //カード使用後
        NSLog(@"カード使用・AA選択フェーズ");
        NSLog(@"でっきのなかみ：%@",app.myDeckCardList);
        [self phaseNameFadeIn:@"カード使用・AAで選択フェイズです。\n使用するカード及びAAを選択してください。"];
        [self sync];
        //手札・キャラクター・ネクストボタン・フィールドカードボタン・墓地カードボタンのタッチを許可する
        [self permitTouchAction];
        
        //ターン毎に説明を入れる
        switch (turnCount) {
            case 1:
                [self startAnimation031];
                break;
            case 2:
                [self startAnimation037];
                break;
            case 3:
                [self startAnimation045];
                break;
            case 4:
                [self startAnimation051_2];
                break;
            case 5:
                [self startAnimation056];
                break;
            case 6:
                [self startAnimation066];
                break;
            default:
                break;
        }
        //touchActionの入力を待つための同期処理
        while (cardIsCompletlyUsed == NO) {
            [self sync];
        }
        [self activateCardInTiming:1];
        
        //手札・キャラクター・ネクストボタン・フィールドカードボタン・墓地カードボタンのタッチを禁止する
        [self forbidTouchAction];

        [sendMyData send];
        [SVProgressHUD dismiss];
        [self activateCardInTiming:99];
        [self refleshView];
        [self cardUsingAnimation:app.cardsIUsedInThisTurn man:MYSELF];
        [self sync];
        [self cardUsingAnimation:app.cardsEnemyUsedInThisTurn man:ENEMY];
        [self sync];
        //ダメージ計算
        NSLog(@"ダメージ計算フェーズ");
        [self phaseNameFadeIn:@"ダメージ計算フェイズ"];
        [self sync];

        
        NSLog(@"-----------------------------------");
        NSLog(@"%s",__func__);
        [self activateCardInTiming:2];

        [sendMyData send];
        [self activateCardInTiming:99];
        //カード効果でカードを引いたら処理する
        for (int i = 0; i < app.myAdditionalGettingCards; i++) {
            [self getACard:MYSELF];
        }
        app.myAdditionalGettingCards = 0;
        //カード効果でカードを捨てたら処理する
        for (int i = 0; i < app.myAdditionalDiscardingCards; i++) {
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) longtapSelector:@selector(detailOfACard:) string:@"捨てるカードを一枚選んでください"];
            [self sync];
        }
        app.enemyDamageFromAA = [_bc damageCaliculate];
        [sendMyData send];
        NSLog(@"app.enemyLifeGage:%d",app.enemyLifeGage);
        [self refleshView];
        [self damageCaliculateFadeIn:_damageCaliculateView animaImage:[UIImage imageNamed:@"fadeinImage"]];
        switch (turnCount) {
            case 1:
                [self startAnimation033_2];
                break;
            case 2:
                [self startAnimation041];
                break;
            case 3:
                [self startAnimation048];
                break;
            case 4:
                break;
            case 5:
                [self startAnimation063];
                break;
            default:
                break;
        }
        
        [self sync];
        if([self isGameOver]){
            return;
//            [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        //ターン終了時
        NSLog(@"ターン終了フェイズ");
        [self phaseNameFadeIn:@"ターン終了フェイズ"];
        [self sync];
        [self activateCardInTiming:3];
        [self activateCardInTiming:99];

        [sendMyData send];
        [self refleshView];
        [self resultFadeIn:_turnResultView animaImage:[UIImage imageNamed:@"fadeinImage"]];
        switch (turnCount) {
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                [self startAnimation053];
                break;
            default:
                break;
        }
        [self sync];
        if([self isGameOver]){
            return;
//            [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        
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
        NSLog(@"自分のやる夫の基本防御力　：%d　＋　自分のやる夫の修正防御力　：%d",app.myYaruoFundamentalDeffencePower,app.myYaruoModifyingDeffencePower);
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
        
        while([app.myHand count] > 5){
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandInTurnEndPhaseSelector:) longtapSelector:@selector(detailOfACard:) string:@"手札の所持枚数が5枚を超えました。\n捨てるカードを一枚選んでください"];
            [self sync];
        }
        [self initializeVariables];
        [self nextTurn];
        
        
        NSLog(@"-----------------------------------");
    }
}
#pragma mark- カード効果実装

-(void)cardActivate :(int)cardnumber string:(NSString *)str{
    switch (cardnumber) {
        case 6:
            //対象キャラの防御力１ターンだけ＋２（W)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            
            break;
        case 7:
            //毎ターンの対象のキャラの防御力を＋２する（W2)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            break;
        case 8:
            //自分のライフ＋２（W)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:2];
            break;
        case 9:
            //自分のライフ＋２、カードを一枚引く（W２）
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:2];
            app.myAdditionalGettingCards++;
            break;
        case 10:
            //毎ターンライフを＋１する（W２)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
            break;
        case 11:
            //このターン相手プレイヤーが使用した白色のカードの枚数だけ、ターン終了時にライフを＋１する（W1)
            for (int i = 0; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
                if ([self distinguishCardColor:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]  == WHITE) {
                    app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                }
            }
            break;
        case 12:
            //このターン相手プレイヤーが使用した青色のカードの枚数だけ、ターン終了時にライフを＋１する（W1)
            for (int i = 0; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
                if ([self distinguishCardColor:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]  == BLUE) {
                    app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                }
            }
            break;
        case 13:
            //このターン相手プレイヤーが使用した黒色のカードの枚数だけ、ターン終了時にライフを＋１する（W1)
            for (int i = 0; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
                if ([self distinguishCardColor:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]  == BLACK) {
                    app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                }
            }
            break;
        case 14:
            //このターン相手プレイヤーが使用した赤色のカードの枚数だけ、ターン終了時にライフを＋１する（W1)
            for (int i = 0; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
                if ([self distinguishCardColor:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]  == RED) {
                    app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                }
            }
            break;
        case 15:
            //このターン相手プレイヤーが使用した緑色のカードの枚数だけ、ターン終了時にライフを＋１する（W1)
            for (int i = 0; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
                if ([self distinguishCardColor:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]  == GREEN) {
                    app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                }
            }
            break;
        case 16:
            //白色のカードからのダメージを１減らす（W1)
            for (int i = 0; i < [app.damageSourceOfWhite count]; i++) {
                for (int j = 0; j < [app.cardsEnemyUsedInThisTurn count]; j++) {
                    if([[app.damageSourceOfWhite objectAtIndex:i] intValue] == [[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]  && [[app.cardList_type objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]] intValue] == SORCERYCARD){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfWhite count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfWhite objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            break;
        case 17:
            //青色のカードからのダメージを１減らす（W1)
            for (int i = 0; i < [app.damageSourceOfBlue count]; i++) {
                for (int j = 0; j < [app.cardsEnemyUsedInThisTurn count]; j++) {
                    if([[app.damageSourceOfBlue objectAtIndex:i] intValue] == [[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]  && [[app.cardList_type objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]] intValue] == SORCERYCARD){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfBlue count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfBlue objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            break;
        case 18:
            //黒色のカードからのダメージを１減らす（W1)
            for (int i = 0; i < [app.damageSourceOfBlack count]; i++) {
                for (int j = 0; j < [app.cardsEnemyUsedInThisTurn count]; j++) {
                    if([[app.damageSourceOfBlack objectAtIndex:i] intValue] == [[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]  && [[app.cardList_type objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]] intValue] == SORCERYCARD){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfBlack count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfBlack objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            break;
        case 19:
            //赤色のカードからのダメージを１減らす（W1)
            for (int i = 0; i < [app.damageSourceOfRed count]; i++) {
                for (int j = 0; j < [app.cardsEnemyUsedInThisTurn count]; j++) {
                    if([[app.damageSourceOfRed objectAtIndex:i] intValue] == [[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]  && [[app.cardList_type objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]] intValue] == SORCERYCARD){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfRed count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfRed objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            break;
        case 20:
            //緑色のカードからのダメージを１減らす（W1)
            for (int i = 0; i < [app.damageSourceOfGreen count]; i++) {
                for (int j = 0; j < [app.cardsEnemyUsedInThisTurn count]; j++) {
                    if([[app.damageSourceOfGreen objectAtIndex:i] intValue] == [[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]  && [[app.cardList_type objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:j] intValue]] intValue] == SORCERYCARD){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfGreen count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfGreen objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                    }
                }
            }
            break;
        case 21:
            //このターン、相手のギコに攻撃させない（W）
            app.enemyGikoAttackPermittedByMyself = NO;
            break;
        case 22:
            //このターン、相手のモナーに攻撃させない（W）
            app.enemyMonarAttackPermittedByMyself = NO;
            break;
        case 23:
            //このターン、相手のショボンに攻撃させない（W）
            app.enemySyobonAttackPermittedByMyself = NO;
            break;
        case 24:
            //このターン、相手に防御させない（W２)
            app.enemyGikoDeffencePermittedByMyself = NO;
            app.enemyMonarDeffencePermittedByMyself = NO;
            app.enemySyobonDeffencePermittedByMyself = NO;
            app.enemyYaruoDeffencePermittedByMyself = NO;
            break;
        case 25:
            //このカードが出ている限り、相手に防御させない（WW３)
            app.enemyGikoDeffencePermittedByMyself = NO;
            app.enemyMonarDeffencePermittedByMyself = NO;
            app.enemySyobonDeffencePermittedByMyself = NO;
            app.enemyYaruoDeffencePermittedByMyself = NO;
            break;
        case 26:
            //手札のカード枚数×２のライフ回復（WW2)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:(int)[app.myHand count] * 2];
            break;
        case 27:
            //自分に４点以上のダメージが与えられる場合、ダメージが３点になるまで回復する（W5)
            app.myDamageFromAA = [self decreaseDamage:app.myDamageFromAA borderOfDamage:3 damageAfterDecreasing:1];
            app.myDamageFromCard =  [self decreaseDamage:app.myDamageFromCard borderOfDamage:3 damageAfterDecreasing:1];
            break;
        case 28:
            //互いに全てのエネルギーカードを破壊する（W4)
            app.myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil];
            for (int i = 0; i < [app.enemyEnergyCard count]; i++) {
                [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:i withObject:[app.enemyEnergyCard objectAtIndex:i]];
            }
            
            break;
        case 29:
            //このターン、全AAの攻撃を禁止する
            app.myGikoAttackPermittedByMyself = NO;
            app.myMonarAttackPermittedByMyself = NO;
            app.mySyobonAttackPermittedByMyself = NO;
            app.myYaruoAttackPermittedByMyself = NO;
            app.enemyGikoAttackPermittedByMyself = NO;
            app.enemyMonarAttackPermittedByMyself = NO;
            app.enemySyobonAttackPermittedByMyself = NO;
            app.enemyYaruoAttackPermittedByMyself = NO;
            //内部的にはとりあえずギコを選んでおき、次フェイズに進めるようにする
            app.mySelectCharacter = GIKO;
            break;
        case 30:
            //対象の場カードを破壊する
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            break;
        case 31:
            //やる夫の攻撃力を１ターンだけ＋5する（W2)
            [self myAttackPowerOperate:YARUO point:5 temporary:1];
            break;
        case 32:
            //相手のライブラリーを上から１枚削る（W)
            [self discardFromLibrary:0];
            break;
        case 33:
            //相手のライブラリーを上から２枚削る（W１）
            [self discardFromLibrary:1];
            [self discardFromLibrary:0];
            break;
        case 34:
            //相手のライブラリーを上から半分削る（WW5)
        {
            int k = (int)([app.enemyDeckCardList count] - [app.enemyDeckCardListByMyself_minus count]);
            for (int i = k ; i > (k / 2); i--) {
                [self discardFromLibrary:i - 1];
            }
        }
            break;
        case 35:
            //エネルギーカードの種類数×2だけライフを回復する（W）
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * 2];
            break;
        case 36:
            //カードを１枚引き、１枚捨てる（U1)
            app.myAdditionalGettingCards++;
            app.myAdditionalDiscardingCards++;
            break;
        case 37:
            //カードを２枚引く（UU1)
            app.myAdditionalGettingCards++;
            app.myAdditionalGettingCards++;
            break;
        case 38:
            //カードを３枚引く（UU２)
            app.myAdditionalGettingCards++;
            app.myAdditionalGettingCards++;
            app.myAdditionalGettingCards++;
            break;
        case 39:
            //対象のエネルギーを破壊し、白にする（U)
            [self colorSelect];
            [self sync];
            int whiteColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:whiteColor + 1]];
            int whiteColor2 = [[app.enemyEnergyCardByMyself_plus objectAtIndex:0] intValue];
            [app.enemyEnergyCardByMyself_plus replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:(whiteColor2 + 1)]];
            break;
        case 40:
            //対象のエネルギーを破壊し、青にする（U)
            [self colorSelect];
            [self sync];
            int blueColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:blueColor + 1]];
            int blueColor2 = [[app.enemyEnergyCardByMyself_plus objectAtIndex:1] intValue];
            [app.enemyEnergyCardByMyself_plus replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:(blueColor2 + 1)]];
            break;
        case 41:
            //対象のエネルギーを破壊し、黒にする（U)
            [self colorSelect];
            [self sync];
            int blackColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:blackColor + 1]];
            int blackColor2 = [[app.enemyEnergyCardByMyself_plus objectAtIndex:2] intValue];
            [app.enemyEnergyCardByMyself_plus replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:(blackColor2 + 1)]];
            
            break;
        case 42:
            //対象のエネルギーを破壊し、赤にする（U)
            [self colorSelect];
            [self sync];
            int redColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:redColor + 1]];
            int redColor2 = [[app.enemyEnergyCardByMyself_plus objectAtIndex:3] intValue];
            [app.enemyEnergyCardByMyself_plus replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:(redColor2 + 1)]];
            
            break;
        case 43:
            //対象のエネルギーを破壊し、緑にする（U)
            [self colorSelect];
            [self sync];
            int greenColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:greenColor + 1]];
            int greenColor2 = [[app.enemyEnergyCardByMyself_plus objectAtIndex:4] intValue];
            [app.enemyEnergyCardByMyself_plus replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:(greenColor2 + 1)]];
            break;
        case 44:
            //対象キャラの攻撃力 −１（U1)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self enemyAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            break;
        case 45:
            //対象の場カードを手札に戻す（UU)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(returnEnemyFieldCardToHandSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:[NSString stringWithFormat:@"%@が発動しました。手札に戻すカードを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            break;
        case 46:
            //相手の全ての場カードをオーナーの手札に戻す（U3)
        {
            int i1 = [app.enemyFieldCard count];
            for (int k = 0; k < i1; k++) {
                [self manipulateCard:[app.enemyFieldCard objectAtIndex:k] plusArray:app.enemyHandByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
            }
        }
            break;
        case 47:
            //対象の場カードを自分のものにする（UU3)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(stealEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:@"相手から奪うカードを選択してください"];
            break;
        case 48:
            //対象のフィールドカードをオーナーの手札に戻し、カードを一枚引く（UU2)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(returnEnemyFieldCardToHandSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:[NSString stringWithFormat:@"%@が発動しました。手札に戻すカードを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            app.myAdditionalGettingCards++;
            break;
        case 49:
            //特定色の相手のフィールドカードを全てオーナーの手札に戻す（U2)
        {
            //手札に戻す色を選ぶ
            [self colorSelect];
            [self sync];
            //            //自分の場のカードを判定
            //            int i1 = [app.myFieldCard count];
            //            for (int i = 0; i < i1; i++) {
            //                if([self distinguishCardColor:[[app.myFieldCard objectAtIndex:i] intValue]] == app.mySelectColor){
            //                    [self manipulateCard:[app.myFieldCard objectAtIndex:i] plusArray:app.myHandByMyself_plus minusArray:app.myFieldCardByMyself_minus];
            //                }
            //            }
            
            //相手の場のカードを判定
            int i2 = [app.enemyFieldCard count];
            for (int i = 0; i < i2; i++) {
                if([self distinguishCardColor:[[app.enemyFieldCard objectAtIndex:i] intValue]] == app.mySelectColor){
                    [self manipulateCard:[app.enemyFieldCard objectAtIndex:i] plusArray:app.enemyHandByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
                }
            }
            app.mySelectColor = -1;
        }
            break;
        case 50:
            //一番上のカードを見て、取るか一番下に置く。（１ターンに１枚以上使用しても意味なし）（U)
            [self browseLibrary:app.myDeckCardList numberOfBrowsingCard:1 tapSelector:@selector(putACardToLibraryTopOrBottomSelector:) string:@"操作するカードを選択してください"];
            break;
            
        case 51:
            //攻撃キャラをギコにする（U2)
            app.enemySelectCharacterByMyself = GIKO;
            break;
        case 52:
            //攻撃キャラをモナーにする（U2)
            app.enemySelectCharacterByMyself = MONAR;
            break;
        case 53:
            //攻撃キャラをショボンにする（U2)
            app.enemySelectCharacterByMyself = SYOBON;
            break;
        case 54:
            //このターン、自分の攻撃についてキャラの相性関係を逆転させる（U2)
            _bc.reverse = YES;
            break;
        case 55:
            //このターン使用されたカードの枚数分だけカードを引く(U4)
            for (int i = 0; i < ([app.cardsIUsedInThisTurn count] + [app.cardsEnemyUsedInThisTurn count]); i++) {
                app.myAdditionalGettingCards++;
            }
            break;
        case 56:
            //エネルギーカードの種類数だけカードを引く（U2)
        {
            int num = [self distinguishTheNumberOfEnergyCardColor:MYSELF];
            NSLog(@"num:%d",num);
            for (int i = 0; i < num; i++) {
                app.myAdditionalGettingCards++;
            }
        }
            break;
        case 57:
            //相手キャラは攻撃・防御できない。別のカードが使われたとき、これは破壊される（U1)
            if([app.cardsEnemyUsedInThisTurn count] != 0){
                [self manipulateCard:[app.myFieldCard objectAtIndex:[GetEnemyDataFromServer indexOfObjectForNSNumber:app.myFieldCard number:[NSNumber numberWithInt:57]]] plusArray:app.myTombByMyself_plus minusArray:app.myFieldCardByMyself_minus];
            }else{
                app.enemyGikoAttackPermittedByMyself = NO;
                app.enemyMonarAttackPermittedByMyself = NO;
                app.enemySyobonAttackPermittedByMyself = NO;
                app.enemyYaruoAttackPermittedByMyself = NO;
                app.enemyGikoDeffencePermittedByMyself = NO;
                app.enemyMonarDeffencePermittedByMyself = NO;
                app.enemySyobonDeffencePermittedByMyself = NO;
                app.enemyYaruoDeffencePermittedByMyself = NO;
            }
            break;
        case 58:
            //カードを２枚引き、２枚捨てる(U2)
            app.myAdditionalGettingCards++;
            app.myAdditionalGettingCards++;
            app.myAdditionalDiscardingCards++;
            app.myAdditionalDiscardingCards++;
            break;
        case 59:
            //手札を全て捨て、同じだけの枚数のカードを引く(１ターンに２枚以上使っても意味なし)(U3)
            {
                int i = (int)([app.myHand count] - [app.myHandByMyself_minus count]);
                for (int k = 0; k < i; k++) {
                    [self manipulateCard:[app.myHand objectAtIndex:k] plusArray:app.myTombByMyself_plus minusArray:app.myHandByMyself_minus];
                    app.myAdditionalGettingCards++;
                }
            }
            break;
        case 60:
            //互いの全てのエネルギーを1ずつ減らす(U3)
            for (int i = 0; i < [app.myEnergyCard count]; i++) {
                [app.myEnergyCardByMyself_minus replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[app.myEnergyCardByMyself_minus objectAtIndex:i] intValue] + 1]];
            }
            for (int i = 0; i < [app.enemyEnergyCard count]; i++) {
                [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[app.enemyEnergyCardByMyself_minus objectAtIndex:i] intValue] + 1]];
            }
            break;
        case 61:
            //互いの全てのエネルギーを3ずつ減らす(U5)
            for (int i = 0; i < [app.myEnergyCard count]; i++) {
                [app.myEnergyCardByMyself_minus replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[app.myEnergyCardByMyself_minus objectAtIndex:i] intValue] + 3]];
            }
            for (int i = 0; i < [app.enemyEnergyCard count]; i++) {
                [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[app.enemyEnergyCardByMyself_minus objectAtIndex:i] intValue] + 3]];
            }
            break;
        case 62:
            //自分のフィールドカードと相手のフィールドカードを一枚交換する(U2)
            if([app.myFieldCard count] == 0 || [app.enemyFieldCard count] == 0){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"カード使用不可" message:@"自分または相手のフィールドにカードがなかったため、使用できませんでした" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }else{
                [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(stealEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:@"相手から奪うカードを選択してください"];
                [self sync];
                [self browseCardsInRegion:app.myFieldCard touchCard:YES tapSelector:@selector(sendMyFieldCardSelector:) longtapSelector:@selector(detailOfACard_MyField:) string:@"相手に渡すカードを選択してください"];
                [self sync];
            }
            break;
        case 63:
            //自分が場に出しているカードのフィールドカードのコピーになる(このターン中に使わなければ破壊される)(UU)
            [self browseCardsInRegion:app.myFieldCard touchCard:YES tapSelector:@selector(copyMyFieldCardSelector:) longtapSelector:@selector(detailOfACard_MyField:) string:@"コピーするカードを選択してください"];
            [self sync];
            break;
        case 64:
            //このカードが場に出ている限り、相手の攻撃力を１さげる(UU3)
            [self enemyAttackPowerOperate:GIKO point:-1 temporary:YES];
            [self enemyAttackPowerOperate:MONAR point:-1 temporary:YES];
            [self enemyAttackPowerOperate:SYOBON point:-1 temporary:YES];
            [self enemyAttackPowerOperate:YARUO point:-1 temporary:YES];
            break;
        case 65:
            //カードを一枚引く（U1)
            app.myAdditionalGettingCards++;
            break;
        case 66:
            //対象キャラの攻撃力＋１（R)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:1 temporary:1];
            break;
        case 67:
            //相手のエネルギーカードを１つ破壊する(RR2)
            [self colorSelect];
            [self sync];
            int selectedColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:selectedColor + 1]];
            break;
        case 68:
            //ランダムで相手のエネルギーカード破壊（R2)
        {
            int rand = (int)(random() % [app.enemyEnergyCard count]);
            int selectedColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:rand] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:rand withObject:[NSNumber numberWithInt:selectedColor + 1]];
            
        }
            break;
        case 69:
            //互いに全てのエネルギーカードを破壊する（R4)
            app.myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil];
            for (int i = 0; i < [app.enemyEnergyCard count]; i++) {
                [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:i withObject:[app.enemyEnergyCard objectAtIndex:i]];
            }
            break;
        case 70:
            //相手のライフに1点のダメージ（R)
            app.enemyDamageFromCard += 1;
            
            break;
        case 71:
            //相手のライフに3点のダメージ（R1)
            app.enemyDamageFromCard += 3;
            break;
        case 72:
            //毎ターン相手に１点のダメージ（R２)
            app.enemyDamageFromCard += 1;
            break;
        case 73:
            //自分のライフを１点削り、相手に2点ダメージ（R)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-1];
            app.enemyDamageFromCard += 2;
            break;
        case 74:
            //自分のライフを２点削り、相手に4点ダメージ（RR)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-2];
            app.enemyDamageFromCard += 4;
            break;
        case 75:
            //対象の場カードを破壊する（R1)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            break;
        case 76:
            //対象の場カードを２枚破壊する（R3)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMultiEnemyFieldCardsSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMultiEnemyFieldCardsSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            break;
        case 77:
            //相手プレイヤーに2点ダメージ。相手がギコを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == GIKO) {
                app.enemyDamageFromCard += 5;
            }else{
                app.enemyDamageFromCard += 2;
            }
            break;
        case 78:
            //相手プレイヤーに2点ダメージ。相手がモナーを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == MONAR) {
                app.enemyDamageFromCard += 5;
            }else{
                app.enemyDamageFromCard += 2;
            }
            break;
        case 79:
            //相手プレイヤーに2点ダメージ。相手がショボンを選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == SYOBON) {
                app.enemyDamageFromCard += 5;
            }else{
                app.enemyDamageFromCard += 2;
            }
            break;
        case 80:
            //相手プレイヤーに2点ダメージ。相手がやる夫を選んでいれば5点ダメージ。（RR)
            if (app.enemySelectCharacter == YARUO) {
                app.enemyDamageFromCard += 5;
            }else{
                app.enemyDamageFromCard += 2;
            }
            break;
        case 81:
            //攻撃力が＋３される代わりに防御力が０になる（R１)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            if(mySelectCharacterInCharacterField == GIKO){
                [self myDeffencePowerOperate:GIKO point:(app.myGikoFundamentalDeffencePower + app.myGikoFundamentalDeffencePowerByMyself + app.myGikoFundamentalDeffencePowerFromEnemy + app.myGikoModifyingDeffencePower + app.myGikoModifyingDeffencePowerByMyself + app.myGikoModifyingDeffencePowerFromEnemy) * -1 temporary:1];
            }else if (mySelectCharacterInCharacterField == MONAR){
                [self myDeffencePowerOperate:MONAR point:(app.myMonarFundamentalDeffencePower + app.myMonarFundamentalDeffencePowerByMyself + app.myMonarFundamentalDeffencePowerFromEnemy + app.myMonarModifyingDeffencePower + app.myMonarModifyingDeffencePowerByMyself + app.myMonarModifyingDeffencePowerFromEnemy) * -1 temporary:1];
            }else if (mySelectCharacterInCharacterField == SYOBON){
                [self myDeffencePowerOperate:SYOBON point:(app.mySyobonFundamentalDeffencePower + app.mySyobonFundamentalDeffencePowerByMyself + app.mySyobonFundamentalDeffencePowerFromEnemy + app.mySyobonModifyingDeffencePower + app.mySyobonModifyingDeffencePowerByMyself + app.mySyobonModifyingDeffencePowerFromEnemy) * -1 temporary:1];
            }else{
                [self myDeffencePowerOperate:YARUO point:(app.myYaruoFundamentalDeffencePower + app.myYaruoFundamentalDeffencePowerByMyself + app.myYaruoFundamentalDeffencePowerFromEnemy + app.myYaruoModifyingDeffencePower + app.myYaruoModifyingDeffencePowerByMyself + app.myYaruoModifyingDeffencePowerFromEnemy) * -1 temporary:1];
            }
            break;
        case 82:
            //相手がこのターンカードを使った場合、相手プレイヤーに3点のダメージ。使っていなければ1点ダメージ（RR)
            if(app.doEnemyUseCard == YES){
                app.enemyDamageFromCard += 3;
            }else{
                app.enemyDamageFromCard += 1;
            }
            break;
        case 83:
            //相手がこのターンカードを使わなかった場合、相手プレイヤーに5点のダメージ。使っていれば１点ダメージ。（RR)
            if(app.doEnemyUseCard == NO){
                app.enemyDamageFromCard += 5;
            }else{
                app.enemyDamageFromCard += 1;
            }
            break;
        case 84:
            //相手プレイヤーに、場に出ている選んだ一色のフィールドカードの枚数分のダメージ（R4)
            [self colorSelect];
            [self sync];
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
            app.enemyDamageFromCard += num;
            app.mySelectColor = -1; //mySelectCharacerを初期化
            
            break;
        case 85:
            //エネルギーカードの種類数ぶんだけ相手プレイヤーにダメージ（R1)
        {
            int num = [self distinguishTheNumberOfEnergyCardColor:MYSELF];
            app.enemyDamageFromCard += num;
        }
            break;
        case 86:
            //全てのエネルギーカードとフィールドカードを破壊する(RR5)
        {
            app.myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil];
            for (int i = 0; i < [app.enemyEnergyCard count]; i++) {
                [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:i withObject:[app.enemyEnergyCard objectAtIndex:i]];
            }
            for (int i = 0; i < [app.myFieldCard count]; i++) {
                [self manipulateCard:[app.myFieldCard objectAtIndex:i] plusArray:app.myTombByMyself_plus minusArray:app.myFieldCardByMyself_minus];
            }
            for (int i = 0; i < [app.enemyFieldCard count]; i++) {
                [self manipulateCard:[app.enemyFieldCard objectAtIndex:i] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
            }
        }
            break;
        case 87:
            //カードを１枚ランダムで捨てる。相手キャラの攻撃力−５（R1）
        {
            int count = [app.myHand count] - [app.myHandByMyself_minus count];
            if(count != 0){
                int rand = (int)(random() % count);
                NSLog(@"[app.myHand count]:%d",(int)[app.myHand count]);
                [self manipulateCard:[app.myHand objectAtIndex:rand] plusArray:app.myTombByMyself_plus minusArray:app.myHandByMyself_minus];
                
                [self enemyAttackPowerOperate:GIKO point:-5 temporary:1];
                [self enemyAttackPowerOperate:MONAR point:-5 temporary:1];
                [self enemyAttackPowerOperate:SYOBON point:-5 temporary:1];
                [self enemyAttackPowerOperate:YARUO point:-5 temporary:1];
            }
        }
            
            break;
        case 88:
            //相手がギコを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == GIKO) {
                app.enemyDamageFromCard += 2;
            }
            break;
        case 89:
            //相手がモナーを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == MONAR) {
                app.enemyDamageFromCard += 2;
            }
            break;
        case 90:
            //相手がショボンを選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == SYOBON) {
                app.enemyDamageFromCard += 2;
            }
            break;
        case 91:
            //相手がやる夫を選ぶたび、２点ダメージ（R1)
            if (app.enemySelectCharacter == YARUO) {
                app.enemyDamageFromCard += 2;
            }
            break;
        case 92:
            //毎ターン１点ダメージ（R2)
            app.enemyDamageFromCard += 1;
            break;
        case 93:
            //このターン自分のキャラの攻撃力−１、２点ダメージ（R)
            [self myAttackPowerOperate:GIKO point:-1 temporary:1];
            [self myAttackPowerOperate:MONAR point:-1 temporary:1];
            [self myAttackPowerOperate:SYOBON point:-1 temporary:1];
            [self myAttackPowerOperate:YARUO point:-1 temporary:1];
            app.enemyDamageFromCard += 2;
            break;
        case 94:
            //全ての場カードを破壊する（BB3)
            for (int i = 0; i < [app.myFieldCard count]; i++) {
                [self manipulateCard:[app.myFieldCard objectAtIndex:i] plusArray:app.myTombByMyself_plus minusArray:app.myFieldCardByMyself_minus];
            }
            for (int i = 0; i < [app.enemyFieldCard count]; i++) {
                [self manipulateCard:[app.enemyFieldCard objectAtIndex:i] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
            }
            break;

        case 95:
            //対象のエネルギーカードを２枚破壊する(RR3)
            [self colorSelect];
            [self sync];
        {
            int destroyedEnergyCard = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:destroyedEnergyCard + 1]];
        }
            [self colorSelect];
            [self sync];
        {
            int destroyedEnergyCard = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:destroyedEnergyCard + 1]];
        }
            break;
        case 96:
            //このターン、赤エネルギーを＋３（B)
        {
            int redColor = [[app.myEnergyCard objectAtIndex:3] intValue];
            [app.myEnergyCard replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:(redColor + 3)]];
        }
            break;
        case 97:
            //相手プレイヤーのライフを１削り、自分は１回復（B１)
            app.enemyDamageFromCard += 1;
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
            
            break;
        case 98:
            //相手プレイヤーのライフを２削り、自分は２回復（B2)
            app.enemyDamageFromCard += 2;
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:2];
            break;
        case 99:
            //相手の手札をランダムで１枚減らす（B)
        {
            int count = [app.enemyHand count] - [app.enemyHandByMyself_minus count];
            if(count >= 1){
                int rand = (int)(random() % count);
                [self manipulateCard:[app.enemyHand objectAtIndex:rand] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
            }
        }
            break;
        case 100:
            //相手の手札をランダムで２枚減らす（BB)
        {
            int count = [app.enemyHand count] - [app.enemyHandByMyself_minus count];
            int rand = 0;
            if(count >= 0){
                rand  = (int)(random() % count);
            }
            if(count >= 1){
                [self manipulateCard:[app.enemyHand objectAtIndex:rand] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
            }
            if(count >= 2){
                int rand2 = (int)(random() % count);
                while (rand2 == rand) {
                    rand2 = (int)(random() % count);
                }
                [self manipulateCard:[app.enemyHand objectAtIndex:rand2] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
            }
        }
            break;
        case 101:
            //相手の手札を全て減らす（BB3)
        {
            for (int i = 0; i < [app.enemyHand count]; i++) {
                [self manipulateCard:[app.enemyHand objectAtIndex:i] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
            }
        }
            break;
        case 102:
            //このターン相手の対象キャラの防御力を-1する（B1)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self enemyDeffencePowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            break;
        case 103:
            //攻撃力と防御力が−１される代わりにブロックされない（B１)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            app.enemyGikoDeffencePermittedByMyself = NO;
            app.enemyMonarDeffencePermittedByMyself = NO;
            app.enemySyobonDeffencePermittedByMyself = NO;
            app.enemyYaruoDeffencePermittedByMyself = NO;
            break;
        case 104:
            //このターン、ライフを３点失う代わりに攻撃力が＋５される（BB)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-3];
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:5 temporary:1];
            break;
        case 105:
            //毎ターンライフを５点失う代わりに攻撃力が＋８される（BB2)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-5];
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:8 temporary:1];
            break;
        case 106:
            //自分の場カードを破壊することでカードを２枚引く（B1)
            
            //selectCardIsCanceledInCardInRegionを初期化し、ターンのそれまでにキャンセルボタンが押されていても正しくカード効果が発動するようにする
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            if(selectCardIsCanceledInCardInRegion == NO){
                app.myAdditionalGettingCards++;
                app.myAdditionalGettingCards++;
            }else{
                selectCardIsCanceledInCardInRegion = NO;
            }
            break;
        case 107:
            //エネルギーカードの種類数だけ、相手の攻撃力と防御力をマイナスさせる（B1)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self enemyAttackPowerOperate:app.enemySelectCharacter point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1 temporary:1];
            [self enemyDeffencePowerOperate:app.enemySelectCharacter point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1 temporary:1];
            break;
        case 108:
            //場のカードを破壊するが、ライフを２点失う（B1)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-2];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            break;
        case 109:
            //自分のターンの開始時に、相手プレイヤーはカードをランダムで１枚捨てる（BB2)
        {
            int count = [app.enemyHand count] - [app.enemyHandByMyself_minus count];
            if(count >= 1){
                int rand = (int)(random() % count);
                [self manipulateCard:[app.enemyHand objectAtIndex:rand] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
            }
        }
            break;
        case 110:
            //対象キャラの攻撃力・防御力を−１し、カードを一枚引く。（B2)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self enemyAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            [self enemyDeffencePowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            app.myAdditionalGettingCards++;
            break;
        case 111:
            //自分のプレイヤーのターン終了時に、相手の場カードかエネルギーカードをランダムで１枚破壊（BB2)
        {
            int rand = random() % 2;
            if (rand == 0 && ([app.enemyFieldCard count] - [app.enemyFieldCardByMyself_minus count]) >= 1) {
                int count = [app.enemyFieldCard count] - [app.enemyFieldCardByMyself_minus count];
                int rand2 = (int)(random() % count);
                [self manipulateCard:[app.enemyFieldCard objectAtIndex:rand2] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
            }else{
                int count2 = [app.enemyEnergyCard count];
                int rand3 = (int)(random() % count2);
                int selectedColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:rand3] intValue];
                [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:rand3 withObject:[NSNumber numberWithInt:selectedColor + 1]];
            }
        }
            break;
        case 112:
            //相手プレイヤーがこのターンカードを使用していれば、カードを一枚引く（BB4)
            if (app.doEnemyUseCard == YES) {
                app.myAdditionalGettingCards++;
            }
            break;
        case 113:
            //カードを一枚好きにサーチし、ライブラリを切り直す。ライフを４点失う（B1)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-4];
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getACardFromLibrarySelector:) longtapSelector:@selector(detailOfACard_MyDeckCardList:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 114:
            //カードを一枚好きにサーチし、ライブラリを切り直す（BB2)
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getACardFromLibrarySelector:) longtapSelector:@selector(detailOfACard_MyDeckCardList:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 115:
            //相手プレイヤーのデッキからカードを一枚捨てる（BB2)
            [self browseCardsInRegion:app.enemyDeckCardList touchCard:YES tapSelector:@selector(discardACardFromLibrarySelector:) longtapSelector:@selector(detailOfACard_EnemyDeckCardList:) string:str];
            [self sync];
            break;
        case 116:
            //相手プレイヤーのデッキからカードを十枚捨てる(BBB5)
            for (int i = 0; i < 10; i++) {
                [self browseCardsInRegion:app.enemyDeckCardList touchCard:YES tapSelector:@selector(discardMultiCardsFromLibrarySelector:) longtapSelector:@selector(detailOfACard_EnemyDeckCardList:) string:str];
                [self sync];
            }
            break;
        case 117:
            //攻撃力が＋２されるが、防御力が半分になる（B)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            if(mySelectCharacterInCharacterField == GIKO){
                [self myDeffencePowerOperate:GIKO point:(app.myGikoFundamentalDeffencePower + app.myGikoModifyingDeffencePower) * -1 / 2 temporary:1];
            }else if (mySelectCharacterInCharacterField == MONAR){
                [self myDeffencePowerOperate:MONAR point:(app.myMonarFundamentalDeffencePower + app.myMonarModifyingDeffencePower) * -1 / 2 temporary:1];
            }else if (mySelectCharacterInCharacterField == SYOBON){
                [self myDeffencePowerOperate:SYOBON point:(app.mySyobonFundamentalDeffencePower + app.mySyobonModifyingDeffencePower) * -1 / 2 temporary:1];
            }else{
                [self myDeffencePowerOperate:YARUO point:(app.myYaruoFundamentalDeffencePower + app.myYaruoModifyingDeffencePower) * -1 / 2 temporary:1];
            }
            
            break;
        case 118:
            //相手プレイヤーの手札の中にある、カードを1枚選んで捨てる（BB2)
            [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyHandSelector:) longtapSelector:@selector(detailOfACard_EnemyHand:) string:str];
            [self sync];
            break;
        case 119:
            //相手プレイヤーの手札の中にある、カードを2枚選んで捨てる（BB2)
            [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyMultiHandSelector:) longtapSelector:@selector(detailOfACard_EnemyHand:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyMultiHandSelector:) longtapSelector:@selector(detailOfACard_EnemyHand:) string:str];
            [self sync];
            break;
        case 120:
            //各プレイヤーの場カードを一枚ずつランダムに破壊する（B)
        {
            int count1 = (int)([app.myFieldCard count] - [app.myFieldCardByMyself_minus count]);
            int count2 = (int)([app.enemyFieldCard count] - [app.enemyFieldCardByMyself_minus count]);
            
            if(count1 >= 1){
                int rand1 = (int)(random() % [app.myFieldCard count]);
                [self manipulateCard:[app.myFieldCard objectAtIndex:rand1] plusArray:app.myTombByMyself_plus minusArray:app.myFieldCardByMyself_minus];
            }
            
            if(count2 >= 1){
                int rand2 = (int)(random() % [app.enemyFieldCard count]);
                [self manipulateCard:[app.enemyFieldCard objectAtIndex:rand2] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
            }
        }
            break;
        case 121:
            //カードを一枚捨てる代わりに、相手のカードを好きに一枚捨てられる（B)
            
            //selectCardIsCanceledInCardInRegionを初期化し、ターンのそれまでにキャンセルボタンが押されていても正しくカード効果が発動するようにする
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) longtapSelector:@selector(detailOfACard:) string:str];
            [self sync];
            if(selectCardIsCanceledInCardInRegion == NO){
                [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyHandSelector:) longtapSelector:@selector(detailOfACard_EnemyHand:) string:str];
                [self sync];
            }else{
                selectCardIsCanceledInCardInRegion = NO;
            }
            break;
        case 122:
            //全プレイヤーは手札を全て捨てる（BB3)
            for (int i = 0; i < [app.myHand count]; i++) {
                [self manipulateCard:[app.myHand objectAtIndex:i] plusArray:app.myTombByMyself_plus minusArray:app.myHandByMyself_minus];
            }
            for (int i = 0; i < [app.enemyHand count]; i++) {
                [self manipulateCard:[app.enemyHand objectAtIndex:i] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
            }
            break;
        case 123:
            //対象キャラはずっと攻撃力＋２、防御力−２（B3)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:2 temporary:0];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:-2 temporary:0];
            break;
        case 124:
            //カードを２枚捨てることで、ずっと攻撃力・防御力＋２（B1)
            
            //selectCardIsCanceledInCardInRegionを初期化し、ターンのそれまでにキャンセルボタンが押されていても正しくカード効果が発動するようにする
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) longtapSelector:@selector(detailOfACard:) string:str];
            [self sync];
            BOOL b = selectCardIsCanceledInCardInRegion;
            
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) longtapSelector:@selector(detailOfACard:) string:str];
            [self sync];
            if(selectCardIsCanceledInCardInRegion == NO && b == NO){
                [self myAttackPowerOperate:GIKO point:2 temporary:0];
                [self myDeffencePowerOperate:GIKO point:2 temporary:0];
                [self myAttackPowerOperate:MONAR point:2 temporary:0];
                [self myDeffencePowerOperate:MONAR point:2 temporary:0];
                [self myAttackPowerOperate:SYOBON point:2 temporary:0];
                [self myDeffencePowerOperate:SYOBON point:2 temporary:0];
                [self myAttackPowerOperate:YARUO point:2 temporary:0];
                [self myDeffencePowerOperate:YARUO point:2 temporary:0];
            }else{
                selectCardIsCanceledInCardInRegion = NO;
            }
            break;
        case 125:
            //毎ターン相手に３点ダメージ（BB3)
            app.enemyDamageFromCard += 3;
            break;
        case 126:
            //対象キャラの攻撃力・防御力を１ターン＋２（G)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            break;
        case 127:
            //対象キャラの攻撃力・防御力を１ターン＋７（G3)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:7 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:7 temporary:1];
            
            break;
        case 128:
            //対象キャラの攻撃力・防御力を１ターン＋１，カードを一枚引く（G)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:1 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:1 temporary:1];
            app.myAdditionalGettingCards++;
            break;
        case 129:
            //１ターンの間、対象キャラの攻撃力・防御力を＋２，攻撃力そのままをダメージにする（G2)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせ、ブロックさせないAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:2 temporary:1];
    
            app.enemyGikoDeffencePermittedByMyself = NO;
            app.enemyMonarDeffencePermittedByMyself = NO;
            app.enemySyobonDeffencePermittedByMyself = NO;
            app.enemyYaruoDeffencePermittedByMyself = NO;
            break;
        case 130:
            //対象キャラの攻撃力・防御力を１ターン＋4（G1)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:4 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:4 temporary:1];
            break;
        case 131:
            //相手がカードを一枚（エネルギーカード除く）使うたびにギコ・モナー・ショボン・やる夫の攻撃力を＋１する（G2)
            for (int i = 0; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
                [self myAttackPowerOperate:GIKO point:1 temporary:1];
                [self myAttackPowerOperate:MONAR point:1 temporary:1];
                [self myAttackPowerOperate:SYOBON point:1 temporary:1];
                [self myAttackPowerOperate:YARUO point:1 temporary:1];
            }
            break;
        case 132:
            //このターン、双方ともダメージ無効（G)
            app.myGikoAttackPermittedByMyself = NO;
            app.myMonarAttackPermittedByMyself = NO;
            app.mySyobonAttackPermittedByMyself = NO;
            app.myYaruoAttackPermittedByMyself = NO;
            app.enemyGikoAttackPermittedByMyself = NO;
            app.enemyMonarAttackPermittedByMyself = NO;
            app.enemySyobonAttackPermittedByMyself = NO;
            app.enemyYaruoAttackPermittedByMyself = NO;
            //内部的にはとりあえずギコを選んでおき、次フェイズに進めるようにする
            app.mySelectCharacter = GIKO;
            break;
        case 133:
            //墓地からカードを一枚手札に戻す（G2)
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getACardFromMyTombSelector:) longtapSelector:@selector(detailOfACard_MyTomb:) string:str];
            [self sync];
            break;
        case 134:
            //墓地からカードを二枚手札に戻す（G3)
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getMultiCardFromMyTombSelector:) longtapSelector:@selector(detailOfACard_MyTomb:) string:str];
            [self sync];
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getMultiCardFromMyTombSelector:) longtapSelector:@selector(detailOfACard_MyTomb:) string:str];
            [self sync];
            break;
        case 135:
            //このターン攻撃力そのままをダメージにする（G)
            app.enemyGikoDeffencePermittedByMyself = NO;
            app.enemyMonarDeffencePermittedByMyself = NO;
            app.enemySyobonDeffencePermittedByMyself = NO;
            app.enemyYaruoDeffencePermittedByMyself = NO;
            break;
        case 136:
            //ずっと攻撃力そのままをダメージにする（G４）
            app.enemyGikoDeffencePermittedByMyself = NO;
            app.enemyMonarDeffencePermittedByMyself = NO;
            app.enemySyobonDeffencePermittedByMyself = NO;
            app.enemyYaruoDeffencePermittedByMyself = NO;
            break;
        case 137:
            //エネルギーカードを１枚サーチ（G１)
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getAEnergyCardFromLibrarySelector:) longtapSelector:@selector(detailOfACard_MyDeckCardList:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 138:
            //エネルギーカードを２枚サーチ（GG2)
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getMultiEnergyCardFromLibraryHandSelector:) longtapSelector:@selector(detailOfACard_MyDeckCardList:) string:str];
            [self sync];
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getMultiEnergyCardFromLibraryHandSelector:) longtapSelector:@selector(detailOfACard_MyDeckCardList:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 139:
            //墓地のカードをライブラリーの一番下に戻す（G)
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(returnMyTombCardToLibrarySelector:) longtapSelector:@selector(detailOfACard_MyTomb:) string:str];
            [self sync];
            break;
        case 140:
            //対象の場カードを破壊する（G1)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            break;
        case 141:
            //全ての場カードを破壊する（G2)
            for (int i = 0; i < [app.myFieldCard count]; i++) {
                [self manipulateCard:[app.myFieldCard objectAtIndex:i] plusArray:app.myTombByMyself_plus minusArray:app.myFieldCardByMyself_minus];
            }
            for (int i = 0; i < [app.enemyFieldCard count]; i++) {
                [self manipulateCard:[app.enemyFieldCard objectAtIndex:i] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
            }
            break;
        case 142:
            //毎ターン、カードを引く代わりにエネルギーカードを選んできても良い。（G1)
        {
            if(!searchACardInsteadOfGetACardFromLibraryTop){
                searchEnergyCardOrGetACard = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ 発動",[app.cardList_cardName objectAtIndex:cardnumber]] message:[NSString stringWithFormat:@"%@ が発動しました。そのままカードを引くか、デッキからエネルギーカードを探すか選択してください",[app.cardList_cardName objectAtIndex:cardnumber]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"そのまま引く",@"エネルギーカードを探す", nil];
                [searchEnergyCardOrGetACard show];
                [self sync];
                [AppDelegate shuffledArray:app.myDeckCardList];
            }
        }

            break;
        case 143:
            //このターン、修正攻撃力がアップしていた場合、カードを一枚引く（G2)
            if(app.myGikoModifyingAttackPower > 0 || app.myMonarModifyingAttackPower > 0 || app.mySyobonModifyingAttackPower > 0 || app.myYaruoModifyingAttackPower > 0){
                app.myAdditionalGettingCards++;
            }            break;
        case 144:
            //自分の場カードを破壊し、そのカードのコスト分このターン攻撃力をプラスする（G1)
        {
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            if(selectCardIsCanceledInCardInRegion == NO){
                NSArray *costLength = [self caliculateEnergyCost:[[[app.myFieldCardByMyself_minus lastObject] objectAtIndex:0] intValue]];
                int cost = 0;
                for (int i = 0; i < [costLength count]; i++) {
                    cost += [[costLength objectAtIndex:i] intValue];
                }
                [self myAttackPowerOperate:GIKO point:cost temporary:1];
                [self myAttackPowerOperate:MONAR point:cost temporary:1];
                [self myAttackPowerOperate:SYOBON point:cost temporary:1];
                [self myAttackPowerOperate:YARUO point:cost temporary:1];
            }else{
                selectCardIsCanceledInCardInRegion = NO;
            }
        }
            break;
        case 145:
            //コントロールするエネルギーカードの種類数だけ、このターン攻撃力と防御力をプラスする（G1)
        {
            int num = [self distinguishTheNumberOfEnergyCardColor:MYSELF];
            [self myAttackPowerOperate:GIKO point:num temporary:1];
            [self myAttackPowerOperate:MONAR point:num temporary:1];
            [self myAttackPowerOperate:SYOBON point:num temporary:1];
            [self myAttackPowerOperate:YARUO point:num temporary:1];
            [self myDeffencePowerOperate:GIKO point:num temporary:1];
            [self myDeffencePowerOperate:MONAR point:num temporary:1];
            [self myDeffencePowerOperate:SYOBON point:num temporary:1];
            [self myDeffencePowerOperate:YARUO point:num temporary:1];
        }
            break;
        case 146:
            //毎ターン選択したキャラクターの攻撃力と防御力が＋１される（G)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:1 temporary:0];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:1 temporary:0];
            
            break;
        case 147:
            //毎ターン全てのキャラクターの攻撃力がずっと＋1されていく（GG1)
            [self myAttackPowerOperate:GIKO point:1 temporary:0];
            [self myAttackPowerOperate:MONAR point:1 temporary:0];
            [self myAttackPowerOperate:SYOBON point:1 temporary:0];
            [self myAttackPowerOperate:YARUO point:1 temporary:0];
            break;
        case 148:
            //カードを一枚捨てることで、このターン攻撃力そのままをダメージにする（G)
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) longtapSelector:@selector(detailOfACard:) string:str];
            [self sync];
            if(selectCardIsCanceledInCardInRegion == NO){
                app.enemyGikoDeffencePermittedByMyself = NO;
                app.enemyMonarDeffencePermittedByMyself = NO;
                app.enemySyobonDeffencePermittedByMyself = NO;
                app.enemyYaruoDeffencePermittedByMyself = NO;
            }else{
                selectCardIsCanceledInCardInRegion = NO;
            }
            break;
        case 149:
            //手札のカードが二枚以下の間、攻撃力と防御力を＋３する（G２)
            if([app.myHand count] <= 2){
                [self myAttackPowerOperate:GIKO point:3 temporary:1];
                [self myAttackPowerOperate:MONAR point:3 temporary:1];
                [self myAttackPowerOperate:SYOBON point:3 temporary:1];
                [self myAttackPowerOperate:YARUO point:3 temporary:1];
                [self myDeffencePowerOperate:GIKO point:3 temporary:1];
                [self myDeffencePowerOperate:MONAR point:3 temporary:1];
                [self myDeffencePowerOperate:SYOBON point:3 temporary:1];
                [self myDeffencePowerOperate:YARUO point:3 temporary:1];
            }
            break;
        case 150:
            //手札のカードが一枚以下の間、攻撃力と防御力を＋５する（G２)
            if([app.myHand count] <= 1){
                [self myAttackPowerOperate:GIKO point:5 temporary:1];
                [self myAttackPowerOperate:MONAR point:5 temporary:1];
                [self myAttackPowerOperate:SYOBON point:5 temporary:1];
                [self myAttackPowerOperate:YARUO point:5 temporary:1];
                [self myDeffencePowerOperate:GIKO point:5 temporary:1];
                [self myDeffencePowerOperate:MONAR point:5 temporary:1];
                [self myDeffencePowerOperate:SYOBON point:5 temporary:1];
                [self myDeffencePowerOperate:YARUO point:5 temporary:1];
            }
            break;
        case 151:
            //カードを３枚捨て、エネルギーカードをデッキからランダムに３枚引く（G１）
            //selectCardIsCanceledInCardInRegionを初期化し、ターンのそれまでにキャンセルボタンが押されていても正しくカード効果が発動するようにする
        {
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) longtapSelector:@selector(detailOfACard:) string:str];
            [self sync];
            BOOL a = selectCardIsCanceledInCardInRegion;
            
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) longtapSelector:@selector(detailOfACard:) string:str];
            [self sync];
            BOOL b = selectCardIsCanceledInCardInRegion;
            
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) longtapSelector:@selector(detailOfACard:) string:str];
            [self sync];
            
            if(selectCardIsCanceledInCardInRegion == NO && a == NO && b == NO){
                NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                for (int i = 0;  i < [app.myDeckCardList count]; i++) {
                    int x = [[app.myDeckCardList objectAtIndex:i] intValue];
                    if(x >= 1 && x <= 5){
                        [tmpArray addObject:[app.myDeckCardList objectAtIndex:i]];
                    }
                    if([tmpArray count] == 3){
                        break;
                    }
                }
                for (int i = 0; i < [tmpArray count]; i++) {
                    [self manipulateCard:[tmpArray objectAtIndex:i] plusArray:app.myHandByMyself_plus minusArray:app.myDeckCardListByMyself_minus];
                }
            }else{
                selectCardIsCanceledInCardInRegion = NO;
            }
        }
            break;
        case 152:
            //互いに場カードを１枚破壊する(G1)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            break;
        case 153:
            //墓地にあるエネルギーカードを一枚手札に戻す（G1)
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getAEnergyCardFromTombSelector:) longtapSelector:@selector(detailOfACard_MyTomb:) string:str];
            [self sync];
            break;
        case 154:
            //場カードと土地を１枚ずつ破壊する（GG2)
        {
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            [self colorSelect];
            [self sync];
            int selectedColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:selectedColor + 1]];
        }
            break;
        case 155:
            //場カードと土地を2枚ずつ破壊する（GGG3)
        {
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:str];
            [self sync];
            [self colorSelect];
            [self sync];
            int selectedColor = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:selectedColor + 1]];
            [self colorSelect];
            [self sync];
            int selectedColor2 = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:selectedColor2 + 1]];
        }
            break;
        default:
            break;
    }
    
}

- (void)turnStartFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    //スクロールビューのビュー範囲を規定するため、スクロールさせるべき画面の大きさを保持しておく
    CGRect cgRect;
    
    
    //スクロールビューから既存のデータを全て取り除く
    for (UILabel *label in [resultFadeinScrollView subviews]) {
        [label removeFromSuperview];
    }
    view.frame = CGRectMake(0, 0, 280, 420);
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2 - 20);
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    [self insertLabelToParentView:view Text:@"ターン開始時に発動したカード"  Rectangle:CGRectMake(50,25,180,30) Touch:NO];
    
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
    
    int myCount = (int)[my1 count]; //自分のカードが発動した枚数
    int enemyCount = (int)[enemy1 count]; //相手のカードが発動した枚数
    
    [self insertLabelToParentView:resultFadeinScrollView Text:@"自分が使用したカード"  Rectangle:CGRectMake(10,0,150,30) Touch:NO];
    if (90 + myCount * 20 <= 200) {
        [self insertLabelToParentView:resultFadeinScrollView Text:@"相手が使用したカード"  Rectangle:CGRectMake(10,170,150,30) Touch:NO];
        
        if(myCount == 0){
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 30, 240, 20) Touch:NO];
        }else{
            for (int i = 0; i < myCount; i++) {
                [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[my1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 30 + (20 * i), 240, 20) Touch:YES];
            }
        }
        if (enemyCount == 0) {
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 200, 240, 20) Touch:NO];
        }else{
            for (int i = 0; i < enemyCount; i++) {
                cgRect = CGRectMake(20, 200 + (20 * i), 240, 20);
                [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[enemy1 objectAtIndex:i] intValue]]] Rectangle:cgRect Touch:YES];
            }
            
        }
    }else{
        [self insertLabelToParentView:resultFadeinScrollView Text:@"相手が使用したカード"  Rectangle:CGRectMake(10,60 + (20 * myCount),150,30) Touch:NO];
        for (int i = 0; i < myCount; i++) {
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[my1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 30 + (20 * i), 240, 20) Touch:YES];
        }
        for (int i = 0; i < enemyCount; i++) {
            cgRect = CGRectMake(20, 90 + (20 * (myCount + i)), 240, 20);
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[enemy1 objectAtIndex:i] intValue]]] Rectangle:cgRect Touch:YES];
        }
    }

    [view addSubview:resultFadeinScrollView];
    resultFadeinScrollView.contentSize = CGSizeMake(cgRect.size.width, 150 + (20 * (myCount + enemyCount)));

    
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2 - 20);
    //[UIView setAnimationDidStopSelector:@selector(resultFadeOut:)];
    [UIView commitAnimations];
}

- (void)cardActivateFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    //スクロールビューのビュー範囲を規定するため、スクロールさせるべき画面の大きさを保持しておく
    CGRect cgRect;
    
    
    //スクロールビューから既存のデータを全て取り除く
    for (UILabel *label in [resultFadeinScrollView subviews]) {
        [label removeFromSuperview];
    }

    view = [[UIImageView alloc] initWithImage:img];
    view.frame = CGRectMake(0, 0, 280, 420);
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    
    
    int myCount = (int)[app.cardsIUsedInThisTurn count]; //自分のカードが発動した枚数
    int enemyCount = (int)[app.cardsEnemyUsedInThisTurn count]; //相手のカードが発動した枚数

    [self insertLabelToParentView:view Text:@"カードの使用結果" Rectangle:CGRectMake(80,25,180,30) Touch:NO];
    [self insertLabelToParentView:resultFadeinScrollView Text:@"自分が使用したカード"  Rectangle:CGRectMake(10,0,150,30) Touch:NO];
    if (90 + myCount * 20 <= 200) {
        [self insertLabelToParentView:resultFadeinScrollView Text:@"相手が使用したカード"  Rectangle:CGRectMake(10,170,150,30) Touch:NO];
        if(myCount == 0){
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"カードを使用しませんでした"] Rectangle:CGRectMake(20, 30, 240, 20) Touch:NO];
        }else{
            for (int i = 0; i < myCount; i++) {
                [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[app.cardsIUsedInThisTurn objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 30 + (20 * i), 240, 20) Touch:YES];
            }
        }
        if (enemyCount == 0) {
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"カードを使用しませんでした"] Rectangle:CGRectMake(20, 200, 240, 20) Touch:NO];
        }else{
            for (int i = 0; i < enemyCount; i++) {
                cgRect = CGRectMake(20, 200 + (20 * i), 240, 20);
                [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]] Rectangle:cgRect Touch:YES];
            }
        }
    }else{
        [self insertLabelToParentView:resultFadeinScrollView Text:@"相手が使用したカード"  Rectangle:CGRectMake(10,60 + (20 * myCount),150,30) Touch:NO];
        for (int i = 0; i < myCount; i++) {
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[app.cardsIUsedInThisTurn objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 30 + (20 * i), 240, 20) Touch:YES];
        }
        for (int i = 0; i < enemyCount; i++) {
            cgRect = CGRectMake(20, 90 + (20 * (myCount + i)), 240, 20);
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[app.cardsEnemyUsedInThisTurn objectAtIndex:i] intValue]]] Rectangle:cgRect Touch:YES];
        }

    }
    [view addSubview:resultFadeinScrollView];
    resultFadeinScrollView.contentSize = CGSizeMake(cgRect.size.width, 150 + (20 * (myCount + enemyCount)));

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
    view.frame = CGRectMake(0, 0, 280, 420);

    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height / 2 - 20);
    
    
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];

    
    for (UILabel *label in [resultFadeinScrollView subviews]) {
        [label removeFromSuperview];
    }
    [view addSubview:resultFadeinScrollView];
    resultFadeinScrollView.contentSize = CGSizeMake(240, 350);
    
    [resultFadeinScrollView addSubview:_myDamage];
    [resultFadeinScrollView addSubview:_myGiko];
    [resultFadeinScrollView addSubview:_myMonar];
    [resultFadeinScrollView addSubview:_mySyobon];
    [resultFadeinScrollView addSubview:_myYaruo];
    [resultFadeinScrollView addSubview:_myDamage];
    [resultFadeinScrollView addSubview:_enemyDamage];
    [resultFadeinScrollView addSubview:_enemyGiko];
    [resultFadeinScrollView addSubview:_enemyMonar];
    [resultFadeinScrollView addSubview:_enemySyobon];
    [resultFadeinScrollView addSubview:_enemyYaruo];
    [resultFadeinScrollView addSubview:_enemyDamage];
    
    
    UILabel *myName = [[UILabel alloc] init];
    [resultFadeinScrollView addSubview:myName];
    myName.text = [NSString stringWithFormat:@"%@の計算結果",app.myNickName];
    myName.frame = CGRectMake(20, 20, view.bounds.size.width -20, 20);
    
    UILabel *enemyName = [[UILabel alloc] init];
    [resultFadeinScrollView addSubview:enemyName];
    enemyName.text = [NSString stringWithFormat:@"%@の計算結果",app.enemyNickName];
    enemyName.frame = CGRectMake(20, 180, view.bounds.size.width -20, 20);
    
    UIFont *nameFont = [UIFont fontWithName:@"Tanuki-Permanent-Marker" size:14];
    myName.font = nameFont;
    enemyName.font = nameFont;
    
    _myGiko.frame      = CGRectMake(20,  40, view.bounds.size.width - 20, 20);
    _myMonar.frame     = CGRectMake(20,  60, view.bounds.size.width - 20, 20);
    _mySyobon.frame    = CGRectMake(20,  80, view.bounds.size.width - 20, 20);
    _myYaruo.frame     = CGRectMake(20, 100, view.bounds.size.width - 20, 20);
    _myDamage.frame    = CGRectMake(20, 120, view.bounds.size.width - 20, 40);
    _enemyGiko.frame   = CGRectMake(20, 200, view.bounds.size.width - 20, 20);
    _enemyMonar.frame  = CGRectMake(20, 220, view.bounds.size.width - 20, 20);
    _enemySyobon.frame = CGRectMake(20, 240, view.bounds.size.width - 20, 20);
    _enemyYaruo.frame  = CGRectMake(20, 260, view.bounds.size.width - 20, 20);
    _enemyDamage.frame = CGRectMake(20, 280, view.bounds.size.width - 20, 40);
    
    UIFont *font = [UIFont fontWithName:@"Tanuki-Permanent-Marker" size:11];
    _myGiko.font = font;
    _myMonar.font = font;
    _mySyobon.font = font;
    _myYaruo.font = font;
    _myDamage.font = font;
    _enemyGiko.font = font;
    _enemyMonar.font = font;
    _enemySyobon.font = font;
    _enemyYaruo.font = font;
    _enemyDamage.font = font;
    
    
    [self insertLabelToParentView:view Text:@"ダメージ計算結果"  Rectangle:CGRectMake(50,25,180,30) Touch:NO];
    
    switch (app.mySelectCharacter) {
        case GIKO:
            _myGiko.textColor = [UIColor redColor];
            break;
        case MONAR:
            _myMonar.textColor = [UIColor redColor];
            break;
        case SYOBON:
            _mySyobon.textColor = [UIColor redColor];
            break;
        case YARUO:
            _myYaruo.textColor = [UIColor redColor];
            break;
        default:
            break;
    }
    switch (app.enemySelectCharacter) {
        case GIKO:
            _enemyGiko.textColor = [UIColor redColor];
            break;
        case MONAR:
            _enemyMonar.textColor = [UIColor redColor];
            break;
        case SYOBON:
            _enemySyobon.textColor = [UIColor redColor];
            break;
        case YARUO:
            _enemyYaruo.textColor = [UIColor redColor];
            break;
        default:
            break;
    }
    
    NSString *myGikoAttackPermitted;
    NSString *myMonarAttackPermitted;
    NSString *mySyobonAttackPermitted;
    NSString *myYaruoAttackPermitted;
    NSString *enemyGikoAttackPermitted;
    NSString *enemyMonarAttackPermitted;
    NSString *enemySyobonAttackPermitted;
    NSString *enemyYaruoAttackPermitted;
    NSString *myGikoDeffencePermitted;
    NSString *myMonarDeffencePermitted;
    NSString *mySyobonDeffencePermitted;
    NSString *myYaruoDeffencePermitted;
    NSString *enemyGikoDeffencePermitted;
    NSString *enemyMonarDeffencePermitted;
    NSString *enemySyobonDeffencePermitted;
    NSString *enemyYaruoDeffencePermitted;
    
    if (app.myGikoAttackPermittedByMyself && app.myGikoAttackPermittedFromEnemy) {
        myGikoAttackPermitted = @"○";
    }else{
        myGikoAttackPermitted = @"×";
    }
    if (app.myMonarAttackPermittedByMyself && app.myMonarAttackPermittedFromEnemy) {
        myMonarAttackPermitted = @"○";
    }else{
        myMonarAttackPermitted = @"×";
    }
    if (app.mySyobonAttackPermittedByMyself && app.mySyobonAttackPermittedFromEnemy) {
        mySyobonAttackPermitted = @"○";
    }else{
        mySyobonAttackPermitted = @"×";
    }
    if (app.myYaruoAttackPermittedByMyself && app.myYaruoAttackPermittedFromEnemy) {
        myYaruoAttackPermitted = @"○";
    }else{
        myYaruoAttackPermitted = @"×";
    }
    if (app.enemyGikoAttackPermittedByMyself && app.enemyGikoAttackPermittedFromEnemy) {
        enemyGikoAttackPermitted = @"○";
    }else{
        enemyGikoAttackPermitted = @"×";
    }
    if (app.enemyMonarAttackPermittedByMyself && app.enemyMonarAttackPermittedFromEnemy) {
        enemyMonarAttackPermitted = @"○";
    }else{
        enemyMonarAttackPermitted = @"×";
    }
    if (app.enemySyobonAttackPermittedByMyself && app.enemySyobonAttackPermittedFromEnemy) {
        enemySyobonAttackPermitted = @"○";
    }else{
        enemySyobonAttackPermitted = @"×";
    }
    if (app.enemyYaruoAttackPermittedByMyself && app.enemyYaruoAttackPermittedFromEnemy) {
        enemyYaruoAttackPermitted = @"○";
    }else{
        enemyYaruoAttackPermitted = @"×";
    }
    
    
    if (app.myGikoDeffencePermittedByMyself && app.myGikoDeffencePermittedFromEnemy) {
        myGikoDeffencePermitted = @"○";
    }else{
        myGikoDeffencePermitted = @"×";
    }
    if (app.myMonarDeffencePermittedByMyself && app.myMonarDeffencePermittedFromEnemy) {
        myMonarDeffencePermitted = @"○";
    }else{
        myMonarDeffencePermitted = @"×";
    }
    if (app.mySyobonDeffencePermittedByMyself && app.mySyobonDeffencePermittedFromEnemy) {
        mySyobonDeffencePermitted = @"○";
    }else{
        mySyobonDeffencePermitted = @"×";
    }
    if (app.myYaruoDeffencePermittedByMyself && app.myYaruoDeffencePermittedFromEnemy) {
        myYaruoDeffencePermitted = @"○";
    }else{
        myYaruoDeffencePermitted = @"×";
    }
    if (app.enemyGikoDeffencePermittedByMyself && app.enemyGikoDeffencePermittedFromEnemy) {
        enemyGikoDeffencePermitted = @"○";
    }else{
        enemyGikoDeffencePermitted = @"×";
    }
    if (app.enemyMonarDeffencePermittedByMyself && app.enemyMonarDeffencePermittedFromEnemy) {
        enemyMonarDeffencePermitted = @"○";
    }else{
        enemyMonarDeffencePermitted = @"×";
    }
    if (app.enemySyobonDeffencePermittedByMyself && app.enemySyobonDeffencePermittedFromEnemy) {
        enemySyobonDeffencePermitted = @"○";
    }else{
        enemySyobonDeffencePermitted = @"×";
    }
    if (app.enemyYaruoDeffencePermittedByMyself && app.enemyYaruoDeffencePermittedFromEnemy) {
        enemyYaruoDeffencePermitted = @"○";
    }else{
        enemyYaruoDeffencePermitted = @"×";
    }
    
    _myGiko.text    = [NSString stringWithFormat:@"ギコ　:攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@"  ,app.myGikoFundamentalAttackPower      , app.myGikoModifyingAttackPower     , app.myGikoFundamentalDeffencePower     , app.myGikoModifyingDeffencePower,myGikoAttackPermitted,myGikoDeffencePermitted];
    _myMonar.text   = [NSString stringWithFormat:@"モナー:攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@"  ,app.myMonarFundamentalAttackPower     , app.myMonarModifyingAttackPower    , app.myMonarFundamentalDeffencePower    , app.myMonarModifyingDeffencePower,myMonarAttackPermitted,myMonarDeffencePermitted];
    _mySyobon.text  = [NSString stringWithFormat:@"ｼｮﾎﾞﾝ :攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@"  ,app.mySyobonFundamentalAttackPower    , app.mySyobonModifyingAttackPower   , app.mySyobonFundamentalDeffencePower   , app.mySyobonModifyingDeffencePower,mySyobonAttackPermitted,mySyobonDeffencePermitted];
    _myYaruo.text   = [NSString stringWithFormat:@"やる夫:攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@"  ,app.myYaruoFundamentalAttackPower     , app.myYaruoModifyingAttackPower    , app.myYaruoFundamentalDeffencePower    , app.myYaruoModifyingDeffencePower,myYaruoAttackPermitted,myYaruoDeffencePermitted];
    _myDamage.text  = [NSString stringWithFormat:@"自分が受けたダメージ:%d",app.myDamageInBattlePhase];
    _enemyGiko.text = [NSString stringWithFormat:@"ギコ　:攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@"  ,app.enemyGikoFundamentalAttackPower   , app.enemyGikoModifyingAttackPower  , app.enemyGikoFundamentalDeffencePower  , app.enemyGikoModifyingDeffencePower,enemyGikoAttackPermitted,enemyGikoDeffencePermitted];
    _enemyMonar.text = [NSString stringWithFormat:@"モナー:攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@" ,app.enemyMonarFundamentalAttackPower  , app.enemyMonarModifyingAttackPower , app.enemyMonarFundamentalDeffencePower , app.enemyMonarModifyingDeffencePower,enemyMonarAttackPermitted,enemyMonarDeffencePermitted];
    _enemySyobon.text = [NSString stringWithFormat:@"ｼｮﾎﾞﾝ :攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@",app.enemySyobonFundamentalAttackPower , app.enemySyobonModifyingAttackPower, app.enemySyobonFundamentalDeffencePower, app.enemySyobonModifyingDeffencePower,enemySyobonAttackPermitted,enemySyobonDeffencePermitted];
    _enemyYaruo.text = [NSString stringWithFormat:@"やる夫:攻撃力:%d+%d 防御力:%d+%d 攻:%@ 防:%@" ,app.enemyYaruoFundamentalAttackPower  , app.enemyYaruoModifyingAttackPower , app.enemyYaruoFundamentalDeffencePower , app.enemyYaruoModifyingDeffencePower,enemyYaruoAttackPermitted,enemyYaruoDeffencePermitted];
    _enemyDamage.text  = [NSString stringWithFormat:@"相手が受けたダメージ:%d",app.enemyDamageInBattlePhase];
    
    
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2 - 20);

    
    //[UIView setAnimationDidStopSelector:@selector(resultFadeOut:)];
    [UIView commitAnimations];
}

- (void)resultFadeIn:(UIImageView *)view animaImage:(UIImage *)img{
    //ダメージ計算画面の、選択したキャラを赤字にする処理を元に戻す
    _myGiko.textColor = [UIColor blackColor];
    _myMonar.textColor = [UIColor blackColor];
    _mySyobon.textColor = [UIColor blackColor];
    _myYaruo.textColor = [UIColor blackColor];
    _enemyGiko.textColor = [UIColor blackColor];
    _enemyMonar.textColor = [UIColor blackColor];
    _enemySyobon.textColor = [UIColor blackColor];
    _enemyYaruo.textColor = [UIColor blackColor];
    
    //スクロールビューのビュー範囲を規定するため、スクロールさせるべき画面の大きさを保持しておく
    CGRect cgRect;
    
    
    //スクロールビューから既存のデータを全て取り除く
    for (UILabel *label in [resultFadeinScrollView subviews]) {
        [label removeFromSuperview];
    }
    
    view.frame = CGRectMake(0, 0, 280, 420);
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2 - 20);
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];

    int myCount = (int)[app.myFieldCard count]; //自分のフィールドカードの枚数
    int enemyCount = (int)[app.enemyFieldCard count]; //相手のフィールドカードの枚数
    
    NSMutableArray *my1 = [[NSMutableArray alloc] init]; //ターン終了時に発動する自分のフィールドカード
    NSMutableArray *enemy1 = [[NSMutableArray alloc] init]; //ターン終了時に発動する相手のフィールドカード

    
    //何枚発動するかを計算する
    for (int i = 0; i < myCount; i++) {
        for (int j = 0; j < [app.fieldCardList_turnEnd count];  j++) {
            if([[app.myFieldCard objectAtIndex:i] isEqual:[app.fieldCardList_turnEnd objectAtIndex:j]]){
                [my1 addObject:[app.myFieldCard objectAtIndex:i]];
            }
        }
    }
    for (int i = 0; i < enemyCount; i++) {
        if([GetEnemyDataFromServer indexOfObjectForNSNumber:app.fieldCardList_turnEnd number:[app.enemyFieldCard objectAtIndex:i]] != -1){
            [enemy1 addObject:[app.enemyFieldCard objectAtIndex:i]];
        }
    }
    
    int my1Count = (int)[my1 count];
    int enemy1Count = (int)[enemy1 count];
    [self insertLabelToParentView:view Text:@"ターン終了時に発動したカード" Rectangle:CGRectMake(50,25,180,30) Touch:NO];
    [self insertLabelToParentView:resultFadeinScrollView Text:@"自分が使用したカード"  Rectangle:CGRectMake(10,0,150,30) Touch:NO];
    if (90 + my1Count * 20 <= 200) {
        [self insertLabelToParentView:resultFadeinScrollView Text:@"相手が使用したカード"  Rectangle:CGRectMake(10,170,150,30) Touch:NO];
        if(my1Count == 0){
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 30, 240, 20) Touch:NO];
        }else{
            for (int i = 0; i < my1Count; i++) {
                [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[my1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 30 + (20 * i), 240, 20) Touch:YES];
            }
        }
        if (enemy1Count == 0) {
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"カード効果は発動しませんでした"] Rectangle:CGRectMake(20, 200, 240, 20) Touch:NO];
        }else{
            for (int i = 0; i < enemy1Count; i++) {
                cgRect = CGRectMake(20, 200 + (20 * i), 240, 20);
                [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[enemy1 objectAtIndex:i] intValue]]] Rectangle:cgRect Touch:YES];
            }
            
        }
    }else{
        [self insertLabelToParentView:resultFadeinScrollView Text:@"相手が使用したカード"  Rectangle:CGRectMake(10,60 + (20 * my1Count),150,30) Touch:NO];
        for (int i = 0; i < my1Count; i++) {
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[my1 objectAtIndex:i] intValue]]] Rectangle:CGRectMake(20, 30 + (20 * i), 240, 20) Touch:YES];
        }
        for (int i = 0; i < enemy1Count; i++) {
            cgRect = CGRectMake(20, 90 + (20 * (myCount + i)), 240, 20);
            [self insertLabelToParentView:resultFadeinScrollView Text:[NSString stringWithFormat:@"%@",[app.cardList_cardName objectAtIndex:[[enemy1 objectAtIndex:i] intValue]]] Rectangle:cgRect Touch:YES];
        }
    }
    
    [view addSubview:resultFadeinScrollView];
    resultFadeinScrollView.contentSize = CGSizeMake(cgRect.size.width, 150 + (20 * (my1Count + enemy1Count)));
    
    [_allImageView addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2 - 20);
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
    [self insertLabelToParentView:_phaseNameView Text:phaseName  Rectangle:CGRectMake(0,0,250,100) Touch:NO];
    [_allImageView addSubview:_phaseNameView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    _phaseNameView.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2 - 40,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDidStopSelector:@selector(resultFadeOutToTextField)];
    [UIView commitAnimations];
}

- (void)resultFadeOutToTextField{
    [NSThread sleepForTimeInterval:2];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    _phaseNameView.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2 - 40,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    _phaseNameView.center = CGPointMake( ([[UIScreen mainScreen] bounds].size.width * -2) ,  [[UIScreen mainScreen] bounds].size.height /2);
    [UIView setAnimationDidStopSelector:@selector(removeView:)];
    [UIView commitAnimations];
}

- (void)removeView:(UIImageView *)view{
    [view removeFromSuperview];
    FINISHED1
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

- (void)insertLabelToParentView:(UIView *)parentView Text:(NSString *)text Rectangle:(CGRect)rect Touch:(BOOL)touch{
    UILabel *label = [[UILabel alloc] init];
    label.frame = rect;
    label.text  = text;
    label.tag = [app.cardList_cardName indexOfObject:text];
    label.font = [UIFont fontWithName:@"Tanuki-Permanent-Marker" size:12.0f];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [parentView addSubview:label];
    if(touch){
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detailOfACardForInsertLabelToParentView:)]];
    }
}

- (void)detailOfACard:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.myHand objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACard_MyField:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.myFieldCard objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACard_EnemyField:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.enemyFieldCard objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACard_MyTomb:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.myTomb objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACard_EnemyTomb:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.enemyTomb objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACard_MyDeckCardList:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.myDeckCardList objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACard_EnemyDeckCardList:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.enemyDeckCardList objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACard_EnemyHand:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", [[app.enemyHand objectAtIndex:(sender.view.tag - 1)] intValue]]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)detailOfACardForInsertLabelToParentView:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG", (int)sender.view.tag]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)removeDetailOfACard{
    [detailOfACard removeFromSuperview];
    _allImageView.userInteractionEnabled = YES;
}


-(void)okButtonPushed{
    AudioServicesPlaySystemSound (app.tapSoundID);
    if (app.mySelectCharacter == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"キャラクター未選択" message:@"キャラクターが選ばれていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"キャラクターを選択する", nil];
        [alert show];
    }else{
        [SVProgressHUD showWithStatus:@"相手の選択を待機中..." maskType:SVProgressHUDMaskTypeGradient];
        cardIsCompletlyUsed = YES;
        
        //プロローグの１ターン目では、OKボタンが押された時に矢印を消す必要がある。
        [app.arrow removeFromSuperview];
        FINISHED1
    }
    
    
}

- (void)battleStart{
    //メインBGMの開始
    [app.audio stop];
 NSString* path = [[NSBundle mainBundle]
                       pathForResource:@"battlegamen_nc29204" ofType:@"mp3"];
     NSURL* url = [NSURL fileURLWithPath:path];
     app.audio = [[AVAudioPlayer alloc]
               initWithContentsOfURL:url error:nil];
     app.audio.numberOfLoops = -1;
    app.audio.volume = 0.5f;
     [app.audio play];
    
    //MARK: ↓↓↓↓↓↓↓↓↓↓デバッグ用。終わったら元に戻す↓↓↓↓↓↓↓↓↓↓
//    app.enemyNickName = @"秋乃のiPhone4S";
//    app.enemyPlayerID = 221887815;
//    NSLog(@"ニックネーム：%@    プレイヤーID：%d",app.enemyNickName,app.enemyPlayerID);
//    SendDataToServer *sendData = [[SendDataToServer alloc] init];
//    [sendData send];
    //MARK: ↑↑↑↑↑↑↑↑↑↑デバッグ用。終わったら元に戻す↑↑↑↑↑↑↑↑↑↑
    
    //相手と自分の名前を表示する
    _myNickNameLabel.text = [NSString stringWithFormat:@"%@",app.myNickName];
    _enemyNickNameLabel.text = [NSString stringWithFormat:@"%@",app.enemyNickName];
    
    UIFont *font = [UIFont fontWithName:@"Tanuki-Permanent-Marker" size:12];
    _myNickNameLabel.font = font;
    _enemyNickNameLabel.font = font;

    
    [_myNickNameLabel sizeToFit];
    [_enemyNickNameLabel sizeToFit];
    
    
    if([YSDeviceHelper is568h]){
        _myNickNameLabel.frame = CGRectMake(20, _myNickNameLabel.superview.bounds.size.height - 180, _myNickNameLabel.bounds.size.width, 20);
        _enemyNickNameLabel.frame = CGRectMake(_enemyNickNameLabel.superview.bounds.size.width - _enemyNickNameLabel.bounds.size.width - 20, 160, _enemyNickNameLabel.bounds.size.width, 20);
    }else{
        _myNickNameLabel.frame = CGRectMake(20, _myNickNameLabel.superview.bounds.size.height - 180, _myNickNameLabel.bounds.size.width, 20);
        _enemyNickNameLabel.frame = CGRectMake(_enemyNickNameLabel.superview.bounds.size.width - _enemyNickNameLabel.bounds.size.width - 20, 160, _enemyNickNameLabel.bounds.size.width, 20);
    }
    
    //メインビューに戻るボタン・ローカル対戦ボタン・インターネット対戦ボタン・対戦開始時の黒半透明背景を外す
    
    [_returnToMainViewButton removeFromSuperview];
    
    if([YSDeviceHelper is568h]){
        //自分
        
        while (myDrawCount < 5) {
            //手札のカード画像を用意する
            UIImage *myCard = [UIImage imageNamed:@"backOfACard_small.png"];
            _myCard = [[UIImageView alloc] initWithImage:myCard];
            [_myCardImageViewArray addObject:_myCard];
            [_myCardImageView addSubview:_myCard];
            _myCard.userInteractionEnabled = YES;
            [_myCard addGestureRecognizer:
             [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(touchAction:)]];
            
            //手札を用意するアニメーション
            [UIView beginAnimations:nil context:nil];
            //移動前
            _myCard.frame = CGRectMake(_myCard.superview.bounds.size.width *2, 0, CARDWIDTH, CARDHEIGHT);
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDelay:0.1];
            [UIView setAnimationDuration:0.1];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            //移動後
            _myCard.frame = CGRectMake(10 + (CARDWIDTH +8) * myDrawCount, 0, CARDWIDTH, CARDHEIGHT);
            [UIView commitAnimations];
            
            
            //引いたカードの数をプラスする
            myDrawCount++;
            _myCard.tag = myDrawCount; // タグ番号=myDrawCountとなっていることに注意する！
            //手札が5枚になるまで繰り返す
            
        }
        
        for (int i = 0; i < 5; i++) {
            //手札に入れたカードを、山札の配列から手札の配列に入れておく
            [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
        }
        
        //デッキのカード画像を用意する
        UIImage *deck = [UIImage imageNamed:@"backOfACard_small.png"];
        _myLibrary = [[UIImageView alloc] initWithImage:deck];
        [_allImageView addSubview:_myLibrary];
        //山札を用意するアニメーション
        [UIView beginAnimations:nil context:nil];
        //移動前
        _myLibrary.frame = CGRectMake(_myLibrary.superview.bounds.size.width - deck.size.width - 10, _myLibrary.superview.bounds.size.height + 100, deck.size.width, deck.size.height);
        //移動後
        _myLibrary.frame = CGRectMake(_myLibrary.superview.bounds.size.width - CARDWIDTH - 10, _myLibrary.superview.bounds.size.height - CARDHEIGHT - 70, CARDWIDTH, CARDHEIGHT);
        [UIView commitAnimations];
        
        //デッキの残枚数を表示
        _myLibraryCount = [[UITextView alloc] init];
        _myLibraryCount.frame = CGRectMake(0, 12, 34, 30);
        _myLibraryCount.textAlignment = NSTextAlignmentCenter;
        _myLibraryCount.editable = NO;
        [PenetrateFilter penetrate:_myLibraryCount];
        _myLibraryCount.text = [NSString stringWithFormat:@"%d", [app.myDeckCardList count]];
        [_myLibrary addSubview:_myLibraryCount];
        
        
        //相手
        
        while (enemyDrawCount < 5) {
            //手札のカード画像を用意する
            UIImage *enemyCard = [UIImage imageNamed:@"backOfACard_small.png"];
            _enemyCard = [[UIImageView alloc] initWithImage:enemyCard];
            [_enemyCardImageViewArray addObject:_enemyCard];
            [_enemyCardImageView addSubview:_enemyCard];
            _enemyCard.userInteractionEnabled = NO;
            
            //手札を用意するアニメーション
            [UIView beginAnimations:nil context:nil];
            //移動前
            _enemyCard.frame = CGRectMake(_enemyCard.superview.bounds.size.width * -2, 0, CARDWIDTH, CARDHEIGHT);
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDelay:0.1];
            [UIView setAnimationDuration:0.1];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            //移動後
            _enemyCard.frame = CGRectMake(_enemyCard.superview.bounds.size.width - 50 - ((CARDWIDTH +8) * enemyDrawCount), 0, CARDWIDTH, CARDHEIGHT);
            [UIView commitAnimations];
            
            
            //引いたカードの数をプラスする
            enemyDrawCount++;
            _enemyCard.tag = enemyDrawCount; // タグ番号=enemyDrawCountとなっていることに注意する！
            //手札が5枚になるまで繰り返す
            
        }
        
        for (int i = 0; i < 5; i++) {
            
            //初回起動なら相手のデッキを適当に仮で作成する（実際には使用しない）
            if (first == 0) {
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], nil];
            }
            
            //手札に入れたカードを、山札の配列から手札の配列に入れておく
            [self setCardFromXTOY:app.enemyDeckCardList cardNumber:0 toField:app.enemyHand];
        }
        
        //デッキのカード画像を用意する
        UIImage *enemydeck = [UIImage imageNamed:@"backOfACard_small.png"];
        _enemyLibrary = [[UIImageView alloc] initWithImage:enemydeck];
        [_allImageView addSubview:_enemyLibrary];
        //山札を用意するアニメーション
        [UIView beginAnimations:nil context:nil];
        //移動前
        _enemyLibrary.frame = CGRectMake(10, -100, deck.size.width, deck.size.height);
        //移動後
        _enemyLibrary.frame = CGRectMake(10, 70, CARDWIDTH, CARDHEIGHT);
        [UIView commitAnimations];
        
        //デッキの残枚数を表示
        _enemyLibraryCount = [[UITextView alloc] init];
        _enemyLibraryCount.frame = CGRectMake(0, 12, 34, 30);
        _enemyLibraryCount.textAlignment = NSTextAlignmentCenter;
        _enemyLibraryCount.editable = NO;
        [PenetrateFilter penetrate:_enemyLibraryCount];
        _enemyLibraryCount.text = [NSString stringWithFormat:@"%d", [app.enemyDeckCardList count]];
        [_enemyLibrary addSubview:_enemyLibraryCount];
        
        [self nextTurn];
    }else{
        //自分
        
        while (myDrawCount < 5) {
            //手札のカード画像を用意する
            UIImage *myCard = [UIImage imageNamed:@"backOfACard_small.png"];
            _myCard = [[UIImageView alloc] initWithImage:myCard];
            [_myCardImageViewArray addObject:_myCard];
            [_myCardImageView addSubview:_myCard];
            _myCard.userInteractionEnabled = YES;
            [_myCard addGestureRecognizer:
             [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(touchAction:)]];
            
            //手札を用意するアニメーション
            [UIView beginAnimations:nil context:nil];
            //移動前
            _myCard.frame = CGRectMake(_myCard.superview.bounds.size.width *2, 0, CARDWIDTH, CARDHEIGHT);
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDelay:0.1];
            [UIView setAnimationDuration:0.1];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            //移動後
            _myCard.frame = CGRectMake(10 + (CARDWIDTH +8) * myDrawCount, 0, CARDWIDTH, CARDHEIGHT);
            [UIView commitAnimations];
            
            
            //引いたカードの数をプラスする
            myDrawCount++;
            _myCard.tag = myDrawCount; // タグ番号=myDrawCountとなっていることに注意する！
            //手札が5枚になるまで繰り返す
            
        }
        
        for (int i = 0; i < 5; i++) {
            //手札に入れたカードを、山札の配列から手札の配列に入れておく
            [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
        }
        
        //デッキのカード画像を用意する
        UIImage *deck = [UIImage imageNamed:@"backOfACard_small.png"];
        _myLibrary = [[UIImageView alloc] initWithImage:deck];
        [_allImageView addSubview:_myLibrary];
        //山札を用意するアニメーション
        [UIView beginAnimations:nil context:nil];
        //移動前
        _myLibrary.frame = CGRectMake(_myLibrary.superview.bounds.size.width - deck.size.width - 10, _myLibrary.superview.bounds.size.height + 100, deck.size.width, deck.size.height);
        //移動後
        _myLibrary.frame = CGRectMake(_myLibrary.superview.bounds.size.width - CARDWIDTH - 10, _myLibrary.superview.bounds.size.height - CARDHEIGHT - 70, CARDWIDTH, CARDHEIGHT);
        [UIView commitAnimations];
        
        //デッキの残枚数を表示
        _myLibraryCount = [[UITextView alloc] init];
        _myLibraryCount.frame = CGRectMake(5, 10, 30, 40);
        _myLibraryCount.textAlignment = NSTextAlignmentCenter;
        _myLibraryCount.editable = NO;
        [PenetrateFilter penetrate:_myLibraryCount];
        _myLibraryCount.text = [NSString stringWithFormat:@"%d", [app.myDeckCardList count]];
        [_myLibrary addSubview:_myLibraryCount];
        
        
        //相手
        while (enemyDrawCount < 5) {
            //手札のカード画像を用意する
            UIImage *enemyCard = [UIImage imageNamed:@"backOfACard_small.png"];
            _enemyCard = [[UIImageView alloc] initWithImage:enemyCard];
            [_enemyCardImageViewArray addObject:_enemyCard];
            [_enemyCardImageView addSubview:_enemyCard];
            _enemyCard.userInteractionEnabled = NO;
            
            //手札を用意するアニメーション
            [UIView beginAnimations:nil context:nil];
            //移動前
            _enemyCard.frame = CGRectMake(_enemyCard.superview.bounds.size.width * -2, 0, CARDWIDTH, CARDHEIGHT);
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDelay:0.1];
            [UIView setAnimationDuration:0.1];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            //移動後
            _enemyCard.frame = CGRectMake(_enemyCard.superview.bounds.size.width - 50 - ((CARDWIDTH +8) * enemyDrawCount), 0, CARDWIDTH, CARDHEIGHT);
            [UIView commitAnimations];
            
            
            //引いたカードの数をプラスする
            enemyDrawCount++;
            _enemyCard.tag = enemyDrawCount; // タグ番号=enemyDrawCountとなっていることに注意する！
            //手札が5枚になるまで繰り返す
            
        }
        
        for (int i = 0; i < 5; i++) {
            
            //初回起動なら相手のデッキを適当に仮で作成する（実際には使用しない）
            if (first == 0) {
                app.enemyDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], [NSNumber numberWithInt:99], nil];
            }
            
            //手札に入れたカードを、山札の配列から手札の配列に入れておく
            [self setCardFromXTOY:app.enemyDeckCardList cardNumber:0 toField:app.enemyHand];
        }
        
        for (int i = 0; i < 5; i++) {
            //手札に入れたカードを、山札の配列から手札の配列に入れておく
            [self setCardFromXTOY:app.enemyDeckCardList cardNumber:0 toField:app.enemyHand];
        }
        
        //デッキのカード画像を用意する
        UIImage *enemydeck = [UIImage imageNamed:@"backOfACard_small.png"];
        _enemyLibrary = [[UIImageView alloc] initWithImage:enemydeck];
        [_allImageView addSubview:_enemyLibrary];
        //山札を用意するアニメーション
        [UIView beginAnimations:nil context:nil];
        //移動前
        _enemyLibrary.frame = CGRectMake(10, -100, deck.size.width, deck.size.height);
        //移動後
        _enemyLibrary.frame = CGRectMake(10, _enemyLibrary.superview.bounds.size.height - CARDHEIGHT - 360, CARDWIDTH, CARDHEIGHT);
        [UIView commitAnimations];
        
        //デッキの残枚数を表示
        _enemyLibraryCount = [[UITextView alloc] init];
        _enemyLibraryCount.frame = CGRectMake(5, 10, 30, 40);
        _enemyLibraryCount.textAlignment = NSTextAlignmentCenter;
        _enemyLibraryCount.editable = NO;
        [PenetrateFilter penetrate:_enemyLibraryCount];
        _enemyLibraryCount.text = [NSString stringWithFormat:@"%d", [app.enemyDeckCardList count]];
        [_enemyLibrary addSubview:_enemyLibraryCount];
        
        [self nextTurn];
    }

}

- (void)battleStartForLocalBattle{
    //BGM鳴らす
    AudioServicesPlaySystemSound (app.tapSoundID);
    
    //どのデッキを使用するかを選択する
    [_returnToMainViewButton removeFromSuperview];
    [_localBattleButton removeFromSuperview];
    [_internetBattleButton removeFromSuperview];
    [_blackBack removeFromSuperview];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _usingDeckCardListForLocalBattle = [[UIAlertView alloc] initWithTitle:@"デッキ選択" message:@"使用するデッキを選んでください" delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@", [ud stringForKey:@"deckName1"]], [NSString stringWithFormat:@"%@", [ud stringForKey:@"deckName2"]], [NSString stringWithFormat:@"%@", [ud stringForKey:@"deckName3"]], nil];
    [_usingDeckCardListForLocalBattle show];
    [self sync];
    
    _battleStartView = [[UIAlertView alloc] initWithTitle:@"戦闘開始" message:@"戦闘開始ボタンを押した後、相手プレイヤーと端末をぶつけてください！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始", nil];
    [_battleStartView show];
    [self sync]; //DeviceMotion.mの - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndexのif(alertView == _isAEnemyNameForLocalBattle)の[self.delegate syncFinished];でsyncを解除しています。
    [getEnemyData doEnemyDecideActionRoopVersion:NO]; //対戦相手を見つける過程で、app.decideActionがYESになるため、デフォルトのNOに戻しておく
    [self battleStart];
}

- (void)touchAction :(UITapGestureRecognizer *)sender{
    AudioServicesPlaySystemSound (app.tapSoundID);
    [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(handTouched:) longtapSelector:@selector(detailOfACard:) string:nil];
}

- (void)handTouched :(UITapGestureRecognizer *)sender{
    AudioServicesPlaySystemSound (app.tapSoundID);
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    cardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue];
    cardType = [[app.cardList_type objectAtIndex:cardNumber] intValue];
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
    
    if([regionViewArray indexOfObject:sender.view] == NSNotFound){
        NSLog(@"手札内にカードが見つかりません");
    }else{
        NSLog(@"現在選んでいるカードは、手札の左から数えて%d番目", selectedCardOrder + 1);
    }
    NSLog(@"-----------------------------------");
    
    if (cardType == SORCERYCARD){
        if(![self doIHaveEnergyToUseCard:cardNumber]){

        }
        else{
            [_border_middleCard removeFromSuperview];
            [_regionView addSubview:_border_middleCard];
            _border_middleCard.frame = sender.view.frame;
            
            _doIUseSorcerycard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"ソーサリーカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseSorcerycard show];
            [self sync];
            //このターン、カードを使用していれば、効果を発動する
            if(doIUseCardInThisTurn == YES){
                //使用したエネルギーを使用済みエネルギーとして把握する
                [self selectUsingEnergy:selectedCardOrder];
                [self sync];
                
                
                //エネルギーを増やすカードの場合は、すぐに効果を発動させる。それ以外はAA・カード選択フェーズの後に効果を発動させる
                if(cardNumber == 96){
                    [self cardActivate:cardNumber string:nil];
                }
                [self setCardToCardsIUsedInThisTurn:app.myHand cardNumber:selectedCardOrder];
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
                [self refleshHandsAndLibraries];
                doIUseCardInThisTurn = NO;
                [self refleshView];
            }
        }
    }
    
    //フィールドカードの場合の実装
    else if (cardType == FIELDCARD){
        if(![self doIHaveEnergyToUseCard:cardNumber]){

        }
        else{
            [_border_middleCard removeFromSuperview];
            [_regionView addSubview:_border_middleCard];
            _border_middleCard.frame = sender.view.frame;
            
            
            _doIUseFieldcard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"フィールドカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseFieldcard show];
            [self sync];
            if(doIUseCardInThisTurn == YES){
                //使用したエネルギーを使用済みエネルギーとして把握する
                [self selectUsingEnergy:selectedCardOrder];
                [self sync];
                
                [self setCardToCardsIUsedInThisTurn:app.myHand cardNumber:selectedCardOrder];
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myFieldCard];
                [self refleshHandsAndLibraries];
                doIUseCardInThisTurn = NO;
                [self refleshView];

            }
        }
    }
    
    //エネルギーカードの場合の実装
    else if (cardType == ENERGYCARD){
        
            [_border_middleCard removeFromSuperview];
            [_regionView addSubview:_border_middleCard];
            _border_middleCard.frame = sender.view.frame;
            
            
            _doIUseEnergycard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"エネルギーカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseEnergycard show];
    }
}

- (void)myTombTouched :(UITapGestureRecognizer *)sender{
    AudioServicesPlaySystemSound (app.tapSoundID);
    [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(nullSelector:) longtapSelector:@selector(detailOfACard_MyTomb:) string:nil];
}

- (void)enemyTombTouched :(UITapGestureRecognizer *)sender{
    AudioServicesPlaySystemSound (app.tapSoundID);
    [self browseCardsInRegion:app.enemyTomb touchCard:YES tapSelector:@selector(nullSelector:) longtapSelector:@selector(detailOfACard_EnemyTomb:) string:nil];
}

- (void)myFieldTouched :(UITapGestureRecognizer *)sender{
    AudioServicesPlaySystemSound (app.tapSoundID);
    [self browseCardsInRegion:app.myFieldCard touchCard:YES tapSelector:@selector(nullSelector:) longtapSelector:@selector(detailOfACard_MyField:) string:nil];
}

- (void)enemyFieldTouched :(UITapGestureRecognizer *)sender{
    AudioServicesPlaySystemSound (app.tapSoundID);
    [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(nullSelector:) longtapSelector:@selector(detailOfACard_EnemyField:) string:nil];
}

- (void)goodGameButtonTouched{
    AudioServicesPlaySystemSound (app.tapSoundID);
    _goodGameAlert = [[UIAlertView alloc] initWithTitle:@"降参しますか" message:@"降参する場合は、「降参する」ボタンを押した後にゲームを進めてください。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"降参する",@"降参しない", nil];
    [_goodGameAlert show];
}


- (void)refleshHandsAndLibraries{
    //自分の手札の更新
    int myHandCount = (int)[app.myHand count];
    if(myHandCount <= 5){
        [_myCardImageView removeFromSuperview];
        for (UIView *view in [_myCardImageView subviews]) {
            [view removeFromSuperview];
        }
        
        for (int i = 0; i < [app.myHand count]; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backOfACard_small.png"]];
            [_myCardImageView addSubview:imgView];
            imgView.frame = CGRectMake(10 + i * (CARDWIDTH + 5), 0, CARDWIDTH, CARDHEIGHT);
            imgView.userInteractionEnabled = YES;
            [imgView addGestureRecognizer:
             [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(touchAction:)]];
        }
        
        [_allImageView addSubview:_myCardImageView];
    }else{
        [_myCardImageView removeFromSuperview];
        for (UIView *view in [_myCardImageView subviews]) {
            [view removeFromSuperview];
        }
        
        for (int i = 0; i < 5; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backOfACard_small.png"]];
            [_myCardImageView addSubview:imgView];
            imgView.frame = CGRectMake(10 + i * (CARDWIDTH + 5), 0, CARDWIDTH, CARDHEIGHT);
            imgView.userInteractionEnabled = YES;
            [imgView addGestureRecognizer:
             [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(touchAction:)]];
        }
        [_allImageView addSubview:_myCardImageView];
        
        UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(10 + 5 * (CARDWIDTH + 5), 5, 40, CARDHEIGHT)];
        [_myCardImageView addSubview:txtView];
        txtView.editable = NO;
        txtView.text = [NSString stringWithFormat:@" × %d",myHandCount];
        [PenetrateFilter penetrate:txtView];
    }
    
    //自分の山札の更新
    _myLibraryCount.text = [NSString stringWithFormat:@"%d",(int)[app.myDeckCardList count]];
    
    
    //相手の手札の更新
    int enemyHandCount = (int)[app.enemyHand count];
    NSLog(@"enemyHandCount:%d",enemyHandCount);
    if(enemyHandCount <= 5){
        [_enemyCardImageView removeFromSuperview];
        for (UIView *view in [_enemyCardImageView subviews]) {
            [view removeFromSuperview];
        }
        
        for (int i = 0; i < [app.enemyHand count]; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backOfACard_small.png"]];
            [_enemyCardImageView addSubview:imgView];
            imgView.frame = CGRectMake(imgView.superview.bounds.size.width - 50 - ((CARDWIDTH +8) * i), 0, CARDWIDTH, CARDHEIGHT);
        }
        
        [_allImageView addSubview:_enemyCardImageView];
    }else{
        [_enemyCardImageView removeFromSuperview];
        for (UIView *view in [_enemyCardImageView subviews]) {
            [view removeFromSuperview];
        }
        
        for (int i = 0; i < 5; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backOfACard_small.png"]];
            [_enemyCardImageView addSubview:imgView];
            imgView.frame = CGRectMake(imgView.superview.bounds.size.width - 50 - ((CARDWIDTH +8) * i), 0, CARDWIDTH, CARDHEIGHT);
        }
        [_allImageView addSubview:_enemyCardImageView];
        
        UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(60, 5, 40, CARDHEIGHT)];
//        [PenetrateFilter penetrate:txtView];
        [_enemyCardImageView addSubview:txtView];
        txtView.editable = NO;
        txtView.text = [NSString stringWithFormat:@" × %d",enemyHandCount];
        [PenetrateFilter penetrate:txtView];
    }
    
    //相手の山札の更新
    _enemyLibraryCount.text = [NSString stringWithFormat:@"%d",(int)[app.enemyDeckCardList count]];
}





/*----------------------------------------------------------------------------------------*/


//対象プレイヤーのXという領域のカードを見る（場・エネルギー置き場・手札）
-(int)browseCardsInRegion :(NSMutableArray *)cards touchCard:(BOOL)touchCard tapSelector:(SEL)selector longtapSelector:(SEL)longTapSelector string:(NSString *)string{
    AudioServicesPlaySystemSound (app.tapSoundID);
    NSLog(@"%@",cards);
    [self forbidTouchAction];
    _cardInRegion = [[UIScrollView alloc] init];
    _cardInRegion.delegate = self;
    _cardInRegion.userInteractionEnabled = YES;
    
    [regionViewArray removeAllObjects];
    for (int i = 0; i < [_cardInRegion.subviews count]; i++) {
        [[_cardInRegion.subviews objectAtIndex:i] removeFromSuperview];
    }
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fadeinImage"]];
    _imgView.userInteractionEnabled = YES;
    [_imgView addSubview:_cardInRegion];
    _imgView.frame = CGRectMake(20, 20, 280 , 440);
    
    if(touchCard){
        
        for (UIView *view in [_regionView subviews]) {
            [view removeFromSuperview];
        }
        _regionView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280 , 90 + [cards count] * (BIGCARDHEIGHT + 10))];
        [PenetrateFilter penetrate:_regionView];
        _regionView.userInteractionEnabled = YES;
        
        for (int i = 0; i < [cards count]; i++) {
            UIImageView *cardImage = [[UIImageView alloc] init];
            cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG",[[cards objectAtIndex:i] intValue]]];
            [_regionView addSubview:cardImage];
            [regionViewArray addObject:cardImage];
            cardImage.frame = CGRectMake(10, 60 + (BIGCARDHEIGHT) * i + (i  * 5), BIGCARDWIDTH, BIGCARDHEIGHT);
            cardImage.userInteractionEnabled = YES;
            cardImage.tag = i + 1;
            [cardImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:selector]];
            [cardImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:longTapSelector]];
        }
        
        
        _cardInRegion.frame = CGRectMake(20, 20, 280 , 440);
        [_cardInRegion addSubview:_backGroundView];
        [_cardInRegion addSubview:_regionView];
        _cardInRegion.contentSize = CGSizeMake(280 ,90 + [cards count] * (BIGCARDHEIGHT + 10) + 40);
        _cardInRegion.contentOffset = CGPointMake(0, 0);
        
        
        UITextView *title = [[UITextView alloc] init];
        [PenetrateFilter penetrate:title];
        [_cardInRegion addSubview: title];
        title.text = string;
        title.editable = NO;
        title.frame = CGRectMake(0, 10, title.superview.bounds.size.width, 50);
        title.textAlignment = NSTextAlignmentCenter;
        
        [self createCancelButton:CGRectMake(_regionView.bounds.size.width / 2 - 35, _regionView.bounds.size.height - 60, 50, 50) parentView:_cardInRegion tag:4];
        [_allImageView addSubview:_imgView];
        
    }else{
        for (UIView *view in [_regionView subviews]) {
            [view removeFromSuperview];
        }
        _regionView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280 , 90 + [cards count] * (BIGCARDHEIGHT + 10))];
        [PenetrateFilter penetrate:_regionView];
        _regionView.userInteractionEnabled = YES;
        
        for (int i = 0; i < [cards count]; i++) {
            UIImageView *cardImage = [[UIImageView alloc] init];
            cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG",[[cards objectAtIndex:i] intValue]]];
            [_regionView addSubview:cardImage];
            [regionViewArray addObject:cardImage];
            cardImage.frame = CGRectMake(10, 10 + (BIGCARDHEIGHT) * i + (i  * 5), BIGCARDWIDTH, BIGCARDHEIGHT);
            cardImage.userInteractionEnabled = NO;
            cardImage.tag = i + 1;
        }
        _cardInRegion.frame = CGRectMake(20, 20, 280 , 440);
        [_cardInRegion addSubview:_regionView];
        _cardInRegion.contentSize = CGSizeMake(280 ,90 + [cards count] * (BIGCARDHEIGHT + 10) + 40);
        _cardInRegion.contentOffset = CGPointMake(0, 0);
        
        
        UITextView *title = [[UITextView alloc] init];
        [PenetrateFilter penetrate:title];
        [_cardInRegion addSubview: title];
        title.text = string;
        title.editable = NO;
        title.frame = CGRectMake(0, 10, title.superview.bounds.size.width, 30);
        title.textAlignment = NSTextAlignmentCenter;
        
        [self createCancelButton:CGRectMake(_regionView.bounds.size.width / 2 - 35, _regionView.bounds.size.height - 60, 50, 50) parentView:_cardInRegion tag:4];
        [_allImageView addSubview:_imgView];
        
        
    }
    
    //初回起動ならプロローグを表示する
    if (first == 0) {
        switch (turnCount) {
            case 2:
                if([cards isEqualToArray:app.myHand]){
                    UIImageView *imageView1 = (UIImageView *)[_regionView viewWithTag:1]; //手札の1枚目のカード
                    UIImageView *imageView2 = (UIImageView *)[_regionView viewWithTag:2]; //手札の2枚目のカード
                    UIImageView *imageView3 = (UIImageView *)[_regionView viewWithTag:3]; //手札の3枚目のカード
                    UIImageView *imageView4 = (UIImageView *)[_regionView viewWithTag:4]; //手札の4枚目のカード
                    UIImageView *imageView5 = (UIImageView *)[_regionView viewWithTag:5]; //手札の5枚目のカード
                    [app.arrow removeFromSuperview];
                    
                    //左矢印を表示。startAnimation038でリムーブしている。
                    app.arrowR.left = imageView1.right;
                    app.arrowR.top  = (imageView1.bottom - imageView1.top) / 2;
                    [_regionView addSubview:app.arrowR];
                    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:imageView2, imageView3, imageView4, imageView5, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _cancelButton, nil] coveredView:self.view];
                    [self startAnimation037_2];
                }
                break;
            case 3:
                if([cards isEqualToArray:app.myHand]){
                    UIImageView *imageView1 = (UIImageView *)[_regionView viewWithTag:1]; //手札の1枚目のカード
                    UIImageView *imageView2 = (UIImageView *)[_regionView viewWithTag:2]; //手札の2枚目のカード
                    UIImageView *imageView3 = (UIImageView *)[_regionView viewWithTag:3]; //手札の3枚目のカード
                    UIImageView *imageView4 = (UIImageView *)[_regionView viewWithTag:4]; //手札の4枚目のカード
                    UIImageView *imageView5 = (UIImageView *)[_regionView viewWithTag:5]; //手札の5枚目のカード
                    //左矢印を表示。エネルギーを使用した段階(alertViewのdoIUseEnergyCardの黒エネルギー使用実装部分)と、オプーナのカードの使用段階（startAnimation046_3）でリムーブしている。
                    app.arrowR.left = imageView1.right;
                    app.arrowR.top   = (imageView1.bottom - imageView1.top) / 2;
                    [_regionView addSubview:app.arrowR];
                    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:imageView2, imageView3, imageView4, imageView5, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _cancelButton, nil] coveredView:self.view];
                }
                break;
            case 4:
                if([cards isEqualToArray:app.myHand]){
                    UIImageView *imageView1 = (UIImageView *)[_regionView viewWithTag:1]; //手札の1枚目のカード
                    UIImageView *imageView2 = (UIImageView *)[_regionView viewWithTag:2]; //手札の3枚目のカード
                    UIImageView *imageView3 = (UIImageView *)[_regionView viewWithTag:3]; //手札の3枚目のカード
                    UIImageView *imageView4 = (UIImageView *)[_regionView viewWithTag:4]; //手札の4枚目のカード
                    //左矢印を表示。エネルギーを使用した段階(alertViewのdoIUseEnergyCardの緑エネルギー使用実装部分)と、サッカー日本代表のカードの使用後(selectUsingEnergy)でリムーブしている。
                    app.arrowR.left = imageView1.right;
                    app.arrowR.top   = (imageView1.bottom - imageView1.top) / 2;
                    [_regionView addSubview:app.arrowR];
                    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:imageView2, imageView3, imageView4, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _cancelButton, nil] coveredView:self.view];
                }
                break;
            case 5:
                if([cards isEqualToArray:app.myTomb]){
                    [self startAnimation058];
                    turn5Boti = YES;
                }else if ([cards isEqualToArray:app.myFieldCard]){
                    [self startAnimation059_2];
                    turn5Ba   = YES;
                }else if ([cards isEqualToArray:app.myHand]){
                    UIImageView *imageView1 = (UIImageView *)[_regionView viewWithTag:1]; //手札の1枚目のカード
                    UIImageView *imageView2 = (UIImageView *)[_regionView viewWithTag:2]; //手札の3枚目のカード
                    UIImageView *imageView3 = (UIImageView *)[_regionView viewWithTag:3]; //手札の3枚目のカード
                    UIImageView *imageView4 = (UIImageView *)[_regionView viewWithTag:4]; //手札の4枚目のカード
                    //左矢印を表示。エネルギーを使用した段階(alertViewのdoIUseEnergyCardの緑エネルギー使用実装部分)でリムーブしている。
                    app.arrowR.left = imageView1.right;
                    app.arrowR.top   = (imageView1.bottom - imageView1.top) / 2;
                    [_regionView addSubview:app.arrowR];
                    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:imageView2,imageView3, imageView4, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _cancelButton, nil] coveredView:self.view];
                }
                break;
            case 6:
                if ([cards isEqualToArray:app.myHand]){
                    if([app.myHand count] == 5){
                        UIImageView *imageView1 = (UIImageView *)[_regionView viewWithTag:1]; //手札の1枚目のカード
                        UIImageView *imageView2 = (UIImageView *)[_regionView viewWithTag:2]; //手札の3枚目のカード
                        UIImageView *imageView3 = (UIImageView *)[_regionView viewWithTag:3]; //手札の3枚目のカード
                        UIImageView *imageView4 = (UIImageView *)[_regionView viewWithTag:4]; //手札の4枚目のカード
                        UIImageView *imageView5 = (UIImageView *)[_regionView viewWithTag:5]; //手札の5枚目のカード
                        //左矢印を表示。エネルギーを使用した段階(alertViewのdoIUseEnergyCardの緑エネルギー使用実装部分)でリムーブしている。
                        app.arrowR.left = imageView1.right;
                        app.arrowR.top   = (imageView1.bottom - imageView1.top) / 2;
                        [_regionView addSubview:app.arrowR];
                        [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:imageView2,imageView3, imageView4, imageView5, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _cancelButton, nil] coveredView:self.view];
                    }else if([app.myHand count] == 4){
                        UIImageView *imageView1 = (UIImageView *)[_regionView viewWithTag:1]; //手札の1枚目のカード
                        UIImageView *imageView2 = (UIImageView *)[_regionView viewWithTag:2]; //手札の3枚目のカード
                        UIImageView *imageView3 = (UIImageView *)[_regionView viewWithTag:3]; //手札の3枚目のカード
                        UIImageView *imageView4 = (UIImageView *)[_regionView viewWithTag:4]; //手札の4枚目のカード
                        //左矢印を表示。「一羽でチュン」のカードの使用後(selectUsingEnergy)にリムーブしている。
                        app.arrowR.left = imageView1.right;
                        app.arrowR.top   = (imageView1.bottom - imageView1.top) / 2;
                        [_regionView addSubview:app.arrowR];
                        [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:imageView2,imageView3, imageView4, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _cancelButton, nil] coveredView:self.view];
                    }
                }
                break;
            default:
                break;
        }
    }
    
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
            app.enemyGikoModifyingAttackPowerByMyself += x;
        }else if (character == MONAR){
            app.enemyMonarModifyingAttackPowerByMyself += x;
        }else if (character == SYOBON){
            app.enemySyobonModifyingAttackPowerByMyself += x;
        }else if (character == YARUO){
            app.enemyYaruoModifyingAttackPowerByMyself += x;
        }
    }else{
        if(character == GIKO){
            app.enemyGikoFundamentalAttackPowerByMyself += x;
        }else if (character == MONAR){
            app.enemyMonarFundamentalAttackPowerByMyself += x;
        }else if (character == SYOBON){
            app.enemySyobonFundamentalAttackPowerByMyself += x;
        }else if (character == YARUO){
            app.enemyYaruoFundamentalAttackPowerByMyself += x;
        }
    }
}

//相手の対象キャラの防御力を操作する（対象キャラの防御力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)enemyDeffencePowerOperate:(int)character point:(int)x temporary:(BOOL)temporary{
    if(temporary == YES){
        if(character == GIKO){
            app.enemyGikoModifyingDeffencePowerByMyself += x;
        }else if (character == MONAR){
            app.enemyMonarModifyingDeffencePowerByMyself += x;
        }else if (character == SYOBON){
            app.enemySyobonModifyingDeffencePowerByMyself += x;
        }else if (character == YARUO){
            app.enemyYaruoModifyingDeffencePowerByMyself += x;
        }
    }else{
        if(character == GIKO){
            app.enemyGikoFundamentalDeffencePowerByMyself += x;
        }else if (character == MONAR){
            app.enemyMonarFundamentalDeffencePowerByMyself += x;
        }else if (character == SYOBON){
            app.enemySyobonFundamentalDeffencePowerByMyself += x;
        }else if (character == YARUO){
            app.enemyYaruoFundamentalDeffencePowerByMyself += x;
        }
    }
}


//対象プレイヤーのHPを操作する（対象プレイヤーのHPを管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(int)HPOperate :(int)lifeGage point:(int)x{
    lifeGage += x;
    return lifeGage;
}

//カードの色を判断する（カードナンバー）
-(int)distinguishCardColor :(int)cardNum{
    int colorNumber = 0;
    colorNumber = [[app.cardList_color objectAtIndex:cardNum] intValue];
    return colorNumber;
}

//対象プレイヤーは1枚カードを引く（対象プレイヤー（０なら自分、１なら相手）
- (void)getACard :(int)man{
    if(man == 0){
        if([app.myDeckCardList count] > 0){
                //        //手札の画像を用意する
                //        UIImage *card = [UIImage imageNamed:[app.cardList_pngName objectAtIndex:[[app.myDeckCardList objectAtIndex:0] intValue]]];
                //        _myGetCard = [[UIImageView alloc] initWithImage:card];
                //        [_myCardImageViewArray addObject:_myGetCard];
                //        [_myCardImageView addSubview:_myGetCard];
                //        _myGetCard.userInteractionEnabled = YES;
                //        [_myGetCard addGestureRecognizer:
                //         [[UITapGestureRecognizer alloc]
                //          initWithTarget:self action:@selector(touchAction:)]];
                //        //移動前
                //        _myGetCard.frame = CGRectMake(_myGetCard.superview.bounds.size.width - CARDWIDTH - 20, 0, CARDWIDTH, CARDHEIGHT);
                //        [UIView setAnimationDelegate:self];
                //        [UIView setAnimationDelay:0.2];
                //        [UIView setAnimationDuration:0.5];
                //        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                //        //移動後
                //        _myGetCard.frame = CGRectMake(10 + (CARDWIDTH + 8) * ([_myCardImageViewArray count] - 1), 0, CARDWIDTH, CARDHEIGHT);
                
                //デッキのカード枚数を減らし、手札に入れる
                [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
            }else{
                [self manipulateCard:[app.enemyDeckCardList objectAtIndex:0] plusArray:app.enemyHandByMyself_plus minusArray:app.enemyDeckCardListByMyself_minus];
            }
    }else{
        if([self isGameOver]){
            return;
//            [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        }
    }

}



//対象プレイヤーのXという場（X=場カード置き場 or エネルギーカード置き場）から対象プレイヤーYという場にZというカードを置く（対象プレイヤー・移動元の場・移動元の配列の何番目に存在するか・移動後の場）
- (void)setCardFromXTOY :(NSMutableArray *)fromField  cardNumber:(int)cardNum toField:(NSMutableArray *)toField{
    [toField addObject:[fromField objectAtIndex:cardNum]];
    [fromField removeObjectAtIndex:cardNum];
}

//対象プレイヤーの山札からカードを一枚墓地に捨てる（対象プレイヤー（対象プレイヤー・タグナンバー）
- (void)discardFromLibrary :(int)num{
    int count = [app.enemyDeckCardList count] - [app.enemyDeckCardListByMyself_minus count];
    if(count >= num + 1){
        [self manipulateCard:[app.enemyDeckCardList objectAtIndex:num] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyDeckCardListByMyself_minus];
    }
}

//対象プレイヤーの山札の上からX枚のカードを見る（対象プレイヤー・見る枚数）
- (void)browseLibrary: (NSMutableArray *)deck numberOfBrowsingCard:(int)num tapSelector:(SEL)selector string:(NSString *)string{
    NSLog(@"%@",deck);
    [regionViewArray removeAllObjects];
    for (UIView *view in [_regionView subviews]) {
        [view removeFromSuperview];
    }
    _regionView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 280 , 90 + num * (BIGCARDHEIGHT + 10))];
    [PenetrateFilter penetrate:_regionView];
    _regionView.userInteractionEnabled = YES;
    
    for (int i = 0; i < num; i++) {
        UIImageView *cardImage = [[UIImageView alloc] init];
        cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[deck objectAtIndex:i]]];
        [_regionView addSubview:cardImage];
        [regionViewArray addObject:cardImage];
        cardImage.frame = CGRectMake(10, 10 + (BIGCARDHEIGHT) * i + (i  * 5), BIGCARDWIDTH, BIGCARDHEIGHT);
        
        cardImage.userInteractionEnabled = YES;
        cardImage.tag = i + 1;
        [cardImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:selector]];
        [cardImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detailOfACard:)]];
    }
    _cardInRegion.frame = CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 460, 280 , 440);
    [_cardInRegion addSubview:_regionView];
    _cardInRegion.contentSize = _regionView.bounds.size;
    UITextView *title = [[UITextView alloc] init];
    [_cardInRegion addSubview: title];
    title.text = string;
    title.editable = NO;
    title.frame = CGRectMake(0, 10, title.superview.bounds.size.width, 30);
    title.textAlignment = NSTextAlignmentCenter;
    [self createOkButton:CGRectMake(10, _cardInRegion.bounds.size.height - 100, 50, 50) parentView:_cardInRegion tag:6];
    [_allImageView addSubview:_cardInRegion];
}

//攻撃キャラを変更する（対象プレイヤー：変更後のキャラ）

- (void)changeAttackCharacter :(int)man :(int)character{
    [self createCharacterField:_allImageView cancelButton:NO explain:@"変更後の選択AAを選んでください"];
    if (man == 0) {
        mySelectCharacterInCharacterField = character;
        app.mySelectCharacter = mySelectCharacterInCharacterField;
    }else{
        mySelectCharacterInCharacterField = character;
        app.enemySelectCharacter = mySelectCharacterInCharacterField;
    }
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
    int result = 999;
    
    return result;
}


//対象のプレイヤーが何色のエネルギーカードを場においているかを判定する。
- (int)distinguishTheNumberOfEnergyCardColor:(int)man{
    int number = 0;
    
    if (man == 0) {
        if (![[app.myEnergyCard objectAtIndex:0] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.myEnergyCard objectAtIndex:1] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.myEnergyCard objectAtIndex:2] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.myEnergyCard objectAtIndex:3] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.myEnergyCard objectAtIndex:4] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        NSLog(@"自分のエネルギーカードの種類数：%d種類",number);
    }else{
        if (![[app.enemyEnergyCard objectAtIndex:0] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.enemyEnergyCard objectAtIndex:1] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.enemyEnergyCard objectAtIndex:2] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.enemyEnergyCard objectAtIndex:3] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        if (![[app.enemyEnergyCard objectAtIndex:4] isEqualToNumber:[NSNumber numberWithInt:0]])number++;
        NSLog(@"相手のエネルギーカードの種類数：%d種類",number);
    }
    return number;
}




/*----------------------------------------------------------------------------------------*/

- (void)createCharacterField: (UIImageView *)view cancelButton:(BOOL)cancel explain:(NSString *)string{
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
    
    giko.frame = CGRectMake(10, 40, CHARACTERWIDTH - 30, CHARACTERHEIGHT- 30);
    monar.frame = CGRectMake(10, 40 + (CHARACTERHEIGHT - 30 + 5), CHARACTERWIDTH- 30, CHARACTERHEIGHT- 30);
    syobon.frame = CGRectMake(10, 40 + 2 * (CHARACTERHEIGHT - 30 + 5), CHARACTERWIDTH- 30, CHARACTERHEIGHT- 30);
    yaruo.frame  = CGRectMake(10, 40 + 3 * (CHARACTERHEIGHT - 30 + 5), CHARACTERWIDTH- 30, CHARACTERHEIGHT- 30);
    
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
    
    UITextView *txtView = [[UITextView alloc] initWithFrame :CGRectMake(10, 10, _characterField.bounds.size.width - 20, 40)];
    txtView.textAlignment = NSTextAlignmentCenter;
    txtView.editable = NO;
    txtView.text = string;
    [_characterField addSubview:txtView];
    
    //初回起動ならプロローグを発動
    if (first == 0){
        [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:monar, syobon, yaruo, nil] coveredView:self.view];
        [self startAnimation070];
    }
    
    if(cancel){
        [self createOkButton:CGRectMake(10, _characterField.bounds.size.height - 70, 50, 50) parentView:_characterField tag:7];
        [self createCancelButton:CGRectMake(_characterField.bounds.size.width - 10 - 100,  _characterField.bounds.size.height - 70, 50, 50) parentView:_characterField tag:8];
    }else{
        [self createOkButton:CGRectMake(_characterField.bounds.size.width / 2 - 50, _characterField.bounds.size.height - 70, 50, 50) parentView:_characterField tag:7];
    }
    
    
}

- (void)characterSelected:(UITapGestureRecognizer *)sender{
    [_border_middleCard removeFromSuperview];
    _border_middleCard.frame = sender.view.frame;
    [_characterField addSubview:_border_middleCard];
    NSLog(@"sender.view.tag:%d", (int)sender.view.tag);
    mySelectCharacterInCharacterField = (int)sender.view.tag;
}

- (void)createOkButton:(CGRect)rect parentView:(UIView *)view tag:(int)tag{
    UIImageView *okButton = [[UIImageView alloc] initWithFrame:rect];
    okButton.image = [UIImage imageNamed:@"ok.png"];
    okButton.userInteractionEnabled = YES;
    okButton.tag = tag;
    [okButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(buttonPushed:)]];
    [view addSubview:okButton];
    
}

- (void)createCancelButton:(CGRect)rect parentView:(UIView *)view tag:(int)tag{
    [self permitTouchAction];
    _cancelButton = [[UIImageView alloc] init];
    [view addSubview:_cancelButton];
    _cancelButton.frame = rect;
    _cancelButton.image = [UIImage imageNamed:@"cancel.png"];
    _cancelButton.userInteractionEnabled = YES;
    _cancelButton.tag = tag;
    [_cancelButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(buttonPushed:)]];
    
}

- (void)buttonPushed :(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 4:
            //ある領域のカードを見た際のOK,キャンセルボタンから飛んできた場合
            AudioServicesPlaySystemSound (app.tapSoundID);
            [_cardInRegion removeFromSuperview];
            [_imgView removeFromSuperview];
            selectCardIsCanceledInCardInRegion = YES;
            if (first == 0) {
                switch (turnCount) {
                    case 5:
                        if(turn5Boti){
                            [self startAnimation059_1_2];
                            turn5Boti = NO;
                        }else if (turn5Ba){
                            [self startAnimation061];
                        }
                        break;
                        
                    default:
                        break;
                }
                
                
            }
            
            FINISHED1
            break;
            
        case 5:
            break;
            
            
        case 6:
            //山札の上からX枚を見た際のOKボタンから飛んできた場合
            [_imgView removeFromSuperview];
            AudioServicesPlaySystemSound (app.tapSoundID);
            [_cardInRegion removeFromSuperview];
            break;
            
        case 7:
            //キャラクター選択画面のOKボタンから飛んできた場合
            NSLog(@"myselect:%d",mySelectCharacterInCharacterField);
            [_imgView removeFromSuperview];
            AudioServicesPlaySystemSound (app.tapSoundID);
            if (mySelectCharacterInCharacterField == -1) {
                
            }else{
                [_characterField removeFromSuperview];
                FINISHED1
            }
            
            
            break;
            
        case 8:
            //キャラクター選択画面のキャンセルボタンから飛んできた場合
            [_imgView removeFromSuperview];
            AudioServicesPlaySystemSound (app.cancelSoundID);
            mySelectCharacterInCharacterField = -1;
            [_characterField removeFromSuperview];
            FINISHED1
            break;
            
        case 9:
            //特定の色を選択する画面のOKボタンから飛んできた場合
            [self permitTouchAction];
            [_imgView removeFromSuperview];
            AudioServicesPlaySystemSound (app.tapSoundID);
            if(app.mySelectColor == -1){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"色未選択" message:@"色が選択されていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"選択する", nil];
                [alert show];
            }else{
                [_colorView removeFromSuperview];
                [_border_middleCard removeFromSuperview];
                FINISHED1
            }
            break;
            
        case 10:
            //カードのコストとして費やすマナを選択する画面のOKボタンから飛んできた場合
            [self permitTouchAction];
            [_imgView removeFromSuperview];
            AudioServicesPlaySystemSound (app.tapSoundID);
            
        {
            NSArray *tempArray = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:app.myUsingCardNumber]];
            
            int whiteNumber  = numberOfUsingWhiteEnergy - [[tempArray objectAtIndex:0] intValue];
            int blueNumber   = numberOfUsingBlueEnergy - [[tempArray objectAtIndex:1] intValue];
            int blackeNumber = numberOfUsingBlackEnergy - [[tempArray objectAtIndex:2] intValue];
            int redNumber    = numberOfUsingRedEnergy - [[tempArray objectAtIndex:3] intValue];
            int greenNumber  = numberOfUsingGreenEnergy - [[tempArray objectAtIndex:4] intValue];
            
            //費やしたマナがカード使用条件（有色マナを十分に満たす）を満たさない場合、警告を出して弾く
            if(whiteNumber < 0 || blueNumber < 0 || blackeNumber < 0 || redNumber < 0 || greenNumber < 0 || whiteNumber + blueNumber + blackeNumber + redNumber + greenNumber != [[tempArray objectAtIndex:5] intValue]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エネルギー不足" message:@"カードの使用条件を満たしていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"使用するエネルギーを選択しなおす", nil];
                [alert show];
            }else{
                [app.myUsingEnergy replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:[[app.myUsingEnergy objectAtIndex:0] intValue] + numberOfUsingWhiteEnergy]];
                [app.myUsingEnergy replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:[[app.myUsingEnergy objectAtIndex:1] intValue] + numberOfUsingBlueEnergy]];
                [app.myUsingEnergy replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:[[app.myUsingEnergy objectAtIndex:2] intValue] + numberOfUsingBlackEnergy]];
                [app.myUsingEnergy replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:[[app.myUsingEnergy objectAtIndex:3] intValue] + numberOfUsingRedEnergy]];
                [app.myUsingEnergy replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:[[app.myUsingEnergy objectAtIndex:4] intValue] + numberOfUsingGreenEnergy]];
                
                numberOfUsingWhiteEnergy = 0;
                numberOfUsingBlueEnergy  = 0;
                numberOfUsingBlackEnergy = 0;
                numberOfUsingRedEnergy   = 0;
                numberOfUsingGreenEnergy = 0;
                [_colorView removeFromSuperview];
                FINISHED1
                
                //初回起動判定。初回起動であれば、プロローグを開始する。
                if (first == 0) {
                    switch (turnCount) {
                        case 3:
                            [self startAnimation046_2];
                            break;
                        case 4:
                            [self startAnimation052_2];
                            break;
                        case 5:
                            break;
                        case 6:
                            [self startAnimation069];
                            break;
                        default:
                            break;
                    }
                    
                }
            }
        }
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
    [self forbidTouchAction];
    for (UIView *view in _colorView.subviews) {
        [view removeFromSuperview];
    }
    
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
    
    whiteImage.frame = CGRectMake(10, 10, 50, 50);
    blueImage.frame = CGRectMake(10, 80, 50, 50);
    blackImage.frame = CGRectMake(10, 150, 50, 50);
    redImage.frame = CGRectMake(10, 220, 50, 50);
    greenImage.frame = CGRectMake(10, 290, 50, 50);
    
    whiteImage.image = [UIImage imageNamed:@"whiteEnergyImage_M"];
    blueImage.image = [UIImage imageNamed:@"blueEnergyImage_M"];
    blackImage.image = [UIImage imageNamed:@"blackEnergyImage_M"];
    redImage.image = [UIImage imageNamed:@"redEnergyImage_M"];
    greenImage.image = [UIImage imageNamed:@"greenEnergyImage_M"];
    
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
    [self createOkButton:CGRectMake(10, (_colorView.bounds.size.height - 70), 50, 50) parentView:_colorView tag:9];
    [_allImageView addSubview:_colorView];
    
}

- (void) selectColor :(UITapGestureRecognizer *)sender{
    [_border_middleCard removeFromSuperview];
    _border_middleCard.frame = sender.view.frame;
    [_colorView addSubview:_border_middleCard];
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
                //カードのcase50から飛んでくる。
                [self manipulateCard:[app.myDeckCardList objectAtIndex:selectedCardOrder] plusArray:app.myDeckCardListByMyself_plus minusArray:app.myDeckCardListByMyself_minus];
                FINISHED1
                break;
        }
    }else if (alertView == _doIUseEnergycard){
        switch (buttonIndex) {
            case 0:
                [self setCardToCardsIUsedInThisTurn:app.myHand cardNumber:selectedCardOrder];
                [_cardInRegion removeFromSuperview];
                [_cancelButton removeFromSuperview];
                [_imgView removeFromSuperview];
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
                [regionViewArray removeAllObjects];
                if(app.myUsingCardNumber == 1){
                    [app.myEnergyCard replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:0] intValue] + 1]];
                    NSLog(@"白エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:0] intValue]);
                
                    //初回起動ならプロローグを表示する
                    if (first == 0) {
                        if([[app.myEnergyCard objectAtIndex:0] intValue] == 1){
                            [self startAnimation038];
                            [app.arrow removeFromSuperview];
                        }
                    }
                    
                }else if (app.myUsingCardNumber == 2){
                    [app.myEnergyCard replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:1] intValue] + 1]];
                    NSLog(@"青エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:1] intValue]);
                }else if (app.myUsingCardNumber == 3){
                    [app.myEnergyCard replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:2] intValue] + 1]];
                    NSLog(@"黒エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:2] intValue]);
                    //初回起動ならプロローグを表示する
                    if (first == 0) {
                        if([[app.myEnergyCard objectAtIndex:2] intValue] == 1){
                            [app.arrowR removeFromSuperview];
                            [self startAnimation047];
                        }
                    }
                }else if (app.myUsingCardNumber == 4){
                    [app.myEnergyCard replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:3] intValue] + 1]];
                    NSLog(@"赤エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:3] intValue]);
                }else if (app.myUsingCardNumber == 5){
                    [app.myEnergyCard replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:[[app.myEnergyCard objectAtIndex:4] intValue] + 1]];
                    NSLog(@"緑エネルギーの数：%d",[[app.myEnergyCard objectAtIndex:4] intValue]);
                    
                    //初回起動ならプロローグを表示する
                    if (first == 0) {
                        if ([[app.myEnergyCard objectAtIndex:4] intValue] == 1) {
                            [app.arrowR removeFromSuperview];
                        }else if ([[app.myEnergyCard objectAtIndex:4] intValue] == 2){
                            [self startAnimation062];
                            [app.arrowR removeFromSuperview];
                        }else if ([[app.myEnergyCard objectAtIndex:4] intValue] == 3){
                            [app.arrowR removeFromSuperview];
                        }
                    }
                    
                }
                
                [self refleshHandsAndLibraries];
                
                _myWhiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:0] intValue]];
                _myBlueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:1] intValue]];
                _myBlackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:2] intValue]];
                _myRedEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:3] intValue]];
                _myGreenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:4] intValue]];
                
                
                
                //後続でソーサリー・フィールドカードを使用する場合があるため、各種カード関係の変数を初期化しておく
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.doIUseCard = NO;
                
                NSLog(@"手札の内容：%@",app.myHand);
                NSLog(@"墓地の内容：%@",app.myTomb);
                FINISHED1
                
                break;
            case 1:
                //キャンセルボタンの場合は数値のみ初期化
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.doIUseCard = NO;
                [_imgView removeFromSuperview];
                [_border_middleCard removeFromSuperview];
                FINISHED1
        }
    }else if (alertView == _doIUseSorcerycard){
        switch (buttonIndex) {
            case 0:
                [_cardInRegion removeFromSuperview];
                [_cancelButton removeFromSuperview];
                FINISHED1
                break;
            case 1:
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.doIUseCard = NO;
                doIUseCardInThisTurn = NO;
                [_border_middleCard removeFromSuperview];
                FINISHED1
                break;
            default:
                break;
        }
    }else if (alertView == _doIUseFieldcard){
        switch (buttonIndex) {
            case 0:
                [_cardInRegion removeFromSuperview];
                [_cancelButton removeFromSuperview];
                FINISHED1
                break;
            case 1:
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.doIUseCard = NO;
                doIUseCardInThisTurn = NO;
                [_border_middleCard removeFromSuperview];
                FINISHED1
                break;
            default:
                break;
        }
    }else if (alertView == _battleStartView){
        switch (buttonIndex) {
            case 0:
                motion = [[DeviceMotion alloc] init];
                motion.delegate = self;
                [motion bumpForLocalBattle];
                break;
            default:
                break;
        }
    }else if (alertView == searchEnergyCardOrGetACard){
        switch (buttonIndex) {
            case 0:
                FINISHED1
                [searchEnergyCardOrGetACard dismissWithClickedButtonIndex:0 animated:NO];
                break;
            case 1:
                [searchEnergyCardOrGetACard dismissWithClickedButtonIndex:1 animated:NO];
                [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getAEnergyCardFromLibrarySelector:) longtapSelector:@selector(detailOfACard_MyDeckCardList:) string:@""];
                searchACardInsteadOfGetACardFromLibraryTop = YES;
                break;
            default:
                break;
        }
    }else if (alertView == _winAlert){
            //カードゲットSE音を実装
            CFURLRef cardGetURL;
            SystemSoundID cardGetID;
            cardGetURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_effect04"),CFSTR ("mp3"),NULL);
            AudioServicesCreateSystemSoundID (cardGetURL, &cardGetID);
            CFRelease (cardGetURL);
            AudioServicesPlaySystemSound (cardGetID);
        
            NSArray *firstRareCardArray = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:25], [NSNumber numberWithInt:27], [NSNumber numberWithInt:28], [NSNumber numberWithInt:34], [NSNumber numberWithInt:46], [NSNumber numberWithInt:54], [NSNumber numberWithInt:57], [NSNumber numberWithInt:59], [NSNumber numberWithInt:62], [NSNumber numberWithInt:69], [NSNumber numberWithInt:82], [NSNumber numberWithInt:83], [NSNumber numberWithInt:86], [NSNumber numberWithInt:87], [NSNumber numberWithInt:101], [NSNumber numberWithInt:105], [NSNumber numberWithInt:112], [NSNumber numberWithInt:116], [NSNumber numberWithInt:122], [NSNumber numberWithInt:127], [NSNumber numberWithInt:141], [NSNumber numberWithInt:142], [NSNumber numberWithInt:150], [NSNumber numberWithInt:155], nil];
            int i = arc4random() % [firstRareCardArray count];
            app.cardIGotInTheLastMatch = [[firstRareCardArray objectAtIndex:i] intValue];
            [self cardGettingAnimation:app.cardIGotInTheLastMatch];
    }else if (alertView == _loseAlert){
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        [[NADInterstitial sharedInstance] showAd];
    }else if (alertView == _usingDeckCardListForLocalBattle){
        [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient]; //デッキ選択後に表示させると、SVProgressHUDの仕様により一瞬しか表示されないため、やむなくここで実装
        app.myDeckCardList = [[NSMutableArray alloc] init];
        switch (buttonIndex) {
            case 0:
                //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
                for (int i = 0; i < [app.myDeck1 count]; i++) {
                    for (int j = 0; j < [[app.myDeck1 objectAtIndex:i] intValue]; j++) {
                        [app.myDeckCardList addObject:[NSNumber numberWithInt:i]];
                    }
                }
                FINISHED1
                break;
                
            case 1:
                //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
                for (int i = 0; i < [app.myDeck2 count]; i++) {
                    for (int j = 0; j < [[app.myDeck2 objectAtIndex:i] intValue]; j++) {
                        [app.myDeckCardList addObject:[NSNumber numberWithInt:i]];
                    }
                }
                FINISHED1
                break;
                
            case 2:
                //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
                for (int i = 0; i < [app.myDeck3 count]; i++) {
                    for (int j = 0; j < [[app.myDeck3 objectAtIndex:i] intValue]; j++) {
                        [app.myDeckCardList addObject:[NSNumber numberWithInt:i]];
                    }
                }
                FINISHED1
                break;
                
            default:
                break;
        }
        app.myDeckCardList = [AppDelegate shuffledArray:app.myDeckCardList];
    }else if (alertView == _usingDeckCardListForInternetBattle){
        //初回起動時のみ、デッキをシャッフルしない。（プロローグの展開に合わせるため）
        //TODO: ここ
        if (first == 0) {
            app.myDeckCardList = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:8], [NSNumber numberWithInt:3], [NSNumber numberWithInt:5], [NSNumber numberWithInt:72], [NSNumber numberWithInt:5], [NSNumber numberWithInt:5], [NSNumber numberWithInt:127], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], [NSNumber numberWithInt:10], nil];
            FINISHED1
        }else{
            app.myDeckCardList = [[NSMutableArray alloc] init];
            switch (buttonIndex) {
                case 0:
                    //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
                    for (int i = 0; i < [app.myDeck1 count]; i++) {
                        for (int j = 0; j < [[app.myDeck1 objectAtIndex:i] intValue]; j++) {
                            [app.myDeckCardList addObject:[NSNumber numberWithInt:i]];
                        }
                    }
                    FINISHED1
                    break;
                    
                case 1:
                    //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
                    for (int i = 0; i < [app.myDeck2 count]; i++) {
                        for (int j = 0; j < [[app.myDeck2 objectAtIndex:i] intValue]; j++) {
                            [app.myDeckCardList addObject:[NSNumber numberWithInt:i]];
                        }
                    }
                    FINISHED1
                    break;
                    
                case 2:
                    //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
                    for (int i = 0; i < [app.myDeck3 count]; i++) {
                        for (int j = 0; j < [[app.myDeck3 objectAtIndex:i] intValue]; j++) {
                            [app.myDeckCardList addObject:[NSNumber numberWithInt:i]];
                        }
                    }
                    FINISHED1
                    break;
                    
                default:
                    break;
            }
            app.myDeckCardList = [AppDelegate shuffledArray:app.myDeckCardList];
        }
    }else if (alertView == _goodGameAlert){
        switch (buttonIndex) {
            case 0:
                app.myLifeGage = -999;
                break;
            case 1:
                break;
                
            default:
                break;
        }
    }
}


//対象のカードのエネルギーコストを配列に収める（カードナンバー）
- (NSArray *)caliculateEnergyCost:(int)cardNum{
    
    int whiteNumber = 0;//必要な白エネルギーの数を集計する
    int blueNumber = 0;//必要な青エネルギーの数を集計する
    int blackNumber = 0;//必要な黒エネルギーの数を集計する
    int redNumber = 0;//必要な赤エネルギーの数を集計する
    int greenNumber = 0;//必要な緑エネルギーの数を集計する
    int otherNumber = 0;//任意の色でよいエネルギーの数を集計する
    
    NSMutableArray *array = [[NSMutableArray alloc] init]; //白・青・黒・赤・緑・無色の配列順でコストがどれだけかかるかを管理する。
    NSString *energyCost = [app.cardList_cost objectAtIndex:cardNum]; //コストの文字列を取得
    int costLength = (int)[energyCost length];
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
- (BOOL)doIHaveEnergyToUseCard :(int)cardNum{
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    NSArray *cardCost = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:cardNum]];
    int whiteNumber = [[app.myEnergyCard objectAtIndex:0] intValue] - [[app.myUsingEnergy objectAtIndex:0] intValue] - [[cardCost objectAtIndex:0] intValue];
    int blueNumber = [[app.myEnergyCard objectAtIndex:1] intValue] - [[app.myUsingEnergy objectAtIndex:1] intValue] - [[cardCost objectAtIndex:1] intValue];
    int blackeNumber = [[app.myEnergyCard objectAtIndex:2] intValue] - [[app.myUsingEnergy objectAtIndex:2] intValue] - [[cardCost objectAtIndex:2] intValue];
    int redNumber = [[app.myEnergyCard objectAtIndex:3] intValue] - [[app.myUsingEnergy objectAtIndex:3] intValue] - [[cardCost objectAtIndex:3] intValue];
    int greenNumber = [[app.myEnergyCard objectAtIndex:4] intValue] - [[app.myUsingEnergy objectAtIndex:4] intValue] - [[cardCost objectAtIndex:4] intValue];
    
    if(whiteNumber < 0 || blueNumber < 0 || blackeNumber < 0 || redNumber < 0 || greenNumber < 0 || whiteNumber + blueNumber + blackeNumber + redNumber + greenNumber < [[cardCost objectAtIndex:5] intValue]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エネルギー不足" message:@"エネルギーが足りません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"カードを選択しなおす", nil];
        [alert show];
        
        NSLog(@"-----------------------------------");
        return NO;
    }
    NSLog(@"エネルギー足りてます");
    NSLog(@"-----------------------------------");
    return YES;
}

//ターン終了時に各種変数を初期化する
- (void)initializeVariables{
    
    //常に初期化するもの
    [getEnemyData doEnemyDecideActionRoopVersion:NO]; //app.decideAction = NOと初期化しておく
    _bc.reverse = NO;
    searchACardInsteadOfGetACardFromLibraryTop = NO;
    selectCardIsCanceledInCardInRegion = NO;
    targetedMyFieldCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedMyFieldCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedEnemyFieldCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedLibraryCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedEnemyHandCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedMyHandCardInThisTurn_destroy = [[NSMutableArray alloc] init];
    targetedMyTombCardInThisTurn_get = [[NSMutableArray alloc] init];
    targetedMyLibraryCardInThisTurn_get = [[NSMutableArray alloc] init];
    targetedEnemyFieldCardInThisTurn_return = [[NSMutableArray alloc] init];
    targetedMyTombCardInThisTurn_return = [[NSMutableArray alloc] init];
    targetedEnemyFieldCardInThisTurn_steal = [[NSMutableArray alloc] init];
    targetedMyFieldCardInThisTurn_send = [[NSMutableArray alloc] init];
    
        //ターン終了時効果を失うカードについて、元に戻す処理をしておく
        for (int i = 0; i < [app.cardsIUsedInThisTurn count]; i++) {
            int k = [[app.cardsIUsedInThisTurn objectAtIndex:i] intValue];
            if(k == 96){
                int redColor = [[app.myEnergyCard objectAtIndex:3] intValue];
                [app.myEnergyCard replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:(redColor - 3)]];
            }else if (k == 63){
                [self manipulateCard:[NSNumber numberWithInt:63] plusArray:app.myTombByMyself_plus minusArray:app.myFieldCardByMyself_minus];
            }
        }
    
    
    
    //自分に関係する変数
    app.myUsingEnergy = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    app.myLifeGageByMyself = 0; //自分のライフポイントを自分で操作する場合の値(差分のみ管理)
    [_border_middleCard removeFromSuperview];
    [_border_character removeFromSuperview];
    selectedCardOrder = -1;
    selectCardTag = -1;
    costLife = NO;
    app.mySelectCharacter = -1;; //自分の選んだキャラクター
    app.mySelectCharacterFromEnemy = -1;
    app.doIUseCard = NO;//自分がこのターンカードを使用したか
    app.myUsingCardNumber = -1; //自分が使用したカードの番号
    app.myDamageInBattlePhase = 0;
    app.myDamageFromAA = 0;
    app.myDamageFromCard = 0;
    app.mySelectColor = -1; //自分が選んだ色
    app.myGikoModifyingAttackPower = 0;
    app.myGikoModifyingDeffencePower = 0;
    app.myMonarModifyingAttackPower = 0;
    app.myMonarModifyingDeffencePower = 0;
    app.mySyobonModifyingAttackPower = 0;
    app.mySyobonModifyingDeffencePower = 0;
    app.myYaruoModifyingAttackPower = 0;
    app.myYaruoModifyingDeffencePower = 0;
    app.myGikoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のギコの基本攻撃力（差分のみ管理）
    app.myGikoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のギコの基本防御力（差分のみ管理）
    app.myMonarFundamentalAttackPowerByMyself = 0; //自分が操作した自分のモナーの基本攻撃力（差分のみ管理）
    app.myMonarFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のモナーの基本防御力（差分のみ管理）
    app.mySyobonFundamentalAttackPowerByMyself = 0; //自分が操作した自分のショボンの基本攻撃力（差分のみ管理）
    app.mySyobonFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のショボンの基本防御力（差分のみ管理）
    app.myYaruoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    app.myYaruoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の基本防御力（差分のみ管理）
    app.myGikoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoModifyingAttackPowerByMyself = 0; //自分が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myGikoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingAttackPowerByMyself = 0; //自分が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myMonarModifyingDeffencePowerByMyself = 0; //自分が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingAttackPowerByMyself = 0; //自分が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.mySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingAttackPowerByMyself = 0; //自分が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    app.myYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    mySelectCharacterInCharacterField = -1;
    
    cardIsCompletlyUsed = NO;
    doIUseCardInThisTurn = NO;
    [app.cardsIUsedInThisTurn removeAllObjects];
    
    
    //相手に関係する変数
    app.enemySelectCharacter = -1; //相手の選んだキャラクター
    app.enemySelectCharacterByMyself = -1;
    app.doEnemyUseCard = NO; //相手がこのターンカードを使用したか
    app.enemyUsingCardNumber = -1; //相手が使用したカードの番号
    app.enemyDamageInBattlePhase = 0;
    app.enemyDamageFromAA = 0;
    app.enemyDamageFromCard = 0;
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
    app.enemyGikoModifyingAttackPowerByMyself = 0; // 自分が操作した相手のギコの修正攻撃力（差分のみ管理）
    app.enemyGikoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のギコの修正防御力（差分のみ管理）
    app.enemyMonarModifyingAttackPowerByMyself = 0; //自分が操作した相手のモナーの修正攻撃力（差分のみ管理）
    app.enemyMonarModifyingDeffencePowerByMyself = 0; //自分が操作した相手のモナーの修正防御力（差分のみ管理）
    app.enemySyobonModifyingAttackPowerByMyself = 0; //自分が操作した相手のショボンの修正攻撃力（差分のみ管理）
    app.enemySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した相手のショボンの修正防御力（差分のみ管理）
    app.enemyYaruoModifyingAttackPowerByMyself = 0; //自分が操作した相手のやる夫の修正攻撃力（差分のみ管理）
    app.enemyYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のやる夫の修正防御力（差分のみ管理）
    [app.cardsEnemyUsedInThisTurn removeAllObjects];
    
    
    //自分に関係する変数
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

    
    //相手に関係する変数
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
}


//カードを特定のタイミングで発動させるメソッドを実装する
-(void) activateCardInTiming :(int)timing{
    //発動タイミング毎に発動させるカードを変える。
    switch (timing) {
            //ターン開始時
        case 0:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([GetEnemyDataFromServer indexOfObjectForNSNumber:app.fieldCardList_turnStart number:[app.myFieldCard objectAtIndex:i]] != -1){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
            //カード使用時
        case 1:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([GetEnemyDataFromServer indexOfObjectForNSNumber:app.fieldCardList_afterCardUsed number:[app.myFieldCard objectAtIndex:i]] != -1){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
            //ダメージ計算時
        case 2:
            for(int i = 0; i < [app.cardsIUsedInThisTurn count]; i++){
                NSNumber *num = [app.cardsIUsedInThisTurn objectAtIndex:i];
                if([app.sorceryCardList containsObject:num] && [num intValue] != 96){
                    //エネルギーを増やすカードは先に効果発動させているので、それ以外を効果発動させる。
                    [self cardActivate:[num intValue] string:nil];
                }
            }
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([GetEnemyDataFromServer indexOfObjectForNSNumber:app.fieldCardList_damageCaliculate number:[app.myFieldCard objectAtIndex:i]] != -1){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
            //ターン終了時
        case 3:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([GetEnemyDataFromServer indexOfObjectForNSNumber:app.fieldCardList_turnEnd number:[app.myFieldCard objectAtIndex:i]] != -1){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            if([GetEnemyDataFromServer indexOfObjectForNSNumber:app.cardsIUsedInThisTurn number:[NSNumber numberWithInt:96]] != -1){
                
            }
            break;
            //他のカード効果発動を待ってから最後に発動するカード
        case 99:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([GetEnemyDataFromServer indexOfObjectForNSNumber:app.fieldCardList_other number:[app.myFieldCard objectAtIndex:i]] != -1){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
        default:
            break;
    }
}

- (void)sync{
    syncFinished = NO;
    while (!syncFinished) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}


- (void)setCardToCardsIUsedInThisTurn:(NSMutableArray *)fromField  cardNumber:(int)cardNum{
    [app.cardsIUsedInThisTurn addObject:[fromField objectAtIndex:cardNum]];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect scrolledRect;
    scrolledRect.origin = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
    scrolledRect.size = _backGroundView.frame.size;
    _backGroundView.frame = scrolledRect;
}

//ターン進行中にビューを更新する必要がある場合はここで実装する
-(void)refleshView{
    //ライフのテキストビューの更新
    myLifeTextView.text = [NSString stringWithFormat:@"%d",app.myLifeGage];
    enemyLifeTextView.text = [NSString stringWithFormat:@"%d",app.enemyLifeGage];
    //エネルギーのテキストビューの更新
    _myWhiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:0] intValue]];
    _myBlueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:1] intValue]];
    _myBlackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:2] intValue]];
    _myRedEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:3] intValue]];
    _myGreenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:4] intValue]];
    
    _myUsingWhiteEnergyText.text    = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:0] intValue]];
    _myUsingBlueEnergyText.text     = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:1] intValue]];
    _myUsingBlackEnergyText.text    = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:2] intValue]];
    _myUsingRedEnergyText.text      = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:3] intValue]];
    _myUsingGreenEnergyText.text    = [NSString stringWithFormat:@"%d",[[app.myUsingEnergy objectAtIndex:4] intValue]];
    
    _enemyWhiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:0] intValue]];
    _enemyBlueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:1] intValue]];
    _enemyBlackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:2] intValue]];
    _enemyRedEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:3] intValue]];
    _enemyGreenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:4] intValue]];
    
    //手札枚数の更新
    [self refleshHandsAndLibraries];
}
-(void)discardMyHandSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に破壊対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyHandCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
    [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
    [_cardInRegion removeFromSuperview];
    FINISHED1
    }
}

-(void)discardMyMultiHandSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //既に破壊対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyHandCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.myHand objectAtIndex:selectedCardOrder] plusArray:app.myTombByMyself_plus minusArray:app.myHandByMyself_minus];
        [targetedMyHandCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}


-(void)discardMyHandInTurnEndPhaseSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
    [_cardInRegion removeFromSuperview];
    
    FINISHED1
}


-(void)discardEnemyHandSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に破壊対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedEnemyHandCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
    [self manipulateCard:[app.enemyHand objectAtIndex:selectedCardOrder] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
    [targetedEnemyHandCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
    [_cardInRegion removeFromSuperview];
    FINISHED1
    }
}

-(void)discardEnemyMultiHandSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //既に破壊対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedEnemyHandCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.enemyHand objectAtIndex:selectedCardOrder] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyHandByMyself_minus];
        [targetedEnemyHandCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)destroyMyFieldCardSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に破壊対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyFieldCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.myFieldCard objectAtIndex:selectedCardOrder] plusArray:app.myTombByMyself_plus minusArray:app.myFieldCardByMyself_minus];
        [targetedMyFieldCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)destroyEnemyFieldCardSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に破壊対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedEnemyFieldCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
    [self manipulateCard:[app.enemyFieldCard objectAtIndex:selectedCardOrder] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
    [targetedEnemyFieldCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
    [_cardInRegion removeFromSuperview];
    FINISHED1
    }
}

-(void)destroyMultiEnemyFieldCardsSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //既に破壊対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedEnemyFieldCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.enemyFieldCard objectAtIndex:selectedCardOrder] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
        [targetedEnemyFieldCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)returnEnemyFieldCardToHandSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に戻す対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedEnemyFieldCardInThisTurn_return number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.enemyFieldCard objectAtIndex:selectedCardOrder] plusArray:app.enemyHandByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
        [targetedEnemyFieldCardInThisTurn_return addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)returnMyTombCardToLibrarySelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に戻す対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyTombCardInThisTurn_return number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.myTomb objectAtIndex:selectedCardOrder] plusArray:app.myDeckCardListByMyself_plus minusArray:app.myTombByMyself_minus];
        [targetedMyTombCardInThisTurn_return addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)stealEnemyFieldCardSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に盗む対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedEnemyFieldCardInThisTurn_steal number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.enemyFieldCard objectAtIndex:selectedCardOrder] plusArray:app.myFieldCardByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
        [targetedEnemyFieldCardInThisTurn_steal addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)putACardToLibraryTopOrBottomSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [_cardInRegion removeFromSuperview];
    _putACardToLibraryTopOrBottom = [[UIAlertView alloc] initWithTitle:@"選択" message:@"山札のどちらにおきますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"一番上", @"一番下", nil];
    [_putACardToLibraryTopOrBottom show];
    [self sync];
}

-(void)sendMyFieldCardSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に渡す対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyFieldCardInThisTurn_send number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.myFieldCard objectAtIndex:selectedCardOrder] plusArray:app.enemyFieldCardByMyself_plus minusArray:app.myFieldCardByMyself_minus];
        [targetedMyFieldCardInThisTurn_send addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}
-(void)copyMyFieldCardSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    if ([[app.myFieldCard objectAtIndex:selectedCardOrder]intValue] == 63) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"自身を選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [app.myFieldCardByMyself_plus addObject:[app.myFieldCard objectAtIndex:selectedCardOrder]];
        
        //その他のマイナス配列と同じデータの入れ方を行う（２つめのNSNumber:2は、マイナス配列に対応するプラス配列がmyFieldCardByMyself_plusであることを意味する）
        NSArray *tmpArray = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:63],[NSNumber numberWithInt:2],[NSNumber numberWithInt:selectedCardOrder], nil];
        [app.myFieldCardByMyself_minus addObject:tmpArray];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)getACardFromLibrarySelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyLibraryCardInThisTurn_get number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
    [self manipulateCard:[app.myDeckCardList objectAtIndex:selectedCardOrder] plusArray:app.myHandByMyself_plus minusArray:app.myDeckCardListByMyself_minus];
    [targetedMyLibraryCardInThisTurn_get addObject:[NSNumber numberWithInt:selectedCardOrder]];
    [_cardInRegion removeFromSuperview];
    FINISHED1
    }
}

-(void)getAEnergyCardFromLibrarySelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //フィールドカードかソーサリーカードなら弾く
    int num = [[app.myDeckCardList objectAtIndex:selectedCardOrder] intValue];
    if(num <= 0 || num >= 6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"エネルギーカード以外は選択できません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyLibraryCardInThisTurn_get number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }else{
        [self manipulateCard:[app.myDeckCardList objectAtIndex:selectedCardOrder] plusArray:app.myHandByMyself_plus minusArray:app.myDeckCardListByMyself_minus];
        [targetedMyLibraryCardInThisTurn_get addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
        }
    }
}

-(void)getMultiEnergyCardFromLibraryHandSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //既に取得対象として選択されているカードが選択された場合は警告を出して弾く
    int num = [[app.myDeckCardList objectAtIndex:selectedCardOrder] intValue];
    if(num <= 0 || num >= 6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"エネルギーカード以外は選択できません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyLibraryCardInThisTurn_get number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }else{
            [self manipulateCard:[app.myDeckCardList objectAtIndex:selectedCardOrder] plusArray:app.enemyHandByMyself_plus minusArray:app.enemyDeckCardListByMyself_minus];
            [targetedMyLibraryCardInThisTurn_get addObject:[NSNumber numberWithInt:selectedCardOrder]];
            [_cardInRegion removeFromSuperview];
            FINISHED1
        }
    }
}

-(void)getAEnergyCardFromTombSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //フィールドカードかソーサリーカードなら弾く
    int num = [[app.myTomb objectAtIndex:selectedCardOrder] intValue];
    NSLog(@"num:%d",num);
    if(num <= 0 || num >= 6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"エネルギーカード以外は選択できません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyTombCardInThisTurn_get number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }else{
            [self manipulateCard:[app.myTomb objectAtIndex:selectedCardOrder] plusArray:app.myHandByMyself_plus minusArray:app.myTombByMyself_minus];
            [targetedMyTombCardInThisTurn_get addObject:[NSNumber numberWithInt:selectedCardOrder]];
            [_cardInRegion removeFromSuperview];
            FINISHED1
        }
    }
}

-(void)getACardFromMyTombSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に取得対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyTombCardInThisTurn_get number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
    [self manipulateCard:[app.myTomb objectAtIndex:selectedCardOrder] plusArray:app.myHandByMyself_plus minusArray:app.myTombByMyself_minus];
    [_cardInRegion removeFromSuperview];
    [targetedMyTombCardInThisTurn_get addObject:[NSNumber numberWithInt:selectedCardOrder]];
    FINISHED1
    }
}

-(void)getMultiCardFromMyTombSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //既に取得対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedMyTombCardInThisTurn_get number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.myTomb objectAtIndex:selectedCardOrder] plusArray:app.myHandByMyself_plus minusArray:app.myTombByMyself_minus];
        [_cardInRegion removeFromSuperview];
        [targetedMyTombCardInThisTurn_get addObject:[NSNumber numberWithInt:selectedCardOrder]];
        FINISHED1
    }
}


-(void)discardACardFromLibrarySelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    //既に捨てる対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedLibraryCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.enemyDeckCardList objectAtIndex:selectedCardOrder] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyDeckCardListByMyself_minus];
        [targetedLibraryCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)discardMultiCardsFromLibrarySelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    
    //既に捨てる対象として選択されているカードが選択された場合は警告を出して弾く
    if([GetEnemyDataFromServer indexOfObjectForNSNumber:targetedLibraryCardInThisTurn_destroy number:[NSNumber numberWithInt:selectedCardOrder]] != -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選択不可" message:@"既に選んだカードを選ぶことはできません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self manipulateCard:[app.enemyDeckCardList objectAtIndex:selectedCardOrder] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyDeckCardListByMyself_minus];
        [targetedLibraryCardInThisTurn_destroy addObject:[NSNumber numberWithInt:selectedCardOrder]];
        [_cardInRegion removeFromSuperview];
        FINISHED1
    }
}

-(void)normalSelector: (UITapGestureRecognizer *)sender{
    [self permitTouchAction];
    [_imgView removeFromSuperview];
    //selectedCardOrderに選ばれたカードの配列の順番だけ入れるセレクタ
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [_cardInRegion removeFromSuperview];
    FINISHED1
}

-(void)nullSelector: (UITapGestureRecognizer *)sender{

}

-(void)manipulateCard:(NSNumber *)cardNum plusArray:(NSMutableArray *)plusArray minusArray:(NSMutableArray *)minusArray{
    //自分のカード効果等による自分自身のカードの移動は、もし先に相手の効果等により移動済みであった場合、空振りにしなければならない。そのためには、減少処理と増加処理を両方空振りさせる必要がある。
    //マイナス配列は、GetEnemyDataFromServer.mのindexOfObjectForNSNumberにて返り値が-1となれば（相手に除去されている等の理由により）既に除去すべきカードがその領域に存在していない（減少処理の空振り）ことがわかるが、プラス配列の方は何もしないと（対応すべきマイナス配列が既に存在しないにもかかわらず）カードの増加処理を行ってしまうため、マイナス配列に対応する配列名及び配列番号を入れておくことで、マイナス配列が空振りした場合にプラス配列の増加処理も止めるように実装している。
    //上記の通り、空振りさせるべきは「自分のカード効果等による、自分自身の」カードの移動のみであることから、自分が相手のカードを移動させるときには原則どおりマイナス配列に移動させるカードのカードナンバーを入れるだけの仕様である。
    
    //プラス配列毎に番号を振り、その番号をマイナス配列に保持させることでプラス配列を特定する
    int tagNumberOfPlusArray = -1;
    if(plusArray == app.myHandByMyself_plus){
        tagNumberOfPlusArray = 0;
    }else if (plusArray == app.myTombByMyself_plus){
        tagNumberOfPlusArray = 1;
    }else if (plusArray == app.myFieldCardByMyself_plus){
        tagNumberOfPlusArray = 2;
    }else if (plusArray == app.myDeckCardListByMyself_plus){
        tagNumberOfPlusArray = 3;
    }else if (plusArray == app.enemyHandByMyself_plus){
        tagNumberOfPlusArray = 4;
    }else if (plusArray == app.enemyTombByMyself_plus){
        tagNumberOfPlusArray = 5;
    }else if (plusArray == app.enemyFieldCardByMyself_plus){
        tagNumberOfPlusArray = 6;
    }else if (plusArray == app.enemyDeckCardListByMyself_plus){
        tagNumberOfPlusArray = 7;
    }
    
    if (minusArray == app.enemyHandByMyself_minus || minusArray == app.enemyTombByMyself_minus || minusArray == app.enemyFieldCardByMyself_minus || minusArray == app.enemyDeckCardListByMyself_minus) {
        [minusArray addObject:cardNum];
    }else{
        NSArray *tmpArray = [[NSArray alloc] initWithObjects:cardNum, [NSNumber numberWithInt:tagNumberOfPlusArray],[NSNumber numberWithInt:(int)[plusArray count]], nil];
        [minusArray addObject:tmpArray];
    }
    [plusArray addObject:cardNum];
}

-(void)forbidTouchAction{
    _okButton.userInteractionEnabled        = NO;
    _myCardImageView.userInteractionEnabled = NO;
    _myCharacterView.userInteractionEnabled = NO;
    _myTomb.userInteractionEnabled          = NO;
    _enemyTomb.userInteractionEnabled       = NO;
    _myField.userInteractionEnabled         = NO;
    _enemyField.userInteractionEnabled      = NO;
    _goodGame.userInteractionEnabled        = NO;
}

-(void)permitTouchAction{
    _okButton.userInteractionEnabled        = YES;
    _myCardImageView.userInteractionEnabled = YES;
    _myCharacterView.userInteractionEnabled = YES;
    _myTomb.userInteractionEnabled          = YES;
    _enemyTomb.userInteractionEnabled       = YES;
    _myField.userInteractionEnabled         = YES;
    _enemyField.userInteractionEnabled      = YES;
    _goodGame.userInteractionEnabled        = YES;
}

//各色毎にいくつのエネルギーを使用するか選択する
-(void)selectUsingEnergy:(int)cardNum{
    //背景のボタンを押させないようにする
    [self forbidTouchAction];
    
    //色を選択する画面を作成する
    for (UIView *view in _colorView.subviews) {
        [view removeFromSuperview];
    }

    //「コストを選択する画面」であることを示すラベル
    UIFont *font = [UIFont fontWithName:@"Tanuki-Permanent-Marker" size:12];
    UILabel *explainLabel = [[UILabel alloc] init];
    [_colorView addSubview:explainLabel];
    explainLabel.font = font;
    explainLabel.text = @"カード使用のために消費する\nエネルギーを選択してください";
    explainLabel.numberOfLines = 2;
    explainLabel.frame  = CGRectMake(30, 20, _colorView.bounds.size.width - 60, 60);
    explainLabel.textAlignment = NSTextAlignmentCenter;
    
    //カード使用に必要なエネルギーを表示するビュー
    UILabel *usingEnergyExplainLabel = [[UILabel alloc] init];
    [_colorView addSubview:usingEnergyExplainLabel];
    usingEnergyExplainLabel.frame = CGRectMake(40, 80, usingEnergyExplainLabel.superview.bounds.size.width - 40, 20);
    usingEnergyExplainLabel.text = @"必要エネルギー：";
    usingEnergyExplainLabel.font = font;
    
    NSArray *tempArray = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:app.myUsingCardNumber]];
    int costImageWidth = 0; //コスト画像を描画する際のwidthを規定する
    
    //有色のコストの画像を描画する
    for (int i = 0; i < [tempArray count] - 1; i++) {
        for (int k = 0; k < [[tempArray objectAtIndex:i] intValue]; k++) {
            UIImageView *costImageView = [[UIImageView alloc] init];
            switch (i) {
                case 0:
                    costImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"whiteEnergyImage" ofType:@"png"]];
                    break;
                case 1:
                    costImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blueEnergyImage" ofType:@"png"]];
                    break;
                case 2:
                    costImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackEnergyImage" ofType:@"png"]];
                    break;
                case 3:
                    costImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"redEnergyImage" ofType:@"png"]];
                    break;
                case 4:
                    costImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"greenEnergyImage" ofType:@"png"]];
                    break;
                default:
                    break;
            }
            [_colorView addSubview:costImageView];
            costImageView.frame = CGRectMake(140 + costImageWidth, 80, 20, 20);
            costImageWidth += 22;
        }
    }
    
    //無色のコストの画像を描画する
    UIImageView *costImageView = [[UIImageView alloc] initWithFrame:CGRectMake(140 + costImageWidth, 80, 20, 20)];
    costImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"noColor%d",[[tempArray objectAtIndex:5] intValue]] ofType:@"png"]];
    [_colorView addSubview:costImageView];
    
//    UIImageView *usingEnergyView = [[UIImageView alloc] init];
//    [_colorView addSubview:usingEnergyView];
//    usingEnergyView.frame = CGRectMake(10, 10, 20, usingEnergyView.superview.bounds.size.width - 10);
    
    //増減させる使用エネルギー・矢印のビュー
    UIImageView *whiteImage = [[UIImageView alloc] init];
    UIImageView *blueImage = [[UIImageView alloc] init];
    UIImageView *blackImage = [[UIImageView alloc] init];
    UIImageView *redImage = [[UIImageView alloc] init];
    UIImageView *greenImage = [[UIImageView alloc] init];
    UIImageView *whiteUp = [[UIImageView alloc] init];
    UIImageView *blueUp = [[UIImageView alloc] init];
    UIImageView *blackUp = [[UIImageView alloc] init];
    UIImageView *redUp = [[UIImageView alloc] init];
    UIImageView *greenUp = [[UIImageView alloc] init];
    UIImageView *whiteDown = [[UIImageView alloc] init];
    UIImageView *blueDown = [[UIImageView alloc] init];
    UIImageView *blackDown = [[UIImageView alloc] init];
    UIImageView *redDown = [[UIImageView alloc] init];
    UIImageView *greenDown = [[UIImageView alloc] init];
    
    [_colorView addSubview:whiteImage];
    [_colorView addSubview:blueImage];
    [_colorView addSubview:blackImage];
    [_colorView addSubview:redImage];
    [_colorView addSubview:greenImage];
    [_colorView addSubview:whiteUp];
    [_colorView addSubview:blueUp];
    [_colorView addSubview:blackUp];
    [_colorView addSubview:redUp];
    [_colorView addSubview:greenUp];
    [_colorView addSubview:whiteDown];
    [_colorView addSubview:blueDown];
    [_colorView addSubview:blackDown];
    [_colorView addSubview:redDown];
    [_colorView addSubview:greenDown];
    [_colorView addSubview:whiteNumberOfText];
    [_colorView addSubview:blueNumberOfText];
    [_colorView addSubview:blackNumberOfText];
    [_colorView addSubview:redNumberOfText];
    [_colorView addSubview:greenNumberOfText];
    
    whiteImage.frame    = CGRectMake(40, 105, 50, 50);
    blueImage.frame     = CGRectMake(40, 165, 50, 50);
    blackImage.frame    = CGRectMake(40, 225, 50, 50);
    redImage.frame      = CGRectMake(40, 285, 50, 50);
    greenImage.frame    = CGRectMake(40, 345, 50, 50);
    
    whiteDown.frame     = CGRectMake(90, 105, 50, 50);
    blueDown.frame      = CGRectMake(90, 165, 50, 50);
    blackDown.frame     = CGRectMake(90, 225, 50, 50);
    redDown.frame       = CGRectMake(90, 285, 50, 50);
    greenDown.frame     = CGRectMake(90, 345, 50, 50);
    
    whiteNumberOfText.frame   = CGRectMake(135, 113, 50, 50);
    blueNumberOfText.frame    = CGRectMake(135, 173, 50, 50);
    blackNumberOfText.frame   = CGRectMake(135, 233, 50, 50);
    redNumberOfText.frame     = CGRectMake(135, 293, 50, 50);
    greenNumberOfText.frame   = CGRectMake(135, 353, 50, 50);
    
    whiteUp.frame       = CGRectMake(180, 105, 50, 50);
    blueUp.frame        = CGRectMake(180, 165, 50, 50);
    blackUp.frame       = CGRectMake(180, 225, 50, 50);
    redUp.frame         = CGRectMake(180, 285, 50, 50);
    greenUp.frame       = CGRectMake(180, 345, 50, 50);
    
    whiteImage.image = [UIImage imageNamed:@"whiteEnergyImage_M"];
    blueImage.image = [UIImage imageNamed:@"blueEnergyImage_M"];
    blackImage.image = [UIImage imageNamed:@"blackEnergyImage_M"];
    redImage.image = [UIImage imageNamed:@"redEnergyImage_M"];
    greenImage.image = [UIImage imageNamed:@"greenEnergyImage_M"];
    
    whiteUp.image = [UIImage imageNamed:@"rightArrow"];
    blueUp.image = [UIImage imageNamed:@"rightArrow"];
    blackUp.image = [UIImage imageNamed:@"rightArrow"];
    redUp.image = [UIImage imageNamed:@"rightArrow"];
    greenUp.image = [UIImage imageNamed:@"rightArrow"];
    
    whiteDown.image = [UIImage imageNamed:@"leftArrow"];
    blueDown.image = [UIImage imageNamed:@"leftArrow"];
    blackDown.image = [UIImage imageNamed:@"leftArrow"];
    redDown.image = [UIImage imageNamed:@"leftArrow"];
    greenDown.image = [UIImage imageNamed:@"leftArrow"];
    
    whiteUp.userInteractionEnabled = YES;
    blueUp.userInteractionEnabled = YES;
    blackUp.userInteractionEnabled = YES;
    redUp.userInteractionEnabled = YES;
    greenUp.userInteractionEnabled = YES;
    
    whiteDown.userInteractionEnabled = YES;
    blueDown.userInteractionEnabled = YES;
    blackDown.userInteractionEnabled = YES;
    redDown.userInteractionEnabled = YES;
    greenDown.userInteractionEnabled = YES;
    
    [whiteUp addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(plusEnergy:)]];
    [blueUp addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(plusEnergy:)]];
    [blackUp addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(plusEnergy:)]];
    [redUp addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(plusEnergy:)]];
    [greenUp addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(plusEnergy:)]];
    
    [whiteDown addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(minusEnergy:)]];
    [blueDown addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(minusEnergy:)]];
    [blackDown addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(minusEnergy:)]];
    [redDown addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(minusEnergy:)]];
    [greenDown addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(minusEnergy:)]];
    
    whiteUp.tag = 1;
    blueUp.tag = 2;
    blackUp.tag = 3;
    redUp.tag = 4;
    greenUp.tag = 5;
    
    whiteDown.tag = 1;
    blueDown.tag = 2;
    blackDown.tag = 3;
    redDown.tag = 4;
    greenDown.tag = 5;
    
    
    numberOfUsingWhiteEnergy = 0;
    numberOfUsingBlueEnergy = 0;
    numberOfUsingBlackEnergy = 0;
    numberOfUsingRedEnergy = 0;
    numberOfUsingGreenEnergy = 0;
    
    whiteNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingWhiteEnergy];
    blueNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingBlueEnergy];
    blackNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingBlackEnergy];
    redNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingRedEnergy];
    greenNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingGreenEnergy];
    
    whiteNumberOfText.editable = NO;
    blueNumberOfText.editable = NO;
    blackNumberOfText.editable = NO;
    redNumberOfText.editable = NO;
    greenNumberOfText.editable = NO;
    
    whiteNumberOfText.textAlignment = NSTextAlignmentCenter;
    blueNumberOfText.textAlignment = NSTextAlignmentCenter;
    blackNumberOfText.textAlignment = NSTextAlignmentCenter;
    redNumberOfText.textAlignment = NSTextAlignmentCenter;
    greenNumberOfText.textAlignment = NSTextAlignmentCenter;
    
    [PenetrateFilter penetrate:whiteNumberOfText];
    [PenetrateFilter penetrate:blueNumberOfText];
    [PenetrateFilter penetrate:blackNumberOfText];
    [PenetrateFilter penetrate:redNumberOfText];
    [PenetrateFilter penetrate:greenNumberOfText];
    
    [self createOkButton:CGRectMake(125, (_colorView.bounds.size.height - 60), 50, 50) parentView:_colorView tag:10];
    [_allImageView addSubview:_colorView];

    if (first == 0) {
        switch (turnCount) {
            case 1:
                
                break;
            case 2:
                break;
            case 3:
                [self startAnimation046_3];
                break;
            case 4:
                [app.arrowR removeFromSuperview];
                [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _chara_myYaruo, nil] coveredView:self.view];
                break;
            case 5:
                [self startAnimation062];
            case 6:
                [app.arrowR removeFromSuperview];
            default:
                break;
        }
        
    }
    
}

-(void)plusEnergy: (UITapGestureRecognizer *)sender{
    NSArray *tempArray = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:app.myUsingCardNumber]];
    int i = 0;
    for (NSNumber *num in tempArray) {
        i += [num intValue];
    }
    
    int allNumber = numberOfUsingWhiteEnergy + numberOfUsingBlueEnergy + numberOfUsingBlackEnergy + numberOfUsingRedEnergy + numberOfUsingGreenEnergy;
    
    switch (sender.view.tag) {
        case 1:
            if(numberOfUsingWhiteEnergy < ([[app.myEnergyCard objectAtIndex:0] intValue] - [[app.myUsingEnergy objectAtIndex:0] intValue]) && allNumber < i){
                numberOfUsingWhiteEnergy++;
                whiteNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingWhiteEnergy];
            }
            break;
        case 2:
            if(numberOfUsingBlueEnergy < ([[app.myEnergyCard objectAtIndex:1] intValue] - [[app.myUsingEnergy objectAtIndex:1] intValue]) && allNumber < i){
                numberOfUsingBlueEnergy++;
                blueNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingBlueEnergy];
            }
            
            break;
        case 3:
            if(numberOfUsingBlackEnergy < ([[app.myEnergyCard objectAtIndex:2] intValue] - [[app.myUsingEnergy objectAtIndex:2] intValue]) && allNumber < i){
                numberOfUsingBlackEnergy++;
                blackNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingBlackEnergy];
            }
            break;
        case 4:
            if(numberOfUsingRedEnergy < ([[app.myEnergyCard objectAtIndex:3] intValue] - [[app.myUsingEnergy objectAtIndex:3] intValue]) && allNumber < i){
                numberOfUsingRedEnergy++;
                redNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingRedEnergy];
            }
            break;
        case 5:
            if(numberOfUsingGreenEnergy < ([[app.myEnergyCard objectAtIndex:4] intValue] - [[app.myUsingEnergy objectAtIndex:4] intValue]) && allNumber < i){
                numberOfUsingGreenEnergy++;
                greenNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingGreenEnergy];
            }
            break;
        default:
            break;
    }
    
    NSLog(@"　　使用に必要なE数　　　現在使用しているエネルギー数\n");
    NSLog(@"白：     %d                %d",[[tempArray objectAtIndex:0] intValue],numberOfUsingWhiteEnergy);
    NSLog(@"青：     %d                %d",[[tempArray objectAtIndex:1] intValue],numberOfUsingBlueEnergy);
    NSLog(@"黒：     %d                %d",[[tempArray objectAtIndex:2] intValue],numberOfUsingBlackEnergy);
    NSLog(@"赤：     %d                %d",[[tempArray objectAtIndex:3] intValue],numberOfUsingRedEnergy);
    NSLog(@"緑：     %d                %d",[[tempArray objectAtIndex:4] intValue],numberOfUsingGreenEnergy);
}

-(void)minusEnergy: (UITapGestureRecognizer *)sender{
    NSArray *tempArray = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:app.myUsingCardNumber]];
    int i = 0;
    for (NSNumber *num in tempArray) {
        i += [num intValue];
    }
    
    int allNumber = numberOfUsingWhiteEnergy + numberOfUsingBlueEnergy + numberOfUsingBlackEnergy + numberOfUsingRedEnergy + numberOfUsingRedEnergy;
    
    switch (sender.view.tag) {
        case 1:
            if(numberOfUsingWhiteEnergy > 0){
                numberOfUsingWhiteEnergy--;
                whiteNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingWhiteEnergy];
            }
            break;
        case 2:
            if(numberOfUsingBlueEnergy > 0){
                numberOfUsingBlueEnergy--;
                blueNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingBlueEnergy];
            }
            break;
        case 3:
            if(numberOfUsingBlackEnergy > 0){
                numberOfUsingBlackEnergy--;
                blackNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingBlackEnergy];
            }
            break;
        case 4:
            if(numberOfUsingRedEnergy > 0){
                numberOfUsingRedEnergy--;
                redNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingRedEnergy];
            }
            break;
        case 5:
            if(numberOfUsingGreenEnergy > 0){
                numberOfUsingGreenEnergy--;
                greenNumberOfText.text = [NSString stringWithFormat:@"%d",numberOfUsingGreenEnergy];
            }
            break;
        default:
            break;
    }
    
    NSLog(@"　　使用に必要なE数　　　現在使用しているエネルギー数\n");
    NSLog(@"白：     %d                %d",[[tempArray objectAtIndex:0] intValue],numberOfUsingWhiteEnergy);
    NSLog(@"青：     %d                %d",[[tempArray objectAtIndex:1] intValue],numberOfUsingBlueEnergy);
    NSLog(@"黒：     %d                %d",[[tempArray objectAtIndex:2] intValue],numberOfUsingBlackEnergy);
    NSLog(@"赤：     %d                %d",[[tempArray objectAtIndex:3] intValue],numberOfUsingRedEnergy);
    NSLog(@"緑：     %d                %d",[[tempArray objectAtIndex:4] intValue],numberOfUsingGreenEnergy);
}

-(BOOL)isGameOver{
    if(app.myLifeGage <= 0 || [app.myDeckCardList count] <= 0){
        _loseAlert = [[UIAlertView alloc] initWithTitle:@"敗北..." message:[NSString stringWithFormat:@"%@に敗北しました...",app.enemyNickName] delegate:self cancelButtonTitle:nil otherButtonTitles:@"タイトル画面に戻る", nil];
        [_loseAlert show];
        [app.audio stop];
        
        //効果音の音量を調整するために、無音のBGMを設定
        NSString* path = [[NSBundle mainBundle]
                          pathForResource:@"muon" ofType:@"mp3"];
        NSURL* url = [NSURL fileURLWithPath:path];
        app.audio = [[AVAudioPlayer alloc]
                     initWithContentsOfURL:url error:nil];
        app.audio.numberOfLoops = -1;
        [app.audio play];
        
        //負けた時のSE音を実装
        CFURLRef makeURL;
        SystemSoundID makeID;
        makeURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_jingle08"),CFSTR ("mp3"),NULL);
        AudioServicesCreateSystemSoundID (makeURL, &makeID);
        CFRelease (makeURL);
        AudioServicesPlaySystemSound (makeID);
        return YES;
    }else if(app.enemyLifeGage <= 0 || [app.enemyDeckCardList count] <= 0){
        //初回起動ならプロローグを表示する
        if (first == 0) {
            [self startAnimation100];
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"firstLaunch_ud"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        _winAlert = [[UIAlertView alloc] initWithTitle:@"勝利！" message:[NSString stringWithFormat:@"%@に勝利しました！",app.enemyNickName] delegate:self cancelButtonTitle:nil otherButtonTitles:@"カードを取得する", nil];
        [_winAlert show];
        [app.audio stop];
        
        //効果音の音量を調整するために、無音のBGMを設定
        NSString* path = [[NSBundle mainBundle]
                          pathForResource:@"muon" ofType:@"mp3"];
        NSURL* url = [NSURL fileURLWithPath:path];
        app.audio = [[AVAudioPlayer alloc]
                     initWithContentsOfURL:url error:nil];
        app.audio.numberOfLoops = -1;
        [app.audio play];
        
        //勝った時のSE音を実装
        CFURLRef katiURL;
        SystemSoundID katiID;
        katiURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("game_maoudamashii_9_jingle01"),CFSTR ("mp3"),NULL);
        AudioServicesCreateSystemSoundID (katiURL, &katiID);
        CFRelease (katiURL);
        AudioServicesPlaySystemSound (katiID);
        return YES;
    }
    return NO;
}

//カード使用時のアニメーション
-(void)cardUsingAnimation:(NSArray *)cardNum man:(int)man{
    //相性判定画面のシャキーンSE音を実装
    CFURLRef aisyouSyakinURL;
    SystemSoundID aisyouSyakinID;
    aisyouSyakinURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_element_fire11"),CFSTR ("mp3"),NULL);
    AudioServicesCreateSystemSoundID (aisyouSyakinURL, &aisyouSyakinID);
    CFRelease (aisyouSyakinURL);
    AudioServicesPlaySystemSound (aisyouSyakinID);
    
    //カード使用時のアニメーションを実装
    _cardUsingAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _cardUsingAnimationView.userInteractionEnabled = YES;
    _allImageView.userInteractionEnabled = NO;
    backGround = [[UIImageView alloc] init];
    [backGround setBackgroundColor:[UIColor blackColor]];
    backGround.image = [UIImage imageNamed:@"littleBlackBack.png"];
    [_allImageView addSubview:backGround];
    backGround.frame = CGRectMake(0,0, backGround.superview.bounds.size.width, backGround.superview.bounds.size.height);
    effect1 = [[MBAnimationView alloc] init];
    [effect1 setAnimationImage:@"pipo-btleffect071.png" :120 :120 :10];
    effect1.frame = CGRectMake(40, 160, 240, 240);
    effect1.animationDuration = 1;
    [backGround addSubview:effect1];
    [effect1 startAnimating];
    
    [backGround whiteFadeInWithDuration:1.2f delay:1.0f block:^(void){
        
        
        effect2 = [[MBAnimationView alloc] init];
        [effect2 setAnimationImage:@"pipo-mapeffect009.png" :240 :240 :12];
        effect2.frame = CGRectMake(40, 100, 240, 240);
        effect2.animationDuration = 1;
        effect2.animationRepeatCount = 0;
        [backGround addSubview:effect2];
        [effect2 startAnimating];

        
        
        int k = (int)[cardNum count]; //使用したカードの枚数を格納する
        if (k == 0) {
            //カードを使用しなかった場合は、その旨表示する。
            UITextView *explain = [[UITextView alloc] init];
            explain.text = @"このターン、カードは使用されませんでした";
            explain.textColor = [UIColor whiteColor];
            explain.frame = CGRectMake(0, 0, 200, 40);
            explain.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 3);
            explain.textAlignment = NSTextAlignmentCenter;
            [PenetrateFilter penetrate:explain];
            [_cardUsingAnimationView addSubview:explain];
        }else{
            //カードを使用した場合は、使用したカードを表示する。
            
            UITextView *explain = [[UITextView alloc] init];
            if(man == MYSELF){
                explain.text = @"自分がこのターン使用したカード";
            }else{
                explain.text = @"相手がこのターン使用したカード";
            }
            
            explain.textColor = [UIColor whiteColor];
            explain.frame = CGRectMake(0, 0, 200, 40);
            explain.center = CGPointMake([[UIScreen mainScreen] bounds].size.width /2, 50);
            explain.textAlignment = NSTextAlignmentCenter;
            [PenetrateFilter penetrate:explain];
            [_cardUsingAnimationView addSubview:explain];
            
            //カード画像の表示
            int cardWidth;
            int cardHeight;
            if([YSDeviceHelper is568h]){
                cardWidth = 300;
                cardHeight = 400;
            }else{
                cardWidth = 200;
                cardHeight = 300;
            }

            
            UIScrollView *cardImageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width * -2, 80, [[UIScreen mainScreen] bounds].size.width, cardHeight)];
            UIImageView *cardImages = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (cardWidth + 10) * k + ([UIScreen mainScreen].bounds.size.width - cardWidth) / 2, cardHeight)];
            [cardImageScroll addSubview:cardImages];
            cardImageScroll.contentSize = CGSizeMake(cardImages.bounds.size.width + 100 + (10 * k), cardImages.bounds.size.height);
            for (int i = 0; i < k; i++) {
                UIImageView *cardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"card%d_M.JPG",[[cardNum objectAtIndex:i] intValue]]]];
                [cardImages addSubview:cardImage];
                cardImage.frame = CGRectMake((cardWidth + 10) * i + ([UIScreen mainScreen].bounds.size.width - cardWidth) / 2, 0, cardWidth, cardHeight);
            }
            [_cardUsingAnimationView addSubview:cardImageScroll];
            
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear                     animations:^{
                // アニメーションをする処理
                cardImageScroll.frame = CGRectMake(0, 80, [[UIScreen mainScreen] bounds].size.width, cardHeight);
            }
                             completion:^(BOOL finished){
                                 //相性判定画面のドンSE音を実装
                                 CFURLRef aisyouDonURL;
                                 SystemSoundID aisyouDonID;
                                 aisyouDonURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_battle12"),CFSTR ("mp3"),NULL);
                                 AudioServicesCreateSystemSoundID (aisyouDonURL, &aisyouDonID);
                                 CFRelease (aisyouDonURL);
                                 AudioServicesPlaySystemSound (aisyouDonID);
                             }
             ];
        }
        
        UIImageView *skipButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
        skipButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 70, [[UIScreen mainScreen] bounds].size.height - 70, 50, 50);
        skipButton.userInteractionEnabled = YES;
        [skipButton addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(removeCardUsingAnimation)]];
        [_cardUsingAnimationView addSubview:skipButton];
        
        [self.view addSubview:_cardUsingAnimationView];

        
    }];
    

}

-(void)removeCardUsingAnimation{
    FINISHED1
    //BGM鳴らす
    AudioServicesPlaySystemSound (app.tapSoundID);
    _allImageView.userInteractionEnabled = YES;
    [BattleScreenViewController releaseUIImageView:backGround];
    for (UIView *view in _cardUsingAnimationView.subviews) {
        [view removeFromSuperview];
    }
    [BattleScreenViewController releaseUIImageView:_cardUsingAnimationView];
    [_cardUsingAnimationView removeFromSuperview];
    _allImageView.userInteractionEnabled = YES;
}

//カード使用時のアニメーション
-(void)cardGettingAnimation:(int)cardNum {
    _cardUsingAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _cardUsingAnimationView.userInteractionEnabled = YES;
    _allImageView.userInteractionEnabled = NO;
    backGround = [[UIImageView alloc] init];
    [backGround setBackgroundColor:[UIColor blackColor]];
    
    NSString *backGroundImagePath = [[NSBundle mainBundle] pathForResource:@"littleBlackBack" ofType:@"png"];
    backGround.image = [UIImage imageWithContentsOfFile:backGroundImagePath];
    [_allImageView addSubview:backGround];
    backGround.frame = CGRectMake(0,0, backGround.superview.bounds.size.width, backGround.superview.bounds.size.height);
    effect1 = [[MBAnimationView alloc] init];
    [effect1 setAnimationImage:@"e_circle_240.png" :240 :240 :11];
    effect1.frame = CGRectMake(40, 160, 240, 240);
    effect1.animationDuration = 1;
    [backGround addSubview:effect1];
    [effect1 startAnimating];
    
    UITextView *explain = [[UITextView alloc] init];
    explain.text = @"今回手に入れたカード";
    explain.textColor = [UIColor whiteColor];
    explain.frame = CGRectMake(0, 0, 200, 40);
    explain.center = CGPointMake([[UIScreen mainScreen] bounds].size.width /2, [[UIScreen mainScreen] bounds].size.height - 400);
    explain.textAlignment = NSTextAlignmentCenter;
    [PenetrateFilter penetrate:explain];
    [_cardUsingAnimationView addSubview:explain];
    
    [backGround whiteFadeInWithDuration:1.2f delay:1.0f block:^(void){
        
        
    effect2 = [[MBAnimationView alloc] init];
    [effect2 setAnimationImageVertical:@"pipo-btleffect058.png" :320 :120 :27];
    effect2.frame = CGRectMake(0, 100, 320, 120);
    effect2.animationDuration = 1;
    effect2.animationRepeatCount = 0;
    [backGround addSubview:effect2];
    [effect2 startAnimating];
        
    effect3 = [[MBAnimationView alloc] init];
    [effect3 setAnimationImageVertical:@"pipo-btleffect012.png" :320 :120 : 9];
    effect3.frame = CGRectMake(0, 320, 320, 120);
    effect3.animationDuration = 1;
    effect3.animationRepeatCount = 0;
    [backGround addSubview:effect3];
    [effect3 startAnimating];
        
    effect4 = [[MBAnimationView alloc] init];
    [effect4 setAnimationImage:@"pipo-battleffect046.png" :240 :240 :10];
    effect4.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 120, 50, 240, 240);
    effect4.animationDuration = 1.5;
    effect4.animationRepeatCount = 0;
    [backGround addSubview:effect4];
    [effect4 startAnimating];
        
        //カード画像の表示

        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"card%d_M",cardNum] ofType:@"JPG"];
        UIImageView *cardImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]];
        if([YSDeviceHelper is568h]){
            cardImage.frame = CGRectMake(0, 0, 320, 480);
        }else{
            cardImage.frame = CGRectMake(0, 0, 200, 300);
        }
        
        cardImage.center = CGPointMake([[UIScreen mainScreen] bounds].size.width /2 , [[UIScreen mainScreen] bounds].size.height / 2);
        [_cardUsingAnimationView addSubview:cardImage];
        
        NSString *backButtonImagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"back"] ofType:@"png"];
        UIImageView *skipButton = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:backButtonImagePath]];
        skipButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 50, [[UIScreen mainScreen] bounds].size.height - 50, 50, 50);
        skipButton.userInteractionEnabled = YES;
        [skipButton addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(removeCardGettingAnimation)]];
        [_cardUsingAnimationView addSubview:skipButton];
        
        [self.view addSubview:_cardUsingAnimationView];
        
        //カードを実際に手に入れる処理
        [app getANewCard:cardNum];
    }];
}

-(void)removeCardGettingAnimation{
    FINISHED1
    NSLog(@"OK");
    _allImageView.userInteractionEnabled = YES;
    
    for (UIView *view in backGround.subviews) {
        [view removeFromSuperview];
    }
    [BattleScreenViewController releaseUIImageView:backGround];
    [backGround removeFromSuperview];
    
    for (UIView *view in _cardUsingAnimationView.subviews) {
        [view removeFromSuperview];
    }
    [BattleScreenViewController releaseUIImageView:_cardUsingAnimationView];
    [_cardUsingAnimationView removeFromSuperview];
    _allImageView.userInteractionEnabled = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //初回起動なら広告を表示しない
    if (first != 1) {
        [[NADInterstitial sharedInstance] showAd];
    }else{
        NSLog(@"初回起動なので広告は表示しない");
    }
}

+ (void)releaseUIImageView:(UIImageView*)uiimgv {
    if(uiimgv != nil){
        uiimgv.image = nil;
        uiimgv.layer.sublayers = nil;
        uiimgv = nil;
    }
}

- (void)jankenHantei{
    _kekkaView = [[UIImageView alloc] init];
    _kekkaView.userInteractionEnabled = YES;
    [self.view addSubview:_kekkaView];
    
    UIImageView *jankenBackGround       = [[UIImageView alloc] init]; //背景
    _myCharacter                        = [[UIImageView alloc] init]; //自分の選んだキャラクターの画像
    _enemyCharacter                     = [[UIImageView alloc] init]; //相手の選んだキャラクターの画像
    UIImageView *skip                   = [[UIImageView alloc] init]; //判定画面を消去
    
    //背景を黒透明に設定
    jankenBackGround.backgroundColor = [UIColor blackColor];
    jankenBackGround.alpha = 0.8f;
    [_kekkaView addSubview:jankenBackGround];
    jankenBackGround.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //とりあえず画面外でキャラクター画像を表示させる
    [_kekkaView addSubview:_myCharacter];
    [_kekkaView addSubview:_enemyCharacter];
    _myCharacter.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * -4, [UIScreen mainScreen].bounds.size.height - _myCharacter.image.size.height - 40, _myCharacter.image.size.width, _myCharacter.image.size.height);
    _enemyCharacter.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 4, 40, _enemyCharacter.image.size.width, _enemyCharacter.image.size.height);
    
    //スキップボタンを実装
    skip.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
    skip.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 70, [[UIScreen mainScreen] bounds].size.height - 70, 50, 50);
    skip.userInteractionEnabled = YES;
    [skip addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(removeJankenHanteiView)]];
    [_kekkaView addSubview:skip];
    
    //自分のキャラクターの画像を設定
    switch (app.mySelectCharacter) {
        case GIKO:
            _myCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"giko" ofType:@"png"]];
            break;
        case MONAR:
            _myCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"monar" ofType:@"png"]];
            break;
        case SYOBON:
            _myCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syobon" ofType:@"png"]];
            break;
        case YARUO:
            _myCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yaruo" ofType:@"png"]];
            break;
        default:
            break;
    }
    
    //相手のキャラクターの画像を設定
    switch (app.enemySelectCharacter) {
        case GIKO:
            _enemyCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"giko" ofType:@"png"]];
            break;
        case MONAR:
            _enemyCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"monar" ofType:@"png"]];
            break;
        case SYOBON:
            _enemyCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syobon" ofType:@"png"]];
            break;
        case YARUO:
            _enemyCharacter.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yaruo" ofType:@"png"]];
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //相性判定画面のシャキーンSE音を実装
                         CFURLRef aisyouSyakinURL;
                         SystemSoundID aisyouSyakinID;
                         aisyouSyakinURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_battle10"),CFSTR ("mp3"),NULL);
                         AudioServicesCreateSystemSoundID (aisyouSyakinURL, &aisyouSyakinID);
                         CFRelease (aisyouSyakinURL);
                         AudioServicesPlaySystemSound (aisyouSyakinID);

                        //アニメーション後の位置
                         _myCharacter.frame = CGRectMake(40, [UIScreen mainScreen].bounds.size.height - _myCharacter.image.size.height - 40, _myCharacter.image.size.width, _myCharacter.image.size.height);
                         _enemyCharacter.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - _enemyCharacter.image.size.width - 40, 40, _enemyCharacter.image.size.width, _enemyCharacter.image.size.height);
                     }
                     completion:^(BOOL finished){
                         [self kekkaHyouji];
                         //相性判定画面のドンSE音を実装
                         CFURLRef aisyouDonURL;
                         SystemSoundID aisyouDonID;
                         aisyouDonURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_battle12"),CFSTR ("mp3"),NULL);
                         AudioServicesCreateSystemSoundID (aisyouDonURL, &aisyouDonID);
                         CFRelease (aisyouDonURL);
                         AudioServicesPlaySystemSound (aisyouDonID);
                     }];
}

-(void)kekkaHyouji{
    UIImageView *kekka = [[UIImageView alloc] init]; //真ん中の結果判定画像
    
    //結果（勝ち・負け・引き分け）の画像を設定
    if (app.mySelectCharacter == GIKO) {
        switch (app.enemySelectCharacter) {
            case GIKO:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hikiwake" ofType:@"png"]];
                break;
            case MONAR:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"kati" ofType:@"png"]];
                break;
            case SYOBON:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"make" ofType:@"png"]];
                break;
            case YARUO:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hikiwake" ofType:@"png"]];
                break;
        }
    }else if (app.mySelectCharacter == MONAR){
        switch (app.enemySelectCharacter) {
            case GIKO:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"make" ofType:@"png"]];
                break;
            case MONAR:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hikiwake" ofType:@"png"]];
                break;
            case SYOBON:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"kati" ofType:@"png"]];
                break;
            case YARUO:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hikiwake" ofType:@"png"]];
                break;
        }
    }else if (app.mySelectCharacter == SYOBON){
        switch (app.enemySelectCharacter) {
            case GIKO:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"kati" ofType:@"png"]];
                break;
            case MONAR:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"make" ofType:@"png"]];
                break;
            case SYOBON:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hikiwake" ofType:@"png"]];
                break;
            case YARUO:
                kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hikiwake" ofType:@"png"]];
                break;
        }
    }else if (app.mySelectCharacter == YARUO){
        kekka.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hikiwake" ofType:@"png"]];
    }
    
    //結果画面はど真ん中
    kekka.frame = CGRectMake(0, 0, kekka.image.size.width * 4, kekka.image.size.height * 4);
    kekka.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    kekka.alpha = 0.0f;
    [_kekkaView addSubview:kekka];
    
    [UIView beginAnimations:nil context:nil];  // 条件指定開始
    [UIView setAnimationDuration:0.5];  // 2秒かけてアニメーションを終了させる
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];  // アニメーションは一定速度
    /***アニメーションの内容ここから***/
    kekka.alpha = 1.0f;
    kekka.transform = CGAffineTransformMakeScale(0.25, 0.25);  // サイズを画像の大きさに一致させる
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(kekkaHyouji2)];
    /***アニメーションの内容ここまで***/
    [UIView commitAnimations];  // アニメーション開始！
}

-(void)kekkaHyouji2{
    int kekkaInt = 0; //結果毎に数値を格納（勝ちなら1,負なら2,引き分けなら3）
    if (app.mySelectCharacter == GIKO) {
        switch (app.enemySelectCharacter) {
            case GIKO:
                kekkaInt = 3;
                break;
            case MONAR:
                kekkaInt = 1;
                break;
            case SYOBON:
                kekkaInt = 2;
                break;
            case YARUO:
                kekkaInt = 3;
                break;
        }
    }else if (app.mySelectCharacter == MONAR){
        switch (app.enemySelectCharacter) {
            case GIKO:
                kekkaInt = 2;
                break;
            case MONAR:
                kekkaInt = 3;
                break;
            case SYOBON:
                kekkaInt = 1;
                break;
            case YARUO:
                kekkaInt = 3;
                break;
        }
    }else if (app.mySelectCharacter == SYOBON){
        switch (app.enemySelectCharacter) {
            case GIKO:
                kekkaInt = 1;
                break;
            case MONAR:
                kekkaInt = 2;
                break;
            case SYOBON:
                kekkaInt = 3;
                break;
            case YARUO:
                kekkaInt = 3;
                break;
        }
    }else if (app.mySelectCharacter == YARUO){
        kekkaInt = 3;
    }
    
    switch (kekkaInt) {
        case 1:{
            //自分が勝った場合
            //TODO: 相手のキャラクターを負けた場合の画像にする
            
            //相性判定の結果、勝ちのSE音を実装
            CFURLRef aisyouKekkaURL;
            SystemSoundID aisyouKekkaID;
            aisyouKekkaURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_onepoint16"),CFSTR ("mp3"),NULL);
            AudioServicesCreateSystemSoundID (aisyouKekkaURL, &aisyouKekkaID);
            CFRelease (aisyouKekkaURL);
            AudioServicesPlaySystemSound (aisyouKekkaID);
            
            //アニメーションを開始
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0];
            _enemyCharacter.transform =
            CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height * 2); //キャラクターを落とす
            [UIView commitAnimations];

        }
        break;
        case 2:{
            //自分が負けた場合
            //TODO: 自分のキャラクターを負けた場合の画像にする
            
            //相性判定の結果、負けのSE音を実装
            CFURLRef aisyouKekkaURL;
            SystemSoundID aisyouKekkaID;
            aisyouKekkaURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_onepoint06"),CFSTR ("mp3"),NULL);
            AudioServicesCreateSystemSoundID (aisyouKekkaURL, &aisyouKekkaID);
            CFRelease (aisyouKekkaURL);
            AudioServicesPlaySystemSound (aisyouKekkaID);
            
            //アニメーション開始
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2.0];
            _myCharacter.transform =
            CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height * 2); //キャラクターを落とす
            [UIView commitAnimations];
        }
            break;
        case 3:{
            //相性判定の結果、引き分けのSE音を実装
            CFURLRef aisyouKekkaURL;
            SystemSoundID aisyouKekkaID;
            aisyouKekkaURL  = CFBundleCopyResourceURL (app.mainBundle,CFSTR ("se_maoudamashii_onepoint09"),CFSTR ("mp3"),NULL);
            AudioServicesCreateSystemSoundID (aisyouKekkaURL, &aisyouKekkaID);
            CFRelease (aisyouKekkaURL);
            AudioServicesPlaySystemSound (aisyouKekkaID);
        }
            break;
        default:
            break;
    }
}

- (void)removeJankenHanteiView{
    NSLog(@"aaa");
    [_kekkaView removeFromSuperview];
}

-(void)syncFinished{
    FINISHED1
}

- (void)activate{
    [app activate];
}

-(void)deactivate{
    [app deactivate];
}

- (void)battleStartForInternetBattle{
    [_returnToMainViewButton removeFromSuperview];
    [_localBattleButton removeFromSuperview];
    [_internetBattleButton removeFromSuperview];
    [_blackBack removeFromSuperview];
    app.battleStart = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    //初回起動ならプロローグを表示する
    if (first == 0) {
        [SVProgressHUD popActivity];
        [course dismissViewControllerAnimated:YES completion:nil];
        [self performSelectorOnMainThread:@selector(battleStart)
                               withObject:nil
                            waitUntilDone:NO];
    }else{
        GetEnemyDataFromServer *get = [[GetEnemyDataFromServer alloc] init];
        app.decideAction = NO;
        //相手の入力待ち(app.decideAction = YESとなれば先に進む)
        while (!app.decideAction) {
            [get doEnemyDecideActionNonRoopVersion:YES];
        }
        [NSThread sleepForTimeInterval:0.5];
        [get doEnemyDecideActionRoopVersion:NO]; //対戦相手を見つける過程で、app.decideActionがYESになるため、デフォルトのNOに戻しておく
        
        [SVProgressHUD popActivity];
        SendDataToServer *sendData = [[SendDataToServer alloc] init];
        [sendData send];
        [course dismissViewControllerAnimated:YES completion:nil];
        [self performSelectorOnMainThread:@selector(battleStart)
                               withObject:nil
                            waitUntilDone:NO];
    }
}

- (void)returnToMainView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark- プロローグアニメーション処理


//-------------------------プロローグ改定案ここから-------------------------//

- (void)startAnimation013{
    [app.arrow removeFromSuperview];
    app.arrow.right = _internetBattleButton.left;
    app.arrow.top = _internetBattleButton.top + 5;
    [self.view addSubview:app.arrow];
    [app.blackBack removeFromSuperview];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:_localBattleButton, _returnToMainViewButton, nil] coveredView:self.view];
    [self.view addSubview:app.blackBack];
}


- (void)startAnimation031{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"おっと、相手プレイヤーが見つかったようだ。" characterIsOnLeft:YES];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032)]];
    [app.blackBack removeFromSuperview];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton,   nil] coveredView:self.view];
    [self.view addSubview:app.blackBack];
}

- (void)startAnimation032{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro32" imagePath:@"png" textString:@"まずは画面の説明をするぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_2)]];
}
- (void)startAnimation032_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"これは自分のAAだ。選んだAAが相手を攻撃するぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_3)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_3)]];
    [app.blackBack changeFrame:_myCharacterView.frame coveredView:self.view];
}
- (void)startAnimation032_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"相手のAAだ。相手も同じように攻撃してくるぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_4)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_4)]];
    [app.blackBack changeFrame:_enemyCharacterView.frame coveredView:self.view];
}
- (void)startAnimation032_4{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"自分のHPだ。ゼロになると負けだぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033)]];
    [app.blackBack changeFrame:myLifeImageView.frame coveredView:self.view];
    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation033{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"相手のHPだ。これをゼロにしたら勝ちだ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_1_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_1_2)]];
    [app.blackBack changeFrame:enemyLifeImageView.frame coveredView:self.view];
}
- (void)startAnimation033_1_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあ相手を攻撃してみよう。俺(ギコ)を選んでターン進行ボタンを押してくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.arrowR removeFromSuperview];
    app.arrowR.left = _chara_myGiko.right;
    app.arrowR.top  = _chara_myGiko.top;
    [_myCharacterView addSubview:app.arrowR];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _chara_myMonar, _chara_mySyobon, _chara_myYaruo, nil] coveredView:self.view];
}

- (void)startAnimation033_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"この画面はダメージ計算結果画面だ。相手と自分が受けたダメージが表示されているぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_3)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_3)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _damageCaliculateView, nil] coveredView:self.view];
}
- (void)startAnimation033_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ダメージは「AAの攻撃力」から「AAの防御力」を引いた数値になる。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_4)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_4)]];

}
- (void)startAnimation033_4{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"このターンに自分が食らったダメージは、" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation034)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation034)]];
}
- (void)startAnimation034{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"自分のギコの防御力１から" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035)]];
    [app.arrow removeFromSuperview];
    [self.view addSubview:app.arrow];
    if([YSDeviceHelper is568h]){
        app.arrow.right = 60;
        app.arrow.top   = 140;
    }else{
        app.arrow.right = 60;
        app.arrow.top   = 100;
    }
}
- (void)startAnimation035{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"相手のギコの攻撃力３を差し引いた" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035_2)]];
    if([YSDeviceHelper is568h]){
        app.arrow.right = 60;
        app.arrow.top   = 300;
    }else{
        app.arrow.right = 60;
        app.arrow.top   = 260;
    }
}
- (void)startAnimation035_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"２になっている。相手にも同じダメージを与えたな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation036)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation036)]];
    if([YSDeviceHelper is568h]){
        app.arrow.right = 60;
        app.arrow.top   = 230;
    }else{
        app.arrow.right = 60;
        app.arrow.top   = 190;
    }
}
- (void)startAnimation036{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"よし、それじゃあ画面をタップして次のターンまで進めてくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.arrow removeFromSuperview];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation037{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"２ターン目に入ったな。今度はカードを使ってみよう。まずは手札をタップしてくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:_myCardImageView.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}

- (void)startAnimation037_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"このターンはエネルギーを貯めよう。一番上のカードをタップしてくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
}

- (void)startAnimation038{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"エネルギーカードを使ったら、白エネルギーがひとつ増えたな！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation039)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation039)]];
    [app.arrowR removeFromSuperview];
    [app.blackBack changeFrameAndPermittionView:_myAllEnergy.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
}

- (void)startAnimation039{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"エネルギーはカードを使用するのに不可欠だから、手札にあるならどんどん貯めていこう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation040)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation040)]];
}
- (void)startAnimation040{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあやる夫以外の好きなAAをタップして、次のフェーズに進めよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _chara_myYaruo, nil] coveredView:self.view];
}

- (void)startAnimation041{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"今度は自分がダメージを受けずに、相手のダメージが増えているな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation042)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation042)]];
    [app.blackBack changeFrame:_myCharacterView.frame coveredView:self.view];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCardImageView, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _damageCaliculateView, nil] coveredView:self.view];
}
- (void)startAnimation042{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"実は、ギコはモナー、モナーはショボン、ショボンはギコに相性が良いんだ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation043)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation043)]];
    UIImageView *aishouImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aishou1" ofType:@"png"]]];
    aishouImageView.frame = CGRectMake(10, 20, 300, 300);
    aishouImageView.tag = 99; //あとで画像を差し替えるために、適当なタグを設定
    [self.view addSubview:aishouImageView];
}
- (void)startAnimation043{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"相性が良いAAに攻撃すると、こちらはダメージゼロで、相手には防御力無視の攻撃ができるぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation044)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation044)]];}
- (void)startAnimation044{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあ画面をタップして次のターンまで進めてくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    UIImageView *aishouImageView = (UIImageView *)[self.view viewWithTag:99]; //相性イメージビューを削除
    [aishouImageView removeFromSuperview];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCardImageView, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation045{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"３ターン目。今度はさっき貯めたエネルギーを使って新しくカードを使おう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046)]];
}
- (void)startAnimation046{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"先ほどと同じように手札を開いて、今度は「オプーナ」というソーサリーカードを使ってくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
        [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation046_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"よし、これでカードが使えたな。後は、黒エネルギーカードを手札から使用しておこう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046_2_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046_2_2)]];
}
- (void)startAnimation046_2_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"手札を開いて、「黒エネルギーカード」のカードを使ってくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation046_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"このカードを使用するには白エネルギーが1つ必要だから、白エネルギーを選んでOKを押そう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCardImageView, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
    [app.arrowR removeFromSuperview];
}
- (void)startAnimation047{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあまたやる夫以外のAAを選んでターンを進めよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _chara_myYaruo, nil] coveredView:self.view];
}
- (void)startAnimation048{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"今回はAAの相性が悪くて、自分が3ダメージ食らってしまったな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation049)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation049)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCardImageView, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _damageCaliculateView, nil] coveredView:self.view];
}
- (void)startAnimation049{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"だが、さっき使ったカードの効果で、" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation050)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation050)]];}
- (void)startAnimation050{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"HPが2点回復しているから、結果的にHPは1減っただけ(17点)だな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation051)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation051)]];}
- (void)startAnimation051{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあ次のターンまで進めよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCardImageView, _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation051_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"４ターン目。また新しくエネルギーを貯めて、今度は場カードを使ってみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation052)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation052)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation052{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"「緑エネルギーカード」と「サッカー日本代表」のカードを選んでみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}

- (void)startAnimation052_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"よし、じゃあやる夫以外のAAを選んで、ターンを進行させてみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _chara_myYaruo, nil] coveredView:self.view];
}

- (void)startAnimation053{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"さっき選んだ場カードの効果が、ターン終了時に発揮されているな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation054)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation054)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, _turnResultView, nil] coveredView:self.view];
}
- (void)startAnimation054{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"カードの名前をロングタップすればカードの中身を知ることが出来るぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation055)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation055)]];
}
- (void)startAnimation055{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ロングタップを試してみたら、次のターンに進めよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation056{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"５ターン目。このターンでは今まで使ったカードを確認してみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation057)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation057)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation057{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"まずは墓地を見てみようか。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
    
    //矢印追加。startAnimation058でリムーブ。
    app.arrow.right = _myTomb.left;
    app.arrow.top =_myTomb.top;
    [self.view addSubview:app.arrow];
}
- (void)startAnimation058{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"さっき使ったエネルギーカードとソーサリーカードが墓地に置かれているな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation059)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation059)]];
    [app.arrow removeFromSuperview];
}
- (void)startAnimation059{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"見終わったら、墓地画面の一番下にあるキャンセルボタンを押してくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
}

- (void)startAnimation059_1_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"次は場カード置き場を見てみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
    //矢印追加。startAnimation059_2でリムーブ。
    app.arrow.right = _myField.left;
    app.arrow.top = _myField.top;
    [self.view addSubview:app.arrow];
}

- (void)startAnimation059_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"さっき使った場カードが置かれているな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation060)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation060)]];
    [app.arrow removeFromSuperview];
}
- (void)startAnimation060{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ソーサリーカードは使い切りだが、場カードは何度も効果を発揮するのでお得だぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation060_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation060_2)]];
}

- (void)startAnimation060_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"見終わったら、一番下のキャンセルボタンを押してくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
}

- (void)startAnimation061{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"さて、それじゃあこのターンは緑エネルギーを貯めて、次のターンに備えよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation062{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"今回はやる夫を選んでターンを進行させてみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _chara_myGiko, _chara_myMonar, _chara_mySyobon, nil] coveredView:self.view];
}
- (void)startAnimation063{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"今回はやる夫で相手にダメージを与えられていないな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation064)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation064)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _damageCaliculateView, nil] coveredView:self.view];
}
- (void)startAnimation064{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"やる夫は全てに引き分けてしまうが、ターン終了時に追加でカードを1枚手札に入れられる。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation064_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation064_2)]];
}
- (void)startAnimation064_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ダメージを与えるよりも手札を増やした方が良い場合もあるから、使いどころが重要だぞ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065)]];
}
- (void)startAnimation065{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあターンを進めてみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, nil] coveredView:self.view];
}
- (void)startAnimation066{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"６ターン目。このターンで相手にとどめを刺そう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation067)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation067)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation067{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"新たに緑エネルギーを手札から使用して、" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation068)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation068)]];
}
- (void)startAnimation068{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"「一羽でチュン 二羽でもチュン 三羽そろえば牙をむく」というカードを使用してくれ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
}
- (void)startAnimation069{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"よし、最後はギコを選んでターンを進めてみよう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _chara_myMonar, _chara_mySyobon, _chara_myYaruo, nil] coveredView:self.view];
}

- (void)startAnimation070{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ここでは、さっき選んだギコを選択しておこう。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
}

- (void)startAnimation099{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ちなみに、ここに出てくるダメージには相手に直接与えたダメージは出てこないから注意が必要だ。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_2)]];
}
- (void)startAnimation099_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"相手のライフポイントは残り１点だが、ターン終了時に前のターンに使った場カードの効果が発動するから、その時点で０点になるな。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, nil] coveredView:self.view];
}
- (void)startAnimation100{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ちょうどいま、相手のライフを０点にすることができた。俺達の勝ちだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];
    app.pbImage.userInteractionEnabled = NO;
}


//-------------------------プロローグ改定案ここまで-------------------------//

//- (void)startAnimation013{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro13" imagePath:@"png" textString:@"おや。ローカル対戦とインターネット対戦に分かれてるお？" characterIsOnLeft:YES];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation014)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation014)]];
//    [app.blackBack removeFromSuperview];
//    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) forbidTapActionViewArray:[[NSArray alloc] initWithObjects:_localBattleButton, _internetBattleButton,_returnToMainViewButton, nil] coveredView:self.view];
//    [self.view addSubview:app.blackBack];
//}
//
//- (void)startAnimation014{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro14" imagePath:@"png" textString:@"ローカル対戦は、すぐ隣にいる相手と対戦したいときに選ぶボタンだ。" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation015)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation015)]];
//    [app.blackBack changeFrame:_localBattleButton.frame coveredView:self.view];
//}
//
//- (void)startAnimation015{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro15" imagePath:@"png" textString:@"インターネット対戦は、ネット上で対戦相手を探したいときに選ぶボタンだ。" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation016)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation016)]];
//    [app.blackBack changeFrame:_internetBattleButton.frame coveredView:self.view];
//}
//
//- (void)startAnimation016{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro16" imagePath:@"png" textString:@"今回はインターネット対戦を選ぼう。" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation017)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation017)]];
//}
//
//- (void)startAnimation017{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro17" imagePath:@"png" textString:@"選ぶお。" characterIsOnLeft:YES];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation018)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation018)]];
//}
//
//- (void)startAnimation018{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro18" imagePath:@"png" textString:@"あ、インターネット対戦ボタンを押すとデッキ選択画面が出るが、" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation019)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation019)]];
//    [app.blackBack changeFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) coveredView:self.view];
//}
//
//- (void)startAnimation019{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro19" imagePath:@"png" textString:@"まだ俺達は最小限の枚数のカードしか持っていないからどれを選んでも同じだ。" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation020)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation020)]];
//}
//
//- (void)startAnimation020{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro20" imagePath:@"png" textString:@"とりあえずデッキ１を選んでおこう。" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation021)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation021)]];
//}
//
//- (void)startAnimation021{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro21" imagePath:@"png" textString:@"分かったお。" characterIsOnLeft:YES];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//     [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_localBattleButton,_returnToMainViewButton, nil] coveredView:self.view];
//}
//
//- (void)startAnimation031{
//    [app.pbImage removeFromSuperview];
//    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro31" imagePath:@"png" textString:@"おっと、早速相手プレイヤーが見つかったようだ。" characterIsOnLeft:NO];
//    [self.view addSubview:app.pbImage];
//    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032)]];
//    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032)]];
//    [app.blackBack removeFromSuperview];
//    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:_turnStartView, nil] coveredView:self.view];
//    [self.view addSubview:app.blackBack];
//}
//
//- (void)startAnimation032{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro32" imagePath:@"png" textString:@"これから対戦のルールを説明していくぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_2)]];}
//- (void)startAnimation032_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro32" imagePath:@"png" textString:@"まず、今見えている画面は、ターン開始時に発動したカードを見る画面だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_3)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_3)]];}
//- (void)startAnimation032_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro32" imagePath:@"png" textString:@"あとで詳しく説明するから、とりあえず今は画面をタップして飛ばしてくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_4)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation032_4)]];}
//- (void)startAnimation032_4{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro32_4" imagePath:@"png" textString:@"わかったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:nil coveredView:self.view];
//}
//- (void)startAnimation033{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro33" imagePath:@"png" textString:@"まず、対戦のおおまかなルールだが、カード化されたAAたちの特殊能力を使って俺たちを強化したり、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_1_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_1_2)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton,   nil] coveredView:self.view];
//}
//- (void)startAnimation033_1_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro33" imagePath:@"png" textString:@"相手を弱体化させたりして、相手プレイヤーのライフをゼロにすれば勝ちとなるようだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_2)]];
//}
//- (void)startAnimation033_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro33" imagePath:@"png" textString:@"自分の残りライフの数値はここ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_3)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_3)]];
//    [app.blackBack changeFrame:myLifeImageView.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//
//- (void)startAnimation033_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro33" imagePath:@"png" textString:@"相手の残りライフの数値はここに書いてある。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_4)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_4)]];
//    [app.blackBack changeFrame:enemyLifeImageView.frame coveredView:self.view];
//}
//- (void)startAnimation033_4{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro33" imagePath:@"png" textString:@"普段はお互い20から始まるが、今回は先に4まで減らしておいたぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_5)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation033_5)]];
//    [app.blackBack changeFrame:enemyLifeImageView.frame coveredView:self.view];
//}
//- (void)startAnimation033_5{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro32_4" imagePath:@"png" textString:@"ここの数値が最終的にゼロになればいいんだお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation034)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation034)]];
//}
//- (void)startAnimation034{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro34" imagePath:@"png" textString:@"ところで、向こうにもやる夫たちがいるみたいだけど、見間違いかお……？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035)]];
//    [app.blackBack changeFrame:_enemyCharacterView.frame coveredView:self.view];
//}
//- (void)startAnimation035{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro35" imagePath:@"png" textString:@"なぜかは分からんが、AAの中でも俺たちだけがカード化されていないようだな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation035_2)]];
//    [app.blackBack changeFrame:self.view.frame coveredView:self.view];
//}
//- (void)startAnimation035_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro35" imagePath:@"png" textString:@"AAはコピーし放題だから、同類もたくさんいるわけだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation036)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation036)]];
//}
//- (void)startAnimation036{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro36" imagePath:@"png" textString:@"うう、同じ顔をしたやる夫を殴るのはいやだお……" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation037)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation037)]];}
//- (void)startAnimation037{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro37" imagePath:@"png" textString:@"そうだお！常に相手のギコを殴るお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation038)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation038)]];}
//- (void)startAnimation038{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro38" imagePath:@"png" textString:@"おらっしゃあぁぁ！！！" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation039)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation039)]];}
//- (void)startAnimation039{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro39" imagePath:@"png" textString:@"ぶううぅうぅ！！！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation040)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation040)]];}
//- (void)startAnimation040{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro40" imagePath:@"png" textString:@"じょ、冗談だお……" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation041)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation041)]];}
//- (void)startAnimation041{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro41" imagePath:@"png" textString:@"それは置いといて、まず、ここが俺たちがいる位置だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation042)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation042)]];
//    [app.blackBack changeFrame:_myCharacterView.frame coveredView:self.view];
//}
//- (void)startAnimation042{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro42" imagePath:@"png" textString:@"？？？そもそもなんでAAが４種類もあるんだお？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation043)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation043)]];}
//- (void)startAnimation043{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro43" imagePath:@"png" textString:@"AAの間には相性関係があるんだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation044)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation044)]];}
//- (void)startAnimation044{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro44" imagePath:@"png" textString:@"相性関係？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation045)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation045)]];}
//- (void)startAnimation045{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro45" imagePath:@"png" textString:@"簡単に言うと、ギコはショボンに強く、ショボンはモナーに強く、モナーはギコに強い。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046)]];
//    UIImageView *aishouImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aishou1" ofType:@"png"]]];
//    aishouImageView.frame = CGRectMake(10, 20, 300, 300);
//    aishouImageView.tag = 99; //あとで画像を差し替えるために、適当なタグを設定
//    [self.view addSubview:aishouImageView];
//}
//- (void)startAnimation046{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro46" imagePath:@"png" textString:@"通常、相手プレイヤーに与えるダメージは、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046_1_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046_1_2)]];}
//- (void)startAnimation046_1_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro46" imagePath:@"png" textString:@"「自分が選んだAAの攻撃力」から「相手が選んだAAの防御力」を引いた数値になるが、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation046_2)]];}
//- (void)startAnimation046_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro46" imagePath:@"png" textString:@"強いAAは弱いAAに対して防御力を無視して攻撃することが出来るんだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation047)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation047)]];}
//- (void)startAnimation047{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro47" imagePath:@"png" textString:@"ん？この図にはやる夫が出てきてないお・・・？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation048)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation048)]];}
//- (void)startAnimation048{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro48" imagePath:@"png" textString:@"やる夫は他の全てのAAに弱い。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation049)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation049)]];
//    
//    UIImageView *aishouImageView = (UIImageView *)[self.view viewWithTag:99]; //相性イメージビューを更新
//    aishouImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aishou2" ofType:@"png"]];
//}
//- (void)startAnimation049{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro49" imagePath:@"png" textString:@"ブーッ！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation050)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation050)]];}
//- (void)startAnimation050{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro50" imagePath:@"png" textString:@"ただし、やる夫は毎ターン追加で１枚カードを山札から手札に入れることができる。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation051)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation051)]];}
//- (void)startAnimation051{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro51" imagePath:@"png" textString:@"手札の上限は５枚だからたくさん手に入れても捨てなきゃいけないが、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation051_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation051_2)]];}
//- (void)startAnimation051_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro51" imagePath:@"png" textString:@"新しくカードが手に入ればゲームを有利に進めることが出来るぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation052)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation052)]];}
//- (void)startAnimation052{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro52" imagePath:@"png" textString:@"やる夫！できる子だお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation053)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation053)]];}
//- (void)startAnimation053{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro53" imagePath:@"png" textString:@"それぞれのAAは、攻撃力が３，防御力は０で設定されている。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation054)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation054)]];
//    UIImageView *aishouImageView = (UIImageView *)[_allImageView viewWithTag:99]; //相性イメージビューを削除
//    [aishouImageView removeFromSuperview];
//}
//- (void)startAnimation054{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro54" imagePath:@"png" textString:@"ただし、やる夫だけは特別で、攻撃力が０，防御力が１で設定されている。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation055)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation055)]];
//}
//- (void)startAnimation055{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro55" imagePath:@"png" textString:@"AAをタップすることで、攻撃するAAを選択することが出来るぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation056)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation056)]];}
//- (void)startAnimation056{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro56" imagePath:@"png" textString:@"試しに俺（ギコ）を選んでみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation057)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation057)]];}
//- (void)startAnimation057{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro57" imagePath:@"png" textString:@"選んでみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//    
//    //相性表を削除
//    UIImageView *aishouImageView = (UIImageView *)[self.view viewWithTag:99];
//    [aishouImageView removeFromSuperview];
//}
//- (void)startAnimation058{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro58" imagePath:@"png" textString:@"OKだ。次に、ここが相手がいる位置だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation059)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation059)]];
//    [app.blackBack changeFrameAndPermittionView:_enemyCharacterView.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//}
//- (void)startAnimation059{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro59" imagePath:@"png" textString:@"相手がどのAAで攻撃してくるかは、実際に攻撃されるまで分からないので、そこの読み合いも重要だぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation059_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation059_2)]];}
//- (void)startAnimation059_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro59" imagePath:@"png" textString:@"次に、ここが山札の位置。山札の残り枚数が書いてあるぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation060)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation060)]];
//    [app.blackBack changeFrame:_myLibrary.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation060{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro60" imagePath:@"png" textString:@"次に、ここが手札の位置。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation061)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation061)]];
//    [app.blackBack changeFrame:_myCardImageView.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation061{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro61" imagePath:@"png" textString:@"手札を見ると、今手札にあるカードの効果とコストを見ることが出来る。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation062)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation062)]];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation062{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro62" imagePath:@"png" textString:@"コスト？コストってなんだお？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation063)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation063)]];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation063{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro63" imagePath:@"png" textString:@"コストとは、そのカードを使うのに必要なエネルギーのことだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation064)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation064)]];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation064{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro64" imagePath:@"png" textString:@"総じて、強い効果を持つカードほど必要なエネルギーも多いようだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065)]];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation065{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro65" imagePath:@"png" textString:@"エネルギーは白・青・黒・赤・緑の５色あって、カード毎に要求されるエネルギーの種類や量が違うぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_2)]];
//    [app.blackBack changeFrame:_myAllEnergy.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation065_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro65" imagePath:@"png" textString:@"普段はお互いに全色のエネルギーが0で始まるが、今回は先に全て5ずつためておいた。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_3)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_3)]];
//    [app.blackBack changeFrame:_myAllEnergy.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation065_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro65" imagePath:@"png" textString:@"青色で書かれている数値は、各色ごとの今もっているエネルギーの数だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_4)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_4)]];
//    [app.blackBack changeFrame:_myAllEnergy.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation065_4{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro65" imagePath:@"png" textString:@"一方、赤色で書かれている数値は、各色ごとのこのターン使ったエネルギーの数だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_5)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_5)]];
//    [app.blackBack changeFrame:_myAllEnergy.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation065_5{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro65" imagePath:@"png" textString:@"今持っているエネルギー（青色の数値）はどんなに使っても次のターンに回復するから、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_6)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation065_6)]];
//    [app.blackBack changeFrame:_myAllEnergy.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation065_6{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro65" imagePath:@"png" textString:@"なるべく毎ターン使いきったほうがお得だぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation066)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation066)]];
//    [app.blackBack changeFrame:_myAllEnergy.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation066{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro66" imagePath:@"png" textString:@"エネルギーは、エネルギーカードを使用することで手に入れることができる。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation066_1_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation066_1_2)]];
//    [app.blackBack changeFrame:_myCardImageView.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation066_1_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro66" imagePath:@"png" textString:@"試しに手札を開いて、一番上のカードを使ってみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation066_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation066_2)]];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation066_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro66" imagePath:@"png" textString:@"手札を開くには、自分の手札をタップすればいいぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:_enemyCharacterView.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView,  _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//    [app.blackBack changeFrame:self.view.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation066_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro66" imagePath:@"png" textString:@"一番上のカードをタップしてくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrame:self.view.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation067{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro67" imagePath:@"png" textString:@"あ！白のエネルギーが１つ増えたお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation068)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation068)]];
//    [app.blackBack changeFrameAndPermittionView:_myAllEnergy.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation068{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro68" imagePath:@"png" textString:@"次に、また一番上のカードを使ってみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069)]];
//    [app.blackBack changeFrame:_myCardImageView.frame coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation069{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro69" imagePath:@"png" textString:@"使ってみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//    app.pbImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation069_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro69" imagePath:@"png" textString:@"おや？この画面はなんだお" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_3)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_3)]];
//}
//- (void)startAnimation069_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro68" imagePath:@"png" textString:@"この画面は、カードの効果を発動するために使うエネルギーを選ぶ画面だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_4)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_4)]];
//}
//- (void)startAnimation069_4{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro68" imagePath:@"png" textString:@"今回使うカードの必要コストは白エネルギー1つ、その他2つだから、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_5)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_5)]];
//}
//- (void)startAnimation069_5{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro68" imagePath:@"png" textString:@"白のエネルギーを1つ、青のエネルギーを2つ選んでみよう。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_6)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_6)]];
//}
//- (void)startAnimation069_6{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro68" imagePath:@"png" textString:@"「→」を押せば使用するエネルギーが増え、「←」を押せば減らすことが出来るぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_7)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_7)]];
//}
//- (void)startAnimation069_7{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro68" imagePath:@"png" textString:@"使うエネルギーが決まったら、OKボタンを押せばいい。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_8)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation069_8)]];
//}
//- (void)startAnimation069_8{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro69" imagePath:@"png" textString:@"わかったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//}
//- (void)startAnimation070{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro70" imagePath:@"png" textString:@"あれ？なにも起こらないお？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation071)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation071)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//}
//- (void)startAnimation071{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro71" imagePath:@"png" textString:@"今使ったカードは「ソーサリー」という種類のカードなんだが、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation071_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation071_2)]];}
//- (void)startAnimation071_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro71" imagePath:@"png" textString:@"ソーサリーカードは、ターンを進めることで効果を発揮する。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation072)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation072)]];}
//- (void)startAnimation072{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro72" imagePath:@"png" textString:@"ソーサリーカードは一回きりの使い捨てカードだ。墓地フィールドを見てみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation073)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation073)]];
//    [app.blackBack changeFrame:_myTomb.frame coveredView:self.view];
//}
//- (void)startAnimation073{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro73" imagePath:@"png" textString:@"見てみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//}
//- (void)startAnimation074{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro74" imagePath:@"png" textString:@"あ、使ったカードが墓地フィールドに置かれてるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation075)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation075)]];}
//- (void)startAnimation075{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro75" imagePath:@"png" textString:@"よし、じゃあ対戦画面に戻ろう。キャンセルボタンを押してくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation076)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation076)]];
//}
//- (void)startAnimation076{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro76" imagePath:@"png" textString:@"その後、もう一度手札の一番上のカードを使ってみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation077)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation077)]];
//}
//- (void)startAnimation077{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro77" imagePath:@"png" textString:@"使ってみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrame:self.view.frame coveredView:self.view];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//}
//- (void)startAnimation078{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro78" imagePath:@"png" textString:@"あれ？また何も起こらないお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation079)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation079)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _myField, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//}
//- (void)startAnimation079{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro79" imagePath:@"png" textString:@"場カードも、ターンを進めると効果を発揮するカードだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation080)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation080)]];}
//- (void)startAnimation080{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro80" imagePath:@"png" textString:@"こいつは一回きりの使い捨てではなく、場にあるかぎりは何度でも効果を発揮する。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation081)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation081)]];}
//- (void)startAnimation081{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro81" imagePath:@"png" textString:@"へー。それは便利だお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation082)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation082)]];}
//- (void)startAnimation082{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro82" imagePath:@"png" textString:@"効果を発揮するタイミングは、ターンの開始時・攻撃時・ターンの終了時等いろいろあるぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation083)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation083)]];}
//- (void)startAnimation083{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro83" imagePath:@"png" textString:@"よくわからないお・・・・・・" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation084)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation084)]];}
//- (void)startAnimation084{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro84" imagePath:@"png" textString:@"まぁ使っているうちに慣れるさ。場フィールドを見てみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation085)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation085)]];
//    [app.blackBack changeFrame:_myField.frame coveredView:self.view];
//}
//- (void)startAnimation085{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro85" imagePath:@"png" textString:@"見てみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//   [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb, _enemyField, _goodGame, _okButton, nil] coveredView:self.view];
//}
//
//- (void)startAnimation086{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro86" imagePath:@"png" textString:@"あ、今使ったカードが、今度は場フィールドに置かれてるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation087)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation087)]];}
//- (void)startAnimation087{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro87" imagePath:@"png" textString:@"ここに置かれている限り、場カードは効果を発揮し続ける。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation088)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation088)]];}
//- (void)startAnimation088{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro88" imagePath:@"png" textString:@"ただし、カードの中には、場カードを破壊するカードもあるらしいから気をつけたほうがいいぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation089)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation089)]];}
//- (void)startAnimation089{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro89" imagePath:@"png" textString:@"わかったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation090)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation090)]];}
//- (void)startAnimation090{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro90" imagePath:@"png" textString:@"よし、じゃあターンを進めよう。AAとカードを選択したから、次はターン進行ボタンを押そう。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation090_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation090_2)]];}
//- (void)startAnimation090_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro90" imagePath:@"png" textString:@"ターン進行ボタンは、場フィールドボタンのすぐ上だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation091)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation091)]];
//    [app.blackBack changeFrame:_okButton.frame coveredView:self.view];
//}
//- (void)startAnimation091{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro91" imagePath:@"png" textString:@"わかったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb,_myField, _enemyField, _goodGame, nil] coveredView:self.view];
//}
//- (void)startAnimation092{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro92" imagePath:@"png" textString:@"お。自分が使ったカードが見えるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation093)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation093)]];
//    
//}
//- (void)startAnimation093{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro93" imagePath:@"png" textString:@"さっき使ったカードだな。横にスクロールすれば、全てのカードが見られるぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation093_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation093_2)]];}
//- (void)startAnimation093_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro93" imagePath:@"png" textString:@"見終わったら、戻るボタンを押してくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation094)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation094)]];}
//- (void)startAnimation094{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro94" imagePath:@"png" textString:@"わかったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects: nil] coveredView:self.view];
//}
//- (void)startAnimation095{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro95" imagePath:@"png" textString:@"相手が使ってきたカードが出ているお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation096)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation096)]];}
//- (void)startAnimation096{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro96" imagePath:@"png" textString:@"相手はAAを強化するカードを使ってきたようだな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation096_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation096_2)]];}
//- (void)startAnimation096_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro96" imagePath:@"png" textString:@"ちなみに、カードは基本的に自分と相手が同時に使用することになるぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation097)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation097)]];}
//- (void)startAnimation097{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro97" imagePath:@"png" textString:@"それじゃあまた戻るボタンを押してくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation098)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation098)]];}
//- (void)startAnimation098{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro98" imagePath:@"png" textString:@"わかったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb,_myField, _enemyField, _goodGame, _okButton, nil ] coveredView:self.view];
//}
//- (void)startAnimation099{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro99" imagePath:@"png" textString:@"あ、ダメージ計算フェーズに入ったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation100)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation100)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb,_myField, _enemyField, _goodGame, _okButton, _damageCaliculateView,resultFadeinScrollView, nil ] coveredView:self.view];
//}
//- (void)startAnimation100{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro100" imagePath:@"png" textString:@"この画面では互いが選んだAA、攻撃力、防御力、攻撃・防御許可、受けたダメージが表示されている。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation101)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation101)]];}
//- (void)startAnimation101{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro101" imagePath:@"png" textString:@"ち、ちんぷんかんぷんだお・・・" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation102)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation102)]];}
//- (void)startAnimation102{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro102" imagePath:@"png" textString:@"ひとつずつ解説していこう。まず、自分と相手が選んだAAの種類。これはわかるな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation103)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation103)]];}
//- (void)startAnimation103{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro103" imagePath:@"png" textString:@"当然だお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation103_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation103_2)]];}
//- (void)startAnimation103_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro102" imagePath:@"png" textString:@"赤文字になっているAAが、自分と相手が選んだAAだ。今回はお互いギコを選んだな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation104)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation104)]];}
//- (void)startAnimation104{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro104" imagePath:@"png" textString:@"次に、基本攻撃力と修正攻撃力だ。\"○○+○○\"と書かれている攻撃力のうち、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation104_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation104_2)]];
//    if([YSDeviceHelper is568h]){
//        [app.blackBack changeFrame:CGRectMake(95, 165, 60, 15) coveredView:self.view];
//    }else{
//        [app.blackBack changeFrame:CGRectMake(95, 122, 60, 15) coveredView:self.view];
//    }
//}
//- (void)startAnimation104_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro104" imagePath:@"png" textString:@"左側が基本攻撃力、右側が修正攻撃力だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation104_3)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation104_3)]];}
//- (void)startAnimation104_3{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro104" imagePath:@"png" textString:@"基本攻撃力はAAが本来持つ攻撃力３が普通だが、まれにこの攻撃力を底上げするカードも有るようだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation105)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation105)]];}
//- (void)startAnimation105{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro105" imagePath:@"png" textString:@"基本攻撃力は、一度上がれば基本的に下がることはない。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation106)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation106)]];}
//- (void)startAnimation106{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro106" imagePath:@"png" textString:@"すると、ずっと攻撃力が高いままだってことだお！お得だお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation107)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation107)]];}
//- (void)startAnimation107{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro107" imagePath:@"png" textString:@"一方で、修正攻撃力はそのターンだけの攻撃力の増減だけを反映する。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation108)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation108)]];}
//- (void)startAnimation108{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro108" imagePath:@"png" textString:@"ただし、修正攻撃力を増減させるカードはコストが低いから使いやすいという利点もあるぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation109)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation109)]];}
//- (void)startAnimation109{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro109" imagePath:@"png" textString:@"なるほどだお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation110)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation110)]];}
//- (void)startAnimation110{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro110" imagePath:@"png" textString:@"次に、基本防御力と修正防御力だが、もうこれはわかるな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation111)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation111)]];
//    if([YSDeviceHelper is568h]){
//        [app.blackBack changeFrame:CGRectMake(150, 165, 60, 15) coveredView:self.view];
//    }else{
//        [app.blackBack changeFrame:CGRectMake(150, 122, 60, 15) coveredView:self.view];
//    }
//}
//- (void)startAnimation111{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro111" imagePath:@"png" textString:@"わかるお。基本攻撃力・修正攻撃力と同じ関係だお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation112)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation112)]];}
//- (void)startAnimation112{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro112" imagePath:@"png" textString:@"そのとおりだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation113)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation113)]];}
//- (void)startAnimation113{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro113" imagePath:@"png" textString:@"次に、攻撃許可・防御許可だが、カードの中には、攻撃や防御を封じる効果を持つものがあるようだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation114)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation114)]];
//    if([YSDeviceHelper is568h]){
//        [app.blackBack changeFrame:CGRectMake(210, 165, 65, 15) coveredView:self.view];
//    }else{
//        [app.blackBack changeFrame:CGRectMake(210, 122, 65, 15) coveredView:self.view];
//    }
//}
//- (void)startAnimation114{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro114" imagePath:@"png" textString:@"そんなカードを相手に使われた時には、自分は攻撃・防御ができなくなってしまう。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation115)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation115)]];}
//- (void)startAnimation115{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro115" imagePath:@"png" textString:@"その場合、ここの表示はどうなるんだお？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation116)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation116)]];}
//- (void)startAnimation116{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro116" imagePath:@"png" textString:@"こうなる。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation117)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation117)]];
//    UIImageView *sampleImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"attackForbidedImage" ofType:@"png"]]];
//    sampleImage.frame = CGRectMake(50, 50, 228, 128);
//    sampleImage.tag = 99;
//    [self.view addSubview:sampleImage];
//}
//- (void)startAnimation117{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro117" imagePath:@"png" textString:@"なるほど、×が表示されるんだお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation118)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation118)]];}
//- (void)startAnimation118{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro118" imagePath:@"png" textString:@"わかりやすいな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation119)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation119)]];}
//- (void)startAnimation119{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro119" imagePath:@"png" textString:@"さて、最後はダメージ欄だ。ここには相手のAAから受けたダメージが表示される。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation120)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation120)]];
//    if([YSDeviceHelper is568h]){
//        [app.blackBack changeFrame:CGRectMake(60, 255, 130, 15) coveredView:self.view];
//    }else{
//        [app.blackBack changeFrame:CGRectMake(60, 212, 130, 15) coveredView:self.view];
//    }
//    
//    UIImageView *sampleImage = (UIImageView *)[self.view viewWithTag:99];
//    [sampleImage removeFromSuperview];
//}
//- (void)startAnimation120{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro120" imagePath:@"png" textString:@"カードの中には直接相手のライフにダメージを与える効果を持つものもあるが、" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation120_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation120_2)]];}
//- (void)startAnimation120_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro120" imagePath:@"png" textString:@"その効果によるダメージはここには表示されないから注意しろよ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation121)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation121)]];}
//- (void)startAnimation121{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro121" imagePath:@"png" textString:@"わかったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation122)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation122)]];}
//- (void)startAnimation122{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro122" imagePath:@"png" textString:@"よし、少し長くなったが、これで戦闘フェーズは終わりだ。画面をタップしてくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation123)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation123)]];
//    [app.blackBack changeFrame:self.view.frame coveredView:self.view];
//}
//- (void)startAnimation123{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro123" imagePath:@"png" textString:@"わかったお！" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb,_myField, _enemyField, _goodGame, _okButton, nil ] coveredView:self.view];
//}
//- (void)startAnimation124{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro124" imagePath:@"png" textString:@"あ、ターン終了時に発動したカードが載ってるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation125)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation125)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb,_myField, _enemyField, _goodGame, _okButton, _turnResultView, nil ] coveredView:self.view];
//}
//- (void)startAnimation125{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro125" imagePath:@"png" textString:@"これはさっきやる夫が使ったカードだな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation125_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation125_2)]];}
//- (void)startAnimation125_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro125" imagePath:@"png" textString:@"カードに書かれていたテキスト通り、ターン終了時に相手に1点ダメージを与えるんだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation126)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation126)]];}
//- (void)startAnimation126{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro126" imagePath:@"png" textString:@"ちなみに、カード名を長押しすればカード効果の詳細を確認することが出来るぞ。やってみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation127)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation127)]];}
//- (void)startAnimation127{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro127" imagePath:@"png" textString:@"やってみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:_myCharacterView, _myCardImageView, _myTomb, _enemyTomb,_myField, _enemyField, _goodGame, _okButton,  nil ] coveredView:self.view];
//}
//- (void)startAnimation128{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro128" imagePath:@"png" textString:@"あ、出たお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation129)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation129)]];}
//- (void)startAnimation129{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro129" imagePath:@"png" textString:@"この画面を消したければ、カードを軽くタップすればいい。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];}
//- (void)startAnimation130{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro130" imagePath:@"png" textString:@"あ、消えたお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation130_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation130_2)]];}
//- (void)startAnimation130_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro129" imagePath:@"png" textString:@"よし。それじゃあ画面をタップして、ターンを進めてくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//}
//- (void)startAnimation131{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro131" imagePath:@"png" textString:@"ちょうどいま、相手のライフを０点にすることができた。俺達の勝ちだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];
//    app.pbImage.userInteractionEnabled = NO;
//}




- (void)removeViewOnPrologue:(UITapGestureRecognizer *)sender{
    for (UIView *view in app.pbImage.subviews) {
        [view removeFromSuperview];
    }
    [app.pbImage removeFromSuperview];
}

@end
