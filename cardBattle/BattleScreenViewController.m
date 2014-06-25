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
    detailOfACard.frame = CGRectMake(0, 0, 280, 420);
    detailOfACard.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
    costOfCard = [[NSArray alloc] init];
    
    //iPhone5ならYES,それ以外ならNOに行く
    if([YSDeviceHelper is568h]){
        //        _myCardImageViewArray = [[NSMutableArray alloc] init];
        //
        //        _allImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        //        _allImageView.userInteractionEnabled = YES;
        //
        //
        //        _myCardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 360, [[UIScreen mainScreen] bounds].size.width, CARDHEIGHT)];
        //        _myCardImageView.userInteractionEnabled = YES;
        //        [_allImageView addSubview:_myCardImageView];
        //
        //
        //
        //        _border_character = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_character.png"]];
        //        _border_middleCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_middleCard.png"]];
        //        _border_middleCard.userInteractionEnabled = YES;
        //        _border_usedCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_usedCard.png"]];
        //        //_border_usedCard.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        //
        //        _additionalCostView = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 60, [[UIScreen mainScreen] bounds].size.width - 40 , 400)];
        //
        //        _cardInRegion = [[UIScrollView alloc] init];
        //        _regionView = [[UIImageView alloc] init];
        //        _regionViewArray =[[NSMutableArray alloc] init];
        //
        //        _colorView = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 60, [[UIScreen mainScreen] bounds].size.width - 40 , 400)];
        //
        //        _okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //        [_okButton setTitle:@"OK" forState:UIControlStateNormal];
        //        [_allImageView addSubview:_okButton];
        //        _okButton.frame = CGRectMake(_allImageView.bounds.size.width - 110, _allImageView.bounds.size.height - 130, 100, 20);
        //        [_okButton addTarget:self action:@selector(okButton)
        //            forControlEvents:UIControlEventTouchUpInside];
        //
        //
        //
        //        UIImage *img_myGiko     = [UIImage imageNamed:@"c0r.PNG"];
        //        UIImage *img_myMonar     = [UIImage imageNamed:@"c5r.PNG"];
        //        UIImage *img_mySyobon         = [UIImage imageNamed:@"c7r.PNG"];
        //        UIImage *img_myYaruo     = [UIImage imageNamed:@"c1r.PNG"];
        //        UIImage *img_enemyGiko  = [UIImage imageNamed:@"c0r.PNG"];
        //        UIImage *img_enemyMonar  = [UIImage imageNamed:@"c5r.PNG"];
        //        UIImage *img_enemySyobon      = [UIImage imageNamed:@"c7r.PNG"];
        //        UIImage *img_enemyYaruo  = [UIImage imageNamed:@"c1r.PNG"];
        //
        //        UIImageView *chara_myGiko       = [[UIImageView alloc] initWithImage:img_myGiko];
        //        UIImageView *chara_myMonar       = [[UIImageView alloc] initWithImage:img_myMonar];
        //        UIImageView *chara_mySyobon           = [[UIImageView alloc] initWithImage:img_mySyobon];
        //        UIImageView *chara_myYaruo       = [[UIImageView alloc] initWithImage:img_myYaruo];
        //        UIImageView *chara_enemyGiko    = [[UIImageView alloc] initWithImage:img_enemyGiko];
        //        UIImageView *chara_enemyMonar    = [[UIImageView alloc] initWithImage:img_enemyMonar];
        //        UIImageView *chara_enemySyobon        = [[UIImageView alloc] initWithImage:img_enemySyobon];
        //        UIImageView *chara_enemyYaruo    = [[UIImageView alloc] initWithImage:img_enemyYaruo];
        //
        //        chara_myGiko.frame      = CGRectMake(48,  50,  32, 48);
        //        chara_myMonar.frame      = CGRectMake(48,  98,  32, 48);
        //        chara_mySyobon.frame          = CGRectMake(48, 146,  32, 48);
        //        chara_myYaruo.frame      = CGRectMake(80,  98,  32, 48);
        //        chara_enemyGiko.frame   = CGRectMake(240,  50,  32, 48);
        //        chara_enemyMonar.frame   = CGRectMake(240,  98,  32, 48);
        //        chara_enemySyobon.frame       = CGRectMake(240,  146, 32, 48);
        //        chara_enemyYaruo.frame   = CGRectMake(208,  98,  32, 48);
        //
        //        chara_myGiko.userInteractionEnabled     = YES;
        //        chara_myMonar.userInteractionEnabled     = YES;
        //        chara_mySyobon.userInteractionEnabled         = YES;
        //        chara_myYaruo.userInteractionEnabled     = YES;
        //        chara_enemyGiko.userInteractionEnabled  = YES;
        //        chara_enemyMonar.userInteractionEnabled  = YES;
        //        chara_enemySyobon.userInteractionEnabled      = YES;
        //        chara_enemyYaruo.userInteractionEnabled  = YES;
        //
        //
        //        chara_myGiko.tag    = GIKO;
        //        chara_myMonar.tag    = MONAR;
        //        chara_mySyobon.tag        = SYOBON;
        //        chara_myYaruo.tag    = YARUO;
        //        /*
        //         chara_enemyGiko.tag = ;
        //         chara_enemyMonar.tag = ;
        //         chara_enemySYOBON.tag     = ;
        //         chara_enemyYaruo.tag = ;
        //         */
        //
        //        [chara_myGiko addGestureRecognizer:
        //         [[UITapGestureRecognizer alloc]
        //          initWithTarget:self action:@selector(touchesBegan:)]];
        //        [chara_myMonar addGestureRecognizer:
        //         [[UITapGestureRecognizer alloc]
        //          initWithTarget:self action:@selector(touchesBegan:)]];
        //        [chara_mySyobon addGestureRecognizer:
        //         [[UITapGestureRecognizer alloc]
        //          initWithTarget:self action:@selector(touchesBegan:)]];
        //        [chara_myYaruo addGestureRecognizer:
        //         [[UITapGestureRecognizer alloc]
        //          initWithTarget:self action:@selector(touchesBegan:)]];
        //        //    [chara_enemyGiko addGestureRecognizer:
        //        //     [[UITapGestureRecognizer alloc]
        //        //      initWithTarget:self action:@selector(touchesBegan:)]];
        //        //    [chara_enemyMonar addGestureRecognizer:
        //        //     [[UITapGestureRecognizer alloc]
        //        //      initWithTarget:self action:@selector(touchesBegan:)]];
        //        //    [chara_enemySyobon addGestureRecognizer:
        //        //     [[UITapGestureRecognizer alloc]
        //        //      initWithTarget:self action:@selector(touchesBegan:)]];
        //        //    [chara_enemyYaruo addGestureRecognizer:
        //        //     [[UITapGestureRecognizer alloc]
        //        //      initWithTarget:self action:@selector(touchesBegan:)]];
        //
        //        [_allImageView addSubview:chara_myGiko];
        //        [_allImageView addSubview:chara_myMonar];
        //        [_allImageView addSubview:chara_mySyobon];
        //        [_allImageView addSubview:chara_myYaruo];
        //        [_allImageView addSubview:chara_enemyGiko];
        //        [_allImageView addSubview:chara_enemyMonar];
        //        [_allImageView addSubview:chara_enemySyobon];
        //        [_allImageView addSubview:chara_enemyYaruo];
        //
        //
        //
        //
        //        //エネルギーの数を表示するビューを作成
        //        _myWhiteEnergyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteEnergyImage"]];
        //        _myBlueEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueEnergyImage"]];
        //        _myBlackEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackEnergyImage"]];
        //        _myRedEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redEnergyImage"]];
        //        _myGreenEnergyImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenEnergyImage"]];
        //
        //        _myAllEnergy = [[UIImageView alloc] init];
        //        [_myAllEnergy addSubview:_myWhiteEnergyImage];
        //        [_myAllEnergy addSubview:_myBlueEnergyImage];
        //        [_myAllEnergy addSubview:_myBlackEnergyImage];
        //        [_myAllEnergy addSubview:_myRedEnergyImage];
        //        [_myAllEnergy addSubview:_myGreenEnergyImage];
        //
        //        _myWhiteEnergyImage.frame = CGRectMake(  0,  0, 20, 20);
        //        _myBlueEnergyImage.frame  = CGRectMake( 70,  0, 20, 20);
        //        _myBlackEnergyImage.frame = CGRectMake(140,  0, 20, 20);
        //        _myRedEnergyImage.frame   = CGRectMake(210,  0, 20, 20);
        //        _myGreenEnergyImage.frame = CGRectMake(280,  0, 20, 20);
        //
        //
        //        _myWhiteEnergyText = [[UITextView alloc] init];
        //        _myBlueEnergyText = [[UITextView alloc] init];
        //        _myBlackEnergyText = [[UITextView alloc] init];
        //        _myRedEnergyText = [[UITextView alloc] init];
        //        _myGreenEnergyText = [[UITextView alloc] init];
        //
        //        _myWhiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:0] intValue]];
        //        _myBlueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:1] intValue]];
        //        _myBlackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:2] intValue]];
        //        _myRedEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:3] intValue]];
        //        _myGreenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.myEnergyCard objectAtIndex:4] intValue]];
        //
        //        [_myAllEnergy addSubview:_myWhiteEnergyText];
        //        [_myAllEnergy addSubview:_myBlueEnergyText];
        //        [_myAllEnergy addSubview:_myBlackEnergyText];
        //        [_myAllEnergy addSubview:_myRedEnergyText];
        //        [_myAllEnergy addSubview:_myGreenEnergyText];
        //
        //        _myWhiteEnergyText.frame = CGRectMake( 20, 0, 40, 20);
        //        _myBlueEnergyText.frame  = CGRectMake( 90, 0, 40, 20);
        //        _myBlackEnergyText.frame = CGRectMake(160, 0, 40, 20);
        //        _myRedEnergyText.frame   = CGRectMake(230, 0, 40, 20);
        //        _myGreenEnergyText.frame = CGRectMake(300, 0, 40, 20);
        //
        //        [_allImageView addSubview: _myAllEnergy];
        //        _myAllEnergy.frame = CGRectMake(10, _myAllEnergy.superview.bounds.size.height - 25, 340, 20);
        //
        //        _myGiko = [[UILabel alloc] init];
        //        _myMonar = [[UILabel alloc] init];
        //        _mySyobon = [[UILabel alloc] init];
        //        _myYaruo = [[UILabel alloc] init];
        //        _enemyGiko = [[UILabel alloc] init];
        //        _enemyMonar = [[UILabel alloc] init];
        //        _enemySyobon = [[UILabel alloc] init];
        //        _enemyYaruo = [[UILabel alloc] init];
        //
        //        [self.view addSubview:_allImageView];
    }else{
        
        
        _myCardImageViewArray = [[NSMutableArray alloc] init];
        
        _allImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _allImageView.userInteractionEnabled = YES;
        
        _myCardImageView = [[UIImageView alloc] init];
        _myCardImageView.userInteractionEnabled = YES;
        [_allImageView addSubview:_myCardImageView];
        _myCardImageView.frame = CGRectMake(0, _myCardImageView.superview.bounds.size.height - 90, _myCardImageView.superview.bounds.size.width, CARDHEIGHT);
        
        _enemyCardImageView = [[UIImageView alloc] init];
        _enemyCardImageView.userInteractionEnabled = YES;
        [_allImageView addSubview:_enemyCardImageView];
        _enemyCardImageView.frame = CGRectMake(10, _enemyCardImageView.superview.bounds.size.height - 440, _enemyCardImageView.superview.bounds.size.width, CARDHEIGHT);
        
        _border_character = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_character.png"]];
        _border_middleCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_middleCard.png"]];
        _border_usedCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_usedCard.png"]];
        _border_usedCard.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        _border_color = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"border_smallCard"]];
        
        _cardInRegion = [[UIScrollView alloc] init];
        _cardInRegion.delegate = self;
        _cardInRegion.backgroundColor = [UIColor cyanColor];
        _cardInRegion.userInteractionEnabled = YES;
        _backGroundView = [[UIImageView alloc] init];
        _backGroundView.userInteractionEnabled = YES;
        regionViewArray =[[NSMutableArray alloc] init];
        
        
        resultFadeinScrollView = [[UIScrollView alloc] init];
        resultFadeinScrollView.delegate = self;
        resultFadeinScrollView.userInteractionEnabled = YES;
        resultFadeinScrollView.frame = CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 430, 240 , 350);
        [resultFadeinScrollView addSubview:_backGroundView];
        resultFadeinScrollView.bounces = NO;
        
        _colorView = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 460, 280 , 440)];
        _colorView.image = [UIImage imageNamed:@"anime"];
        _colorView.userInteractionEnabled = YES;
        
        
        _okButton = [[UIButton alloc] init];
        [_okButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [_allImageView addSubview:_okButton];
        _okButton.frame = CGRectMake(_okButton.superview.bounds.size.width - 60, _okButton.superview.bounds.size.height - 300, 50, 50);
        [_okButton addTarget:self action:@selector(okButtonPushed)
            forControlEvents:UIControlEventTouchUpInside];
        
        myLifeImageView = [[UIImageView alloc] init];
        myLifeImageView.image = [UIImage imageNamed:@"anime"];
        myLifeTextView = [[UITextView alloc] init];
        myLifeTextView.text = [NSString stringWithFormat:@"%d",app.myLifeGage];
        myLifeTextView.editable = NO;
        myLifeTextView.textAlignment = NSTextAlignmentCenter;
        [PenetrateFilter penetrate:myLifeTextView];
        [myLifeImageView addSubview: myLifeTextView];
        [_allImageView addSubview:myLifeImageView];
        myLifeImageView.frame = CGRectMake(myLifeImageView.superview.bounds.size.width - 60, myLifeImageView.superview.bounds.size.height - 60, 50, 50);
        myLifeTextView.frame = CGRectMake(0, 10, myLifeTextView.superview.bounds.size.width, myLifeTextView.superview.bounds.size.height - 10);
        
        
        enemyLifeImageView = [[UIImageView alloc] init];
        enemyLifeImageView.image = [UIImage imageNamed:@"anime"];
        enemyLifeTextView = [[UITextView alloc] init];
        enemyLifeTextView.text = [NSString stringWithFormat:@"%d",app.enemyLifeGage];
        enemyLifeTextView.editable = NO;
        enemyLifeTextView.textAlignment = NSTextAlignmentCenter;
        
        [PenetrateFilter penetrate:enemyLifeTextView];
        [enemyLifeImageView addSubview: enemyLifeTextView];
        [_allImageView addSubview:enemyLifeImageView];
        enemyLifeImageView.frame = CGRectMake(10, 10, 50, 50);
        enemyLifeTextView.frame = CGRectMake(0, 10, enemyLifeTextView.superview.bounds.size.width, enemyLifeTextView.superview.bounds.size.height - 10);
        
        
        _myCharacterView = [[UIImageView alloc] init];
        _enemyCharacterView = [[UIImageView alloc] init];
        [_allImageView addSubview:_myCharacterView];
        [_allImageView addSubview:_enemyCharacterView];
        _myCharacterView.userInteractionEnabled = YES;
        _enemyCharacterView.userInteractionEnabled = YES;
        _myCharacterView.frame = CGRectMake(20, _myCharacterView.superview.bounds.size.height - 150, 200, 50);
        _enemyCharacterView.frame = CGRectMake(100, _enemyCharacterView.superview.bounds.size.height - 380, 200, 50);
        
        UIImageView *chara_myGiko       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giko.png"]];
        UIImageView *chara_myMonar       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monar.png"]];
        UIImageView *chara_mySyobon           = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"syobon.png"]];
        UIImageView *chara_myYaruo       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yaruo.png"]];
        UIImageView *chara_enemyGiko    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"giko.png"]];
        UIImageView *chara_enemyMonar    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"monar.png"]];
        UIImageView *chara_enemySyobon        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"syobon.png"]];
        UIImageView *chara_enemyYaruo    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yaruo.png"]];
        
        chara_myGiko.frame          = CGRectMake(  0, 0, 50, 50);
        chara_myMonar.frame         = CGRectMake( 50, 0, 50, 50);
        chara_mySyobon.frame        = CGRectMake(100, 0, 50, 50);
        chara_myYaruo.frame         = CGRectMake(150, 0, 50, 50);
        chara_enemyGiko.frame       = CGRectMake(  0, 0, 50, 50);
        chara_enemyMonar.frame      = CGRectMake( 50, 0, 50, 50);
        chara_enemySyobon.frame     = CGRectMake(100, 0, 50, 50);
        chara_enemyYaruo.frame      = CGRectMake(150, 0, 50, 50);
        
        
        chara_myGiko.userInteractionEnabled         = YES;
        chara_myMonar.userInteractionEnabled        = YES;
        chara_mySyobon.userInteractionEnabled       = YES;
        chara_myYaruo.userInteractionEnabled        = YES;
        chara_enemyGiko.userInteractionEnabled      = YES;
        chara_enemyMonar.userInteractionEnabled     = YES;
        chara_enemySyobon.userInteractionEnabled    = YES;
        chara_enemyYaruo.userInteractionEnabled     = YES;
        
        
        chara_myGiko.tag    = GIKO;
        chara_myMonar.tag   = MONAR;
        chara_mySyobon.tag  = SYOBON;
        chara_myYaruo.tag   = YARUO;
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
        
        [_myCharacterView addSubview:chara_myGiko];
        [_myCharacterView addSubview:chara_myMonar];
        [_myCharacterView addSubview:chara_mySyobon];
        [_myCharacterView addSubview:chara_myYaruo];
        [_enemyCharacterView addSubview:chara_enemyGiko];
        [_enemyCharacterView addSubview:chara_enemyMonar];
        [_enemyCharacterView addSubview:chara_enemySyobon];
        [_enemyCharacterView addSubview:chara_enemyYaruo];
        
        
        
        //墓地を表示するビューを作成
        _myTomb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tomb"]];
        _myTomb.userInteractionEnabled = YES;
        [_myTomb addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(myTombTouched:)]];
        [_allImageView addSubview:_myTomb];
        _myTomb.frame = CGRectMake(_myTomb.superview.bounds.size.width - 60, _myTomb.superview.bounds.size.height - 180, 50, 50);
        
        _enemyTomb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tomb"]];
        _enemyTomb.userInteractionEnabled = YES;
        [_enemyTomb addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(enemyTombTouched:)]];
        [_allImageView addSubview:_enemyTomb];
        _enemyTomb.frame = CGRectMake(_enemyTomb.superview.bounds.size.width - 310, _enemyTomb.superview.bounds.size.height - 350, 50, 50);
        
        
        //フィールドカード置き場を表示するビューを作成
        _myField = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"field"]];
        _myField.userInteractionEnabled = YES;
        [_myField addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(myFieldTouched:)]];
        [_allImageView addSubview:_myField];
        _myField.frame = CGRectMake(_myField.superview.bounds.size.width - 60, _myField.superview.bounds.size.height - 240, 50, 50);
        
        _enemyField = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"field"]];
        _enemyField.userInteractionEnabled = YES;
        [_enemyField addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(enemyFieldTouched:)]];
        [_allImageView addSubview:_enemyField];
        _enemyField.frame = CGRectMake(_enemyField.superview.bounds.size.width - 310, _enemyField.superview.bounds.size.height - 290, 50, 50);
        
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
        
        _myWhiteEnergyImage.frame = CGRectMake(  0,  0, 20, 20);
        _myBlueEnergyImage.frame  = CGRectMake( 50,  0, 20, 20);
        _myBlackEnergyImage.frame = CGRectMake(100,  0, 20, 20);
        _myRedEnergyImage.frame   = CGRectMake(150,  0, 20, 20);
        _myGreenEnergyImage.frame = CGRectMake(200,  0, 20, 20);
        
        
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
        
        [_myAllEnergy addSubview:_myWhiteEnergyText];
        [_myAllEnergy addSubview:_myBlueEnergyText];
        [_myAllEnergy addSubview:_myBlackEnergyText];
        [_myAllEnergy addSubview:_myRedEnergyText];
        [_myAllEnergy addSubview:_myGreenEnergyText];
        
        _myWhiteEnergyText.frame = CGRectMake( 20, 0, 30, 20);
        _myBlueEnergyText.frame  = CGRectMake( 70, 0, 30, 20);
        _myBlackEnergyText.frame = CGRectMake(120, 0, 30, 20);
        _myRedEnergyText.frame   = CGRectMake(170, 0, 30, 20);
        _myGreenEnergyText.frame = CGRectMake(220, 0, 30, 20);
        
        [_allImageView addSubview: _myAllEnergy];
        _myAllEnergy.frame = CGRectMake(10, _myAllEnergy.superview.bounds.size.height - 30, 250, 20);
        
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
        
        _enemyWhiteEnergyImage.frame = CGRectMake(  0,  0, 20, 20);
        _enemyBlueEnergyImage.frame  = CGRectMake( 50,  0, 20, 20);
        _enemyBlackEnergyImage.frame = CGRectMake(100,  0, 20, 20);
        _enemyRedEnergyImage.frame   = CGRectMake(150,  0, 20, 20);
        _enemyGreenEnergyImage.frame = CGRectMake(200,  0, 20, 20);
        
        
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
        
        _enemyWhiteEnergyText.frame = CGRectMake( 20, 0, 30, 20);
        _enemyBlueEnergyText.frame  = CGRectMake( 70, 0, 30, 20);
        _enemyBlackEnergyText.frame = CGRectMake(120, 0, 30, 20);
        _enemyRedEnergyText.frame   = CGRectMake(170, 0, 30, 20);
        _enemyGreenEnergyText.frame = CGRectMake(220, 0, 30, 20);
        
        [_allImageView addSubview: _enemyAllEnergy];
        _enemyAllEnergy.frame = CGRectMake(_enemyAllEnergy.superview.bounds.size.width - 250, _enemyAllEnergy.superview.bounds.size.height - 470, 250, 20);
        
        
        
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
        
        [self.view addSubview:_allImageView];
    }
    
    
    
    
    //--------------------------デバッグ用ボタン-----------------------------------
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(160, 240, 80, 20);
    [startButton setTitle:@"開始" forState:UIControlStateNormal];
    [_allImageView addSubview:startButton];
    [startButton addTarget:self action:@selector(battleStart)
          forControlEvents:UIControlEventTouchUpInside];
    
    //--------------------------デバッグ用ボタンここまで-----------------------------
    
