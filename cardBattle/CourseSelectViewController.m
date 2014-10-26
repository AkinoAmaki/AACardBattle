//
//  CourseSelectViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/11.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "CourseSelectViewController.h"

@interface CourseSelectViewController ()

@end

@implementation CourseSelectViewController

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
    
    //AppDelegateの起動
    app = [[UIApplication sharedApplication] delegate];
    
    NSString *backGroundImagePath = [[NSBundle mainBundle] pathForResource:@"backOfACard_skelton" ofType:@"png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:backGroundImagePath]];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:imageView];
    
    //説明文を実装
    UITextView *explainTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 60)];
    explainTextView.textAlignment = NSTextAlignmentCenter;
    explainTextView.text = @"対戦相手を探している間に\nカードを探索するフィールドを選んでください";
    [PenetrateFilter penetrate:explainTextView];
    [self.view addSubview: explainTextView];
    
    //メインビューに戻るボタンを実装
    _returnToMainViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_returnToMainViewButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:_returnToMainViewButton];
    _returnToMainViewButton.frame = CGRectMake(30,30, 50, 50);
    [_returnToMainViewButton addTarget:self action:@selector(returnToMainView)
                      forControlEvents:UIControlEventTouchUpInside];
    
    //コース選択ボタンの実装
    int width = 180;
    int height = 30;
    int w = ([[UIScreen mainScreen] bounds].size.width - width) / 2;
    int h = 120;
    
    course1Button = [[AAButton alloc] initWithImageAndText:@"glyphicons_310_flower" imagePath:@"png" textString:@"草原フィールド" tag:1 CGRect:CGRectMake(w,h,width,height)];
    [course1Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:course1Button];

    h += 50;
    
    course2Button = [[AAButton alloc] initWithImageAndText:@"glyphicons_021_snowflake" imagePath:@"png" textString:@"雪山フィールド" tag:2 CGRect:CGRectMake(w,h,width,height)];
    [course2Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:course2Button];
    h += 50;
    
    course3Button = [[AAButton alloc] initWithImageAndText:@"glyphicons_230_moon" imagePath:@"png" textString:@"宵闇フィールド" tag:3 CGRect:CGRectMake(w,h,width,height)];
    [course3Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:course3Button];
    h += 50;
    
    course4Button = [[AAButton alloc] initWithImageAndText:@"glyphicons_231_sun" imagePath:@"png" textString:@"砂漠フィールド" tag:4 CGRect:CGRectMake(w,h,width,height)];
    [course4Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:course4Button];
    h += 50;
    
    course5Button = [[AAButton alloc] initWithImageAndText:@"glyphicons_001_leaf" imagePath:@"png" textString:@"密林フィールド" tag:5 CGRect:CGRectMake(w,h,width,height)];
    [course5Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:course5Button];
    h += 50;
    
    //  NADViewの作成
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, 320, 100)];
    //  ログ出力の指定
    [self.nadView setIsOutputLog:NO];
    //  set apiKey, spotId.
    [self.nadView setNendID:@"17df8518f899a6d562f10eb8532b19d48af66209"
                     spotID:@"237832"];
    //　デリゲートの設定
    [self.nadView setDelegate:self];
    //　広告の読み込み
    [self.nadView load]; //(6)
    [self.view addSubview:self.nadView]; // 最初から表示する場合
    
    //初回起動判定。初回起動であれば、プロローグを開始する。
    int first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
    if (first == 0) {
        [self startAnimation022];
    }
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startExploration:(UIButton *)button{
    GikoGikoWaintngViewController *giko = [[GikoGikoWaintngViewController alloc] init];
    giko.course = button.tag;
    [self presentViewController:giko animated:YES completion:nil];
}

- (void)returnToMainView
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startAnimation022{
    NSLog(@"%s",__func__);
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro22" imagePath:@"png" textString:@"おや？フィールドを選べと言われたお。" characterIsOnLeft:YES];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation023)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation023)]];
    [app.blackBack removeFromSuperview];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:self.view.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:course1Button,course2Button,course3Button,course4Button,course5Button,_returnToMainViewButton, nil] coveredView:self.view];
    [self.view addSubview:app.blackBack];
}

- (void)startAnimation023{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro23" imagePath:@"png" textString:@"インターネット対戦で対戦相手を探すには、少し時間がかかる場合があるんだ。" characterIsOnLeft:NO];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation024)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation024)]];
}

- (void)startAnimation024{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro24" imagePath:@"png" textString:@"その間にフィールドを探索することで、新しいカードを手に入れることができる。" characterIsOnLeft:NO];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation025)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation025)]];
}

- (void)startAnimation025{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro25" imagePath:@"png" textString:@"それはいいお！" characterIsOnLeft:YES];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation026)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation026)]];
}

- (void)startAnimation026{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro26" imagePath:@"png" textString:@"だが、フィールド探索だけでは手に入れられないレアカードもあるようだから注意は必要だ。" characterIsOnLeft:NO];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation027)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation027)]];
}

- (void)startAnimation027{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro27" imagePath:@"png" textString:@"みんなを救うにはバトルも必要ってことかお……" characterIsOnLeft:YES];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation028)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation028)]];
}

- (void)startAnimation028{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro28" imagePath:@"png" textString:@"そういうことだな。" characterIsOnLeft:NO];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation029)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation029)]];
}

- (void)startAnimation029{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro29" imagePath:@"png" textString:@"とりあえず今回は草原フィールドを選んでみよう。" characterIsOnLeft:NO];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation030)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation030)]];
    [app.blackBack changeFrame:course1Button.frame coveredView:self.view];
}

- (void)startAnimation030{
    [app.pbImage removeFromSuperview];
    app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro30" imagePath:@"png" textString:@"分かったお。" characterIsOnLeft:YES];
    [self.view addSubview:app.pbImage];
    [app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    [app.blackBack changeFrameAndPermittionView:self.view.frame forbidedArray:[[NSArray alloc] initWithObjects:course2Button,course3Button,course4Button,course5Button, _returnToMainViewButton, nil] coveredView:self.view];
}

- (void)removeViewOnPrologue:(UITapGestureRecognizer *)sender{
    for (UIView *view in app.pbImage.subviews) {
        [view removeFromSuperview];
    }
    [app.pbImage removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
