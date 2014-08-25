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
    [[UIButton appearance] setFont:[UIFont fontWithName:@"Tanuki-Permanent-Marker" size:14.0f]];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    int first =  [userDefault integerForKey:@"firstLaunch_ud"];
    appdelegate = [[UIApplication sharedApplication] delegate];
    
    if(first == 0){
        firstLaunchView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        firstLaunchView.image = [UIImage imageNamed:@"anime"];
        firstLaunchView.userInteractionEnabled = YES;
        tf = [[UITextField alloc] initWithFrame:CGRectMake(20 , 60, [[UIScreen mainScreen] bounds].size.width -20, 30)];
        tf.placeholder = @"なまえを入力してください";
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.returnKeyType = UIReturnKeyDone;
        tf.delegate = self;
        tf.text = @"test";
        [firstLaunchView addSubview:tf];
        [self.view addSubview:firstLaunchView];
        [userDefault setInteger:1 forKey:@"firstLaunch_ud"];
    }
    
    //!!!デバッグ用
    
//    UIButton *debug2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    debug2Button.frame = CGRectMake(40, 30, 80, 20);
//    [debug2Button setTitle:@"デバッグ2" forState:UIControlStateNormal];
//    [[self view] addSubview:debug2Button];
//    [debug2Button addTarget:self action:@selector(debug2:)
//           forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *debug3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    debug3Button.frame = CGRectMake(40, 60, 80, 20);
//    [debug3Button setTitle:@"デバッグ3" forState:UIControlStateNormal];
//    [[self view] addSubview:debug3Button];
//    [debug3Button addTarget:self action:@selector(debug3:)
//           forControlEvents:UIControlEventTouchUpInside];
    
    //!!!デバッグ用
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 -(BOOL)textFieldShouldReturn:(UITextField*)textField{
     userDefault = [NSUserDefaults standardUserDefaults];
     [userDefault setObject:tf.text forKey:@"myNickName_ud"];
     [userDefault synchronize];
     appdelegate.myNickName = [userDefault objectForKey:@"myNickName_ud"];
     NSLog(@"ニックネーム：%@",appdelegate.myNickName);
     [tf resignFirstResponder];
     [firstLaunchView removeFromSuperview];
     return YES;
 }

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    appdelegate.myCards = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myCards_ud"]];
    appdelegate.myDeck1 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud1"]];
    appdelegate.myDeck2 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud2"]];
    appdelegate.myDeck3 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud3"]];