//MARK: デバッグ用。終わったら元に戻す_battleStart = [[UIAlertView alloc] initWithTitle:@"戦闘開始" message:@"戦闘開始ボタンを押した後、相手プレイヤーと端末をぶつけてください！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始", nil];
//MARK: デバッグ用。終わったら元に戻す[_battleStart show];
    
    //MARK: ↓↓↓↓↓↓↓↓↓↓デバッグ用。終わったら元に戻す↓↓↓↓↓↓↓↓↓↓
    app.enemyNickName = @"秋乃のiPhone4S";
    app.enemyPlayerID = 120008502;
    NSLog(@"ニックネーム：%@    プレイヤーID：%d",app.enemyNickName,app.enemyPlayerID);
    
    SendDataToServer *sendData = [[SendDataToServer alloc] init];
    [sendData send];
    //MARK: ↑↑↑↑↑↑↑↑↑↑デバッグ用。終わったら元に戻す↑↑↑↑↑↑↑↑↑↑
}

//--------------------------デバッグ用ボタン実装ここから-----------------------------

-(void)getACardForDebug{
    [self getACard:MYSELF];
}

- (void)debug1 :(UITapGestureRecognizer *)sender{
    [self selectUsingEnergy:10];
}

- (void)debug2 :(UITapGestureRecognizer *)sender{
    [sendMyData send];
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
    while (!app.decideAction) {
        [getEnemyData doEnemyDecideAction:YES];
    }
    [NSThread sleepForTimeInterval:1];
    [getEnemyData doEnemyDecideAction:NO];
    [sendMyData send];
    [self activateCardInTiming:99];
    app.myLifeGage = app.myLifeGage - app.myDamageFromCard;
    //ダメージを与え終えたら値を0に戻しておく
    app.myDamageFromCard = 0;
    app.enemyDamageFromCard = 0;
    [self refleshView];
    [self phaseNameFadeIn:[NSString stringWithFormat:@"%dターン目　ターン開始フェイズ", turnCount++]];
    [self sync];
     if(!searchACardInsteadOfGetACardFromLibraryTop){
    [self getACard:MYSELF];
    }
    for (int i = 0; i < app.myAdditionalGettingCards; i++) {
        [self getACard:MYSELF];
    }
    app.myAdditionalGettingCards = 0;
    [self turnStartFadeIn:_turnStartView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self sync];
    
    
    //カード使用後
    NSLog(@"カード使用・AA選択フェーズ");
    NSLog(@"でっきのなかみ：%@",app.myDeckCardList);
    [self phaseNameFadeIn:@"カード使用・AAで選択フェイズです。使用するカード及びAAを選択してください。"];
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
        [getEnemyData doEnemyDecideAction:YES];
    }
    [getEnemyData doEnemyDecideAction:NO];
    [sendMyData send];
    [self activateCardInTiming:99];
    [self refleshView];
    [self cardActivateFadeIn:_afterCardUsedView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self sync];
    //ダメージ計算
    NSLog(@"ダメージ計算フェーズ");
    [self phaseNameFadeIn:@"ダメージ計算フェイズ"];
    [self sync];
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    [self activateCardInTiming:2];
    while (!app.decideAction) {
        [getEnemyData doEnemyDecideAction:YES];
    }
    [NSThread sleepForTimeInterval:1];
    [getEnemyData doEnemyDecideAction:NO];
    [sendMyData send];
    [self activateCardInTiming:99];
    //カード効果でカードを引いたら処理する
        for (int i = 0; i < app.myAdditionalGettingCards; i++) {
            [self getACard:MYSELF];
        }
        app.myAdditionalGettingCards = 0;
    //カード効果でカードを捨てたら処理する
        for (int i = 0; i < app.myAdditionalDiscardingCards; i++) {
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) string:@"捨てるカードを一枚選んでください"];
            [self sync];
        }
    app.enemyDamageFromAA = [_bc damageCaliculate];
    while (!app.decideAction) {
        [getEnemyData doEnemyDecideAction:YES];
    }
    [NSThread sleepForTimeInterval:1];
    [getEnemyData doEnemyDecideAction:NO];
    [sendMyData send];
    app.myLifeGage = app.myLifeGage - (app.myDamageFromAA + app.myDamageFromCard);
    NSLog(@"被ダメージ:%d",app.myDamageFromAA + app.myDamageFromCard);
    [self damageCaliculateFadeIn:_damageCaliculateView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self sync];
    //ダメージを与え終えたら値を0に戻しておく
    app.myDamageFromAA = 0;
    app.myDamageFromCard = 0;
    app.enemyDamageFromCard = 0;
    //ターン終了時
    NSLog(@"ターン終了フェイズ");
    [self phaseNameFadeIn:@"ターン終了フェイズ"];
    [self sync];
    [self activateCardInTiming:3];
    [self activateCardInTiming:99];
    app.myLifeGage = app.myLifeGage -app.myDamageFromCard;
    //ダメージを与え終えたら値を0に戻しておく
    app.myDamageFromCard = 0;
    app.enemyDamageFromCard = 0;
    while (!app.decideAction) {
        [getEnemyData doEnemyDecideAction:YES];
    }
    [NSThread sleepForTimeInterval:1];
    [getEnemyData doEnemyDecideAction:NO];
    [sendMyData send];
    [self refleshView];
    [self resultFadeIn:_turnResultView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self sync];
    
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
        [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandInTurnEndPhaseSelector:) string:@"手札の所持枚数が5枚を超えました。捨てるカードを一枚選んでください"];
        [self sync];
    }
    [self initializeVariables];
    [self nextTurn];
    
    
    NSLog(@"-----------------------------------");
    
    
}
#pragma mark- カード効果実装

