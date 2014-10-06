//
//  WaitingForInternetBattleViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/08.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "WaitingForInternetBattleViewController.h"


@interface WaitingForInternetBattleViewController ()

@end

@implementation WaitingForInternetBattleViewController
@synthesize course;

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
    NSLog(@"notification:on");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopExploringAnimation)
                                                 name:@"stopExploringAnimation"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopExploringAnimation)
                                                 name:@"stopExploringForExcemption"
                                               object:nil];

    app = [[UIApplication sharedApplication] delegate];
    
    //探索開始時にstopWalkingをNOにしておく
    stopWalking = NO;
    
    //インターネット対戦時の待機時間（＝ギコの総歩行時間）を読み込む
    ud = [NSUserDefaults standardUserDefaults];
    allWalkingTime = [ud integerForKey:@"allWalkingTime"];
    remainedWalkingTime = [ud integerForKey:@"remainedWalkingTime"];
    
    // Do any additional setup after loading the view.
    cardBoxAnimationView = [[MBAnimationView alloc] init];
    [cardBoxAnimationView setAnimationImageVertical:@"cardBox.png" :17 :32 :4];
    cardBoxAnimationView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 17, 80, 34, 64);
    cardBoxAnimationView.animationDuration = 3;
    
    
    gikoAnimationView = [[MBAnimationView alloc] init];
    [gikoAnimationView setAnimationImage:@"gikoWalking.png" :24 :22 :3];
    gikoAnimationView.frame = CGRectMake( [[UIScreen mainScreen] bounds].size.width / 2 - 24, 30, 48, 44);
    gikoAnimationView.animationDuration = 2;
    gikoAnimationView.animationRepeatCount = 0;
    
    walkingMeter = [[UITextView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 100, 40, 80, 40)];
    [PenetrateFilter penetrate:walkingMeter];
    walkingMeter.editable = NO;
    walkingMeter.text = [NSString stringWithFormat:@"残り：%dｍ",(int)((remainedWalkingTime - 8) * 1.6)];
    
    //選択したコースごとに背景画像を用意する
    switch (course) {
        case 1:
        {
            NSString *cardImagePath = [[NSBundle mainBundle] pathForResource:@"grass" ofType:@"png"];
            backgroundImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
            backgroundImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
        }
            break;
        case 2:
        {
            NSString *cardImagePath = [[NSBundle mainBundle] pathForResource:@"snow" ofType:@"png"];
            backgroundImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
            backgroundImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
        }
            break;
        case 3:
        {
            NSString *cardImagePath = [[NSBundle mainBundle] pathForResource:@"deepForest" ofType:@"png"];
            backgroundImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
            backgroundImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
            walkingMeter.textColor = [UIColor whiteColor];
        }
            break;
        case 4:
        {
            NSString *cardImagePath = [[NSBundle mainBundle] pathForResource:@"desert" ofType:@"png"];
            backgroundImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
            backgroundImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
        }
            break;
        case 5:
        {
            NSString *cardImagePath = [[NSBundle mainBundle] pathForResource:@"amazon" ofType:@"png"];
            backgroundImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
            backgroundImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
        }
            break;
        default:
            break;
    }
    
    //探索中止ボタンの実装
    stopExplorationButton = [[UIButton alloc] init];
    [stopExplorationButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]] forState:UIControlStateNormal];
    [stopExplorationButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    stopExplorationButton.frame = CGRectMake(10, 10, 50, 50);
    [self.view addSubview:stopExplorationButton];
    // ボタンがタッチされた時にstopExplorationメソッドを呼び出す
    [stopExplorationButton addTarget:self action:@selector(stopExploration)
                    forControlEvents:UIControlEventTouchUpInside];
    
    backgroundImageView1.frame = CGRectMake(0,   0, 320, 960);
    backgroundImageView2.frame = CGRectMake(0, 960, 320, 960);
    
    cardBox_closed = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 8, [[UIScreen mainScreen] bounds].size.height * 2 + 80 , 17, 32)];
    cardBox_closed.image = [UIImage imageNamed:@"cardBox_closed"];
    
    
    gettingCardNumber = arc4random() % [app.cardList_cardName count];
    NSString *cardImagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"card%d_M",gettingCardNumber] ofType:@"JPG"];
    cardImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:cardImagePath]];
    cardImageView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 16, 60, 32, 48);
    
    getACardAlertView = [[UIAlertView alloc] initWithTitle:@"カード発見！" message:@"カードを発見しました！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"探索を再開する", nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self startAnimation];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any/ resources that can be recreated.
}