//    カード効果実装時のデバッグ用
//    appdelegate.myDeck = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],
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
    
    appdelegate.myHand = [[NSMutableArray alloc] init]; //自分の手札
    appdelegate.myTomb = [[NSMutableArray alloc] init]; //自分の墓地のカードナンバー
    appdelegate.myFieldCard = [[NSMutableArray alloc] initWithObjects:nil]; //自分の場カードのカードナンバー
    appdelegate.myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:5], [NSNumber numberWithInt:5], [NSNumber numberWithInt:5], [NSNumber numberWithInt:5],nil]; //自分のエネルギーカードの数
    appdelegate.myDeckCardListByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyDeckCardList（差分のみ管理）
    appdelegate.myHandByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyHand（差分のみ管理）
    appdelegate.myTombByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyTomb（差分のみ管理）
    appdelegate.myFieldCardByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyFieldCard（差分のみ管理）
    appdelegate.myEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // 自分が操作し、増加したmyEnergyCard（差分のみ管理）
    appdelegate.myDeckCardListByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyDeckCardList（差分のみ管理）
    appdelegate.myHandByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyHand（差分のみ管理）
    appdelegate.myTombByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyTomb（差分のみ管理）
    appdelegate.myFieldCardByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyFieldCard（差分のみ管理）
    appdelegate.myEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // 自分が操作し、減少したmyEnergyCard（差分のみ管理）
    appdelegate.myDeckCardListFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyDeckCardList（差分のみ管理）
    appdelegate.myHandFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyHand（差分のみ管理）
    appdelegate.myTombFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyTomb（差分のみ管理）
    appdelegate.myFieldCardFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyFieldCard（差分のみ管理）
    appdelegate.myEnergyCardFromEnemy_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //相手が操作し、増加したmyEnergyCard（差分のみ管理）
    appdelegate.myDeckCardListFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyDeckCardList（差分のみ管理）
    appdelegate.myHandFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyHand（差分のみ管理）
    appdelegate.myTombFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyTomb（差分のみ管理）
    appdelegate.myFieldCardFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyFieldCard（差分のみ管理）
    appdelegate.myEnergyCardFromEnemy_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //相手が操作し、減少したmyEnergyCard（差分のみ管理）
    appdelegate.myUsingEnergy = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //自分がこのターン使用したエネルギーの量
    appdelegate.myLifeGage = 20;
    appdelegate.myLifeGageByMyself = 0; //自分のライフポイントを自分で操作する場合の値(差分のみ管理)
    appdelegate.myAdditionalGettingCards = 0;//ターンの開始時に引くカード以外で引いた、ターン毎のカードの枚数を管理する
    appdelegate.myAdditionalDiscardingCards = 0;//ターンの終了時に捨てるカード以外で捨てた、ターン毎のカードの枚数を管理する
    appdelegate.myGikoFundamentalAttackPower = 3; //自分のギコの基本攻撃力
    appdelegate.myGikoFundamentalDeffencePower = 0; //自分のギコの基本防御力
    appdelegate.myMonarFundamentalAttackPower = 3; //自分のモナーの基本攻撃力
    appdelegate.myMonarFundamentalDeffencePower = 0; //自分のモナーの基本防御力
    appdelegate.mySyobonFundamentalAttackPower = 3; //自分のショボンの基本攻撃力
    appdelegate.mySyobonFundamentalDeffencePower = 0; //自分のショボンの基本防御力
    appdelegate.myYaruoFundamentalAttackPower = 0; //自分のやる夫の基本攻撃力
    appdelegate.myYaruoFundamentalDeffencePower = 3; //自分のやる夫の基本防御力
    appdelegate.myGikoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のギコの基本攻撃力（差分のみ管理）
    appdelegate.myGikoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のギコの基本防御力（差分のみ管理）
    appdelegate.myMonarFundamentalAttackPowerByMyself = 0; //自分が操作した自分のモナーの基本攻撃力（差分のみ管理）
    appdelegate.myMonarFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のモナーの基本防御力（差分のみ管理）
    appdelegate.mySyobonFundamentalAttackPowerByMyself = 0; //自分が操作した自分のショボンの基本攻撃力（差分のみ管理）
    appdelegate.mySyobonFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のショボンの基本防御力（差分のみ管理）
    appdelegate.myYaruoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    appdelegate.myYaruoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の基本防御力（差分のみ管理）
    appdelegate.myGikoFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のギコの基本攻撃力（差分のみ管理）
    appdelegate.myGikoFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のギコの基本防御力（差分のみ管理）
    appdelegate.myMonarFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のモナーの基本攻撃力（差分のみ管理）
    appdelegate.myMonarFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のモナーの基本防御力（差分のみ管理）
    appdelegate.mySyobonFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のショボンの基本攻撃力（差分のみ管理）
    appdelegate.mySyobonFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のショボンの基本防御力（差分のみ管理）
    appdelegate.myYaruoFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    appdelegate.myYaruoFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のやる夫の基本防御力（差分のみ管理）
    appdelegate.mySelectCharacter = -1; //自分の選んだキャラクター
    appdelegate.mySelectCharacterFromEnemy = -1;
    appdelegate.myGikoModifyingAttackPower = 0; //自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.myGikoModifyingDeffencePower = 0; //自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.myMonarModifyingAttackPower = 0; //自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.myMonarModifyingDeffencePower = 0; //自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.mySyobonModifyingAttackPower = 0; //自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.mySyobonModifyingDeffencePower = 0; //自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.myYaruoModifyingAttackPower = 0; //自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.myYaruoModifyingDeffencePower = 0; //自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.myGikoModifyingAttackPowerByMyself = 0; //自分が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myGikoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myMonarModifyingAttackPowerByMyself = 0; //自分が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myMonarModifyingDeffencePowerByMyself = 0; //自分が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.mySyobonModifyingAttackPowerByMyself = 0; //自分が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.mySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myYaruoModifyingAttackPowerByMyself = 0; //自分が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myGikoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myGikoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myMonarModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myMonarModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.mySyobonModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.mySyobonModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myYaruoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myYaruoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    appdelegate.myGikoAttackPermittedByMyself = YES; //自分のギコの攻撃許可
    appdelegate.myGikoDeffencePermittedByMyself = YES; //自分のギコの防御許可
    appdelegate.myMonarAttackPermittedByMyself = YES; //自分のモナーの攻撃許可
    appdelegate.myMonarDeffencePermittedByMyself = YES; //自分のモナーの防御許可
    appdelegate.mySyobonAttackPermittedByMyself = YES; //自分のショボンの攻撃許可
    appdelegate.mySyobonDeffencePermittedByMyself = YES; //自分のショボンの防御許可
    appdelegate.myYaruoAttackPermittedByMyself = YES; //自分のやる夫の攻撃許可
    appdelegate.myYaruoDeffencePermittedByMyself = YES; //自分のやる夫の防御許可
    appdelegate.myGikoAttackPermittedFromEnemy = YES; //相手の妨害による自分のギコの攻撃許可
    appdelegate.myGikoDeffencePermittedFromEnemy = YES; //相手の制限による自分のギコの防御許可
    appdelegate.myMonarAttackPermittedFromEnemy = YES; //相手の制限による自分のモナーの攻撃許可
    appdelegate.myMonarDeffencePermittedFromEnemy = YES; //相手の制限による自分のモナーの防御許可
    appdelegate.mySyobonAttackPermittedFromEnemy = YES; //相手の制限による自分のショボンの攻撃許可
    appdelegate.mySyobonDeffencePermittedFromEnemy = YES; //相手の制限による自分のショボンの防御許可
    appdelegate.myYaruoAttackPermittedFromEnemy = YES; //相手の制限による自分のやる夫の攻撃許可
    appdelegate.myYaruoDeffencePermittedFromEnemy = YES; //相手の制限による自分のやる夫の防御許可
    appdelegate.doIUseCard = NO; //自分がこのターンカードを使用したか
    appdelegate.myDamageFromAA = 0;
    appdelegate.myDamageFromCard = 0;
    appdelegate.mySelectColor = -1; //自分が選んだ色
    appdelegate.cardsIUsedInThisTurn = [[NSMutableArray alloc] init];
    
    
    
    //相手に関係する変数
    appdelegate.enemyLifeGage = 20;
    appdelegate.enemyDeckCardList = [[NSMutableArray alloc] init]; //相手のデッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
    appdelegate.enemyHand = [[NSMutableArray alloc] init]; //相手の手札
    appdelegate.enemyDeckCardListByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyDeckCardList（差分のみ管理）
    appdelegate.enemyHandByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyHand（差分のみ管理）
    appdelegate.enemyTombByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyTomb（差分のみ管理）
    appdelegate.enemyFieldCardByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyFieldCard（差分のみ管理）
    appdelegate.enemyEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //自分が操作し、増加したenemyEnergyCard（差分のみ管理）
    appdelegate.enemyDeckCardListByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyDeckCardList（差分のみ管理）
    appdelegate.enemyHandByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyHand（差分のみ管理）
    appdelegate.enemyTombByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyTomb（差分のみ管理）
    appdelegate.enemyFieldCardByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyFieldCard（差分のみ管理）
    appdelegate.enemyEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //自分が操作し、減少したenemyEnergyCard（差分のみ管理）
    appdelegate.enemyGikoFundamentalAttackPower = 3; // 相手のギコの基本攻撃力
    appdelegate.enemyGikoFundamentalDeffencePower = 0; //相手のギコの基本防御力
    appdelegate.enemyMonarFundamentalAttackPower = 3; //相手のモナーの基本攻撃力
    appdelegate.enemyMonarFundamentalDeffencePower = 0; //相手のモナーの基本防御力
    appdelegate.enemySyobonFundamentalAttackPower = 3; //相手のショボンの基本攻撃力
    appdelegate.enemySyobonFundamentalDeffencePower = 0; //相手のショボンの基本防御力
    appdelegate.enemyYaruoFundamentalAttackPower = 0; //相手のやる夫の基本攻撃力
    appdelegate.enemyYaruoFundamentalDeffencePower = 3; //相手のやる夫の基本防御力
    appdelegate.enemyGikoFundamentalAttackPowerByMyself = 0; // 自分が操作した相手のギコの基本攻撃力（差分のみ管理）
    appdelegate.enemyGikoFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のギコの基本防御力（差分のみ管理）
    appdelegate.enemyMonarFundamentalAttackPowerByMyself = 0; //自分が操作した相手のモナーの基本攻撃力（差分のみ管理）
    appdelegate.enemyMonarFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のモナーの基本防御力（差分のみ管理）
    appdelegate.enemySyobonFundamentalAttackPowerByMyself = 0; //自分が操作した相手のショボンの基本攻撃力（差分のみ管理）
    appdelegate.enemySyobonFundamentalDeffencePowerByMyself = 0; //相自分が操作した手のショボンの基本防御力（差分のみ管理）
    appdelegate.enemyYaruoFundamentalAttackPowerByMyself = 0; //自分が操作した相手のやる夫の基本攻撃力（差分のみ管理）
    appdelegate.enemyYaruoFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のやる夫の基本防御力（差分のみ管理）
    appdelegate.enemySelectCharacter = -1; //相手の選んだキャラクター
    appdelegate.enemySelectCharacterByMyself = -1;
    appdelegate.enemyGikoModifyingAttackPower = 0; // 相手のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemyGikoModifyingDeffencePower = 0; //相手のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemyMonarModifyingAttackPower = 0; //相手のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemyMonarModifyingDeffencePower = 0; //相手のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemySyobonModifyingAttackPower = 0; //相手のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemySyobonModifyingDeffencePower = 0; //相手のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemyYaruoModifyingAttackPower = 0; //相手のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemyYaruoModifyingDeffencePower = 0; //相手のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    appdelegate.enemyGikoModifyingAttackPowerByMyself = 0; // 自分が操作した相手のギコの修正攻撃力（差分のみ管理）
    appdelegate.enemyGikoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のギコの修正防御力（差分のみ管理）
    appdelegate.enemyMonarModifyingAttackPowerByMyself = 0; //自分が操作した相手のモナーの修正攻撃力（差分のみ管理）
    appdelegate.enemyMonarModifyingDeffencePowerByMyself = 0; //自分が操作した相手のモナーの修正防御力（差分のみ管理）
    appdelegate.enemySyobonModifyingAttackPowerByMyself = 0; //自分が操作した相手のショボンの修正攻撃力（差分のみ管理）
    appdelegate.enemySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した相手のショボンの修正防御力（差分のみ管理）
    appdelegate.enemyYaruoModifyingAttackPowerByMyself = 0; //自分が操作した相手のやる夫の修正攻撃力（差分のみ管理）
    appdelegate.enemyYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のやる夫の修正防御力（差分のみ管理）
    
    appdelegate.enemyGikoAttackPermittedByMyself = YES; //相手のギコの攻撃許可
    appdelegate.enemyGikoDeffencePermittedByMyself = YES; //相手のギコの防御許可
    appdelegate.enemyMonarAttackPermittedByMyself = YES; //相手のモナーの攻撃許可
    appdelegate.enemyMonarDeffencePermittedByMyself = YES; //相手のモナーの防御許可
    appdelegate.enemySyobonAttackPermittedByMyself = YES; //相手のショボンの攻撃許可
    appdelegate.enemySyobonDeffencePermittedByMyself = YES; //相手のショボンの防御許可
    appdelegate.enemyYaruoAttackPermittedByMyself = YES; //相手のやる夫の攻撃許可
    appdelegate.enemyYaruoDeffencePermittedByMyself = YES; //相手のやる夫の防御許可
    appdelegate.enemyGikoAttackPermittedFromEnemy = YES; //相手の制限による相手のギコの攻撃許可
    appdelegate.enemyGikoDeffencePermittedFromEnemy = YES; //相手の制限による相手のギコの防御許可
    appdelegate.enemyMonarAttackPermittedFromEnemy = YES; //相手の制限による相手のモナーの攻撃許可
    appdelegate.enemyMonarDeffencePermittedFromEnemy = YES; //相手の制限による相手のモナーの防御許可
    appdelegate.enemySyobonAttackPermittedFromEnemy = YES; //相手の制限による相手のショボンの攻撃許可
    appdelegate.enemySyobonDeffencePermittedFromEnemy = YES; //相手の制限による相手のショボンの防御許可
    appdelegate.enemyYaruoAttackPermittedFromEnemy = YES; //相手の制限による相手のやる夫の攻撃許可
    appdelegate.enemyYaruoDeffencePermittedFromEnemy = YES; //相手の制限による手のやる夫の防御許可
    appdelegate.enemyTomb = [[NSMutableArray alloc] init]; //相手の墓地のカードナンバー
    appdelegate.doEnemyUseCard = NO; //相手がこのターンカードを使用したか
    appdelegate.enemyFieldCard = [[NSMutableArray alloc] init]; //相手の場カードのカードナンバー
    appdelegate.enemyEnergyCard = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //相手のエネルギーカードの数
    appdelegate.canEnemyPlaySorceryCardByMyself = YES; //相手が魔法カードを手札からプレイできるか
    appdelegate.canEnemyPlayFieldCardByMyself = YES; //相手が場カードを手札からプレイできるか
    appdelegate.canEnemyActivateFieldCardByMyself = YES; //相手が場カードの能力を起動できるか
    appdelegate.canEnemyPlayEnergyCardByMyself = YES; //相手がエネルギーカードを手札からプレイできるか
    appdelegate.canEnemyActivateEnergyCardByMyself = YES; //相手がエネルギーカードを起動できるか
    appdelegate.canEnemyPlaySorceryCardFromEnemy = YES; //相手の制限により相手が魔法カードを手札からプレイできるか
    appdelegate.canEnemyPlayFieldCardFromEnemy = YES; //相手の制限により相手が場カードを手札からプレイできるか
    appdelegate.canEnemyActivateFieldCardFromEnemy = YES; //相手の制限により相手が場カードの能力を起動できるか
    appdelegate.canEnemyPlayEnergyCardFromEnemy = YES; //相手の制限により相手がエネルギーカードを手札からプレイできるか
    appdelegate.canEnemyActivateEnergyCardFromEnemy = YES; //相手の制限により相手がエネルギーカードを起動できるか
    appdelegate.denyEnemyCardPlaying = NO; //相手がカードのプレイを打ち消されたか
    appdelegate.enemyDamageFromAA = 0;
    appdelegate.enemyDamageFromCard = 0;
    appdelegate.enemySelectColor = -1; //相手が選んだ色
    appdelegate.cardsEnemyUsedInThisTurn = [[NSMutableArray alloc] init];
    
    NSLog(@"初期化完了");
}