-(void)cardActivate :(int)cardnumber string:(NSString *)str{
    switch (cardnumber) {
        case 6:
            //対象キャラの防御力１ターンだけ＋３（W)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            
            break;
        case 7:
            //毎ターンの対象のキャラの防御力を＋３する（W2)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            break;
        case 8:
            //自分のライフ＋３（W)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:3];
            break;
        case 9:
            //自分のライフ＋３、カードを一枚引く（W２）
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:3];
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
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
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
            int k = [app.enemyDeckCardList count] - [app.enemyDeckCardListByMyself_minus count];
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
            //対象キャラの攻撃力 −３（U1)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self enemyAttackPowerOperate:mySelectCharacterInCharacterField point:-3 temporary:1];
            break;
        case 45:
            //対象の場カードを手札に戻す（UU)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(returnEnemyFieldCardToHandSelector:) string:[NSString stringWithFormat:@"%@が発動しました。手札に戻すカードを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
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
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(stealEnemyFieldCardSelector:) string:@"相手から奪うカードを選択してください"];
            break;
        case 48:
            //対象のフィールドカードをオーナーの手札に戻し、カードを一枚引く（UU2)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(returnEnemyFieldCardToHandSelector:) string:[NSString stringWithFormat:@"%@が発動しました。手札に戻すカードを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
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
                [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(stealEnemyFieldCardSelector:) string:@"相手から奪うカードを選択してください"];
                [self sync];
                [self browseCardsInRegion:app.myFieldCard touchCard:YES tapSelector:@selector(sendMyFieldCardSelector:) string:@"相手に渡すカードを選択してください"];
                [self sync];
            }
            break;
        case 63:
            //自分が場に出しているカードのフィールドカードのコピーになる(このターン中に使わなければ破壊される)(UU)
            [self browseCardsInRegion:app.myFieldCard touchCard:YES tapSelector:@selector(copyMyFieldCardSelector:) string:@"コピーするカードを選択してください"];
            [self sync];
            break;
        case 64:
            //このカードが場に出ている限り、相手の攻撃力を３さげる(UU3)
            [self enemyAttackPowerOperate:GIKO point:-3 temporary:YES];
            [self enemyAttackPowerOperate:MONAR point:-3 temporary:YES];
            [self enemyAttackPowerOperate:SYOBON point:-3 temporary:YES];
            [self enemyAttackPowerOperate:YARUO point:-3 temporary:YES];
            break;
        case 65:
            //カードを一枚引く（U1)
            app.myAdditionalGettingCards++;
            break;
        case 66:
            //対象キャラの攻撃力＋３（R)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
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
            //相手のライフに2点のダメージ（R)
            app.enemyDamageFromCard += 2;
            
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
            //自分のライフを１点削り、相手に3点ダメージ（R)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-1];
            app.enemyDamageFromCard += 3;
            break;
        case 74:
            //自分のライフを２点削り、相手に4点ダメージ（RR)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-2];
            app.enemyDamageFromCard += 4;
            break;
        case 75:
            //対象の場カードを破壊する（R1)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
            [self sync];
            break;
        case 76:
            //対象の場カードを２枚破壊する（R3)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMultiEnemyFieldCardsSelector:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMultiEnemyFieldCardsSelector:) string:str];
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
            //攻撃力が＋５される代わりに防御力が０になる（R１)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:5 temporary:1];
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
                NSLog(@"[app.myHand count]:%d",[app.myHand count]);
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
            //自分のキャラの攻撃力−１、２点ダメージ（R)
            [self myAttackPowerOperate:GIKO point:-1 temporary:1];
            [self myAttackPowerOperate:MONAR point:-1 temporary:1];
            [self myAttackPowerOperate:SYOBON point:-1 temporary:1];
            [self myAttackPowerOperate:YARUO point:-1 temporary:1];
            app.enemyDamageFromCard += 2;
            break;
        case 94:
            //対象のエネルギーカードを破壊する（R2)
            [self colorSelect];
            [self sync];
        {
            int destroyedEnergyCard = [[app.enemyEnergyCardByMyself_minus objectAtIndex:(app.mySelectColor - 1)] intValue];
            [app.enemyEnergyCardByMyself_minus replaceObjectAtIndex:(app.mySelectColor - 1) withObject:[NSNumber numberWithInt:destroyedEnergyCard + 1]];
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
            //このターン、黒エネルギーを＋３（B)
        {
            int blackColor = [[app.myEnergyCard objectAtIndex:2] intValue];
            [app.myEnergyCard replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:(blackColor + 3)]];
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
            //このターン相手の対象キャラの防御力を-3する（B1)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self enemyDeffencePowerOperate:mySelectCharacterInCharacterField point:-3 temporary:1];
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
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMyFieldCardSelector:) string:str];
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
            //場のカードを破壊するが、ライフを３点失う（B1)
            app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:-3];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
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
            //自分のプレイヤーのターン終了時に場カードかエネルギーカードをランダムで１枚破壊（BB2)
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
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getACardFromLibrarySelector:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 114:
            //カードを一枚好きにサーチし、ライブラリを切り直す（BB2)
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getACardFromLibrarySelector:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 115:
            //相手プレイヤーのデッキからカードを一枚捨てる（BB2)
            [self browseCardsInRegion:app.enemyDeckCardList touchCard:YES tapSelector:@selector(discardACardFromLibrarySelector:) string:str];
            [self sync];
            break;
        case 116:
            //相手プレイヤーのデッキからカードを十枚捨てる(BBB5)
            for (int i = 0; i < 10; i++) {
                [self browseCardsInRegion:app.enemyDeckCardList touchCard:YES tapSelector:@selector(discardMultiCardsFromLibrarySelector:) string:str];
                [self sync];
            }
            break;
        case 117:
            //攻撃力は＋３されるが、防御力が半分になる（B)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
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
            [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyHandSelector:) string:str];
            [self sync];
            break;
        case 119:
            //相手プレイヤーの手札の中にある、カードを2枚選んで捨てる（BB2)
            [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyMultiHandSelector:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyMultiHandSelector:) string:str];
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
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) string:str];
            [self sync];
            if(selectCardIsCanceledInCardInRegion == NO){
                [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyHandSelector:) string:str];
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
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) string:str];
            [self sync];
            BOOL b = selectCardIsCanceledInCardInRegion;
            
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) string:str];
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
            //対象キャラの攻撃力・防御力を１ターン＋３（G)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:cardnumber]]];
            [self sync];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
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
            //相手がカードを一枚（エネルギーカード除く）使うたびに剣士・魔法使い・格闘家の攻撃力を＋１する（G2)
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
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getACardFromMyTombSelector:) string:str];
            [self sync];
            break;
        case 134:
            //墓地からカードを二枚手札に戻す（G3)
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getMultiCardFromMyTombSelector:) string:str];
            [self sync];
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getMultiCardFromMyTombSelector:) string:str];
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
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getAEnergyCardFromLibrarySelector:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 138:
            //エネルギーカードを２枚サーチ（GG2)
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getMultiEnergyCardFromLibraryHandSelector:) string:str];
            [self sync];
            [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getMultiEnergyCardFromLibraryHandSelector:) string:str];
            [self sync];
            [AppDelegate shuffledArray:app.myDeckCardList];
            break;
        case 139:
            //墓地のカードをライブラリーの一番下に戻す（G)
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(returnMyTombCardToLibrarySelector:) string:str];
            [self sync];
            break;
        case 140:
            //対象の場カードを破壊する（G1)
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
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
            //このターン、修正攻撃力がアップしていた場合、そのプレイヤーはカードを一枚引く（G2)
            if(app.myGikoModifyingAttackPower > 0 || app.myMonarModifyingAttackPower > 0 || app.mySyobonModifyingAttackPower > 0 || app.myYaruoModifyingAttackPower > 0){
                app.myAdditionalGettingCards++;
            }
            if (app.enemyGikoModifyingAttackPower > 0 || app.enemyMonarModifyingAttackPower > 0 || app.enemySyobonModifyingAttackPower > 0 || app.enemyYaruoModifyingAttackPower > 0) {
                [self getACard:ENEMY];
            }
            break;
        case 144:
            //自分の場カードを破壊し、そのカードのコスト分このターン攻撃力をプラスする（G1)
        {
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMyFieldCardSelector:) string:str];
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
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) string:str];
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
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) string:str];
            [self sync];
            BOOL a = selectCardIsCanceledInCardInRegion;
            
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) string:str];
            [self sync];
            BOOL b = selectCardIsCanceledInCardInRegion;
            
            selectCardIsCanceledInCardInRegion = NO;
            [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyMultiHandSelector:) string:str];
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
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyMyFieldCardSelector:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
            [self sync];
            break;
        case 153:
            //墓地にあるエネルギーカードを一枚手札に戻す（G1)
            [self browseCardsInRegion:app.myTomb touchCard:YES tapSelector:@selector(getAEnergyCardFromTombSelector:) string:str];
            [self sync];
            break;
        case 154:
            //場カードと土地を１枚ずつ破壊する（GG2)
        {
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
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
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
            [self sync];
            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES tapSelector:@selector(destroyEnemyFieldCardSelector:) string:str];
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
    
    
    view = [[UIImageView alloc] initWithImage:img];
    view.frame = CGRectMake(0, 0, 280, 420);
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(resultFadeOut:)]];
    [self insertLabelToParentView:view Text:@"ターン開始時に発動したカード"  Rectangle:CGRectMake(60,5,180,30) Touch:NO];
    
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
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width / 2,  [[UIScreen mainScreen] bounds].size.height /2);
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

    [self insertLabelToParentView:view Text:@"カードの使用結果" Rectangle:CGRectMake(80,5,180,30) Touch:NO];
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
    view = [[UIImageView alloc] initWithImage:img];
    view.frame = CGRectMake(0, 0, 280, 420);
    view.center = CGPointMake( [[UIScreen mainScreen] bounds].size.width *2,  [[UIScreen mainScreen] bounds].size.height /2);
    view.userInteractionEnabled = YES;
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
    
    _myGiko.frame      = CGRectMake(20,  10, view.bounds.size.width - 20, 20);
    _myMonar.frame     = CGRectMake(20,  30, view.bounds.size.width - 20, 20);
    _mySyobon.frame    = CGRectMake(20,  50, view.bounds.size.width - 20, 20);
    _myYaruo.frame     = CGRectMake(20,  70, view.bounds.size.width - 20, 20);
    _myDamage.frame    = CGRectMake(20,  90, view.bounds.size.width - 20, 40);
    _enemyGiko.frame   = CGRectMake(20, 190, view.bounds.size.width - 20, 20);
    _enemyMonar.frame  = CGRectMake(20, 210, view.bounds.size.width - 20, 20);
    _enemySyobon.frame = CGRectMake(20, 230, view.bounds.size.width - 20, 20);
    _enemyYaruo.frame  = CGRectMake(20, 250, view.bounds.size.width - 20, 20);
    _enemyDamage.frame = CGRectMake(20, 270, view.bounds.size.width - 20, 40);
    
    UIFont *font = [UIFont fontWithName:@"Didot" size:12];
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
    
    
    [self insertLabelToParentView:view Text:@"ダメージ計算結果"  Rectangle:CGRectMake(80,5,180,30) Touch:NO];
    
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
    
    _myGiko.text    = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@"  ,app.myGikoFundamentalAttackPower      , app.myGikoModifyingAttackPower     , app.myGikoFundamentalDeffencePower     , app.myGikoModifyingDeffencePower,myGikoAttackPermitted,myGikoDeffencePermitted];
    _myMonar.text   = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@"  ,app.myMonarFundamentalAttackPower     , app.myMonarModifyingAttackPower    , app.myMonarFundamentalDeffencePower    , app.myMonarModifyingDeffencePower,myMonarAttackPermitted,myMonarDeffencePermitted];
    _mySyobon.text  = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@"  ,app.mySyobonFundamentalAttackPower    , app.mySyobonModifyingAttackPower   , app.mySyobonFundamentalDeffencePower   , app.mySyobonModifyingDeffencePower,mySyobonAttackPermitted,mySyobonDeffencePermitted];
    _myYaruo.text   = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@"  ,app.myYaruoFundamentalAttackPower     , app.myYaruoModifyingAttackPower    , app.myYaruoFundamentalDeffencePower    , app.myYaruoModifyingDeffencePower,myYaruoAttackPermitted,myYaruoDeffencePermitted];
    _myDamage.text  = [NSString stringWithFormat:@"受けたダメージ:%d",(app.myDamageFromAA + app.myDamageFromCard)];
    _enemyGiko.text = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@"  ,app.enemyGikoFundamentalAttackPower   , app.enemyGikoModifyingAttackPower  , app.enemyGikoFundamentalDeffencePower  , app.enemyGikoModifyingDeffencePower,enemyGikoAttackPermitted,enemyGikoDeffencePermitted];
    _enemyMonar.text = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@" ,app.enemyMonarFundamentalAttackPower  , app.enemyMonarModifyingAttackPower , app.enemyMonarFundamentalDeffencePower , app.enemyMonarModifyingDeffencePower,enemyMonarAttackPermitted,enemyMonarDeffencePermitted];
    _enemySyobon.text = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@",app.enemySyobonFundamentalAttackPower , app.enemySyobonModifyingAttackPower, app.enemySyobonFundamentalDeffencePower, app.enemySyobonModifyingDeffencePower,enemySyobonAttackPermitted,enemySyobonDeffencePermitted];
    _enemyYaruo.text = [NSString stringWithFormat:@"攻撃力:%d + %d  防御力:%d + %d  攻:%@  防:%@" ,app.enemyYaruoFundamentalAttackPower  , app.enemyYaruoModifyingAttackPower , app.enemyYaruoFundamentalDeffencePower , app.enemyYaruoModifyingDeffencePower,enemyYaruoAttackPermitted,enemyYaruoDeffencePermitted];
    _enemyDamage.text  = [NSString stringWithFormat:@"受けたダメージ:%d",(app.enemyDamageFromAA + app.enemyDamageFromCard)];
    
    
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
    [self insertLabelToParentView:view Text:@"ターン終了時に発動したカード" Rectangle:CGRectMake(80,5,180,30) Touch:NO];
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
    [self insertLabelToParentView:_phaseNameView Text:phaseName  Rectangle:CGRectMake(0,0,180,60) Touch:NO];
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
    UIFont *font = [UIFont fontWithName:@"Didot" size:12];
    label.frame = rect;
    label.text  = text;
    label.font = font;
    label.tag = [app.cardList_cardName indexOfObject:text];
    [parentView addSubview:label];
    if(touch){
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detailOfACard:)]];
    }
}