- (void)appearAnimationImage:(MBAnimationView *)animationView rect:(CGRect)rect duration:(float)duration repeatCount:(int)repeat{
    animationView.frame = rect;
    animationView.animationDuration = duration;
    animationView.animationRepeatCount = repeat;
    [self.view addSubview:animationView];
    [animationView startAnimating];
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

- (IBAction)startAnimation{
    [self.view addSubview:backgroundImageView1];
    [self.view addSubview:backgroundImageView2];
    [self.view addSubview:gikoAnimationView];
    [self.view addSubview:cardBox_closed];
    [self.view addSubview:walkingMeter];
    [self.view addSubview:stopExplorationButton];
    
    [self walkingTimeCaliculate];
    
    //対戦相手の検索
    dev = [[DeviceMotion alloc] init];
    dev.delegate = self;
    [dev bumpForInternetBattle];
    
    //ギコの歩行アニメーション
    [gikoAnimationView startAnimating];
    
    //2枚の背景を次々にアニメーションさせて背景の動きを実現する
    [UIView animateWithDuration:10.0f delay:0.0f options:UIViewAnimationOptionCurveLinear                     animations:^{
        // アニメーションをする処理
        backgroundImageView1.frame = CGRectMake(0, -960, 320, 960);
    }completion:^(BOOL finished){
        backgroundImageView1.frame = CGRectMake(0, 960, 320, 960);
        [UIView animateWithDuration:20.0f delay:0.0f options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear                     animations:^{
            // アニメーションをする処理
            backgroundImageView1.frame = CGRectMake(0, -960, 320, 960);
        }completion:^(BOOL finished){
            backgroundImageView1.frame = CGRectMake(0,  960, 320, 960);
        }
         ];
    }
     ];
    
    [UIView animateWithDuration:20.0f delay:0.0f options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear
                     animations:^{
        // アニメーションをする処理
        backgroundImageView2.frame = CGRectMake(0, -960, 320, 960);
    }completion:^(BOOL finished){
        backgroundImageView2.frame = CGRectMake(0, 960, 320, 960);
    }
     ];
    
    //カードゲット時間に到達したあとの処理
    [UIView animateWithDuration:10.0f delay:remainedWalkingTime - 16
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // アニメーションをする処理
                         cardBox_closed.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 17, 80, 34, 64);
                     }completion:^(BOOL finished){
                         cardBox_closed.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 8, [[UIScreen mainScreen] bounds].size.height * 2 + 80 , 17, 32);
                         [cardBox_closed removeFromSuperview];
                         [gikoAnimationView.layer pauseAnimation:YES];
                         [backgroundImageView1.layer pauseAnimation:YES];
                         [backgroundImageView2.layer pauseAnimation:YES];
                         [self.view addSubview:cardBoxAnimationView];
                         [cardBoxAnimationView startAnimating];
                         dev.exploringFinished = YES;
                         timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
                                                                selector:@selector(onTimer:) userInfo:nil repeats:NO];
                     }
     ];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == walkingStartAlertView){
        [self startAnimation];
    }else if (alertView == getACardAlertView){
        [self setNewExploration];
    }
}

//アニメーションと並列してカードゲットの歩行時間計算を行う
- (void)walkingTimeCaliculate{
    //アニメーションと並列処理で歩行時間を計測する
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main   = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        
        //残り距離数の更新
        while (remainedWalkingTime > 8) {
            if(stopWalking == YES){
                break;
            }else{
                [NSThread sleepForTimeInterval:1.0];
                remainedWalkingTime -= 1;
                
                //残り距離数の更新
                [self performSelectorOnMainThread:@selector(setWalkingMeter)
                                       withObject:nil
                                    waitUntilDone:NO];
            }
        }
        dispatch_async(q_main, ^{
        });
    });
}

//cardBoxAnimationViewがアニメーションを終わったか否かを判定する
- (void)onTimer:(NSTimer *)theTimer {
    if (cardBoxAnimationView.isAnimating) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
                                                    selector:@selector(onTimer:) userInfo:nil repeats:NO];
    }else
    {
        [timer invalidate];
        [self.view addSubview:cardImageView];
        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseIn                     animations:^{
                // アニメーションをする処理
                cardImageView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 2);
                cardImageView.transform = CGAffineTransformMakeScale(10.0,10.0);
            }completion:^(BOOL finished){
                //カードゲット(任意で「戻る」ボタンを押した時にはshowしないようにしておく)
                if (getACardAlertView != nil) {
                    //Timer 設定(0.5秒設定）
                    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(dismissGetACardAlertView:) userInfo:getACardAlertView repeats:NO];
                    [getACardAlertView show];
                }
            }
        ];
    }
    
}

- (void)stopExploration{
    NSLog(@"notification:off");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    stopWalking = YES;
    getACardAlertView = nil;
    [ud setInteger:remainedWalkingTime forKey:@"remainedWalkingTime"];
    [ud synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissGikoGikoViewController"
                                                        object:self
                                                      userInfo:nil];
}

- (void)setWalkingMeter{
    walkingMeter.text = [NSString stringWithFormat:@"残り：%dｍ",(int)((remainedWalkingTime - 8) * 1.6)];
    NSLog(@"残り：%d秒",remainedWalkingTime - 8);
}

//deviceMotionDelegateのdelegateを実装
- (void)stopExploringAnimation{
    [self stopExploration];
}

- (void)stopExploringForExcemption{
    [self stopExploration];
    [dev.errorAlert show];
}

- (void)dismissGetACardAlertView:(NSTimer *)theTimer{
    UIAlertView *alertView = [theTimer userInfo];
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [self setNewExploration];
}

-(void)setNewExploration{
    [app getANewCard:gettingCardNumber];
    remainedWalkingTime = arc4random() % 21 + 30; //探索秒数は30秒〜50秒の間でランダム設定
    [ud setInteger:remainedWalkingTime forKey:@"remainedWalkingTime"];
    [ud synchronize];
    NSLog(@"設定された探索秒数：%d秒",remainedWalkingTime - 8 );
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