//!!!:カードゲットの練習用ここから

- (void)startAnimation
{

}

- (void)viewEffect2:(id)sender{
    NSLog(@"viewEffect2");
    // 渦巻きエフェクト発動
    [[self view] addSubview:effect2];
    [effect2 startAnimating];
    
    // タイマー
    [NSTimer scheduledTimerWithTimeInterval:0.4
                                     target:self
                                   selector:@selector(viewEffect3:)
                                   userInfo:nil
                                    repeats:false];
}

- (void)viewEffect3:(id)sender{
    NSLog(@"viewEffect3");
    // キャラ登場
    view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card98"]];
    view.frame = CGRectMake(60, 90, 200, 300);
    [[self view] addSubview:view];
    [[self view] addSubview:effect2];
    
    // タップレコグナイザー
    tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewStatus:)];
    [[self view] addGestureRecognizer:tgr];
}

- (void)viewStatus:(id)sender{
    [view removeFromSuperview];
    [[self view] removeGestureRecognizer:tgr];
    [self dismissViewControllerAnimated:NO completion:nil];
}



- (void)debug2 :(UITapGestureRecognizer *)sender{
    NSLog(@"おされた");
    
    NSLog(@"SummonViewController viewDidLoad");
    // 背景
    [[self view] setBackgroundColor:[UIColor blackColor]];
    
    // 魔法陣エフェクト準備
    effect1 = [[MBAnimationView alloc] init];
    [effect1 setAnimationImage:@"e_circle_240.png" :240 :240 :11];
    effect1.frame = CGRectMake(40, 160, 240, 240);
    effect1.animationDuration = 1;
    
    // 渦巻きエフェクト準備
    effect2 = [[MBAnimationView alloc] init];
    [effect2 setAnimationImage:@"e_appear_240.png" :94 :240 :12];
    effect2.frame = CGRectMake(113, 60, 94, 240);
    effect2.animationDuration = 1;
    
    // 魔法陣エフェクト発動
    [[self view] addSubview:effect1];
    [effect1 startAnimating];
    // タイマー
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(viewEffect2:)
                                   userInfo:nil
                                    repeats:false];
}

- (void)debug3 :(UITapGestureRecognizer *)sender{
    NSLog(@"おされた");
   
}


//!!!:カードゲットの練習用ここまで




@end
