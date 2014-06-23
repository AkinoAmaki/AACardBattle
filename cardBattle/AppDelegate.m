//
//  AppDelegate.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize damageSourceOfWhite;
@synthesize damageSourceOfBlue;
@synthesize damageSourceOfBlack;
@synthesize damageSourceOfRed;
@synthesize damageSourceOfGreen;
@synthesize cardList_cardName;
@synthesize cardList_pngName;
@synthesize myDeck;
@synthesize myCards;
@synthesize myDeckCardList;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

//    // アプリケーションのバンドル識別子を取得します。
//    NSString* domain = [[NSBundle mainBundle] bundleIdentifier];
//    
//    // バンドル識別子を使って、アプリに関係する設定を一括消去します。
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domain];
    
    
    
    //iPhoneのステータスバーを非表示にする
    [UIApplication sharedApplication].statusBarHidden = YES;
    
#pragma mark- デッキの準備
    ud = [NSUserDefaults standardUserDefaults];
    firstLaunch =  [ud integerForKey:@"firstLaunch_ud"];

    NSLog(@"高さ：%f:幅：%f",[[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width);

    if(firstLaunch == 0){
        //最初のデッキを構築する
        
        NSMutableArray *firstCards = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                             [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              [NSNumber numberWithInt:99],
                                                                              nil];
        NSMutableArray *firstDeck = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             [NSNumber numberWithInt:2],
                                                                             nil];
        
        [ud setObject:firstCards forKey:@"myCards_ud"];
        [ud setObject:firstDeck forKey:@"myDeck_ud"];
        [ud synchronize];
        
        //ユニークなプレイヤーIDを発番する
        //サーバ側で取得したIDを受け取り、playerIDとして保持する
        [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
        NSString *url = @"http://utakatanet.dip.jp:58080/playerID.php";
        NSMutableURLRequest *request;
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
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
        [ud setObject:[NSNumber numberWithInt:[string intValue]] forKey:@"playerID_ud"];
        [ud synchronize];
        
        [SVProgressHUD dismiss];
        
        NSLog(@"初回起動");
    }
    

    _playerID = [ud integerForKey:@"playerID_ud"];
    _myNickName = [ud objectForKey:@"myNickName_ud"];
    NSLog(@"ID:%d",_playerID);
    NSLog(@"ニックネーム:%@",_myNickName);
    
    
    myCards = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myCards_ud"]];
    //MARK: カード効果のデバッグが終わったら元に戻す　_myDeck = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myDeck_ud"]];
    myDeck = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],//10
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0],
                                                     [NSNumber numberWithInt:0], //20
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//30
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//40
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//50
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//60
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:10],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//70
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//80
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//90
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//100
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//110
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//120
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//130
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//140
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],//150
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   [NSNumber numberWithInt:0],
                                                   nil];
    myDeckCardList = [[NSMutableArray alloc] init];

    //デッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
    for (int i = 0; i < [myDeck count]; i++) {
        for (int j = 0; j < [[myDeck objectAtIndex:i] intValue]; j++) {
            [myDeckCardList addObject:[NSNumber numberWithInt:i]];
        }
    }
    myDeckCardList = [AppDelegate shuffledArray:myDeckCardList];


    
