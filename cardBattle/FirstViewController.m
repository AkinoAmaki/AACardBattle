//
//  FirstViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/15.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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
    app = [[UIApplication sharedApplication] delegate];
    deactivateFinished = NO;
    
    NSString *backGroundImagePath = [[NSBundle mainBundle] pathForResource:@"backOfACard" ofType:@"png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:backGroundImagePath]];
    imageView.frame = CGRectMake(0, 0, 320, 480);
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToMainView)]];
    [self.view addSubview:imageView];
}

- (void)moveToMainView{
//    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    [self performSelector:@selector(moveToMainView2) withObject:nil afterDelay:0.1];
}

- (void)moveToMainView2{
//    [self deactivate];
    [self performSegueWithIdentifier:@"goToMainView" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)activate{
    NSLog(@"あくてぃべーと");
    activateOrDeactivate = YES;
    [self activateFunction:YES];
}

-(void)deactivate{
    NSLog(@"でぃあくてぃべーと");
    activateOrDeactivate = NO;
    [self activateFunction:NO];
}

- (void)activateFunction:(BOOL)activate{
    
    //一旦配列に直した上でディクショナリ化する（配列１つ分のディクショナリとして格納される）。こうした場合、サーバ側の処理が楽になる。
    NSArray *arrayParameter = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:app.playerID],[NSNumber numberWithBool:activate],  nil];
    
    NSArray *arrayKey = [[NSArray alloc] initWithObjects:@"playerID",@"activate", nil];
    
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:arrayParameter forKeys:arrayKey];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = @"http://utakatanet.dip.jp:58080/activate.php";
    
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *result;
    result= [NSURLConnection sendSynchronousRequest:request
                                  returningResponse:&response
                                              error:&error];
    
    //データがgetできなければ、0.5秒待ったあとに再度get処理する
    int loop = 0;
    while (!result) {
        [NSThread sleepForTimeInterval:0.5];
        result= [NSURLConnection sendSynchronousRequest:request
                                      returningResponse:&response
                                                  error:&error];
        NSLog(@"再度get処理実行中...");
        if(loop == 10){
            [SVProgressHUD popActivity];
            notFoundForInternetBattle = [[UIAlertView alloc] initWithTitle:@"通信不能" message:@"通信できませんでした。電波が弱いか、サーバが応答していません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [notFoundForInternetBattle show];
            return;
        }
        loop++;
    }
    
    NSString *string = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
    if([string hasPrefix:@"timeout"]){
        [SVProgressHUD popActivity];
        notFoundForInternetBattle = [[UIAlertView alloc] initWithTitle:@"通信不能" message:@"通信できませんでした。電波が弱いか、サーバが応答していません" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [notFoundForInternetBattle show];
    }else{
        NSLog(@"アクティベート or ディアクティベート完了");
        deactivateFinished = YES;
        [SVProgressHUD popActivity];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == notFoundForInternetBattle){
        FINISHED1
        if(activateOrDeactivate){
            [self activate];
        }else{
            [self deactivate];
        }
    }
}

- (void)sync{
    syncFinished = NO;
    while (!syncFinished) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
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
