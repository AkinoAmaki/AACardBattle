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
    
    // "MyEvent"という名前のイベントが発行されたらtransitViewが呼ばれる
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transitView:) name:@"battleStartEvent" object:nil];
    
    app = [[UIApplication sharedApplication] delegate];
    turnCount = 1;
    myDrawCount = 0;
    enemyDrawCount = 0;
    selectedCardOrder = -1;
    app.myUsingCardNumber = -1;
    selectCardTag = -1;
    syncFinished = NO;
    doIUseCardInThisTurn = NO;
    cardIsCompletlyUsed = NO;
    
    _bc = [[BattleCaliculate alloc] init];
    getEnemyData = [[GetEnemyDataFromServer alloc] init];
    sendMyData = [[SendDataToServer alloc] init];
    
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
        
        _additionalCostView = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 60, [[UIScreen mainScreen] bounds].size.width - 40 , 400)];
        
        _cardInRegion = [[UIScrollView alloc] init];
        _cardInRegion.delegate = self;
        _cardInRegion.backgroundColor = [UIColor cyanColor];
        _cardInRegion.userInteractionEnabled = YES;
        _backGroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anime"]];
        _backGroundView.userInteractionEnabled = YES;
        regionViewArray =[[NSMutableArray alloc] init];
        [_cardInRegion addSubview:_backGroundView];
        
        _colorView = [[UIImageView alloc] initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height - 460, 280 , 440)];
        _colorView.image = [UIImage imageNamed:@"anime"];
        _colorView.userInteractionEnabled = YES;
        
        
        _okButton = [[UIButton alloc] init];
        [_okButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [_allImageView addSubview:_okButton];
        _okButton.frame = CGRectMake(_okButton.superview.bounds.size.width - 60, _okButton.superview.bounds.size.height - 300, 50, 50);
        [_okButton addTarget:self action:@selector(okButton)
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
        _enemyGiko = [[UILabel alloc] init];
        _enemyMonar = [[UILabel alloc] init];
        _enemySyobon = [[UILabel alloc] init];
        _enemyYaruo = [[UILabel alloc] init];
        
        [self.view addSubview:_allImageView];
    }
    
    
    
    
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
    
    //MARK: デバッグ用。終わったら元に戻す_battleStart = [[UIAlertView alloc] initWithTitle:@"戦闘開始" message:@"戦闘開始ボタンを押した後、相手プレイヤーと端末をぶつけてください！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"戦闘開始", nil];
    //MARK: デバッグ用。終わったら元に戻す[_battleStart show];
    
    //MARK: ↓↓↓↓↓↓↓↓↓↓デバッグ用。終わったら元に戻す↓↓↓↓↓↓↓↓↓↓
    app.enemyNickName = @"秋乃のiPhone4S";
    app.enemyPlayerID = 120008502;
    NSLog(@"ニックネーム：%@    プレイヤーID：%d",app.enemyNickName,app.enemyPlayerID);
    
    SendDataToServer *sendData = [[SendDataToServer alloc] init];
    while (![[sendData send] isEqualToString:@"諸データの更新が終了しました"]) {
        
    }
    GetEnemyDataFromServer *getEnemyData = [[GetEnemyDataFromServer alloc] init];
    [getEnemyData get];
    //MARK: ↑↑↑↑↑↑↑↑↑↑デバッグ用。終わったら元に戻す↑↑↑↑↑↑↑↑↑↑
}

//--------------------------デバッグ用ボタン実装ここから-----------------------------

-(void)getACardForDebug{
    [self getACard:MYSELF];
}

- (void)debug1 :(UITapGestureRecognizer *)sender{
    
}

- (void)debug2 :(UITapGestureRecognizer *)sender{
    [sendMyData send];
}


