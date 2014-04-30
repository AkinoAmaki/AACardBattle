//
//  AppDelegate.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    firstLaunch =  [ud integerForKey:@"firstLaunch_ud"];

#pragma mark デッキの準備
    
    if(firstLaunch == 0){
        NSMutableArray *firstCards = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],
                                                                             [NSNumber numberWithInteger:4],
                                                                             [NSNumber numberWithInteger:4],
                                                                             [NSNumber numberWithInteger:4],
                                                                             [NSNumber numberWithInteger:4],
                                                                             [NSNumber numberWithInteger:5],
                                                                             [NSNumber numberWithInteger:6],
                                                                             [NSNumber numberWithInteger:7],
                                                                             [NSNumber numberWithInteger:8],
                                                                             [NSNumber numberWithInteger:9],
                                                                             [NSNumber numberWithInteger:10],
                                                                             [NSNumber numberWithInteger:11],
                                                                             [NSNumber numberWithInteger:12],
                                                                             [NSNumber numberWithInteger:13],
                                                                             [NSNumber numberWithInteger:14],
                                                                             [NSNumber numberWithInteger:15],
                                                                             [NSNumber numberWithInteger:16],
                                                                             [NSNumber numberWithInteger:17],
                                                                             [NSNumber numberWithInteger:18],
                                                                             [NSNumber numberWithInteger:19],
                                                                             [NSNumber numberWithInteger:20],nil];
        NSMutableArray *firstDeck = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:40],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],
                                     [NSNumber numberWithInteger:2],nil];
        
        [ud setObject:firstCards forKey:@"myCards_ud"];
        [ud setObject:firstDeck forKey:@"myDeck_ud"];
        [ud setInteger:1 forKey:@"firstLaunch_ud"];
        [ud synchronize];
        NSLog(@"初回起動");
    }
    
//    // アプリケーションのバンドル識別子を取得します。
//    NSString* domain = [[NSBundle mainBundle] bundleIdentifier];
//    
//    // バンドル識別子を使って、アプリに関係する設定を一括消去します。
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domain];
    
    
    _myCards = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myCards_ud"]];
    _myDeck = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud"]];
    _myDeckCardList = [[NSMutableArray alloc] init];

    //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
    for (int i = 0; i < [_myDeck count]; i++) {
        for (int j = 0; j < [[_myDeck objectAtIndex:i] intValue]; j++) {
            [_myDeckCardList addObject:[NSNumber numberWithInteger:i]];
        }
    }
    _myDeckCardList = [self shuffledArray:_myDeckCardList];
    
    NSLog(@"デッキカード一覧：%@",_myDeckCardList);

    