#pragma mark- カード関連のデータ（カード名、カードナンバー等）の配列
    
    cardList_cardName = [[NSArray alloc] initWithObjects:@"outicon",@"1",	@"2",	@"3",	@"4",	@"5",	@"6",	@"7",	@"8",	@"9",	@"10",	@"11",	@"12",	@"13",	@"14",	@"15",	@"16",	@"17",	@"18",	@"19",	@"20",	@"21",	@"22",	@"23",	@"24",	@"25",	@"26",	@"27",	@"28",	@"29",	@"30",	@"31",	@"32",	@"33",	@"34",	@"35",	@"36",	@"37",	@"38",	@"39",	@"40",	@"41",	@"42",	@"43",	@"44",	@"45",	@"46",	@"47",	@"48",	@"49",	@"50",	@"51",	@"52",	@"53",	@"54",	@"55",	@"56",	@"57",	@"58",	@"59",	@"60",	@"61",	@"62",	@"63",	@"64",	@"65",	@"66",	@"67",	@"68",	@"69",	@"70",	@"71",	@"72",	@"73",	@"74",	@"75",	@"76",	@"77",	@"78",	@"79",	@"80",	@"81",	@"82",	@"83",	@"84",	@"85",	@"86",	@"87",	@"88",	@"89",	@"90",	@"91",	@"92",	@"93",	@"94",	@"95",	@"96",	@"97",	@"98",	@"99",	@"100",	@"101",	@"102",	@"103",	@"104",	@"105",	@"106",	@"107",	@"108",	@"109",	@"110",	@"111",	@"112",	@"113",	@"114",	@"115",	@"116",	@"117",	@"118",	@"119",	@"120",	@"121",	@"122",	@"123",	@"124",	@"125",	@"126",	@"127",	@"128",	@"129",	@"130",	@"131",	@"132",	@"133",	@"134",	@"135",	@"136",	@"137",	@"138",	@"139",	@"140",	@"141",	@"142",	@"143",	@"144",	@"145",	@"146",	@"147",	@"148",	@"149",	@"150",	@"151",	@"152",	@"153",	@"154",	@"155",	/*@"156",	@"157",	@"158",	@"159",	@"160",	@"161",	@"162",	@"163",	@"164",	@"165",	@"166",	@"167",	@"168",	@"169",	@"170",	@"171",	@"172",	@"173",	@"174",	@"175",	@"176",	@"177",	@"178",	@"179",	@"180",	@"181",	@"182",	@"183",	@"184",	@"185",	@"186",	@"187",	@"188",	@"189",	@"190",	@"191",	@"192",	@"193",	@"194",	@"195",	@"196",	@"197",	@"198",	@"199",	@"200",	@"201",	@"202",	@"203",	@"204",	@"205",*/
 nil];
    cardList_pngName  = [[NSArray alloc] initWithObjects:@"dummy.png",@"card1.png",	@"card2.png",	@"card3.png",	@"card4.png",	@"card5.png",	@"card6.png",	@"card7.png",	@"card8.png",	@"card9.png",	@"card10.png",	@"card11.png",	@"card12.png",	@"card13.png",	@"card14.png",	@"card15.png",	@"card16.png",	@"card17.png",	@"card18.png",	@"card19.png",	@"card20.png",	@"card21.png",	@"card22.png",	@"card23.png",	@"card24.png",	@"card25.png",	@"card26.png",	@"card27.png",	@"card28.png",	@"card29.png",	@"card30.png",	@"card31.png",	@"card32.png",	@"card33.png",	@"card34.png",	@"card35.png",	@"card36.png",	@"card37.png",	@"card38.png",	@"card39.png",	@"card40.png",	@"card41.png",	@"card42.png",	@"card43.png",	@"card44.png",	@"card45.png",	@"card46.png",	@"card47.png",	@"card48.png",	@"card49.png",	@"card50.png",	@"card51.png",	@"card52.png",	@"card53.png",	@"card54.png",	@"card55.png",	@"card56.png",	@"card57.png",	@"card58.png",	@"card59.png",	@"card60.png",	@"card61.png",	@"card62.png",	@"card63.png",	@"card64.png",	@"card65.png",	@"card66.png",	@"card67.png",	@"card68.png",	@"card69.png",	@"card70.png",	@"card71.png",	@"card72.png",	@"card73.png",	@"card74.png",	@"card75.png",	@"card76.png",	@"card77.png",	@"card78.png",	@"card79.png",	@"card80.png",	@"card81.png",	@"card82.png",	@"card83.png",	@"card84.png",	@"card85.png",	@"card86.png",	@"card87.png",	@"card88.png",	@"card89.png",	@"card90.png",	@"card91.png",	@"card92.png",	@"card93.png",	@"card94.png",	@"card95.png",	@"card96.png",	@"card97.png",	@"card98.png",	@"card99.png",	@"card100.png",	@"card101.png",	@"card102.png",	@"card103.png",	@"card104.png",	@"card105.png",	@"card106.png",	@"card107.png",	@"card108.png",	@"card109.png",	@"card110.png",	@"card111.png",	@"card112.png",	@"card113.png",	@"card114.png",	@"card115.png",	@"card116.png",	@"card117.png",	@"card118.png",	@"card119.png",	@"card120.png",	@"card121.png",	@"card122.png",	@"card123.png",	@"card124.png",	@"card125.png",	@"card126.png",	@"card127.png",	@"card128.png",	@"card129.png",	@"card130.png",	@"card131.png",	@"card132.png",	@"card133.png",	@"card134.png",	@"card135.png",	@"card136.png",	@"card137.png",	@"card138.png",	@"card139.png",	@"card140.png",	@"card141.png",	@"card142.png",	@"card143.png",	@"card144.png",	@"card145.png",	@"card146.png",	@"card147.png",	@"card148.png",	@"card149.png",	@"card150.png",	@"card151.png",	@"card152.png",	@"card153.png",	@"card154.png",	@"card155.png",/*	@"card156.png",	@"card157.png",	@"card158.png",	@"card159.png",	@"card160.png",	@"card161.png",	@"card162.png",	@"card163.png",	@"card164.png",	@"card165.png",	@"card166.png",	@"card167.png",	@"card168.png",	@"card169.png",	@"card170.png",	@"card171.png",	@"card172.png",	@"card173.png",	@"card174.png",	@"card175.png",	@"card176.png",	@"card177.png",	@"card178.png",	@"card179.png",	@"card180.png",	@"card181.png",	@"card182.png",	@"card183.png",	@"card184.png",	@"card185.png",	@"card186.png",	@"card187.png",	@"card188.png",	@"card189.png",	@"card190.png",	@"card191.png",	@"card192.png",	@"card193.png",	@"card194.png",	@"card195.png",	@"card196.png",	@"card197.png",	@"card198.png",	@"card199.png",	@"card200.png",	@"card201.png",	@"card202.png",	@"card203.png",	@"card204.png",	@"card205.png",*/
            nil];
    
    
    _cardList_text = [[NSArray alloc] initWithObjects:@"ぬる", @"1番目のカードだよ", @"2番目のカードだよ",	@"3番目のカードだよ", @"4番目のカードだよ", @"5番目のカードだよ", @"6番目のカードだよ", @"7番目のカードだよ", @"8番目のカードだよ", @"9番目のカードだよ", @"10番目のカードだよ", @"11番目のカードだよ", @"12番目のカードだよ", @"13番目のカードだよ", @"14番目のカードだよ", @"15番目のカードだよ", @"16番目のカードだよ", @"17番目のカードだよ", @"18番目のカードだよ", @"19番目のカードだよ", @"20番目のカードだよ",@"21番目のカードだよ", 	@"22番目のカードだよ", 	@"23番目のカードだよ", 	@"24番目のカードだよ", 	@"25番目のカードだよ", 	@"26番目のカードだよ", 	@"27番目のカードだよ", 	@"28番目のカードだよ", 	@"29番目のカードだよ", 	@"30番目のカードだよ", 	@"31番目のカードだよ", 	@"32番目のカードだよ", 	@"33番目のカードだよ", 	@"34番目のカードだよ", 	@"35番目のカードだよ", 	@"36番目のカードだよ", 	@"37番目のカードだよ", 	@"38番目のカードだよ", 	@"39番目のカードだよ", 	@"40番目のカードだよ", 	@"41番目のカードだよ", 	@"42番目のカードだよ", 	@"43番目のカードだよ", 	@"44番目のカードだよ", 	@"45番目のカードだよ", 	@"46番目のカードだよ", 	@"47番目のカードだよ", 	@"48番目のカードだよ", 	@"49番目のカードだよ", 	@"50番目のカードだよ", 	@"51番目のカードだよ", 	@"52番目のカードだよ", 	@"53番目のカードだよ", 	@"54番目のカードだよ", 	@"55番目のカードだよ", 	@"56番目のカードだよ", 	@"57番目のカードだよ", 	@"58番目のカードだよ", 	@"59番目のカードだよ", 	@"60番目のカードだよ", 	@"61番目のカードだよ", 	@"62番目のカードだよ", 	@"63番目のカードだよ", 	@"64番目のカードだよ", 	@"65番目のカードだよ", 	@"66番目のカードだよ", 	@"67番目のカードだよ", 	@"68番目のカードだよ", 	@"69番目のカードだよ", 	@"70番目のカードだよ", 	@"71番目のカードだよ", 	@"72番目のカードだよ", 	@"73番目のカードだよ", 	@"74番目のカードだよ", 	@"75番目のカードだよ", 	@"76番目のカードだよ", 	@"77番目のカードだよ", 	@"78番目のカードだよ", 	@"79番目のカードだよ", 	@"80番目のカードだよ", 	@"81番目のカードだよ", 	@"82番目のカードだよ", 	@"83番目のカードだよ", 	@"84番目のカードだよ", 	@"85番目のカードだよ", 	@"86番目のカードだよ", 	@"87番目のカードだよ", 	@"88番目のカードだよ", 	@"89番目のカードだよ", 	@"90番目のカードだよ", 	@"91番目のカードだよ", 	@"92番目のカードだよ", 	@"93番目のカードだよ", 	@"94番目のカードだよ", 	@"95番目のカードだよ", 	@"96番目のカードだよ", 	@"97番目のカードだよ", 	@"98番目のカードだよ", 	@"99番目のカードだよ", 	@"100番目のカードだよ", 	@"101番目のカードだよ", 	@"102番目のカードだよ", 	@"103番目のカードだよ", 	@"104番目のカードだよ", 	@"105番目のカードだよ", 	@"106番目のカードだよ", 	@"107番目のカードだよ", 	@"108番目のカードだよ", 	@"109番目のカードだよ", 	@"110番目のカードだよ", 	@"111番目のカードだよ", 	@"112番目のカードだよ", 	@"113番目のカードだよ", 	@"114番目のカードだよ", 	@"115番目のカードだよ", 	@"116番目のカードだよ", 	@"117番目のカードだよ", 	@"118番目のカードだよ", 	@"119番目のカードだよ", 	@"120番目のカードだよ", 	@"121番目のカードだよ", 	@"122番目のカードだよ", 	@"123番目のカードだよ", 	@"124番目のカードだよ", 	@"125番目のカードだよ", 	@"126番目のカードだよ", 	@"127番目のカードだよ", 	@"128番目のカードだよ", 	@"129番目のカードだよ", 	@"130番目のカードだよ", 	@"131番目のカードだよ", 	@"132番目のカードだよ", 	@"133番目のカードだよ", 	@"134番目のカードだよ", 	@"135番目のカードだよ", 	@"136番目のカードだよ", 	@"137番目のカードだよ", 	@"138番目のカードだよ", 	@"139番目のカードだよ", 	@"140番目のカードだよ", 	@"141番目のカードだよ", 	@"142番目のカードだよ", 	@"143番目のカードだよ", 	@"144番目のカードだよ", 	@"145番目のカードだよ", 	@"146番目のカードだよ", 	@"147番目のカードだよ", 	@"148番目のカードだよ", 	@"149番目のカードだよ", 	@"150番目のカードだよ", 	@"151番目のカードだよ", 	@"152番目のカードだよ", 	@"153番目のカードだよ", 	@"154番目のカードだよ", 	@"155番目のカードだよ",
nil];
    
    NSNumber *energy  = [NSNumber numberWithInt:ENERGYCARD];
    NSNumber *field  = [NSNumber numberWithInt:FIELDCARD];
    NSNumber *sorcery = [NSNumber numberWithInt:SORCERYCARD];
    
    
    _cardList_type = [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:0], energy, energy, energy, energy, energy, sorcery, field,sorcery,sorcery,field,field,field,field,field,field,field,field,field,field,field,sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	field, 	field, 	field, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	field, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	field, 	field, 	sorcery, 	sorcery, 	field, 	field, 	field, 	field, 	field, 	sorcery, 	sorcery, 	sorcery, 	sorcery, 	sorcery,
 nil];
    _cardList_cost = [[NSArray alloc] initWithObjects: @"null", @"0", @"0", @"0", @"0", @"0",@"W", @"W2", @"W", @"W2", @"W2", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W1", @"W", 	@"W", 	@"W", 	@"W2", 	@"WW3", 	@"WW2", 	@"W5", 	@"W4", 	@"W", 	@"W1", 	@"W2", 	@"W", 	@"W1", 	@"WW5", 	@"W", 	@"U1", 	@"UU1", 	@"UU2", 	@"U", 	@"U", 	@"U", 	@"U", 	@"U", 	@"U1", 	@"UU", 	@"UU3", 	@"UU2", 	@"UU2", 	@"U3", 	@"U", 	@"U2", 	@"U2", 	@"U2", 	@"U2", 	@"U4", 	@"U2", 	@"U1", 	@"U2", 	@"U3", 	@"U3", 	@"U5", 	@"U2", 	@"UU", 	@"UU3", 	@"U1", 	@"R", 	@"R2", 	@"RR2", 	@"R4", 	@"R", 	@"R1", 	@"R2", 	@"R", 	@"RR", 	@"R1", 	@"R3", 	@"RR", 	@"RR", 	@"RR", 	@"RR", 	@"R1", 	@"RR", 	@"RR", 	@"R4", 	@"R1", 	@"RRR4", 	@"R1", 	@"R1", 	@"R1", 	@"R1", 	@"R1", 	@"R2", 	@"R", 	@"R2", 	@"RR3", 	@"B", 	@"B1", 	@"B2", 	@"B", 	@"BB", 	@"BB3", 	@"B1", 	@"B1", 	@"BB", 	@"BB2", 	@"B1", 	@"B1", 	@"B1", 	@"BB1", 	@"B2", 	@"BB2", 	@"BB4", 	@"B1", 	@"BB2", 	@"BB2", 	@"BBB5", 	@"B", 	@"B1", 	@"BB2", 	@"B1", 	@"B", 	@"BB3", 	@"B1", 	@"B1", 	@"BB3", 	@"G", 	@"G3", 	@"G", 	@"G2", 	@"G1", 	@"G2", 	@"G", 	@"G2", 	@"G3", 	@"G1", 	@"G4", 	@"G1", 	@"GG2", 	@"G", 	@"G1", 	@"G2", 	@"G1", 	@"G2", 	@"G1", 	@"G1", 	@"G", 	@"GG1", 	@"G", 	@"G2", 	@"G2", 	@"G1", 	@"G1", 	@"G1", 	@"GG2", 	@"GGG3",
 nil];
    _cardList_color = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],
        [NSNumber numberWithInt:0], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE],
        [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE],
        [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED],
        [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK],
        [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], nil];
    
    damageSourceOfWhite = [[NSArray alloc] initWithObjects:nil];
    damageSourceOfBlue  = [[NSArray alloc] initWithObjects:nil];
    damageSourceOfRed = [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:70], [NSNumber numberWithInt:71], [NSNumber numberWithInt:73], [NSNumber numberWithInt:74], [NSNumber numberWithInt:77], [NSNumber numberWithInt:78], [NSNumber numberWithInt:79], [NSNumber numberWithInt:80], [NSNumber numberWithInt:82], [NSNumber numberWithInt:83], [NSNumber numberWithInt:84], [NSNumber numberWithInt:85], [NSNumber numberWithInt:88], [NSNumber numberWithInt:89], [NSNumber numberWithInt:90], [NSNumber numberWithInt:91], [NSNumber numberWithInt:92], [NSNumber numberWithInt:93],  nil];
    damageSourceOfBlack   = [[NSArray alloc] initWithObjects: nil];
    damageSourceOfGreen = [[NSArray alloc] initWithObjects: nil];
    
    _sorceryCardList = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:6],	[NSNumber numberWithInt:8],	[NSNumber numberWithInt:9],	[NSNumber numberWithInt:21],	[NSNumber numberWithInt:22],	[NSNumber numberWithInt:23],	[NSNumber numberWithInt:24],	[NSNumber numberWithInt:26],	[NSNumber numberWithInt:28],	[NSNumber numberWithInt:29],	[NSNumber numberWithInt:30],	[NSNumber numberWithInt:31],	[NSNumber numberWithInt:32],	[NSNumber numberWithInt:33],	[NSNumber numberWithInt:34],	[NSNumber numberWithInt:35],	[NSNumber numberWithInt:36],	[NSNumber numberWithInt:37],	[NSNumber numberWithInt:38],	[NSNumber numberWithInt:39],	[NSNumber numberWithInt:40],	[NSNumber numberWithInt:41],	[NSNumber numberWithInt:42],	[NSNumber numberWithInt:43],	[NSNumber numberWithInt:44],	[NSNumber numberWithInt:45],	[NSNumber numberWithInt:46],	[NSNumber numberWithInt:47],	[NSNumber numberWithInt:48],	[NSNumber numberWithInt:49],	[NSNumber numberWithInt:50],	[NSNumber numberWithInt:51],	[NSNumber numberWithInt:52],	[NSNumber numberWithInt:53],	[NSNumber numberWithInt:54],	[NSNumber numberWithInt:55],	[NSNumber numberWithInt:56],	[NSNumber numberWithInt:58],	[NSNumber numberWithInt:59],	[NSNumber numberWithInt:60],	[NSNumber numberWithInt:61],	[NSNumber numberWithInt:62],	[NSNumber numberWithInt:65],	[NSNumber numberWithInt:66],	[NSNumber numberWithInt:67],	[NSNumber numberWithInt:68],	[NSNumber numberWithInt:69],	[NSNumber numberWithInt:70],	[NSNumber numberWithInt:71],	[NSNumber numberWithInt:73],	[NSNumber numberWithInt:74],	[NSNumber numberWithInt:75],	[NSNumber numberWithInt:76],	[NSNumber numberWithInt:77],	[NSNumber numberWithInt:78],	[NSNumber numberWithInt:79],	[NSNumber numberWithInt:80],	[NSNumber numberWithInt:81],	[NSNumber numberWithInt:82],	[NSNumber numberWithInt:83],	[NSNumber numberWithInt:84],	[NSNumber numberWithInt:85],	[NSNumber numberWithInt:86],	[NSNumber numberWithInt:87],	[NSNumber numberWithInt:93],	[NSNumber numberWithInt:94],	[NSNumber numberWithInt:95],	[NSNumber numberWithInt:96],	[NSNumber numberWithInt:97],	[NSNumber numberWithInt:98],	[NSNumber numberWithInt:99],	[NSNumber numberWithInt:100],	[NSNumber numberWithInt:101],	[NSNumber numberWithInt:102],	[NSNumber numberWithInt:103],	[NSNumber numberWithInt:104],	[NSNumber numberWithInt:106],	[NSNumber numberWithInt:107],	[NSNumber numberWithInt:108],	[NSNumber numberWithInt:110],	[NSNumber numberWithInt:113],	[NSNumber numberWithInt:114],	[NSNumber numberWithInt:115],	[NSNumber numberWithInt:116],	[NSNumber numberWithInt:117],	[NSNumber numberWithInt:118],	[NSNumber numberWithInt:119],	[NSNumber numberWithInt:120],	[NSNumber numberWithInt:121],	[NSNumber numberWithInt:122],	[NSNumber numberWithInt:123],	[NSNumber numberWithInt:124],	[NSNumber numberWithInt:126],	[NSNumber numberWithInt:127],	[NSNumber numberWithInt:128],	[NSNumber numberWithInt:129],	[NSNumber numberWithInt:130],	[NSNumber numberWithInt:132],	[NSNumber numberWithInt:133],	[NSNumber numberWithInt:134],	[NSNumber numberWithInt:135],	[NSNumber numberWithInt:136],	[NSNumber numberWithInt:137],	[NSNumber numberWithInt:138],	[NSNumber numberWithInt:139],	[NSNumber numberWithInt:140],	[NSNumber numberWithInt:141],	[NSNumber numberWithInt:144],	[NSNumber numberWithInt:145],	[NSNumber numberWithInt:151],	[NSNumber numberWithInt:152],	[NSNumber numberWithInt:153],	[NSNumber numberWithInt:154],	[NSNumber numberWithInt:155], nil];
    _fieldCardList_turnStart = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:142], nil];
    _fieldCardList_afterCardUsed = [[NSArray alloc] initWithObjects: nil];
    _fieldCardList_damageCaliculate = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:7],[NSNumber numberWithInt:16],[NSNumber numberWithInt:17],[NSNumber numberWithInt:18],[NSNumber numberWithInt:19],[NSNumber numberWithInt:20],[NSNumber numberWithInt:25],[NSNumber numberWithInt:57],[NSNumber numberWithInt:63],[NSNumber numberWithInt:64],[NSNumber numberWithInt:72],[NSNumber numberWithInt:88],[NSNumber numberWithInt:89],[NSNumber numberWithInt:90],[NSNumber numberWithInt:91],[NSNumber numberWithInt:92],[NSNumber numberWithInt:105],[NSNumber numberWithInt:112],[NSNumber numberWithInt:125],[NSNumber numberWithInt:131],[NSNumber numberWithInt:136],[NSNumber numberWithInt:143],[NSNumber numberWithInt:146],[NSNumber numberWithInt:148],[NSNumber numberWithInt:149],[NSNumber numberWithInt:150], nil];
    _fieldCardList_turnEnd = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:11],[NSNumber numberWithInt:12],[NSNumber numberWithInt:13],[NSNumber numberWithInt:14],[NSNumber numberWithInt:15],[NSNumber numberWithInt:109],[NSNumber numberWithInt:111],[NSNumber numberWithInt:147], nil];
    _fieldCardList_other = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:27], nil];
    _decideAction = NO;
    
