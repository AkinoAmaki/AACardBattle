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
@synthesize delegate;

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
    
    //探索中止ボタンの実装
    stopExplorationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopExplorationButton.frame = CGRectMake(10, 10, 100, 30);
    [stopExplorationButton setTitle:@"探索中止" forState:UIControlStateNormal];
    [stopExplorationButton setTitle:@"探索中止" forState:UIControlStateHighlighted];
    // ボタンがタッチされた時にstopExplorationメソッドを呼び出す
    [stopExplorationButton addTarget:self action:@selector(stopExploration)
                    forControlEvents:UIControlEventTouchUpInside];
    
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
    
    backgroundImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backOfACard"]];
    backgroundImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backOfACard"]];
    backgroundImageView1.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    backgroundImageView2.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    cardBox_closed = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 8, [[UIScreen mainScreen] bounds].size.height * 2 + 80 , 17, 32)];
    cardBox_closed.image = [UIImage imageNamed:@"cardBox_closed"];
    
    
    cardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card100_M.JPG"]];
    cardImageView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2 - 16, 60, 32, 48);

    walkingMeter = [[UITextView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 100, 40, 80, 40)];
    
    
    getACardAlertView = [[UIAlertView alloc] initWithTitle:@"カード発見！" message:@"カードを発見しました！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"探索を再開する", nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self startAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [gikoAnimationView startAnimating];
    
    //2枚の背景を次々にアニメーションさせて背景の動きを実現する
    [UIView animateWithDuration:4.0f delay:0.0f options:UIViewAnimationOptionCurveLinear                     animations:^{
        // アニメーションをする処理
        backgroundImageView1.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height * -1, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }completion:^(BOOL finished){
        backgroundImageView1.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        [UIView animateWithDuration:8.0f delay:0.0f options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear                     animations:^{
            // アニメーションをする処理
            backgroundImageView1.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height * -1, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        }completion:^(BOOL finished){
            backgroundImageView1.frame = CGRectMake(0,[[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        }
         ];
    }
     ];
    
    [UIView animateWithDuration:8.0f delay:0.0f options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear
                     animations:^{
        // アニメーションをする処理
        backgroundImageView2.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height * -1, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }completion:^(BOOL finished){
        backgroundImageView2.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
     ];
    
    //カードゲット時間に到達したあとの処理
    [UIView animateWithDuration:8.0f delay:remainedWalkingTime - 2
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
                         timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
                                                                selector:@selector(onTimer:) userInfo:nil repeats:NO];
                     }
     ];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == walkingStartAlertView){
        [self startAnimation];
    }else if (alertView == getACardAlertView){
        remainedWalkingTime = arc4random() % 21 + 30; //探索秒数は30秒〜50秒の間でランダム設定
        [ud setInteger:remainedWalkingTime forKey:@"remainedWalkingTime"];
        [ud synchronize];
        NSLog(@"設定された探索秒数：%d秒",remainedWalkingTime);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)walkingProcess{
    while (remainedWalkingTime > 8) {
        [NSThread sleepForTimeInterval:1.0];
        remainedWalkingTime -= 1;
        NSLog(@"%d", remainedWalkingTime);
    }
}

//アニメーションと並列してカードゲットの歩行時間計算を行う
- (void)walkingTimeCaliculate{
    //アニメーションと並列処理で歩行時間を計測する
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main   = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        
        [self walkingProcess];
        
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
                    [getACardAlertView show];
                }
            }
        ];
    }
    
}

- (void)stopExploration{
    getACardAlertView = nil;
    [ud setInteger:remainedWalkingTime forKey:@"remainedWalkingTime"];
    [ud synchronize];
    [[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