- (void)detailOfACard:(UILongPressGestureRecognizer *)sender{
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",(int)sender.view.tag]];
    [self.view addSubview:detailOfACard];
    _allImageView.userInteractionEnabled = NO;
}

- (void)removeDetailOfACard{
    [detailOfACard removeFromSuperview];
    _allImageView.userInteractionEnabled = YES;
}


-(void)okButtonPushed{
    if (app.mySelectCharacter == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"キャラクター未選択" message:@"キャラクターが選ばれていません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"キャラクターを選択する", nil];
        [alert show];
    }else{
        [SVProgressHUD showWithStatus:@"相手の選択を待機中..." maskType:SVProgressHUDMaskTypeGradient];
        cardIsCompletlyUsed = YES;
        FINISHED1
    }
    
    
}

- (void)battleStart{
    if([YSDeviceHelper is568h]){
        //
        //        //自分
        //            while (myDrawCount < 5) {
        //                NSLog(@"ドローカウント：%d",myDrawCount);
        //                //手札のカード画像を用意する
        //                    UIImage *myCard = [UIImage imageNamed:[app.cardList_pngName objectAtIndex:[[app.myDeckCardList objectAtIndex:myDrawCount] intValue]]];
        //                    _myCard = [[UIImageView alloc] initWithImage:myCard];
        //                    [_myCardImageViewArray addObject:_myCard];
        //                    [_myCardImageView addSubview:_myCard];
        //                    _myCard.userInteractionEnabled = YES;
        //                    [_myCard addGestureRecognizer:
        //                     [[UITapGestureRecognizer alloc]
        //                      initWithTarget:self action:@selector(touchAction:)]];
        //
        //                //手札を用意するアニメーション
        //                [UIView beginAnimations:nil context:nil];
        //                //移動前
        //                _myCard.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width *2, 0, CARDWIDTH, CARDHEIGHT);
        //                [UIView setAnimationDelegate:self];
        //                [UIView setAnimationDelay:0.1];
        //                [UIView setAnimationDuration:0.1];
        //                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //                //移動後
        //                _myCard.frame = CGRectMake(20 + (CARDWIDTH +8) * myDrawCount, 0, CARDWIDTH, CARDHEIGHT);
        //                [UIView commitAnimations];
        //
        //
        //                //引いたカードの数をプラスする
        //                myDrawCount++;
        //                _myCard.tag = myDrawCount; // ATTENTION:  タグ番号=myDrawCountとなっていることに注意する！
        //                //手札が5枚になるまで繰り返す
        //
        //            }
        //
        //            for (int i = 0; i < 5; i++) {
        //                //手札に入れたカードを、山札の配列から手札の配列に入れておく
        //                [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
        //            }
        //
        //            //デッキのカード画像を用意する
        //            UIImage *deck = [UIImage imageNamed:@"library.png"];
        //            _myLibrary = [[UIImageView alloc] initWithImage:deck];
        //            [_allImageView addSubview:_myLibrary];
        //            //山札を用意するアニメーション
        //            [UIView beginAnimations:nil context:nil];
        //            //移動前
        //            _myLibrary.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - deck.size.width - 20, [[UIScreen mainScreen] bounds].size.height + 100, deck.size.width, deck.size.height);
        //            //移動後
        //            _myLibrary.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - CARDWIDTH - 20, [[UIScreen mainScreen] bounds].size.height - CARDHEIGHT - 20, CARDWIDTH, CARDHEIGHT);
        //            [UIView commitAnimations];
        //
        //            //デッキの残枚数を表示
        //            _myLibraryCount = [[UITextView alloc] init];
        //            _myLibraryCount.frame = CGRectMake(5, 10, 30, 40);
        //            _myLibraryCount.textAlignment = NSTextAlignmentCenter;
        //            _myLibraryCount.editable = NO;
        //            UIColor *black = [UIColor blackColor]; //ボタンの背景を透明にするため、とりあえず黒を設定（下で透明化する）
        //            UIColor *alphaZero = [black colorWithAlphaComponent:0.0]; //黒を透明化
        //            _myLibraryCount.backgroundColor = alphaZero;//テキストビューの背景を透明化
        //            _myLibraryCount.text = [NSString stringWithFormat:@"%d", [app.myDeckCardList count]];
        //            [_myLibrary addSubview:_myLibraryCount];
        //
        //            NSLog(@"-----------------------------------");
        //            NSLog(@"%s", __func__);
        //            for (int i = 0; i < [app.myHand count]; i++) {
        //                NSLog(@"現在の手札のカードナンバー：%d枚目:%d",i + 1,[[app.myHand objectAtIndex:i] intValue]);
        //            }
        //            NSLog(@"-----------------------------------");
        //
        //
        //        //相手
        //        while (myDrawCount < 5) {
        //            NSLog(@"ドローカウント：%d",myDrawCount);
        //            //手札のカード画像を用意する
        //            UIImage *myCard = [UIImage imageNamed:[app.cardList_pngName objectAtIndex:[[app.myDeckCardList objectAtIndex:myDrawCount] intValue]]];
        //            _myCard = [[UIImageView alloc] initWithImage:myCard];
        //            [_myCardImageViewArray addObject:_myCard];
        //            [_myCardImageView addSubview:_myCard];
        //            _myCard.userInteractionEnabled = YES;
        //            [_myCard addGestureRecognizer:
        //             [[UITapGestureRecognizer alloc]
        //              initWithTarget:self action:@selector(touchAction:)]];
        //
        //            //手札を用意するアニメーション
        //            [UIView beginAnimations:nil context:nil];
        //            //移動前
        //            _myCard.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width * - 2, 0, CARDWIDTH, CARDHEIGHT);
        //            [UIView setAnimationDelegate:self];
        //            [UIView setAnimationDelay:0.1];
        //            [UIView setAnimationDuration:0.1];
        //            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //            //移動後
        //            _myCard.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width + (CARDWIDTH +8) * myDrawCount, 0, CARDWIDTH, CARDHEIGHT);
        //            [UIView commitAnimations];
        //
        //
        //            //引いたカードの数をプラスする
        //            myDrawCount++;
        //            _myCard.tag = myDrawCount;
        //            //手札が5枚になるまで繰り返す
        //
        //        }
        //
        //        for (int i = 0; i < 5; i++) {
        //            //手札に入れたカードを、山札の配列から手札の配列に入れておく
        //            [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
        //        }
        //
        //
        //        [self nextTurn];
    }else{
        //自分
        while (myDrawCount < 5) {
            //手札のカード画像を用意する
            UIImage *myCard = [UIImage imageNamed:@"outicon"];
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
        UIImage *deck = [UIImage imageNamed:@"library.png"];
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
            UIImage *enemyCard = [UIImage imageNamed:[app.cardList_pngName objectAtIndex:[[app.enemyDeckCardList objectAtIndex:enemyDrawCount + 1] intValue]]];
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
            //手札に入れたカードを、山札の配列から手札の配列に入れておく
            [self setCardFromXTOY:app.enemyDeckCardList cardNumber:0 toField:app.enemyHand];
        }
        
        //デッキのカード画像を用意する
        UIImage *enemydeck = [UIImage imageNamed:@"library.png"];
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

- (void)touchAction :(UITapGestureRecognizer *)sender{
    [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(handTouched:) string:nil];
}

- (void)handTouched :(UITapGestureRecognizer *)sender{
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
        if([self doIHaveEnergyToUseCard:cardNumber]){

        }
        else{
            [_border_usedCard removeFromSuperview];
            [_regionView addSubview:_border_usedCard];
            _border_usedCard.frame = sender.view.frame;
            
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
                    [self refleshView];
                    
                }
                [self setCardToCardsIUsedInThisTurn:app.myHand cardNumber:selectedCardOrder];
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
                [self refleshMyHand];
                doIUseCardInThisTurn = NO;
            }
        }
    }
    
    //フィールドカードの場合の実装
    else if (cardType == FIELDCARD){
        if([self doIHaveEnergyToUseCard:cardNumber]){

        }
        else{
            [_border_usedCard removeFromSuperview];
            [_regionView addSubview:_border_usedCard];
            _border_usedCard.frame = sender.view.frame;
            
            
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
                [self refleshMyHand];
                doIUseCardInThisTurn = NO;
            }
        }
    }
    
    //エネルギーカードの場合の実装
    else if (cardType == ENERGYCARD){
        
            [_border_usedCard removeFromSuperview];
            [_regionView addSubview:_border_usedCard];
            _border_usedCard.frame = sender.view.frame;
            
            
            _doIUseEnergycard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"エネルギーカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseEnergycard show];
    }
    
}