#pragma mark カード関連のデータ（カード名、カードナンバー等）の配列
    
    _cardList_cardName = [[NSArray alloc] initWithObjects:@"outicon",@"1",	@"2",	@"3",	@"4",	@"5",	@"6",	@"7",	@"8",	@"9",	@"10",	@"11",	@"12",	@"13",	@"14",	@"15",	@"16",	@"17",	@"18",	@"19",	@"20",/*	@"21",	@"22",	@"23",	@"24",	@"25",	@"26",	@"27",	@"28",	@"29",	@"30",	@"31",	@"32",	@"33",	@"34",	@"35",	@"36",	@"37",	@"38",	@"39",	@"40",	@"41",	@"42",	@"43",	@"44",	@"45",	@"46",	@"47",	@"48",	@"49",	@"50",	@"51",	@"52",	@"53",	@"54",	@"55",	@"56",	@"57",	@"58",	@"59",	@"60",	@"61",	@"62",	@"63",	@"64",	@"65",	@"66",	@"67",	@"68",	@"69",	@"70",	@"71",	@"72",	@"73",	@"74",	@"75",	@"76",	@"77",	@"78",	@"79",	@"80",	@"81",	@"82",	@"83",	@"84",	@"85",	@"86",	@"87",	@"88",	@"89",	@"90",	@"91",	@"92",	@"93",	@"94",	@"95",	@"96",	@"97",	@"98",	@"99",	@"100",	@"101",	@"102",	@"103",	@"104",	@"105",	@"106",	@"107",	@"108",	@"109",	@"110",	@"111",	@"112",	@"113",	@"114",	@"115",	@"116",	@"117",	@"118",	@"119",	@"120",	@"121",	@"122",	@"123",	@"124",	@"125",	@"126",	@"127",	@"128",	@"129",	@"130",	@"131",	@"132",	@"133",	@"134",	@"135",	@"136",	@"137",	@"138",	@"139",	@"140",	@"141",	@"142",	@"143",	@"144",	@"145",	@"146",	@"147",	@"148",	@"149",	@"150",	@"151",	@"152",	@"153",	@"154",	@"155",	@"156",	@"157",	@"158",	@"159",	@"160",	@"161",	@"162",	@"163",	@"164",	@"165",	@"166",	@"167",	@"168",	@"169",	@"170",	@"171",	@"172",	@"173",	@"174",	@"175",	@"176",	@"177",	@"178",	@"179",	@"180",	@"181",	@"182",	@"183",	@"184",	@"185",	@"186",	@"187",	@"188",	@"189",	@"190",	@"191",	@"192",	@"193",	@"194",	@"195",	@"196",	@"197",	@"198",	@"199",	@"200",	@"201",	@"202",	@"203",	@"204",	@"205",*/
 nil];
    _cardList_pngName  = [[NSArray alloc] initWithObjects:@"dummy.png",@"card1.png",	@"card2.png",	@"card3.png",	@"card4.png",	@"card5.png",	@"card6.png",	@"card7.png",	@"card8.png",	@"card9.png",	@"card10.png",	@"card11.png",	@"card12.png",	@"card13.png",	@"card14.png",	@"card15.png",	@"card16.png",	@"card17.png",	@"card18.png",	@"card19.png",	@"card20.png",/*	@"card21.png",	@"card22.png",	@"card23.png",	@"card24.png",	@"card25.png",	@"card26.png",	@"card27.png",	@"card28.png",	@"card29.png",	@"card30.png",	@"card31.png",	@"card32.png",	@"card33.png",	@"card34.png",	@"card35.png",	@"card36.png",	@"card37.png",	@"card38.png",	@"card39.png",	@"card40.png",	@"card41.png",	@"card42.png",	@"card43.png",	@"card44.png",	@"card45.png",	@"card46.png",	@"card47.png",	@"card48.png",	@"card49.png",	@"card50.png",	@"card51.png",	@"card52.png",	@"card53.png",	@"card54.png",	@"card55.png",	@"card56.png",	@"card57.png",	@"card58.png",	@"card59.png",	@"card60.png",	@"card61.png",	@"card62.png",	@"card63.png",	@"card64.png",	@"card65.png",	@"card66.png",	@"card67.png",	@"card68.png",	@"card69.png",	@"card70.png",	@"card71.png",	@"card72.png",	@"card73.png",	@"card74.png",	@"card75.png",	@"card76.png",	@"card77.png",	@"card78.png",	@"card79.png",	@"card80.png",	@"card81.png",	@"card82.png",	@"card83.png",	@"card84.png",	@"card85.png",	@"card86.png",	@"card87.png",	@"card88.png",	@"card89.png",	@"card90.png",	@"card91.png",	@"card92.png",	@"card93.png",	@"card94.png",	@"card95.png",	@"card96.png",	@"card97.png",	@"card98.png",	@"card99.png",	@"card100.png",	@"card101.png",	@"card102.png",	@"card103.png",	@"card104.png",	@"card105.png",	@"card106.png",	@"card107.png",	@"card108.png",	@"card109.png",	@"card110.png",	@"card111.png",	@"card112.png",	@"card113.png",	@"card114.png",	@"card115.png",	@"card116.png",	@"card117.png",	@"card118.png",	@"card119.png",	@"card120.png",	@"card121.png",	@"card122.png",	@"card123.png",	@"card124.png",	@"card125.png",	@"card126.png",	@"card127.png",	@"card128.png",	@"card129.png",	@"card130.png",	@"card131.png",	@"card132.png",	@"card133.png",	@"card134.png",	@"card135.png",	@"card136.png",	@"card137.png",	@"card138.png",	@"card139.png",	@"card140.png",	@"card141.png",	@"card142.png",	@"card143.png",	@"card144.png",	@"card145.png",	@"card146.png",	@"card147.png",	@"card148.png",	@"card149.png",	@"card150.png",	@"card151.png",	@"card152.png",	@"card153.png",	@"card154.png",	@"card155.png",	@"card156.png",	@"card157.png",	@"card158.png",	@"card159.png",	@"card160.png",	@"card161.png",	@"card162.png",	@"card163.png",	@"card164.png",	@"card165.png",	@"card166.png",	@"card167.png",	@"card168.png",	@"card169.png",	@"card170.png",	@"card171.png",	@"card172.png",	@"card173.png",	@"card174.png",	@"card175.png",	@"card176.png",	@"card177.png",	@"card178.png",	@"card179.png",	@"card180.png",	@"card181.png",	@"card182.png",	@"card183.png",	@"card184.png",	@"card185.png",	@"card186.png",	@"card187.png",	@"card188.png",	@"card189.png",	@"card190.png",	@"card191.png",	@"card192.png",	@"card193.png",	@"card194.png",	@"card195.png",	@"card196.png",	@"card197.png",	@"card198.png",	@"card199.png",	@"card200.png",	@"card201.png",	@"card202.png",	@"card203.png",	@"card204.png",	@"card205.png",
	*/
            nil];
    
    
    _cardList_text = [[NSArray alloc] initWithObjects:@"ぬる", @"1番目のカードだよ", @"2番目のカードだよ",	@"3番目のカードだよ", @"4番目のカードだよ", @"5番目のカードだよ", @"6番目のカードだよ", @"7番目のカードだよ", @"8番目のカードだよ", @"9番目のカードだよ", @"10番目のカードだよ", @"11番目のカードだよ", @"12番目のカードだよ", @"13番目のカードだよ", @"14番目のカードだよ", @"15番目のカードだよ", @"16番目のカードだよ", @"17番目のカードだよ", @"18番目のカードだよ", @"19番目のカードだよ", @"20番目のカードだよ",nil];
    
    NSNumber *energy  = [NSNumber numberWithInt:ENERGYCARD];
    NSNumber *field  = [NSNumber numberWithInt:FIELDCARD];
    NSNumber *sorcery = [NSNumber numberWithInt:SORCERYCARD];
    
    _cardList_type = [[NSArray alloc] initWithObjects: energy, energy, energy, energy, energy, sorcery, field,sorcery,sorcery,field,field,field,field,field,field,field,field,field,field,field, nil];
    _cardList_cost = [[NSArray alloc] initWithObjects: @"0", @"0", @"0", @"0", @"0",@"W", @"W2", @"W", @"W2", @"W2", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", nil];

    
    NSLog(@"%f：%f",[[UIScreen mainScreen] bounds].size.width ,[[UIScreen mainScreen] bounds].size.height);

    
    
#pragma mark 対戦に関連する各種数値の初期化
    
    
    _myLifeGage = 20;
    _myHand = [[NSMutableArray alloc] init]; //自分の手札
    _myGikoFundamentalAttackPower = 3; //自分のギコの基本攻撃力
    _myGikoFundamentalDeffencePower = 0; //自分のギコの基本防御力
    _myMonarFundamentalAttackPower = 3; //自分のモナーの基本攻撃力
    _myMonarFundamentalDeffencePower = 0; //自分のモナーの基本防御力
    _mySyobonFundamentalAttackPower = 3; //自分のショボンの基本攻撃力
    _mySyobonFundamentalDeffencePower = 0; //自分のショボンの基本防御力
    _myYaruoFundamentalAttackPower = 0; //自分のやる夫の基本攻撃力
    _myYaruoFundamentalDeffencePower = 3; //自分のやる夫の基本防御力
    _mySelectCharacter = -1; //自分の選んだキャラクター
    _myCharacterFundamentalAttackPower = 0; //自分の選んだキャラクターの基本攻撃力
    _myCharacterFundamentalDeffencePower = 0; //自分の選んだキャラクターの基本防御力
    _myGikoModifyingAttackPower = 0; //自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _myGikoModifyingDeffencePower = 0; //自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _myMonarModifyingAttackPower = 0; //自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _myMonarModifyingDeffencePower = 0; //自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _mySyobonModifyingAttackPower = 0; //自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _mySyobonModifyingDeffencePower = 0; //自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _myYaruoModifyingAttackPower = 0; //自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _myYaruoModifyingDeffencePower = 0; //自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _myCharacterModifyingAttackPower = 0; //自分の選んだキャラクターの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _myCharacterModifyingDeffencePower = 0; //自分の選んだキャラクターの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    
    _myGikoAttackPermitted = YES; //自分のギコの攻撃許可
    _myGikoDeffencePermitted = YES; //自分のギコの防御許可
    _myMonarAttackPermitted = YES; //自分のモナーの攻撃許可
    _myMonarDeffencePermitted = YES; //自分のモナーの防御許可
    _mySyobonAttackPermitted = YES; //自分のショボンの攻撃許可
    _mySyobonDeffencePermitted = YES; //自分のショボンの防御許可
    _myYaruoAttackPermitted = NO; //自分のやる夫の攻撃許可
    _myYaruoDeffencePermitted = YES; //自分のやる夫の防御許可
    _myTomb = [[NSMutableArray alloc] init]; //自分の墓地のカードナンバー
    _doIUseCard = NO; //自分がこのターンカードを使用したか
    _myFieldCard = [[NSMutableArray alloc] init]; //自分の場カードのカードナンバー
    _myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:20], [NSNumber numberWithInt:20], [NSNumber numberWithInt:20], [NSNumber numberWithInt:20], [NSNumber numberWithInt:20], [NSNumber numberWithInt:20],nil]; //自分のエネルギーカードの数
    _canIPlaySorceryCard =YES; //自分が魔法カードを手札からプレイできるか
    _canIPlayFieldCard = YES; //自分が場カードを手札からプレイできるか
    _canIActivateFieldCard = YES; //自分が場カードの能力を起動できるか
    _canIPlayEnergyCard = YES; //自分がエネルギーカードを手札からプレイできるか
    _canIActivateEnergyCard = YES; //自分がエネルギーカードを起動できるか
    _denymyCardPlaying = NO; //自分がカードのプレイを打ち消されたか
    _myDamage = 0; //このターン自分に与えられるダメージ
    _mySelectColor = -1; //自分が選んだ色
    
    
    
    //相手に関係する変数
    _enemyLifeGage = 20;
    _enemyDeckCardList = [[NSMutableArray alloc] init]; //相手のデッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
    _enemyHand = [[NSMutableArray alloc] init]; //相手の手札
    _enemyGikoFundamentalAttackPower = 3; // 相手のギコの基本攻撃力
    _enemyGikoFundamentalDeffencePower = 0; //相手のギコの基本防御力
    _enemyMonarFundamentalAttackPower = 3; //相手のモナーの基本攻撃力
    _enemyMonarFundamentalDeffencePower = 0; //相手のモナーの基本防御力
    _enemySyobonFundamentalAttackPower = 3; //相手のショボンの基本攻撃力
    _enemySyobonFundamentalDeffencePower = 0; //相手のショボンの基本防御力
    _enemyYaruoFundamentalAttackPower = 0; //相手のやる夫の基本攻撃力
    _enemyYaruoFundamentalDeffencePower = 3; //相手のやる夫の基本防御力
    _enemySelectCharacter = -1; //相手の選んだキャラクター
    _enemyCharacterFundamentalAttackPower = 0; //相手の選んだキャラクターの基本攻撃力
    _enemyCharacterFundamentalDeffencePower = 0; //相手の選んだキャラクターの基本防御力
    _enemyGikoModifyingAttackPower = 0; // 相手のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyGikoModifyingDeffencePower = 0; //相手のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyMonarModifyingAttackPower = 0; //相手のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyMonarModifyingDeffencePower = 0; //相手のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemySyobonModifyingAttackPower = 0; //相手のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemySyobonModifyingDeffencePower = 0; //相手のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyYaruoModifyingAttackPower = 0; //相手のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyYaruoModifyingDeffencePower = 0; //相手のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyCharacterModifyingAttackPower = 0; //相手の選んだキャラクターの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyCharacterModifyingDeffencePower = 0; //相手の選んだキャラクターの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    
    _enemyGikoAttackPermitted = YES; //相手のギコの攻撃許可
    _enemyGikoDeffencePermitted = YES; //相手のギコの防御許可
    _enemyMonarAttackPermitted = YES; //相手のモナーの攻撃許可
    _enemyMonarDeffencePermitted = YES; //相手のモナーの防御許可
    _enemySyobonAttackPermitted = YES; //相手のショボンの攻撃許可
    _enemySyobonDeffencePermitted = YES; //相手のショボンの防御許可
    _enemyYaruoAttackPermitted = NO; //相手のやる夫の攻撃許可
    _enemyYaruoDeffencePermitted = YES; //相手のやる夫の防御許可
    _enemyTomb = [[NSMutableArray alloc] init]; //相手の墓地のカードナンバー
    _doEnemyUseCard = NO; //相手がこのターンカードを使用したか
    _enemyFieldCard = [[NSMutableArray alloc] init]; //相手の場カードのカードナンバー
    _enemyEnergyCard = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //相手のエネルギーカードの数
    _canEnemyPlaySorceryCard = YES; //相手が魔法カードを手札からプレイできるか
    _canEnemyPlayFieldCard = YES; //相手が場カードを手札からプレイできるか
    _canEnemyActivateFieldCard = YES; //相手が場カードの能力を起動できるか
    _canEnemyPlayEnergyCard = YES; //相手がエネルギーカードを手札からプレイできるか
    _canEnemyActivateEnergyCard = YES; //相手がエネルギーカードを起動できるか
    _denyEnemyCardPlaying = NO; //相手がカードのプレイを打ち消されたか
    _enemyDamage = 0; //このターン相手に与えられるダメージ
    _enemySelectColor = -1; //相手が選んだ色
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSMutableArray *)shuffledArray :(NSMutableArray *)array{
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:[array count]];
    for(id object in array){
        NSUInteger randomNum = arc4random() % ([tmpArray count] + 1);
        [tmpArray insertObject:object atIndex:randomNum];
    }
    return tmpArray;
}

@end