- (void)debug3 :(UITapGestureRecognizer *)sender{
    getEnemyData = [[GetEnemyDataFromServer alloc] init];
    [getEnemyData get];
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
    //MARK: デバッグ終わったら戻す[self phaseNameFadeIn:[NSString stringWithFormat:@"%dターン目　ターン開始フェイズ", turnCount++]];
    //MARK: デバッグ終わったら戻す[self sync];
    //MARK: デバッグ終わったら戻す[self getACard:MYSELF];
    //MARK: デバッグ終わったら戻すfor (int i = 0; i < app.myAdditionalGettingCards; i++) {
    //MARK: デバッグ終わったら戻す    [self getACard:MYSELF];
    //MARK: デバッグ終わったら戻す}
    //MARK: デバッグ終わったら戻すapp.myAdditionalGettingCards = 0;
    [self activateCardInTiming:0];
    [sendMyData send];
    [self activateCardInTiming:99];
    app.myLifeGage = app.myLifeGage - app.myDamageFromCard;
    //ダメージを与え終えたら値を0に戻しておく
    app.myDamageFromCard = 0;
    app.enemyDamageFromCard = 0;
    [self refleshView];
    //MARK: デバッグ終わったら戻す[self turnStartFadeIn:_turnStartView animaImage:[UIImage imageNamed:@"anime.png"]];
    //MARK: デバッグ終わったら戻す[self sync];
    
    
    //カード使用後
    NSLog(@"カード使用・AA選択フェーズ");
    NSLog(@"でっきのなかみ：%@",app.myDeckCardList);
    //MARK: デバッグ終わったら戻す[self phaseNameFadeIn:@"カード使用・AAで選択フェイズです。使用するカード及びAAを選択してください。"];
    //MARK: デバッグ終わったら戻す[self sync];
    
    
    //touchActionの入力を待つための同期処理
    
    while (cardIsCompletlyUsed == NO) {
        [self sync];
    }
    [self activateCardInTiming:1];
    
    //相手の入力待ち(app.decideAction = YESとなれば先に進む)
    while (!app.decideAction) {
        [NSThread sleepForTimeInterval:1];
        [getEnemyData doEnemyDecideAction:YES];
    }
    [sendMyData send];
    [self activateCardInTiming:99];
    [self refleshView];
    //MARK: デバッグ終わったら戻す[self cardActivateFadeIn:_afterCardUsedView animaImage:[UIImage imageNamed:@"anime.png"]];
    //MARK: デバッグ終わったら戻す[self sync];
    //ダメージ計算
    NSLog(@"ダメージ計算フェーズ");
    //MARK: デバッグ終わったら戻す[self phaseNameFadeIn:@"ダメージ計算フェイズ"];
    //MARK: デバッグ終わったら戻す[self sync];
    NSLog(@"-----------------------------------");
    NSLog(@"%s",__func__);
    [self activateCardInTiming:2];
    NSLog(@"入れる枚数：%d",app.myAdditionalGettingCards);
    [sendMyData send];
    [self activateCardInTiming:99];
    //カード効果でカードを引いたら処理する
        for (int i = 0; i < app.myAdditionalGettingCards; i++) {
            [self getACard:MYSELF];
        }
        app.myAdditionalGettingCards = 0;
    //カード効果でカードを捨てたら処理する
        for (int i = 0; i < app.myAdditionalDiscardingCards; i++) {
            [self discardFromHand:MYSELF string:@"捨てるカードを一枚選んでください"];
            [self sync];
        }
    app.enemyDamageFromAA = [_bc damageCaliculate];
    [sendMyData send];
    app.myLifeGage = app.myLifeGage - (app.myDamageFromAA + app.myDamageFromCard);
    NSLog(@"被ダメージ:%d",app.myDamageFromAA + app.myDamageFromCard);
    //ダメージを与え終えたら値を0に戻しておく
    app.myDamageFromAA = 0;
    app.myDamageFromCard = 0;
    app.enemyDamageFromAA = 0;
    app.enemyDamageFromCard = 0;
    [self damageCaliculateFadeIn:_damageCaliculateView animaImage:[UIImage imageNamed:@"anime.png"]];
    [self sync];
    //ターン終了時
    [sendMyData send];
    [self refleshView];
    NSLog(@"ターン終了フェイズ");
    //MARK: デバッグ終わったら戻す[self phaseNameFadeIn:@"ターン終了フェイズ"];
    //MARK: デバッグ終わったら戻す[self sync];
    [self activateCardInTiming:3];
    [self activateCardInTiming:99];
    app.myLifeGage = app.myLifeGage -app.myDamageFromCard;
    //ダメージを与え終えたら値を0に戻しておく
    app.myDamageFromCard = 0;
    app.enemyDamageFromCard = 0;
    [sendMyData send];
    [self refleshView];
    //MARK: デバッグ終わったら戻す[self resultFadeIn:_turnResultView animaImage:[UIImage imageNamed:@"anime.png"]];
    //MARK: デバッグ終わったら戻す[self sync];
    
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
    
    while([app.myHand count] > 5){
        [self discardFromHandInTurnEndPhase:@"手札の所持枚数が5枚を超えました。捨てるカードを一枚選んでください"];
        [self sync];
    }
    [self initializeVariables];
    [sendMyData send];
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
                        NSLog(@"ソーサリーです");
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfWhite count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfWhite objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                        NSLog(@"フィールドカードです");
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
                        NSLog(@"ソーサリーです");
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfBlue count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfBlue objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                        NSLog(@"フィールドカードです");
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
                        NSLog(@"ソーサリーです");
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfBlack count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfBlack objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                        NSLog(@"フィールドカードです");
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
                        NSLog(@"ソーサリーです");
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfRed count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfRed objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                        NSLog(@"フィールドカードです");
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
                        NSLog(@"ソーサリーです");
                    }
                }
            }
            for (int i = 0; i < [app.damageSourceOfGreen count]; i++) {
                for (int j = 0; j < [app.enemyFieldCard count]; j++) {
                    if([[app.damageSourceOfGreen objectAtIndex:i] intValue] == [[app.enemyFieldCard objectAtIndex:j] intValue]){
                        app.myLifeGageByMyself = [self HPOperate:app.myLifeGageByMyself point:1];
                        NSLog(@"フィールドカードです");
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
            app.myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
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
            [self discardFromLibrary:0];
            [self discardFromLibrary:1];
            break;
        case 34:
            //相手のライブラリーを上から半分削る（WW2)
            for (int i = 0; i < [app.enemyDeckCardList count] / 2; i++) {
                [self discardFromLibrary:i];
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
            //手札を全て捨て、同じだけの枚数のカードを引く(U3)
            {
                int i = (int)[app.myHand count];
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
            break;
        case 63:
            //このカードが場に出た時、ライフを５点得る。このカードが場から離れた時、ライフを５点失う。(UU)
            break;
        case 64:
            //このカードが場に出ている限り、相手の攻撃力を３さげる(UU3)
            break;
        case 65:
            //カードを一枚引く（U1)
            app.myAdditionalGettingCards++;
            break;
        case 66:
            //対象キャラの攻撃力＋３（R)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            break;
        case 67:
            //相手のエネルギーカードを破壊(RR2)
            //            [self browseCardsInRegion:app.enemyEnergyCard touchCard:YES fromMethod:-1];
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
            //            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 76:
            //対象の場カードを２枚破壊する（R3)
            //            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES fromMethod:-1];
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
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
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
            
            break;
        case 87:
            //カードを１枚ランダムで捨てる。相手キャラの攻撃力−５（R３）
        {
            int rand = random() % [app.enemyHand count];
            //                [self discardFromHand:ENEMY cardNumber:rand];
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
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            app.enemyLifeGage = [self HPOperate:app.enemyLifeGage point:-2];
            break;
        case 94:
            //対象のエネルギーカードを破壊する（R2)
            //            [self browseCardsInRegion:app.enemyEnergyCard touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.enemyEnergyCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 95:
            //対象のエネルギーカードを２枚破壊する(RR3)
            //            [self browseCardsInRegion:app.enemyEnergyCard touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.enemyEnergyCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            //            [self browseCardsInRegion:app.enemyEnergyCard touchCard:YES fromMethod:-1];
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
            //                [self discardFromHand:ENEMY cardNumber:rand];
        }
            break;
        case 100:
            //相手の手札をランダムで２枚減らす（BB)
        {
            int rand = random() % [app.enemyHand count];
            //                [self discardFromHand:ENEMY cardNumber:rand];
            
            int rand2 = random() % [app.enemyHand count];
            //                [self discardFromHand:ENEMY cardNumber:rand2];
        }
            break;
        case 101:
            //相手の手札を全て減らす（BB3)
        {
            for (int i = 0; i < [app.enemyHand count]; i++) {
                //                    [self discardFromHand:ENEMY cardNumber:0];
            }
        }
            break;
        case 102:
            //このターンに与えたダメージ分、自分は回復（B1)
            //TODO: メソッド実装
            break;
        case 103:
            //攻撃力と防御力が−１される代わりにブロックされない（B１)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:-1 temporary:1];
            app.enemyGikoDeffencePermittedByMyself = NO;
            app.enemyMonarDeffencePermittedByMyself = NO;
            app.enemySyobonDeffencePermittedByMyself = NO;
            app.enemyYaruoDeffencePermittedByMyself = NO;
            break;
        case 104:
            //このターン、ライフを３点失う代わりに攻撃力が＋５される（BB)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-3];
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:5 temporary:1];
            
            break;
        case 105:
            //毎ターンライフを５点失う代わりに攻撃力が＋８される（BB2)
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-5];
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:8 temporary:0];
            
            break;
        case 106:
            //自分の場カードを破壊することでカードを２枚引く（B1)
            //            [self browseCardsInRegion:app.myFieldCard touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.myFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            [self getACard:MYSELF];
            [self getACard:MYSELF];
            
            break;
        case 107:
            //エネルギーカードの種類数だけ、相手の攻撃力と防御力をマイナスさせる（B1)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self enemyAttackPowerOperate:app.enemySelectCharacter point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1 temporary:1];
            [self enemyDeffencePowerOperate:app.enemySelectCharacter point:[self distinguishTheNumberOfEnergyCardColor:MYSELF] * -1 temporary:1];
            break;
        case 108:
            //場のカードを破壊するが、ライフを３点失う（B1)
            //            [self browseCardsInRegion:app.enemyFieldCard touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.enemyFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 109:
            //自分のターンの開始時に、相手プレイヤーはカードをランダムで１枚捨てる（BB2)
        {
            int rand = random() % [app.enemyHand count];
            //                [self discardFromHand:ENEMY cardNumber:rand];
        }
            break;
        case 110:
            //対象キャラの攻撃力・防御力を−１し、カードを一枚引く。（B2)
            //TODO: app.mySelectCharacterに数値が入った時は、app.myCharacterAttackPowerとapp.myCharacterDeffencePowerにも数値が入るようにする。
            //TODO: app.mySelectCharacterとapp.myCharacterAttackPowerとapp.myCharacterDeffencePowerはターン終了時に初期化する
            
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
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
            //            [self browseCardsInRegion:app.myDeckCardList touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.myDeckCardList cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myHand];
            app.myLifeGage = [self HPOperate:app.myLifeGage point:-4];
            
            break;
        case 114:
            //カードを一枚好きにサーチし、ライブラリを切り直す（BB2)
            //            [self browseCardsInRegion:app.myDeckCardList touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.myDeckCardList cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myHand];
            break;
        case 115:
            //相手プレイヤーのデッキからカードを一枚捨てる（B１)
            //            [self browseCardsInRegion:app.enemyDeckCardList touchCard:YES fromMethod:-1];
            [self discardFromLibrary:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 116:
            //相手プレイヤーのデッキからカードを十枚捨てる(BBB5)
            for (int i = 0; i < 10; i++) {
                //                [self browseCardsInRegion:app.enemyDeckCardList touchCard:YES fromMethod:-1];
                [self discardFromLibrary:[self substituteSelectCardTagAndInitilizeIt]];
            }
            break;
        case 117:
            //攻撃力は＋３されるが、防御力が半分になる（B)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
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
            //            [self browseCardsInRegion:app.enemyHand touchCard:YES fromMethod:-1];
            //            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 119:
            //相手プレイヤーの手札の中にある、カードを2枚選んで捨てる（BB2)
            //            [self browseCardsInRegion:app.enemyHand touchCard:YES fromMethod:-1];
            //            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
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
            //            [self browseCardsInRegion:app.enemyHand touchCard:YES fromMethod:-1];
            //            [self discardFromHand:ENEMY cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
            break;
        case 122:
            //全プレイヤーは手札を捨てる（BB3)
            
            for (int i = 0; i < [app.myHand count]; i++) {
                //                    [self discardFromHand:MYSELF cardNumber:0];
            }
            for (int i = 0; i < [app.enemyHand count]; i++) {
                //                    [self discardFromHand:ENEMY cardNumber:0];
            }
            break;
        case 123:
            //対象キャラは攻撃力＋２、防御力−２（B3)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力をアップさせ、防御力をダウンさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:2 temporary:0];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:-2 temporary:0];
            break;
        case 124:
            //自分の場カードを破壊することで、対象プレイヤーはカードを２枚捨てる（B1)
            //            [self browseCardsInRegion:app.myFieldCard touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.myFieldCard cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            //            [self browseCardsInRegion:app.enemyHand touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.enemyHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            //            [self browseCardsInRegion:app.enemyHand touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.enemyHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.enemyTomb];
            break;
        case 125:
            //カードを２枚捨てることで、ずっと攻撃力・防御力＋２（B1)
            //            [self browseCardsInRegion:app.myHand touchCard:YES fromMethod:-1];
            [self setCardFromXTOY:app.myHand cardNumber:[self substituteSelectCardTagAndInitilizeIt] toField:app.myTomb];
            //            [self browseCardsInRegion:app.myHand touchCard:YES fromMethod:-1];
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
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:3 temporary:1];
            break;
        case 128:
            //対象キャラの攻撃力・防御力を１ターン＋７（G3)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:7 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:7 temporary:1];
            
            break;
        case 129:
            //対象キャラの攻撃力・防御力を１ターン＋１，カードを一枚引く（G)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
            [self myAttackPowerOperate:mySelectCharacterInCharacterField point:1 temporary:1];
            [self myDeffencePowerOperate:mySelectCharacterInCharacterField point:1 temporary:1];
            [self getACard:MYSELF];
            
            break;
        case 130:
            //１ターンの間、対象キャラの攻撃力・防御力を＋２，攻撃力そのままをダメージにする（G2)
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせ、ブロックさせないAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
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
            [self createCharacterField:_allImageView cancelButton:NO explain:[NSString stringWithFormat:@"%@が発動しました。攻撃力と防御力をアップさせるAAを選んでください",[app.cardList_cardName objectAtIndex:(cardnumber + 1)]]];
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
    if ([app.cardsEnemyUsedInThisTurn count] == 1) {
        [self insertTextViewToParentView:view Text:[NSString stringWithFormat:@"カードを使用しませんでした"] Rectangle:CGRectMake(20, 220, 240, 20)];
    }else{
        for (int i = 1; i < [app.cardsEnemyUsedInThisTurn count]; i++) {
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
    
    
    [view addSubview:_myDamage];
    [view addSubview:_myGiko];
    [view addSubview:_myMonar];
    [view addSubview:_mySyobon];
    [view addSubview:_myYaruo];
    [view addSubview:_enemyDamage];
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
    //TODO: 今回選ばれているキャラクターのみ赤字にする
    
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
            NSLog(@"ドローカウント：%d",myDrawCount);
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
        
        NSLog(@"-----------------------------------");
        NSLog(@"%s", __func__);
        for (int i = 0; i < [app.myHand count]; i++) {
            NSLog(@"現在の手札のカードナンバー：%d枚目:%d",i + 1,[[app.myHand objectAtIndex:i] intValue]);
        }
        NSLog(@"-----------------------------------");
        
        
        //相手
        while (enemyDrawCount < 5) {
            NSLog(@"ドローカウント：%d",enemyDrawCount);
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
    int cardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue];
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
            app.myUsingCardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
            
            _doIUseSorcerycard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"ソーサリーカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseSorcerycard show];
            [self sync];
            //このターン、カードを使用していれば、効果を発動する
            if(doIUseCardInThisTurn == YES){
                //[self cardActivate:cardNumber string:nil];
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
            app.myUsingCardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
            
            
            _doIUseFieldcard = [[UIAlertView alloc] initWithTitle:@"確認" message:@"フィールドカードを使用しますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"はい", @"いいえ", nil];
            [_doIUseFieldcard show];
            [self sync];
            if(doIUseCardInThisTurn == YES){
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
            app.myUsingCardNumber = [[app.myHand objectAtIndex:selectedCardOrder] intValue]; //今選んでいるカードのナンバー
            
            
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
            [cardImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detailOfACard)]]; //detailOfACard:はDeckViewControllerのメソッド。エラーが出る場合は注意。
            
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
            app.myGikoModifyingAttackPowerByMyself += x;
        }else if (character == MONAR){
            app.myMonarModifyingAttackPowerByMyself += x;
        }else if (character == SYOBON){
            app.mySyobonModifyingAttackPowerByMyself += x;
        }else if (character == YARUO){
            app.myYaruoModifyingAttackPowerByMyself += x;
        }
    }else{
        if(character == GIKO){
            app.myGikoFundamentalAttackPowerByMyself += x;
        }else if (character == MONAR){
            app.myMonarFundamentalAttackPowerByMyself += x;
        }else if (character == SYOBON){
            app.mySyobonFundamentalAttackPowerByMyself += x;
        }else if (character == YARUO){
            app.myYaruoFundamentalAttackPowerByMyself += x;
        }
    }
}

//自分の対象キャラの防御力を操作する（対象キャラの防御力を管理する変数・操作する値(プラスならアップ、マイナスならダウン)）
-(void)myDeffencePowerOperate:(int)character point:(int)x temporary:(BOOL)temporary{
    if(temporary == YES){
        if(character == GIKO){
            app.myGikoModifyingDeffencePowerByMyself += x;
        }else if (character == MONAR){
            app.myMonarModifyingDeffencePowerByMyself += x;
        }else if (character == SYOBON){
            app.mySyobonModifyingDeffencePowerByMyself += x;
        }else if (character == YARUO){
            app.myYaruoModifyingDeffencePowerByMyself += x;
        }
    }else{
        if(character == GIKO){
            app.myGikoFundamentalDeffencePowerByMyself += x;
        }else if (character == MONAR){
            app.myMonarFundamentalDeffencePowerByMyself += x;
        }else if (character == SYOBON){
            app.mySyobonFundamentalDeffencePowerByMyself += x;
        }else if (character == YARUO){
            app.myYaruoFundamentalDeffencePowerByMyself += x;
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
        NSLog(@"app.enemyGikoModifyingAttackPowerByMyself:%d",app.enemyGikoModifyingAttackPowerByMyself);
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
-(int)distinguishCardColor :(int)cardNumber{
    int colorNumber = 0;
    colorNumber = [[app.cardList_color objectAtIndex:cardNumber] intValue];
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
        NSLog(@"手札に入れたカードのタグ：%ld",_myGetCard.tag);
        
        //デッキのカード枚数を減らし、手札に入れる
        [self setCardFromXTOY:app.myDeckCardList cardNumber:0 toField:app.myHand];
        
    }else{
        //TODO: 敵がカードを手に入れた際の処理
    }
}

//対象プレイヤーは1枚カードを捨てる（対象プレイヤー（０なら自分、１なら相手）・対象プレイヤーの手札・捨てるカードの番号(myHand or enemyHandの配列番号)）
- (void)discardFromHand :(int)man string:(NSString *)str{
    if(man == 0){
        [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandSelector:) string:str];
    }else{
        [self browseCardsInRegion:app.enemyHand touchCard:YES tapSelector:@selector(discardEnemyHandSelector:) string:str];
    }
}

//ターン終了フェイズにおいて、手札が5枚を超えているときに使うメソッド
- (void)discardFromHandInTurnEndPhase :(NSString *)str{
    [self browseCardsInRegion:app.myHand touchCard:YES tapSelector:@selector(discardMyHandInTurnEndPhaseSelector:) string:str];
}

//対象プレイヤーの山札からカードを一枚墓地に捨てる（対象プレイヤー（対象プレイヤー・タグナンバー）
- (void)discardFromLibrary :(int)num{
    [self manipulateCard:[app.enemyDeckCardList objectAtIndex:num] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyDeckCardListByMyself_minus];
}

//対象プレイヤーのXという場（X=場カード置き場 or エネルギーカード置き場）から対象プレイヤーYという場にZというカードを置く（対象プレイヤー・移動元の場・移動元の配列の何番目に存在するか・移動後の場）
- (void)setCardFromXTOY :(NSMutableArray *)fromField  cardNumber:(int)cardNumber toField:(NSMutableArray *)toField{
    [toField addObject:[fromField objectAtIndex:cardNumber]];
    [fromField removeObjectAtIndex:cardNumber];
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
        [cardImage addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detailOfACard)]]; //detailOfACard:はDeckViewControllerのメソッド。エラーが出る場合は注意。
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


//特定の場面でカードの追加コストを要求する
- (void)payAdditionalCost{
    
    //TODO : カードたくさん入れるとはみ出るかも
    
    for (int i = 0; i < [app.myHand count]; i++) {
        UIImageView *cardImage = [[UIImageView alloc] init];
        [_additionalCostView addSubview:cardImage];
        cardImage.frame = CGRectMake(10, 10 + (CARDHEIGHT) * i + (i  * 5), CARDWIDTH, CARDHEIGHT);
        cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[app.myHand objectAtIndex:i]]];
        cardImage.userInteractionEnabled = YES;
        cardImage.tag = i + 1;
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


//TODO: 相性を逆転させた上で、ダメージ計算を行う
- (int)reverseCaliculate :(int)man{
    int result = 999;
    
    return result;
}


//TODO: 対象のプレイヤーが何色のエネルギーカードを場においているかを判定する。
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
        case 0:
            //追加コストとしてカードを捨てる際のOKボタンから飛んできた場合
            //- (void)selectCardで事前設定済み
            //            [self discardFromHand:MYSELF cardNumber:[self substituteSelectCardTagAndInitilizeIt]];
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
            //ある領域のカードを見た際のOK,キャンセルボタンから飛んできた場合
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
                app.myUsingCardNumber = -1;
                app.doIUseCard = NO;
                
                NSLog(@"selectCardNum:%d",app.myUsingCardNumber);
                NSLog(@"手札の内容：%@",app.myHand);
                NSLog(@"墓地の内容：%@",app.myTomb);
                FINISHED1
                break;
            case 1:
                //キャンセルボタンの場合は数値のみ初期化
                app.myUsingCardNumber = -1;
                selectedCardOrder = -1;
                app.myUsingCardNumber = -1;
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
                app.myUsingCardNumber = -1;
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
                app.myUsingCardNumber = -1;
                app.doIUseCard = NO;
                doIUseCardInThisTurn = NO;
                [_border_usedCard removeFromSuperview];
                FINISHED1
                break;
            default:
                break;
        }
    }else if (alertView == _battleStart){
        switch (buttonIndex) {
            case 0:
                motion = [[DeviceMotion alloc] init];
                [motion bump];
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
    NSString *energyCost = [app.cardList_cost objectAtIndex:cardNumber]; //コストの文字列を取得
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
- (void)initializeVariables{
    
    //常に初期化するもの
    [getEnemyData doEnemyDecideAction:NO]; //app.decideAction = NOと初期化しておく
    _bc.reverse = NO;
    
    //自分に関係する変数
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
                if([app.fieldCardList_turnStart containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
            //カード使用時
        case 1:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_afterCardUsed containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
            //ダメージ計算時
        case 2:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_damageCaliculate containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            for(int i = 0; i < [app.cardsIUsedInThisTurn count]; i++){
                if([app.sorceryCardList containsObject:[app.cardsIUsedInThisTurn objectAtIndex:i]]){
                    [self cardActivate:[[app.cardsIUsedInThisTurn objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
            //ターン終了時
        case 3:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_turnEnd containsObject:[app.myFieldCard objectAtIndex:i]]){
                    [self cardActivate:[[app.myFieldCard objectAtIndex:i] intValue] string:nil];
                }
            }
            break;
            //他のカード効果発動を待ってから最後に発動するカード
        case 99:
            for(int i = 0; i < [app.myFieldCard count]; i++){
                if([app.fieldCardList_other containsObject:[app.myFieldCard objectAtIndex:i]]){
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


- (void)setCardToCardsIUsedInThisTurn:(NSMutableArray *)fromField  cardNumber:(int)cardNumber{
    [app.cardsIUsedInThisTurn addObject:[fromField objectAtIndex:cardNumber]];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == _cardInRegion){
        CGRect scrolledRect;
        scrolledRect.origin = CGPointMake(_cardInRegion.contentOffset.x, _cardInRegion.contentOffset.y);
        scrolledRect.size = _backGroundView.frame.size;
        _backGroundView.frame = scrolledRect;
    }
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
    [self setCardFromXTOY:app.myHand cardNumber:selectedCardOrder toField:app.myTomb];
    [_cardInRegion removeFromSuperview];
    
    FINISHED1
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
    [self setCardFromXTOY:app.enemyHand cardNumber:selectedCardOrder toField:app.enemyTomb];
    [_cardInRegion removeFromSuperview];
    FINISHED1
}

-(void)destroyEnemyFieldCardSelector: (UITapGestureRecognizer *)sender{
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [self manipulateCard:[app.enemyFieldCard objectAtIndex:selectedCardOrder] plusArray:app.enemyTombByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
    
    [_cardInRegion removeFromSuperview];
    FINISHED1
    
}

-(void)returnEnemyFieldCardToHandSelector: (UITapGestureRecognizer *)sender{
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [self manipulateCard:[app.enemyFieldCard objectAtIndex:selectedCardOrder] plusArray:app.enemyHandByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
    [_cardInRegion removeFromSuperview];
    FINISHED1
}

-(void)stealEnemyFieldCardSelector: (UITapGestureRecognizer *)sender{
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [self manipulateCard:[app.enemyFieldCard objectAtIndex:selectedCardOrder] plusArray:app.myFieldCardByMyself_plus minusArray:app.enemyFieldCardByMyself_minus];
    [_cardInRegion removeFromSuperview];
    FINISHED1
}

-(void)putACardToLibraryTopOrBottomSelector: (UITapGestureRecognizer *)sender{
    //selectedCardOrderに選ばれたカードの配列の順番だけ入れるセレクタ
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [_cardInRegion removeFromSuperview];
    _putACardToLibraryTopOrBottom = [[UIAlertView alloc] initWithTitle:@"選択" message:@"山札のどちらにおきますか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"一番上", @"一番下", nil];
    [_putACardToLibraryTopOrBottom show];
    [self sync];
}

-(void)normalSelector: (UITapGestureRecognizer *)sender{
    //selectedCardOrderに選ばれたカードの配列の順番だけ入れるセレクタ
    NSLog(@"selectedCardOrder:%d",(int)[regionViewArray indexOfObject:sender.view]);
    selectedCardOrder = (int)[regionViewArray indexOfObject:sender.view];
    [_cardInRegion removeFromSuperview];
    FINISHED1
}

-(void)manipulateCard:(NSNumber *)cardNumber plusArray:(NSMutableArray *)plusArray minusArray:(NSMutableArray *)minusArray{
    [plusArray addObject:cardNumber];
    [minusArray addObject:cardNumber];
}



@end