- (void)myTombTouched :(UITapGestureRecognizer *)sender{
    [self browseCardsInRegion:app.myTomb touchCard:NO tapSelector:@selector(nullSelector:) string:nil];
}

- (void)enemyTombTouched :(UITapGestureRecognizer *)sender{
    [self browseCardsInRegion:app.enemyTomb touchCard:NO tapSelector:@selector(nullSelector:) string:nil];
}

- (void)myFieldTouched :(UITapGestureRecognizer *)sender{
    [self browseCardsInRegion:app.myFieldCard touchCard:NO tapSelector:@selector(nullSelector:) string:nil];
}

- (void)enemyFieldTouched :(UITapGestureRecognizer *)sender{
    [self browseCardsInRegion:app.enemyFieldCard touchCard:NO tapSelector:@selector(nullSelector:) string:nil];
}


- (void)refleshMyHand{
    [_myCardImageView removeFromSuperview];
    for (UIView *view in [_myCardImageView subviews]) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < [app.myHand count]; i++){
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"outicon"]];
        [_myCardImageView addSubview:imgView];
        imgView.frame = CGRectMake(10 + i * (CARDWIDTH + 5), 0, CARDWIDTH, CARDHEIGHT);
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(touchAction:)]];
    }
    
    [_allImageView addSubview:_myCardImageView];
    
    for (int i = 0; i < [_myCardImageViewArray count]; i++) {
        UIImageView *tmp = [[UIImageView alloc] init];
        tmp = [_myCardImageViewArray objectAtIndex:i];
    }
    
    
    //    [_myCardImageView removeFromSuperview];
    //
    //    NSLog(@"selectedCardOrder:%d",selectedCardOrder);
    //    NSLog(@"[_myCardImageViewArray count]:%d",[_myCardImageViewArray count]);
    //    [_myCardImageViewArray removeObjectAtIndex:selectedCardOrder];
    //
    //
    //    UIImageView *temp =[[_myCardImageView subviews] objectAtIndex:selectedCardOrder];
    //    [[_myCardImageView viewWithTag:temp.tag] removeFromSuperview];
    //    NSLog(@"[[_myCardImageView subviews] count]:%d",[[_myCardImageView subviews] count]);
    //
    //    //手札の画像を全てテンポラリな配列に収め、myCardImageViewから消す
    //    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    //    for (int i = 0; i < [[_myCardImageView subviews] count]; i++){
    //        [tempArray addObject:[[_myCardImageView subviews] objectAtIndex:i]];
    //    }
    //    for (UIView *view in [_myCardImageView subviews]) {
    //        [view removeFromSuperview];
    //    }
    //
    //    _myCardImageView = [[UIImageView alloc] init];
    //    _myCardImageView.userInteractionEnabled = YES;
    //
    //    for (int i = 0; i < [tempArray count]; i++){
    //        UIImageView *imgView = [tempArray objectAtIndex:i];
    //        [_myCardImageView addSubview:imgView];
    //        imgView.frame = CGRectMake(10 + i * (CARDWIDTH + 5), 0, CARDWIDTH, CARDHEIGHT);
    //        imgView.userInteractionEnabled = YES;
    //        [imgView addGestureRecognizer:
    //         [[UITapGestureRecognizer alloc]
    //          initWithTarget:self action:@selector(touchAction:)]];
    //    }
    //
    //    [_allImageView addSubview:_myCardImageView];
    //    _myCardImageView.frame = CGRectMake(0, _myCardImageView.superview.bounds.size.height - 90, _myCardImageView.superview.bounds.size.width, CARDHEIGHT);
    //
    //    for (int i = 0; i < [_myCardImageViewArray count]; i++) {
    //        UIImageView *tmp = [[UIImageView alloc] init];
    //        tmp = [_myCardImageViewArray objectAtIndex:i];
    //        NSLog(@"残ってるカード：%ld",tmp.tag);
    //    }
}





