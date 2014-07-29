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
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                             [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
                                                                              [NSNumber numberWithInt:20],
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
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
                                                                             [NSNumber numberWithInt:0],
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


    
#pragma mark- カード関連のデータ（カード名、カードナンバー等）の配列
    
    cardList_cardName = [[NSArray alloc] initWithObjects:@"outicon",@"1",	@"2",	@"3",	@"4",	@"5",	@"おれの名はテレホマン",	@"イヤッッホォォォオオォオウ！",	@"オプーナ",	@"オプーナを買う権利をやる",	@"僕は、神山満月ちゃん！",	@"御社の株の空売りです",	@"志望者がいなさそうな会社の面接に顔出ししてます。",	@"自宅に住み込み、警備をする仕事です",	@"特に退社時間に関しては厳格に守るつもりです",	@"日本語は一通りはなせます",	@"「人事を潰して天命を待つ」です",	@"「特技など」？じゃあ特技じゃなくていいんですね。",	@"2ｃｈのブラック偏差値７5はどんな会社か見に来ました！",	@"キーボードです",	@"ここ何て会社？",	@"だが、断る。",	@"ちょうしょ、たんしょ 。ハイ、言いました。",	@"パンフレットに「一部上場」と書いてありますが、全部上場するのはいつ頃でしょうか？",	@"安価なんて言えないな・・",	@"おっと、それ以上は言うなよ…",	@"ＡＡがズレてるだけなんだお",	@"うそです",	@"うるせぇ、エビフライぶつけんぞ",	@"落ち込み",	@"通報しますた！",	@"こいよオラ！！オラ！！",	@"パンチ",	@"トンファーキ～ック！",	@"というお話だったのサ",	@"ガラッ(オプーナ)",	@"圧縮",	@"解凍",	@"荒巻スカルチノフ",	@"やるじゃん",	@"ま～た始まった",	@"キュッキュッ",	@"トン",	@"は？",	@"いやどす",	@"エラー",	@"深刻なエラー",	@"草刈り",	@"お断りします",	@"もうどうにでもな～れ",	@"うわああぁぁあ",	@"シャキーン侍",	@"ズコー",	@"ぼこぼこにしてやんよ",	@"ダンス",	@"はいはいわろすわろす",	@"チャーハン作るよ！！",	@"キャーコワーイ",	@"【審議中】",	@"NO THANK YOU",	@"ダディクール",	@"タンヤオ",	@"決闘を申し込む！",	@"お薬増やしておきますねー",	@"ブーン",	@"ぃょぅ",	@"わたしです",	@"シラネーヨ",	@"流石だよな俺ら",	@"すいません、ちょっと通りますよ",	@"ヘディング脳、おーにぃっぽー、サッカー日本代表",	@"集団、おーにぃっぽー、サッカー日本代表応援",	@"おーにぃっぽー、サッカー日本代表",	@"なんというURL、クリックした瞬間ブラクラだと気づいてしまった、このPCは間違いなく再起動",	@"なんというZIP、ファイル名を見ただけでワクワクしてしまった、このファイルは間違いなくexe",	@"アッー！",	@"さいたま",	@"キター！(ジャンプ)",	@"キター！(回転)",	@"キター！(叫び)",	@"キター！(集団)",	@"キター！(走)",	@"コネー！(立体・大)",	@"コネー！(泣)",	@"やめてください　しんでしまいます",	@"モウコネエヨ、ウワァァン",	@"いいぜてめえが何でも思い通りに出来るってならまずはそのふざけた幻想をぶち壊す ",	@"インターネットのしくみ",	@"ブームくん",	@"ふーん",	@"ヤダヤダ！",	@"わりとどうでもいい",	@"パーン",	@"オワタ、コナン全巻、練炭くださーい",	@"メシウマ状態！",	@"にっぽん！にっぽん！",	@"次でボケて！！！",	@"それは気になる…",	@"もう寝る！",	@"きたか…！",	@"ゴルァ！",	@"そんなバナナ",	@"グンク・ツノ・オトガー",	@"イ・ミフ",	@"嫌なら見るな！嫌なら見るな！",	@"ムチャシヤガッテ…",	@"カチャ、ターン",	@"W・バーロー",	@"エーカゲン2世",	@"ヴァーボーン・ハウス",	@"クタバ・レカス",	@"クソスレータ・テルナー",	@"今だ！2ゲットォー!",	@"ケン＝サクシル",	@"ググレカス",	@"ポーン",	@"スポポポポポポーン！！！",	@"グロ中尉",	@"コ・チミルナ",	@"クワシク",	@"コーレハヒ・ドイク=ソスレ",	@"イマキ・タ・サンゲウ",	@"エイガーカ・ケッティ",	@"ヌルポガ",	@"いいか、みんな 小五とロリでは単なる犯罪だが二つ合わされば悟りとなる",	@"シネカス",	@"もうおこったぞう",	@"一羽でチュン 二羽でもチュン 三羽そろえば牙をむく",	@"チラッ",	@"ひよこ",	@"クマー！",	@"争いは同じレベルの者同士でしか発生しない！",	@"なにマジになってんの？この鮭の切り身やるから帰れよ",	@"釣り",	@"そんな餌に俺様が釣られクマー",	@"お前それﾌﾟﾚﾊﾟﾗｰﾄでも同じ事言えんの？",	@"お前それサバンナでも同じ事言えんの？",	@"こいつ最高にアホ",	@"知ってるがお前の熊度が気にクマない",	@"先生助けてっ！さっきまで元気だった荒巻が息をしてないの！！",	@"お前を消す方法",	@"でっていうWWWW",	@"うpします。",	@"駄目だ、まだ吐くな、こらえるんだ",	@"オエー鳥",	@"成功者に対して失礼だと思わないのかね？",	@"貴方はとんでもないものを盗みました。私の心です！",	@"毎日が休日です",	@"面接で自分を偽ることにかけて僕の右にでる者はいないでしょうね",	@"人事がすっげーハゲてて笑えっから見て来いっつわれて来ました",	@"下克上です！ ",	@"給料です。",	@"今みたいな圧迫面接です",	@"ワクワククマクマ",	@"人事(じんじ)と書いて(ひとごと)と読む",	@"今日の交通費はどちらでいただけるのでしょうか？",
        nil];
    
    cardList_pngName  = [[NSArray alloc] initWithObjects:@"dummy.png",@"card1.png",	@"card2.png",	@"card3.png",	@"card4.png",	@"card5.png",	@"card6.png",	@"card7.png",	@"card8.png",	@"card9.png",	@"card10.png",	@"card11.png",	@"card12.png",	@"card13.png",	@"card14.png",	@"card15.png",	@"card16.png",	@"card17.png",	@"card18.png",	@"card19.png",	@"card20.png",	@"card21.png",	@"card22.png",	@"card23.png",	@"card24.png",	@"card25.png",	@"card26.png",	@"card27.png",	@"card28.png",	@"card29.png",	@"card30.png",	@"card31.png",	@"card32.png",	@"card33.png",	@"card34.png",	@"card35.png",	@"card36.png",	@"card37.png",	@"card38.png",	@"card39.png",	@"card40.png",	@"card41.png",	@"card42.png",	@"card43.png",	@"card44.png",	@"card45.png",	@"card46.png",	@"card47.png",	@"card48.png",	@"card49.png",	@"card50.png",	@"card51.png",	@"card52.png",	@"card53.png",	@"card54.png",	@"card55.png",	@"card56.png",	@"card57.png",	@"card58.png",	@"card59.png",	@"card60.png",	@"card61.png",	@"card62.png",	@"card63.png",	@"card64.png",	@"card65.png",	@"card66.png",	@"card67.png",	@"card68.png",	@"card69.png",	@"card70.png",	@"card71.png",	@"card72.png",	@"card73.png",	@"card74.png",	@"card75.png",	@"card76.png",	@"card77.png",	@"card78.png",	@"card79.png",	@"card80.png",	@"card81.png",	@"card82.png",	@"card83.png",	@"card84.png",	@"card85.png",	@"card86.png",	@"card87.png",	@"card88.png",	@"card89.png",	@"card90.png",	@"card91.png",	@"card92.png",	@"card93.png",	@"card94.png",	@"card95.png",	@"card96.png",	@"card97.png",	@"card98.png",	@"card99.png",	@"card100.png",	@"card101.png",	@"card102.png",	@"card103.png",	@"card104.png",	@"card105.png",	@"card106.png",	@"card107.png",	@"card108.png",	@"card109.png",	@"card110.png",	@"card111.png",	@"card112.png",	@"card113.png",	@"card114.png",	@"card115.png",	@"card116.png",	@"card117.png",	@"card118.png",	@"card119.png",	@"card120.png",	@"card121.png",	@"card122.png",	@"card123.png",	@"card124.png",	@"card125.png",	@"card126.png",	@"card127.png",	@"card128.png",	@"card129.png",	@"card130.png",	@"card131.png",	@"card132.png",	@"card133.png",	@"card134.png",	@"card135.png",	@"card136.png",	@"card137.png",	@"card138.png",	@"card139.png",	@"card140.png",	@"card141.png",	@"card142.png",	@"card143.png",	@"card144.png",	@"card145.png",	@"card146.png",	@"card147.png",	@"card148.png",	@"card149.png",	@"card150.png",	@"card151.png",	@"card152.png",	@"card153.png",	@"card154.png",	@"card155.png",/*	@"card156.png",	@"card157.png",	@"card158.png",	@"card159.png",	@"card160.png",	@"card161.png",	@"card162.png",	@"card163.png",	@"card164.png",	@"card165.png",	@"card166.png",	@"card167.png",	@"card168.png",	@"card169.png",	@"card170.png",	@"card171.png",	@"card172.png",	@"card173.png",	@"card174.png",	@"card175.png",	@"card176.png",	@"card177.png",	@"card178.png",	@"card179.png",	@"card180.png",	@"card181.png",	@"card182.png",	@"card183.png",	@"card184.png",	@"card185.png",	@"card186.png",	@"card187.png",	@"card188.png",	@"card189.png",	@"card190.png",	@"card191.png",	@"card192.png",	@"card193.png",	@"card194.png",	@"card195.png",	@"card196.png",	@"card197.png",	@"card198.png",	@"card199.png",	@"card200.png",	@"card201.png",	@"card202.png",	@"card203.png",	@"card204.png",	@"card205.png",*/
            nil];
    
    
    _cardList_text = [[NSArray alloc] initWithObjects:@"ぬる", @"白のエネルギーを1つ追加する",	@"青のエネルギーを1つ追加する",	@"黒のエネルギーを1つ追加する",	@"赤のエネルギーを1つ追加する",	@"緑のエネルギーを1つ追加する",	@"あなたが選んだAA1体の修正防御力を3増加させる",	@"戦闘フェーズにおいて、あなたが選んだAA1体の基修正防御力を3増加させる",	@"あなたは3点のライフを得る",	@"あなたは3点のライフを得る。山札からカードを1枚引く",	@"ターン終了フェーズにおいて、あなたは1点のライフを得る",	@"相手プレイヤーが白色のカードを使用するたび、ターン終了フェーズにあなたは1点のライフを得る",	@"相手プレイヤーが青色のカードを使用するたび、ターン終了フェーズにあなたは1点のライフを得る",	@"相手プレイヤーが黒色のカードを使用するたび、ターン終了フェーズにあなたは1点のライフを得る",	@"相手プレイヤーが赤色のカードを使用するたび、ターン終了フェーズにあなたは1点のライフを得る",	@"相手プレイヤーが緑色のカードを使用するたび、ターン終了フェーズにあなたは1点のライフを得る",	@"戦闘時に与えられる白色のカードからのダメージを1減らす",	@"戦闘時に与えられる青色のカードからのダメージを1減らす",	@"戦闘時に与えられる黒色のカードからのダメージを1減らす",	@"戦闘時に与えられる赤色のカードからのダメージを1減らす",	@"戦闘時に与えられる緑色のカードからのダメージを1減らす",	@"このターン、相手プレイヤーのギコは攻撃できない",	@"このターン、相手プレイヤーのモナーは攻撃できない",	@"このターン、相手プレイヤーのショボンは攻撃できない",	@"このターン、相手プレイヤーのAAは防御できない",	@"戦闘フェーズにおいて、あなたの全てのAAはブロックされない",	@"あなたはあなたの手札のカード枚数×2の点数分だけライフを得る",	@"互いのプレイヤーが4点以上のダメージを与えられる場合、そのダメージは3点になる",	@"互いのプレイヤーが持つ全てのエネルギーを破壊する",	@"このターン、互いのプレイヤーの全てのAAは攻撃できない",	@"あなたが選んだ場カードを1枚破壊する",	@"あなたのやる夫の修正攻撃力を5増加させる",	@"相手プレイヤーの山札を上から1枚墓地に移動させる",	@"相手プレイヤーの山札を上から2枚墓地に移動させる",	@"相手プレイヤーの山札を上から半分墓地に移動させる",	@"あなたはあなたが持つエネルギーの種類数×2の点数分だけライフを得る",	@"山札からカードを1枚引き、1枚捨てる",	@"山札からカードを2枚引く",	@"山札からカードを3枚引く",	@"相手プレイヤーのエネルギーを1枚を破壊し、代わりに白のエネルギーを追加する",	@"相手プレイヤーのエネルギーを1枚を破壊し、代わりに青のエネルギーを追加する",	@"相手プレイヤーのエネルギーを1枚を破壊し、代わりに黒のエネルギーを追加する",	@"相手プレイヤーのエネルギーを1枚を破壊し、代わりに赤のエネルギーを追加する",	@"相手プレイヤーのエネルギーを1枚を破壊し、代わりに緑のエネルギーを追加する",	@"あなたが選んだAA1体の修正攻撃力を3減らす",	@"あなたが選んだ場カードを1枚手札に戻す",	@"相手プレイヤーの全ての場カードを手札に戻す",	@"あなたはあなたが選んだ場カードのコントロールを得る",	@"あなたが選んだ場カードを手札に戻し、カードを一枚引く",	@"色を一色選ぶ。相手プレイヤーが持つ、その色の場カードを全て手札に戻す",	@"あなたはあなたの山札の一番上のカードを見る。その後、そのカードを手札に入れるか山札の一番下に置く",	@"相手プレイヤーの使用AAをギコに変更する",	@"相手プレイヤーの使用AAをモナーに変更する",	@"相手プレイヤーの使用AAをショボンに変更する",	@"このターン、全てのAA間の相性関係を逆転させる",	@"このターンに使用されたカードの枚数分だけ山札からカードを引く",	@"あなたが持つエネルギーの種類数分だけ山札からカードを引く",	@"相手プレイヤーの全てのAAは攻撃もブロックもできない。このカード以外のカードが使用されたとき、このカードは破壊される",	@"山札からカードを2枚引き、2枚捨てる",	@"手札を全て捨て、同じ枚数のカードを引く(1ターンに1枚しか使用できない)",	@"互いのプレイヤーが持つ全種類のエネルギーを1ずつ減らす",	@"互いのプレイヤーが持つ全種類のエネルギーを3ずつ減らす",	@"自分がコントロールする場カードと相手がコントロールする場カードを一枚交換する",	@"このカードは自分がコントロールする他の場カードのコピーになる(このターン中に使わない場合、破壊される)",	@"このカードが場に存在する限り、相手の全てのAAの修正攻撃力を3減らす",	@"山札からカードを1枚引く",	@"あなたが選んだAA1体の修正攻撃力を3増加させる",	@"相手プレイヤーが持つエネルギーを1つ破壊する",	@"相手プレイヤーが持つエネルギーをランダムで1つ破壊する",	@"全てのエネルギーカードを破壊する",	@"相手プレイヤーに2点のダメージを与える",	@"相手プレイヤーに3点のダメージを与える",	@"ターン終了フェーズにおいて、相手プレイヤーに1点のダメージを与える",	@"あなたは1点のライフを支払い、相手プレイヤーに3点のダメージを与える",	@"あなたは2点のライフを支払い、相手プレイヤーに4点のダメージを与える",	@"あなたが選んだ場カードを1枚破壊する",	@"あなたが選んだ場カードを最大2枚破壊する",	@"相手プレイヤーに2点のダメージを与える。このターン、相手がギコを選んでいれば、代わりに5点のダメージを与える",	@"相手プレイヤーに2点のダメージを与える。このターン、相手がモナーを選んでいれば、代わりに5点のダメージを与える",	@"相手プレイヤーに2点のダメージを与える。このターン、相手がショボンを選んでいれば、代わりに5点のダメージを与える",	@"相手プレイヤーに2点のダメージを与える。このターン、相手がやる夫を選んでいれば、代わりに5点のダメージを与える",	@"あなたが選んだAA1体の修正攻撃力を5増加させ、基本防御力・修正防御力を0にする",	@"このターン相手プレイヤーがカードを使用した場合、相手プレイヤーに3点のダメージを与える。使用しなかった場合、代わりに1点のダメージを与える。",	@"このターン相手プレイヤーがカードを使用しなかった場合、相手プレイヤーに5点のダメージを与える。使用した場合、代わりに1点のダメージを与える。",	@"色を一色選ぶ。場に出ている、その色の場カードの枚数分だけ相手プレイヤーにダメージを与える",	@"あなたが持つエネルギーカードの種類数分だけ相手プレイヤーにダメージを与える",	@"全てのエネルギーと場カードを破壊する",	@"手札からカードを1枚ランダムで捨てる。あなたが選んだAAの修正攻撃力を5減らす",	@"相手がギコを選ぶたび、ダメージ計算フェーズにおいて2点のダメージを与える",	@"相手がモナーを選ぶたび、ダメージ計算フェーズにおいて2点のダメージを与える",	@"相手がショボンを選ぶたび、ダメージ計算フェーズにおいて2点のダメージを与える。",	@"相手がやる夫を選ぶたび、ダメージ計算フェーズにおいて2点のダメージを与える",	@"ダメージ計算フェーズにおいて、相手プレイヤーに毎ターン1点のダメージを与える",	@"このターン、自分の全AAの修正攻撃力を1減らす。相手プレイヤーに2点のダメージを与える",	@"あなたが選んだ相手プレイヤーのエネルギーを破壊する",	@"あなたが選んだ相手プレイヤーのエネルギーを最大2枚破壊する",	@"このターン、黒エネルギーを3点増やす",	@"相手プレイヤーに1点のダメージを与え、あなたは1点のライフを得る",	@"相手プレイヤーに2点のダメージを与え、あなたは4点のライフを得る",	@"相手プレイヤーの手札をランダムで1枚減らす",	@"相手プレイヤーの手札をランダムで2枚減らす",	@"相手プレイヤーの手札を全て減らす",	@"あなたが選んだAA1体の修正防御力を3減らす",	@"あなたのAAの修正攻撃力と修正防御力を1減らす。あなたのAAはブロックされない",	@"あなたは3点のライフを支払う。あなたが選んだAA1体の修正攻撃力を5増加させる",	@"ダメージ計算フェーズにおいて、あなたは5点のライフを支払う。あなたが選んだAA1体の修正攻撃力を8増加させる",	@"あなたがコントロールする場カードを1枚破壊する。あなたは山札からカードを2枚引く",	@"あなたが持つエネルギーの種類数だけ相手のAAの修正攻撃力と修正防御力を減らす",	@"あなたは3点のライフを支払う。あなたが選んだ場カードを1枚破壊する",	@"ターン開始フェーズにおいて、相手プレイヤーはランダムでカードを1枚捨てる",	@"あなたが選んだAA1体の修正攻撃力と修正防御力を1減らす。あなたは山札からカードを1枚引く。",	@"ターン終了フェーズにおいて、相手のコントロールする場カードかエネルギーをランダムで1枚破壊する",	@"相手プレイヤーが使用したカードの枚数だけ、ダメージ計算フェーズに山札からカードを引く",	@"あなたは4点のライフを失う。あなたは山札からカードを1枚探し、手札に入れる。その後、ライブラリを切り直す",	@"あなたは山札からカードを1枚探し、手札に入れる。その後、ライブラリを切り直す",	@"相手プレイヤーの山札からカードを1枚捨てる",	@"相手プレイヤーの山札からカードを10枚捨てる",	@"あなたが選んだAA1体の修正攻撃力を3増やし、基本防御力と修正防御力を半分に減らす",	@"相手プレイヤーの手札からカードを1枚選んで墓地に捨てる",	@"相手プレイヤーの手札からカードを1枚選んで墓地に捨てる",	@"互いのプレイヤーが持つ場カードをランダムに1枚ずつ破壊する",	@"あなたは手札からカードを1枚捨てる。相手プレイヤーの手札からカードを1枚選んで墓地に捨てる",	@"互いのプレイヤーは手札を全て捨てる",	@"あなたが選んだAA1体の基本攻撃力を2増やし、基本防御力を2減らす",	@"あなたは手札からカードを2枚捨てる。あなたが選んだAA1体の基本攻撃力と基本防御力を2増やす",	@"ダメージ計算フェーズにおいて、相手プレイヤーに3点のダメージを与える",	@"あなたが選んだAA1体の修正攻撃力と修正防御力を3増やす",	@"あなたが選んだAA1体の修正攻撃力と修正防御力を7増やす",	@"あなたが選んだAA1体の修正攻撃力と修正防御力を1増やす。あなたは山札からカードを1枚引く",	@"あなたが選んだAA1体の修正攻撃力と修正防御力を2増やす。このターン、選んだAAはブロックされない。",	@"あなたが選んだAA1体の修正攻撃力と修正防御力を4増やす",	@"相手が使用したカード(エネルギーカード除く)の枚数だけ、ダメージ計算フェーズにあなたのAAの修正攻撃力を1増やす",	@"このターン、互いのプレイヤーの全てのAAは攻撃できない",	@"墓地からカードを一枚手札に戻す",	@"墓地からカードを二枚手札に戻す",	@"あなたの全てのAAはブロックされない",	@"このカードが場に存在する限り、あなたの全てのAAはブロックされない",	@"あなたは山札からエネルギーを1枚探し、手札に入れる。その後、ライブラリを切り直す",	@"あなたは山札からエネルギーを2枚探し、手札に入れる。その後、ライブラリを切り直す",	@"あなたが選んだあなたの墓地のカードを1枚山札の一番下に戻す",	@"あなたが選んだ場カードを1枚破壊する",	@"全ての場カードを破壊する",	@"ターン開始フェーズにおいて、山札からカードを1枚引く代わりにエネルギーを1枚探し、手札に入れても良い。",	@"このターン、あなたのAAの修正攻撃力が増加していた場合、あなたは山札からカードを1枚引く",	@"あなたがコントロールする場カードを1枚破壊する。破壊したカードのコスト分だけ、このターンあなたの全てのAAの修正攻撃力を増加させる",	@"あなたはあなたが持つエネルギーの種類数だけあなたのAAの修正攻撃力と修正防御力を増加させる",	@"毎ターン、あなたが選んだAA1体の修正攻撃力と修正防御力を1増加させる",	@"毎ターン、あなたの全てのAAの基本攻撃力と基本防御力を1増加させる",	@"ダメージ計算フェーズにおいて、あなたは手札からカードを1枚捨てる。このターン、あなたの全てのAAはブロックされない",	@"あなたが持つ手札のカードが2枚以下の場合、ダメージ計算フェーズにあなたの全てのAAの修正攻撃力と修正防御力を3増加させる",	@"あなたが持つ手札のカードが1枚以下の場合、ダメージ計算フェーズにあなたの全てのAAの修正攻撃力と修正防御力を5増加させる",	@"あなたは手札からカードを3枚捨てる。あなたは山札からエネルギーをランダムに3枚引く",	@"互いのプレイヤーの場カードを1枚ずつ破壊する",	@"あなたの墓地にあるエネルギーを1枚手札に戻す",	@"あなたが選んだ相手プレイヤーの場カードとエネルギーを1枚ずつ破壊する",	@"あなたが選んだ相手プレイヤーの場カードとエネルギーを2枚ずつ破壊する",nil];
    
    NSNumber *energy  = [NSNumber numberWithInt:ENERGYCARD];
    NSNumber *field  = [NSNumber numberWithInt:FIELDCARD];
    NSNumber *sorcery = [NSNumber numberWithInt:SORCERYCARD];
    
    
    _cardList_type = [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:0], energy,	energy,	energy,	energy,	energy,	sorcery,	field,	sorcery,	sorcery,	field,	field,	field,	field,	field,	field,	field,	field,	field,	field,	field,	sorcery,	sorcery,	sorcery,	sorcery,	field,	sorcery,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	field,	field,	field,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	sorcery,	sorcery,	sorcery,	field,	sorcery,	field,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	sorcery,	sorcery,	sorcery,	sorcery,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,	field,	field,	sorcery,	sorcery,	field,	field,	field,	field,	field,	sorcery,	sorcery,	sorcery,	sorcery,	sorcery,
 nil];
    _cardList_cost = [[NSArray alloc] initWithObjects: @"null", @"0", @"0", @"0", @"0", @"0",@"W",	@"W2",	@"W",	@"W2",	@"W2",	@"W1",	@"W1",	@"W1",	@"W1",	@"W1",	@"W1",	@"W1",	@"W1",	@"W1",	@"W1",	@"W",	@"W",	@"W",	@"W2",	@"WW3",	@"WW2",	@"W5",	@"W4",	@"W",	@"W1",	@"W2",	@"W",	@"W1",	@"WW2",	@"W",	@"U1",	@"UU1",	@"UU2",	@"U",	@"U",	@"U",	@"U",	@"U",	@"U1",	@"UU",	@"UU3",	@"UU3",	@"UU1",	@"U2",	@"U",	@"U2",	@"U2",	@"U2",	@"U2",	@"U4",	@"U2",	@"U1",	@"U2",	@"U3",	@"U3",	@"U5",	@"U2",	@"UU",	@"UU3",	@"U1",	@"R",	@"RR2",	@"R2",	@"R4",	@"R",	@"R1",	@"R2",	@"R",	@"RR",	@"R1",	@"R3",	@"RR",	@"RR",	@"RR",	@"RR",	@"R1",	@"RR",	@"RR",	@"R4",	@"R1",	@"RRR4",	@"R1",	@"R1",	@"R1",	@"R1",	@"R1",	@"R2",	@"R",	@"R2",	@"RR3",	@"B",	@"B1",	@"B2",	@"B",	@"BB",	@"BB3",	@"B1",	@"B1",	@"BB",	@"BB2",	@"B1",	@"B1",	@"B1",	@"BB2",	@"B2",	@"BB2",	@"BB4",	@"B2",	@"BB2",	@"B1",	@"BBB5",	@"B",	@"B1",	@"BB2",	@"B1",	@"B",	@"BB3",	@"B3",	@"B1",	@"BB3",	@"G",	@"G3",	@"G",	@"G2",	@"G1",	@"G2",	@"G",	@"G2",	@"G3",	@"G1",	@"G4",	@"G1",	@"GG2",	@"G",	@"G1",	@"G2",	@"G1",	@"G2",	@"G1",	@"G1",	@"G",	@"GG1",	@"G",	@"G2",	@"G2",	@"G1",	@"G1",	@"G1",	@"GG2",	@"GGG3",

 nil];
    _cardList_color = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],
        [NSNumber numberWithInt:0], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE], [NSNumber numberWithInt:WHITE],
        [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE], [NSNumber numberWithInt:BLUE],
        [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED], [NSNumber numberWithInt:RED],
        [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK], [NSNumber numberWithInt:BLACK],
        [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], [NSNumber numberWithInt:GREEN], nil];
    
    _cardList_rarelity = [[NSArray alloc] initWithObjects:@"null",@"C",	@"C",	@"C",	@"C",	@"C",	@"C",	@"U",	@"C",	@"U",	@"C",	@"U",	@"U",	@"U",	@"U",	@"U",	@"C",	@"C",	@"C",	@"C",	@"C",	@"C",	@"C",	@"C",	@"U",	@"R",	@"U",	@"R",	@"R",	@"C",	@"C",	@"C",	@"C",	@"U",	@"R",	@"U",	@"C",	@"C",	@"U",	@"C",	@"C",	@"C",	@"C",	@"C",	@"C",	@"C",	@"U",	@"U",	@"U",	@"R",	@"C",	@"C",	@"C",	@"C",	@"R",	@"U",	@"U",	@"R",	@"U",	@"R",	@"C",	@"U",	@"R",	@"U",	@"U",	@"C",	@"C",	@"C",	@"U",	@"R",	@"C",	@"U",	@"C",	@"C",	@"U",	@"C",	@"U",	@"C",	@"C",	@"C",	@"C",	@"U",	@"R",	@"R",	@"U",	@"U",	@"R",	@"R",	@"C",	@"C",	@"C",	@"C",	@"U",	@"C",	@"U",	@"U",	@"C",	@"C",	@"U",	@"C",	@"U",	@"R",	@"C",	@"C",	@"U",	@"R",	@"C",	@"U",	@"C",	@"U",	@"C",	@"U",	@"R",	@"C",	@"U",	@"C",	@"R",	@"C",	@"C",	@"U",	@"U",	@"C",	@"R",	@"C",	@"U",	@"C",	@"C",	@"R",	@"C",	@"U",	@"C",	@"U",	@"C",	@"C",	@"U",	@"C",	@"U",	@"C",	@"U",	@"C",	@"C",	@"R",	@"R",	@"U",	@"C",	@"U",	@"C",	@"U",	@"C",	@"U",	@"R",	@"C",	@"C",	@"U",	@"U",	@"R", nil];
    
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

-(int)getANewCard{
    int getCardNumber;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    getCardNumber = (arc4random() % [cardList_cardName count]);
    NSLog(@"getCardNumber:%d",getCardNumber);
    
    //自分の持っているカードを全て呼び出し、新しく手に入れたカードを増やした上で保存する
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[user arrayForKey:@"myCards_ud"]];
    NSLog(@"array:%@",array);
    [array replaceObjectAtIndex:getCardNumber withObject:[NSNumber numberWithInt:([[array objectAtIndex:getCardNumber] intValue] + 1)]];
    

    [user setObject:array forKey:@"myCards_ud"];
    [user synchronize];
    
    NSMutableArray *array2 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"myCards_ud"]];
        NSLog(@"array2:%@",array2);
    
    return getCardNumber;
}





@end
