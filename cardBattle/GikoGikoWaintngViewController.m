//
//  GikoGikoWaintngViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "GikoGikoWaintngViewController.h"

@interface GikoGikoWaintngViewController ()

@end

@implementation GikoGikoWaintngViewController
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
    
    
    
    // Do any additional setup after loading the view.
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    image.image = [UIImage imageNamed:@"blackBack"];
    [self.view addSubview:image];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissGikoGikoViewController)
                                                 name:@"dismissGikoGikoViewController"
                                               object:nil];
    explorationIsFinished = NO;
    
    [self startLoadingAnimation];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    if (!explorationIsFinished) {
        waiting = [[WaitingForInternetBattleViewController alloc] init];
        waiting.course = self.course;
        [NSThread sleepForTimeInterval:5.0];
        [self presentViewController:waiting animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sync{
    syncFinished = NO;
    while (!syncFinished) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == usingDeckCardList){
        FINISHED
    }
}

- (void)dismissGikoGikoViewController{
    NSLog(@"ちぇっく３");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    explorationIsFinished = YES;
}

- (void)startLoadingAnimation{
    //各種アニメーション用画像を配列にセット
    int randomNum = arc4random() % 10 + 1;
    
    NSArray *animationArray;
    switch (randomNum) {
        case 1:
             animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation1_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation1_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation1_3" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation1_4" ofType:@"png"]], nil];
            break;
        case 2:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation2_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation2_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation2_3" ofType:@"png"]], nil];
            break;
        case 3:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation3_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation3_2" ofType:@"png"]], nil];
            break;
        case 4:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation4_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation4_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation4_3" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation4_4" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation4_5" ofType:@"png"]], nil];
            break;
        case 5:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation5_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation5_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation5_3" ofType:@"png"]], nil];
            break;
        case 6:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation6_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation6_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation6_3" ofType:@"png"]], nil];
            break;
        case 7:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation7_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation7_2" ofType:@"png"]], nil];
            break;
        case 8:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation8_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation8_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation8_3" ofType:@"png"]], nil];
            break;
        case 9:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation9_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation9_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation9_3" ofType:@"png"]], nil];
            break;
        case 10:
            animationArray = [[NSArray alloc] initWithObjects:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation10_1" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation10_2" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation10_3" ofType:@"png"]],[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gikoAnimation10_4" ofType:@"png"]], nil];
            break;
        default:
            break;
    }
    
    UIImage *tmpImage = [animationArray objectAtIndex:0];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - tmpImage.size.width - 10, [UIScreen mainScreen].bounds.size.height - tmpImage.size.height - 10, tmpImage.size.width, tmpImage.size.height)];
    
    // アニメーション用画像をセット
    imageView.animationImages = animationArray;
    
    // アニメーションの速度
    imageView.animationDuration = [animationArray count] * 2.0;
    
    // アニメーションのリピート回数
    imageView.animationRepeatCount = 0;
    
    [self.view addSubview:imageView];
    
    [imageView startAnimating];

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