/*----------------------------------------------------------------------------------------*/


//対象プレイヤーのXという領域のカードを見る（場・エネルギー置き場・手札）
-(int)browseCardsInRegion :(NSMutableArray *)cards touchCard:(BOOL)touchCard tapSelector:(SEL)selector string:(NSString *)string{
    NSLog(@"%@",cards);
    [regionViewArray removeAllObjects];
    for (int i = 0; i < [_cardInRegion.subviews count]; i++) {
        [[_cardInRegion.subviews objectAtIndex:i] removeFromSuperview];
    }
    
    
    if(touchCard){
        
        for (UIView *view in [_regionView subviews]) {
            [view removeFromSuperview];
        }
        _regionView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 280 , 90 + [cards count] * (BIGCARDHEIGHT + 10))];
        [PenetrateFilter penetrate:_regionView];
        _regionView.userInteractionEnabled = YES;
        
        for (int i = 0; i < [cards count]; i++) {
            UIImageView *cardImage = [[UIImageView alloc] init];
            cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d.png",[[cards objectAtIndex:i] intValue]]];
            [_regionView addSubview:cardImage];
            [regionViewArray addObject:cardImage];
            cardImage.frame = CGRectMake(10, 10 + (BIGCARDHEIGHT) * i + (i  * 5), BIGCARDWIDTH, BIGCARDHEIGHT);
            cardImage.userInteractionEnabled = YES;
            cardImage.tag = i + 1;
            [cardImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:selector]];
            [cardImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detailOfACard:)]];
        }
        
        
        _cardInRegion.frame = CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 460, 280 , 440);
        [_cardInRegion addSubview:_backGroundView];
        [_cardInRegion addSubview:_regionView];
        _cardInRegion.contentSize = _regionView.bounds.size;
        
        
        UITextView *title = [[UITextView alloc] init];
        [_cardInRegion addSubview: title];
        title.text = string;
        title.editable = NO;
        title.frame = CGRectMake(0, 10, title.superview.bounds.size.width, 30);
        title.textAlignment = NSTextAlignmentCenter;
        
        [self createCancelButton:CGRectMake(10, _regionView.bounds.size.height - 30, 100, 20) parentView:_cardInRegion tag:4];
        [_allImageView addSubview:_cardInRegion];
        
    }else{
        for (UIView *view in [_regionView subviews]) {
            [view removeFromSuperview];
        }
        _regionView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 280 , 90 + [cards count] * (BIGCARDHEIGHT + 10))];
        [PenetrateFilter penetrate:_regionView];
        _regionView.userInteractionEnabled = YES;
        
        for (int i = 0; i < [cards count]; i++) {
            UIImageView *cardImage = [[UIImageView alloc] init];
            cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d.png",[[cards objectAtIndex:i] intValue]]];
            [_regionView addSubview:cardImage];
            [regionViewArray addObject:cardImage];
            cardImage.frame = CGRectMake(10, 10 + (BIGCARDHEIGHT) * i + (i  * 5), BIGCARDWIDTH, BIGCARDHEIGHT);
            cardImage.userInteractionEnabled = NO;
            cardImage.tag = i + 1;
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
        
        [self createCancelButton:CGRectMake(10, _regionView.bounds.size.height - 30, 100, 20) parentView:_cardInRegion tag:4];
        [_allImageView addSubview:_cardInRegion];
        
        
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
        _myGetCard.frame = CGRectMake(_myGetCard.superview.bounds.size.width - CARDWIDTH - 20, 0, CARDWIDTH, CARDHEIGHT);
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //移動後
        _myGetCard.frame = CGRectMake(10 + (CARDWIDTH + 8) * ([_myCardImageViewArray count] - 1), 0, CARDWIDTH, CARDHEIGHT);
        
        //引いたカードの数を増やす
        myDrawCount++;
        _myGetCard.tag = myDrawCount;
        NSLog(@"手札に入れたカードのタグ：%d",_myGetCard.tag);
        
        //デッキのカード枚数を減らし、手札に入れる
        [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
        
    }else{
        [self manipulateCard:[app.enemyDeckCardList objectAtIndex:0] plusArray:app.enemyHandByMyself_plus minusArray:app.enemyDeckCardListByMyself_minus];
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
    [self createOkButton:CGRectMake(10, _cardInRegion.bounds.size.height - 100, 100, 20) parentView:_cardInRegion tag:6];
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
    [view addSubview:txtView];
    
    
    if(cancel){
        [self createOkButton:CGRectMake(10, _characterField.bounds.size.height - 20 - 10, 100, 20) parentView:_characterField tag:7];
        [self createCancelButton:CGRectMake(_characterField.bounds.size.width - 10 - 100,  _characterField.bounds.size.height - 20 - 10, 100, 20) parentView:_characterField tag:8];
    }else{
        [self createOkButton:CGRectMake(_characterField.bounds.size.width / 2 - 50, _characterField.bounds.size.height - 20 - 10, 100, 20) parentView:_characterField tag:7];
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
            [_cardInRegion removeFromSuperview];
            selectCardIsCanceledInCardInRegion = YES;
            FINISHED1
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
            FINISHED1
            
            break;
            
        case 8:
            //キャラクター選択画面のキャンセルボタンから飛んできた場合
            mySelectCharacterInCharacterField = -1;
            [_characterField removeFromSuperview];
            FINISHED1
            break;
            
        case 9:
            //特定の色を選択する画面のOKボタンから飛んできた場合
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
    
    whiteImage.image = [UIImage imageNamed:@"whiteEnergyImage"];
    blueImage.image = [UIImage imageNamed:@"blueEnergyImage"];
    blackImage.image = [UIImage imageNamed:@"blackEnergyImage"];
    redImage.image = [UIImage imageNamed:@"redEnergyImage"];
    greenImage.image = [UIImage imageNamed:@"greenEnergyImage"];
    
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
    [self createOkButton:CGRectMake(10, (_colorView.bounds.size.height - 40), 100, 20) parentView:_colorView tag:9];
    [_allImageView addSubview:_colorView];
    
}

- (void) selectColor :(UITapGestureRecognizer *)sender{
    [_border_color removeFromSuperview];
    _border_color.frame = sender.view.frame;
    [_colorView addSubview:_border_color];
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
                
                NSLog(@"このターン使用したカード：%@",app.cardsIUsedInThisTurn);
                [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
                [regionViewArray removeAllObjects];
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
                
                [self refleshMyHand];
                
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
                [_border_usedCard removeFromSuperview];
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
                [_border_usedCard removeFromSuperview];
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
                [_border_usedCard removeFromSuperview];
                FINISHED1
                break;
            default:
                break;
        }
    }else if (alertView == _battleStartView){
        switch (buttonIndex) {
            case 0:
                motion = [[DeviceMotion alloc] init];
                [motion bump];
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
                [self browseCardsInRegion:app.myDeckCardList touchCard:YES tapSelector:@selector(getAEnergyCardFromLibrarySelector:) string:@""];
                searchACardInsteadOfGetACardFromLibraryTop = YES;
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
        return YES;
    }
    NSLog(@"エネルギー足りてます");
    NSLog(@"-----------------------------------");
    return NO;
}

//ターン終了時に各種変数を初期化する
- (void)initializeVariables{
    
    //常に初期化するもの
    [getEnemyData doEnemyDecideAction:NO]; //app.decideAction = NOと初期化しておく
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
                int blackColor = [[app.myEnergyCard objectAtIndex:2] intValue];
                [app.myEnergyCard replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:(blackColor - 3)]];
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
    _enemyWhiteEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:0] intValue]];
    _enemyBlueEnergyText.text  = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:1] intValue]];
    _enemyBlackEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:2] intValue]];
    _enemyRedEnergyText.text   = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:3] intValue]];
    _enemyGreenEnergyText.text = [NSString stringWithFormat:@"%d",[[app.enemyEnergyCard objectAtIndex:4] intValue]];
    
    //手札枚数の更新
    [self refleshMyHand];
}
-(void)discardMyHandSelector: (UITapGestureRecognizer *)sender{
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
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
    [_cardInRegion removeFromSuperview];
    
    FINISHED1
}


