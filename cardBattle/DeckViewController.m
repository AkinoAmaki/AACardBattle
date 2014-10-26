//
//  DeckViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/11.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "DeckViewController.h"


@interface DeckViewController ()

@end

@implementation DeckViewController

@synthesize selectedCards;
@synthesize isSelectedCards;
@synthesize detailOfACard;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //AppDelegateの呼び出し
    app = [[UIApplication sharedApplication] delegate];
    
    allImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 260 + NUMBEROFCARDS / 2 * (IMGHEIGHT + 5))];
    
    //スクロールビューの設定
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = allImage.bounds.size;
    
    NSString *backGroundImagePath = [[NSBundle mainBundle] pathForResource:@"backOfACard_skelton" ofType:@"png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:backGroundImagePath]];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:imageView];
    
    //決定ボタンを実装
    decideButton = [[AAButton alloc] initWithImageAndText:nil imagePath:nil textString:@"決定" tag:1 CGRect:CGRectMake(140, 80, 50, 20)];
    [decideButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(cardSelectDecideButtonPushed)]];
    [allImage addSubview:decideButton];

    
    //キャンセルボタンを実装
    cancelButton = [[AAButton alloc] initWithImageAndText:nil imagePath:nil textString:@"キャンセル" tag:1 CGRect:CGRectMake(200, 80, 100, 20)];
    [cancelButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(cardSelectCancelButtonPushed)]];
    [allImage addSubview:cancelButton];
    
    //メインビューに戻るボタンを実装
    _returnToMainViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_returnToMainViewButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [allImage addSubview:_returnToMainViewButton];
    _returnToMainViewButton.frame = CGRectMake(20,65, 50, 50);
    [_returnToMainViewButton addTarget:self action:@selector(returnToMainView:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    changeOfACardCount = 0;
    detailOfACardCount = 0;
    detailOfACard = [[UIImageView alloc] initWithFrame:CGRectMake(40, scrollView.contentOffset.y + 40, 240, 360)];
    
    
    //デッキ名入れるテキスト画面入れる
    UILabel *deckNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 50, 30)];
    deckNameLabel.text = @"デッキ名";
    deckNameLabel.adjustsFontSizeToFitWidth = YES;
    [allImage addSubview:deckNameLabel];
    deckName = [[UITextField alloc] initWithFrame:CGRectMake(80, 25, [[UIScreen mainScreen] bounds].size.width - 100, 30)];
    deckName.textAlignment = NSTextAlignmentCenter;
    deckName.clearButtonMode = UITextFieldViewModeAlways;
    deckName.borderStyle = UITextBorderStyleBezel;
    [allImage addSubview:deckName];
    
    
    //カードタップ音
    mainBundle = CFBundleGetMainBundle ();
    tapSoundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("se_maoudamashii_system49"),CFSTR ("mp3"),NULL);
    AudioServicesCreateSystemSoundID (tapSoundURL, &tapSoundID);
    CFRelease (tapSoundURL);
    //キャンセルボタンタップ音
    cancelSoundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("se_maoudamashii_system10"),CFSTR ("mp3"),NULL);
    AudioServicesCreateSystemSoundID (cancelSoundURL, &cancelSoundID);
    CFRelease (cancelSoundURL);
    
    
    //広告枠の設置
    //  NADViewの作成
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 98, 320, 50)];
    //  ログ出力の指定
    [self.nadView setIsOutputLog:NO];
    //  set apiKey, spotId.
    [self.nadView setNendID:@"64f46c33e622b9615a35dd87e3f8e3ea83a8e731"
                     spotID:@"237828"];
    //　デリゲートの設定
    [self.nadView setDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    //広告の停止
    NSLog(@"広告を停止しました");
    [self.nadView pause];
}

- (void)viewWillAppear:(BOOL)animated {
    //広告の再開
    NSLog(@"広告を開始しました");
    [self.nadView resume];
}

- (void) touchAction: (UITapGestureRecognizer *)sender{
    NSLog(@"タッチ感知 from %d",sender.view.tag);
    if (sender.view.tag <= 5) {
        //エネルギーカードは1枚ごとに4枚の制限はないため、実装を変える。
        if ([[isSelectedCards objectAtIndex:sender.view.tag] intValue] == [[app.myCards objectAtIndex:sender.view.tag] intValue]) {
            [isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:0]];
        }else{
            int i = [[isSelectedCards objectAtIndex:sender.view.tag] intValue];
            i++;
            [isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:i]];
        }
    }else{
        //エネルギーカードは1枚ごとに4枚の制限があるため、実装を変える。
        if ([[isSelectedCards objectAtIndex:sender.view.tag] intValue] == 4 || [[isSelectedCards objectAtIndex:sender.view.tag] intValue] == [[app.myCards objectAtIndex:sender.view.tag] intValue]) {
            [isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:0]];
        }else{
            int i = [[isSelectedCards objectAtIndex:sender.view.tag] intValue];
            i++;
            [isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:i]];
        }
        
        //初回起動ならプロローグを表示
        int first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
        if (first == 1 && sender.view.tag == app.firstRareCardNumber) {
                [self startAnimation154];
        }
    }
    
    UITextView *tmpTextView = (UITextView *)[allTxtView viewWithTag:sender.view.tag];
    tmpTextView.text = [NSString stringWithFormat:@"%@枚/%@枚",[isSelectedCards objectAtIndex:sender.view.tag],[app.myCards objectAtIndex:sender.view.tag]];
    [[allTxtView viewWithTag:sender.view.tag] removeFromSuperview];
    tmpTextView.tag = sender.view.tag;
    [allTxtView addSubview:tmpTextView];
    
    NSLog(@"カードナンバー%dの所持カード数：%d",sender.view.tag,[[app.myCards objectAtIndex:sender.view.tag] intValue]);
    NSLog(@"デッキに入っているカードナンバー%dの枚数:%d",sender.view.tag , [[isSelectedCards objectAtIndex:sender.view.tag] intValue]);
    
}