#pragma mark- 対戦に関連する各種数値の初期化

    _myHand = [[NSMutableArray alloc] init]; //自分の手札
    _myTomb = [[NSMutableArray alloc] init]; //自分の墓地のカードナンバー
    _myFieldCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],nil]; //自分の場カードのカードナンバー
    _myEnergyCard = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:20], [NSNumber numberWithInt:20], [NSNumber numberWithInt:20], [NSNumber numberWithInt:20], [NSNumber numberWithInt:20],nil]; //自分のエネルギーカードの数
    _myDeckCardListByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyDeckCardList（差分のみ管理）
    _myHandByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyHand（差分のみ管理）
    _myTombByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyTomb（差分のみ管理）
    _myFieldCardByMyself_plus = [[NSMutableArray alloc] init]; // 自分が操作し、増加したmyFieldCard（差分のみ管理）
    _myEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // 自分が操作し、増加したmyEnergyCard（差分のみ管理）
    _myDeckCardListByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyDeckCardList（差分のみ管理）
    _myHandByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyHand（差分のみ管理）
    _myTombByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyTomb（差分のみ管理）
    _myFieldCardByMyself_minus = [[NSMutableArray alloc] init]; // 自分が操作し、減少したmyFieldCard（差分のみ管理）
    _myEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // 自分が操作し、減少したmyEnergyCard（差分のみ管理）
    _myDeckCardListFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyDeckCardList（差分のみ管理）
    _myHandFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyHand（差分のみ管理）
    _myTombFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyTomb（差分のみ管理）
    _myFieldCardFromEnemy_plus = [[NSMutableArray alloc] init]; //相手が操作し、増加したmyFieldCard（差分のみ管理）
    _myEnergyCardFromEnemy_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //相手が操作し、増加したmyEnergyCard（差分のみ管理）
    _myDeckCardListFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyDeckCardList（差分のみ管理）
    _myHandFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyHand（差分のみ管理）
    _myTombFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyTomb（差分のみ管理）
    _myFieldCardFromEnemy_minus = [[NSMutableArray alloc] init]; //相手が操作し、減少したmyFieldCard（差分のみ管理）
    _myEnergyCardFromEnemy_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //相手が操作し、減少したmyEnergyCard（差分のみ管理）
    _myLifeGage = 20;
    _myLifeGageByMyself = 0; //自分のライフポイントを自分で操作する場合の値(差分のみ管理)
    _myAdditionalGettingCards = 0;//ターンの開始時に引くカード以外で引いた、ターン毎のカードの枚数を管理する
    _myAdditionalDiscardingCards = 0;//ターンの終了時に捨てるカード以外で捨てた、ターン毎のカードの枚数を管理する
    _myGikoFundamentalAttackPower = 3; //自分のギコの基本攻撃力
    _myGikoFundamentalDeffencePower = 0; //自分のギコの基本防御力
    _myMonarFundamentalAttackPower = 3; //自分のモナーの基本攻撃力
    _myMonarFundamentalDeffencePower = 0; //自分のモナーの基本防御力
    _mySyobonFundamentalAttackPower = 3; //自分のショボンの基本攻撃力
    _mySyobonFundamentalDeffencePower = 0; //自分のショボンの基本防御力
    _myYaruoFundamentalAttackPower = 0; //自分のやる夫の基本攻撃力
    _myYaruoFundamentalDeffencePower = 3; //自分のやる夫の基本防御力
    _myGikoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のギコの基本攻撃力（差分のみ管理）
    _myGikoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のギコの基本防御力（差分のみ管理）
    _myMonarFundamentalAttackPowerByMyself = 0; //自分が操作した自分のモナーの基本攻撃力（差分のみ管理）
    _myMonarFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のモナーの基本防御力（差分のみ管理）
    _mySyobonFundamentalAttackPowerByMyself = 0; //自分が操作した自分のショボンの基本攻撃力（差分のみ管理）
    _mySyobonFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のショボンの基本防御力（差分のみ管理）
    _myYaruoFundamentalAttackPowerByMyself = 0; //自分が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    _myYaruoFundamentalDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の基本防御力（差分のみ管理）
    _myGikoFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のギコの基本攻撃力（差分のみ管理）
    _myGikoFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のギコの基本防御力（差分のみ管理）
    _myMonarFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のモナーの基本攻撃力（差分のみ管理）
    _myMonarFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のモナーの基本防御力（差分のみ管理）
    _mySyobonFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のショボンの基本攻撃力（差分のみ管理）
    _mySyobonFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のショボンの基本防御力（差分のみ管理）
    _myYaruoFundamentalAttackPowerFromEnemy = 0; //相手が操作した自分のやる夫の基本攻撃力（差分のみ管理）
    _myYaruoFundamentalDeffencePowerFromEnemy = 0; //相手が操作した自分のやる夫の基本防御力（差分のみ管理）
    _mySelectCharacter = -1; //自分の選んだキャラクター
    _mySelectCharacterFromEnemy = -1; 
    _myGikoModifyingAttackPower = 0; //自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _myGikoModifyingDeffencePower = 0; //自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _myMonarModifyingAttackPower = 0; //自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _myMonarModifyingDeffencePower = 0; //自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _mySyobonModifyingAttackPower = 0; //自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _mySyobonModifyingDeffencePower = 0; //自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _myYaruoModifyingAttackPower = 0; //自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _myYaruoModifyingDeffencePower = 0; //自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _myGikoModifyingAttackPowerByMyself = 0; //自分が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myGikoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myMonarModifyingAttackPowerByMyself = 0; //自分が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myMonarModifyingDeffencePowerByMyself = 0; //自分が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _mySyobonModifyingAttackPowerByMyself = 0; //自分が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _mySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myYaruoModifyingAttackPowerByMyself = 0; //自分が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myGikoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myGikoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myMonarModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myMonarModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _mySyobonModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _mySyobonModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myYaruoModifyingAttackPowerFromEnemy = 0; //相手が操作した自分のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myYaruoModifyingDeffencePowerFromEnemy = 0; //相手が操作した自分のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)（差分のみ管理）
    _myGikoAttackPermittedByMyself = YES; //自分のギコの攻撃許可
    _myGikoDeffencePermittedByMyself = YES; //自分のギコの防御許可
    _myMonarAttackPermittedByMyself = YES; //自分のモナーの攻撃許可
    _myMonarDeffencePermittedByMyself = YES; //自分のモナーの防御許可
    _mySyobonAttackPermittedByMyself = YES; //自分のショボンの攻撃許可
    _mySyobonDeffencePermittedByMyself = YES; //自分のショボンの防御許可
    _myYaruoAttackPermittedByMyself = YES; //自分のやる夫の攻撃許可
    _myYaruoDeffencePermittedByMyself = YES; //自分のやる夫の防御許可
    _myGikoAttackPermittedFromEnemy = YES; //相手の妨害による自分のギコの攻撃許可
    _myGikoDeffencePermittedFromEnemy = YES; //相手の制限による自分のギコの防御許可
    _myMonarAttackPermittedFromEnemy = YES; //相手の制限による自分のモナーの攻撃許可
    _myMonarDeffencePermittedFromEnemy = YES; //相手の制限による自分のモナーの防御許可
    _mySyobonAttackPermittedFromEnemy = YES; //相手の制限による自分のショボンの攻撃許可
    _mySyobonDeffencePermittedFromEnemy = YES; //相手の制限による自分のショボンの防御許可
    _myYaruoAttackPermittedFromEnemy = YES; //相手の制限による自分のやる夫の攻撃許可
    _myYaruoDeffencePermittedFromEnemy = YES; //相手の制限による自分のやる夫の防御許可
    _doIUseCard = NO; //自分がこのターンカードを使用したか
    _myDamageFromAA = 0;
    _myDamageFromCard = 0;
    _mySelectColor = -1; //自分が選んだ色
    _cardsIUsedInThisTurn = [[NSMutableArray alloc] init];
    
    
    
    //相手に関係する変数
    _enemyLifeGage = 20;
    _enemyDeckCardList = [[NSMutableArray alloc] init]; //相手のデッキについて、カード一枚一枚をばらしてひとつずつ配列(_myDeckCardList)に収めたあと、カード順をランダムに入れ替える
    _enemyHand = [[NSMutableArray alloc] init]; //相手の手札
    _enemyDeckCardListByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyDeckCardList（差分のみ管理）
    _enemyHandByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyHand（差分のみ管理）
    _enemyTombByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyTomb（差分のみ管理）
    _enemyFieldCardByMyself_plus = [[NSMutableArray alloc] init]; //自分が操作し、増加したenemyFieldCard（差分のみ管理）
    _enemyEnergyCardByMyself_plus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //自分が操作し、増加したenemyEnergyCard（差分のみ管理）
    _enemyDeckCardListByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyDeckCardList（差分のみ管理）
    _enemyHandByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyHand（差分のみ管理）
    _enemyTombByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyTomb（差分のみ管理）
    _enemyFieldCardByMyself_minus = [[NSMutableArray alloc] init]; //自分が操作し、減少したenemyFieldCard（差分のみ管理）
    _enemyEnergyCardByMyself_minus = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]; //自分が操作し、減少したenemyEnergyCard（差分のみ管理）
    _enemyGikoFundamentalAttackPower = 3; // 相手のギコの基本攻撃力
    _enemyGikoFundamentalDeffencePower = 0; //相手のギコの基本防御力
    _enemyMonarFundamentalAttackPower = 3; //相手のモナーの基本攻撃力
    _enemyMonarFundamentalDeffencePower = 0; //相手のモナーの基本防御力
    _enemySyobonFundamentalAttackPower = 3; //相手のショボンの基本攻撃力
    _enemySyobonFundamentalDeffencePower = 0; //相手のショボンの基本防御力
    _enemyYaruoFundamentalAttackPower = 0; //相手のやる夫の基本攻撃力
    _enemyYaruoFundamentalDeffencePower = 3; //相手のやる夫の基本防御力
    _enemyGikoFundamentalAttackPowerByMyself = 0; // 自分が操作した相手のギコの基本攻撃力（差分のみ管理）
    _enemyGikoFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のギコの基本防御力（差分のみ管理）
    _enemyMonarFundamentalAttackPowerByMyself = 0; //自分が操作した相手のモナーの基本攻撃力（差分のみ管理）
    _enemyMonarFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のモナーの基本防御力（差分のみ管理）
    _enemySyobonFundamentalAttackPowerByMyself = 0; //自分が操作した相手のショボンの基本攻撃力（差分のみ管理）
    _enemySyobonFundamentalDeffencePowerByMyself = 0; //相自分が操作した手のショボンの基本防御力（差分のみ管理）
    _enemyYaruoFundamentalAttackPowerByMyself = 0; //自分が操作した相手のやる夫の基本攻撃力（差分のみ管理）
    _enemyYaruoFundamentalDeffencePowerByMyself = 0; //自分が操作した相手のやる夫の基本防御力（差分のみ管理）
    _enemySelectCharacter = -1; //相手の選んだキャラクター
    _enemySelectCharacterByMyself = -1;
    _enemyGikoModifyingAttackPower = 0; // 相手のギコの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyGikoModifyingDeffencePower = 0; //相手のギコの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyMonarModifyingAttackPower = 0; //相手のモナーの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyMonarModifyingDeffencePower = 0; //相手のモナーの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemySyobonModifyingAttackPower = 0; //相手のショボンの修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemySyobonModifyingDeffencePower = 0; //相手のショボンの修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyYaruoModifyingAttackPower = 0; //相手のやる夫の修正攻撃力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyYaruoModifyingDeffencePower = 0; //相手のやる夫の修正防御力(1ターンだけ効果が及ぶカード効果を管理する)
    _enemyGikoModifyingAttackPowerByMyself = 0; // 自分が操作した相手のギコの修正攻撃力（差分のみ管理）
    _enemyGikoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のギコの修正防御力（差分のみ管理）
    _enemyMonarModifyingAttackPowerByMyself = 0; //自分が操作した相手のモナーの修正攻撃力（差分のみ管理）
    _enemyMonarModifyingDeffencePowerByMyself = 0; //自分が操作した相手のモナーの修正防御力（差分のみ管理）
    _enemySyobonModifyingAttackPowerByMyself = 0; //自分が操作した相手のショボンの修正攻撃力（差分のみ管理）
    _enemySyobonModifyingDeffencePowerByMyself = 0; //自分が操作した相手のショボンの修正防御力（差分のみ管理）
    _enemyYaruoModifyingAttackPowerByMyself = 0; //自分が操作した相手のやる夫の修正攻撃力（差分のみ管理）
    _enemyYaruoModifyingDeffencePowerByMyself = 0; //自分が操作した相手のやる夫の修正防御力（差分のみ管理）
    
    _enemyGikoAttackPermittedByMyself = YES; //相手のギコの攻撃許可
    _enemyGikoDeffencePermittedByMyself = YES; //相手のギコの防御許可
    _enemyMonarAttackPermittedByMyself = YES; //相手のモナーの攻撃許可
    _enemyMonarDeffencePermittedByMyself = YES; //相手のモナーの防御許可
    _enemySyobonAttackPermittedByMyself = YES; //相手のショボンの攻撃許可
    _enemySyobonDeffencePermittedByMyself = YES; //相手のショボンの防御許可
    _enemyYaruoAttackPermittedByMyself = YES; //相手のやる夫の攻撃許可
    _enemyYaruoDeffencePermittedByMyself = YES; //相手のやる夫の防御許可
    _enemyGikoAttackPermittedFromEnemy = YES; //相手の制限による相手のギコの攻撃許可
    _enemyGikoDeffencePermittedFromEnemy = YES; //相手の制限による相手のギコの防御許可
    _enemyMonarAttackPermittedFromEnemy = YES; //相手の制限による相手のモナーの攻撃許可
    _enemyMonarDeffencePermittedFromEnemy = YES; //相手の制限による相手のモナーの防御許可
    _enemySyobonAttackPermittedFromEnemy = YES; //相手の制限による相手のショボンの攻撃許可
    _enemySyobonDeffencePermittedFromEnemy = YES; //相手の制限による相手のショボンの防御許可
    _enemyYaruoAttackPermittedFromEnemy = YES; //相手の制限による相手のやる夫の攻撃許可
    _enemyYaruoDeffencePermittedFromEnemy = YES; //相手の制限による手のやる夫の防御許可
    _enemyTomb = [[NSMutableArray alloc] init]; //相手の墓地のカードナンバー
    _doEnemyUseCard = NO; //相手がこのターンカードを使用したか
    _enemyFieldCard = [[NSMutableArray alloc] init]; //相手の場カードのカードナンバー
    _enemyEnergyCard = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; //相手のエネルギーカードの数
    _canEnemyPlaySorceryCardByMyself = YES; //相手が魔法カードを手札からプレイできるか
    _canEnemyPlayFieldCardByMyself = YES; //相手が場カードを手札からプレイできるか
    _canEnemyActivateFieldCardByMyself = YES; //相手が場カードの能力を起動できるか
    _canEnemyPlayEnergyCardByMyself = YES; //相手がエネルギーカードを手札からプレイできるか
    _canEnemyActivateEnergyCardByMyself = YES; //相手がエネルギーカードを起動できるか
    _canEnemyPlaySorceryCardFromEnemy = YES; //相手の制限により相手が魔法カードを手札からプレイできるか
    _canEnemyPlayFieldCardFromEnemy = YES; //相手の制限により相手が場カードを手札からプレイできるか
    _canEnemyActivateFieldCardFromEnemy = YES; //相手の制限により相手が場カードの能力を起動できるか
    _canEnemyPlayEnergyCardFromEnemy = YES; //相手の制限により相手がエネルギーカードを手札からプレイできるか
    _canEnemyActivateEnergyCardFromEnemy = YES; //相手の制限により相手がエネルギーカードを起動できるか
    _denyEnemyCardPlaying = NO; //相手がカードのプレイを打ち消されたか
    _enemyDamageFromAA = 0;
    _enemyDamageFromCard = 0;
    _enemySelectColor = -1; //相手が選んだ色
    _cardsEnemyUsedInThisTurn = [[NSMutableArray alloc] init];
    
    
    // 一括でテキストビューのフォントをArialのサイズ12.0fに統一する
    [[UITextView appearance] setFont:[UIFont fontWithName:@"Arial" size:12]];
    
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

+ (NSMutableArray *)shuffledArray :(NSMutableArray *)array{
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:[array count]];
    for(id object in array){
        NSUInteger randomNum = arc4random() % ([tmpArray count] + 1);
        [tmpArray insertObject:object atIndex:randomNum];
    }
    return tmpArray;
}





@end