-(void)discardEnemyHandSelector: (UITapGestureRecognizer *)sender{
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
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [_cardInRegion removeFromSuperview];
    _putACardToLibraryTopOrBottom = [[UIAlertView alloc] initWithTitle:@"選択" message:@"山札のどちらにおきますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"一番上", @"一番下", nil];
    [_putACardToLibraryTopOrBottom show];
    [self sync];
}

-(void)sendMyFieldCardSelector: (UITapGestureRecognizer *)sender{
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
    //selectedCardOrderに選ばれたカードの配列の順番だけ入れるセレクタ
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [_cardInRegion removeFromSuperview];
    FINISHED1
}

-(void)nullSelector: (UITapGestureRecognizer *)sender{
    //何もしないセレクタ
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
    _okButton.userInteractionEnabled = NO;
    _myCardImageView.userInteractionEnabled = NO;
    _myCharacterView.userInteractionEnabled = NO;
    _myTomb.userInteractionEnabled = NO;
    _enemyTomb.userInteractionEnabled = NO;
    _myField.userInteractionEnabled = NO;
    _enemyField.userInteractionEnabled = NO;
}

-(void)permitTouchAction{
    _okButton.userInteractionEnabled        = YES;
    _myCardImageView.userInteractionEnabled = YES;
    _myCharacterView.userInteractionEnabled = YES;
    _myTomb.userInteractionEnabled          = YES;
    _enemyTomb.userInteractionEnabled       = YES;
    _myField.userInteractionEnabled         = YES;
    _enemyField.userInteractionEnabled      = YES;
}

//各色毎にいくつのエネルギーを使用するか選択する
-(void)selectUsingEnergy:(int)cardNum{
    //色を選択する画面を作成する
    for (UIView *view in _colorView.subviews) {
        [view removeFromSuperview];
    }

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
    
    whiteImage.frame    = CGRectMake(10, 40, 50, 50);
    blueImage.frame     = CGRectMake(10, 120, 50, 50);
    blackImage.frame    = CGRectMake(10, 200, 50, 50);
    redImage.frame      = CGRectMake(10, 280, 50, 50);
    greenImage.frame    = CGRectMake(10, 360, 50, 50);
    
    whiteDown.frame     = CGRectMake(80, 40, 50, 50);
    blueDown.frame      = CGRectMake(80, 120, 50, 50);
    blackDown.frame     = CGRectMake(80, 200, 50, 50);
    redDown.frame       = CGRectMake(80, 280, 50, 50);
    greenDown.frame     = CGRectMake(80, 360, 50, 50);
    
    whiteNumberOfText.frame   = CGRectMake(140, 40, 50, 50);
    blueNumberOfText.frame    = CGRectMake(140, 120, 50, 50);
    blackNumberOfText.frame   = CGRectMake(140, 200, 50, 50);
    redNumberOfText.frame     = CGRectMake(140, 280, 50, 50);
    greenNumberOfText.frame   = CGRectMake(140, 360, 50, 50);
    
    whiteUp.frame       = CGRectMake(200, 40, 50, 50);
    blueUp.frame        = CGRectMake(200, 120, 50, 50);
    blackUp.frame       = CGRectMake(200, 200, 50, 50);
    redUp.frame         = CGRectMake(200, 280, 50, 50);
    greenUp.frame       = CGRectMake(200, 360, 50, 50);
    
    whiteImage.image = [UIImage imageNamed:@"whiteEnergyImage"];
    blueImage.image = [UIImage imageNamed:@"blueEnergyImage"];
    blackImage.image = [UIImage imageNamed:@"blackEnergyImage"];
    redImage.image = [UIImage imageNamed:@"redEnergyImage"];
    greenImage.image = [UIImage imageNamed:@"greenEnergyImage"];
    
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
    
    costOfCard= [self caliculateEnergyCost:cardNum];
    
    [self createOkButton:CGRectMake(10, (_colorView.bounds.size.height - 40), 100, 20) parentView:_colorView tag:10];
    [_allImageView addSubview:_colorView];
}

-(void)plusEnergy: (UITapGestureRecognizer *)sender{
    NSArray *tempArray = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:app.myUsingCardNumber]];
    int i = 0;
    for (NSNumber *num in tempArray) {
        i += [num intValue];
    }
    NSLog(@"i:%d",i);
    
    int allNumber = numberOfUsingWhiteEnergy + numberOfUsingBlueEnergy + numberOfUsingBlackEnergy + numberOfUsingRedEnergy + numberOfUsingRedEnergy;
    
    NSLog(@"allNumber:%d",allNumber);
    
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
}

-(void)minusEnergy: (UITapGestureRecognizer *)sender{
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
}



@end