- (void)cardSelectDecideButtonPushed{
    //子クラスで実装
    
}

- (void)cardSelectCancelButtonPushed{
    AudioServicesPlaySystemSound (cancelSoundID);
    NSLog(@"%@",isSelectedCards);
    
    for (UIView *view in allTxtView.subviews) {
        [view removeFromSuperview];
    }
    
    for(int i = 1; i < [app.cardList_pngName count]; i++){
        
        [self openSmallCard:i];
        
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(25 + (IMGWIDTH) * (int)((i - 1) % NUMBEROFIMAGEINRAW) + (((i - 1) % NUMBEROFIMAGEINRAW) * 5), 158 + (IMGHEIGHT) * (int)((i - 1) / NUMBEROFIMAGEINRAW) + ((i - 1) / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT)];
        [txtView setFont:[UIFont systemFontOfSize:8]];
        
        UIColor *black = [UIColor blackColor]; //ボタンの背景を透明にするため、とりあえず黒を設定（下で透明化する）
        UIColor *alphaZero = [black colorWithAlphaComponent:0.0]; //黒を透明化
        txtView.backgroundColor = alphaZero;//テキストビューの背景を透明化
        
        txtView.text = [NSString stringWithFormat:@"%@枚/%@枚",[isSelectedCards objectAtIndex:i],[app.myCards objectAtIndex:i]];
        txtView.editable = NO;
        txtView.tag = i;
        [allTxtView addSubview:txtView];
    }
    [allImage addSubview:allTxtView];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"デッキ編成取消" message:@"デッキの編成を取り消しました" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)longTouchAcrion:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"感知 from %d",sender.view.tag);
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",(int)sender.view.tag]];
    [self.view addSubview:detailOfACard];
    detailOfACard.userInteractionEnabled = YES;
    [detailOfACard addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(removeDetailOfACard)]];
    [self touchesPermittion:NO];
}

- (void)removeDetailOfACard{
    NSLog(@"うん");
    [detailOfACard removeFromSuperview];
    [self touchesPermittion:YES];
}

- (void)putACancelButton:(CGRect)rect{
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancelButton.png"] forState:UIControlStateNormal];
    cancelButton.frame = rect;
    [cancelButton addTarget:self action:@selector(cancelButtonTouched:)
           forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cancelButton];
}

- (void) touchesPermittion:(BOOL)permit{
    if(permit){
        [scrollView setScrollEnabled:YES];
        allImage.userInteractionEnabled = YES;
    }else{
        [scrollView setScrollEnabled:NO];
        allImage.userInteractionEnabled = NO;
    }
}

- (void)cancelButtonTouched:(UIButton *)sender{
    [sender removeFromSuperview];
    [detailOfACard removeFromSuperview];
    [self touchesPermittion:YES];
    detailOfACardCount = 0;
}

- (void)openSmallCard:(int)i{
    
    UIImage *img;
    if([[app.myCards objectAtIndex:i] intValue] == 0){
        img = [UIImage imageNamed:@"question.png"];
    }else{
        img = [UIImage imageNamed:[NSString stringWithFormat:@"%@_D.jpg",[app.cardList_pngName objectAtIndex:i]]];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchAction:)]];
    [imgView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAcrion:)]];
    imgView.frame = CGRectMake(10 + (IMGWIDTH) * (int)((i - 1) % NUMBEROFIMAGEINRAW) + (((i - 1) % NUMBEROFIMAGEINRAW) * 5), 130 + (IMGHEIGHT) * (int)((i - 1) / NUMBEROFIMAGEINRAW) + ((i - 1) / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT);
    imgView.tag = i;
    [allImage addSubview:imgView];
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

- (void)startAnimation154{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro153" imagePath:@"png" textString:@"お、カードの表示が 「0枚/1枚」から「1枚/1枚」に変わったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation155)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation155)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation155{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro154" imagePath:@"png" textString:@"だが、これだけじゃデッキの編集は終わらない。最後に一番上にあった「決定」ボタンを押してみろ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation156)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation156)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
    [app.blackBack removeFromSuperview];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:decideButton.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:cancelButton, nil] coveredView:allImage];
    [allImage addSubview:app.blackBack];
    
}
- (void)startAnimation156{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro155" imagePath:@"png" textString:@"押してみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}

- (void)removeViewOnPrologue:(UITapGestureRecognizer *)sender{
    for (UIView *view in app.pbImage.subviews) {
        [view removeFromSuperview];
    }
    [app.pbImage removeFromSuperview];
}

@end

