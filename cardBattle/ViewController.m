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
    ud = [NSUserDefaults standardUserDefaults];
    int first =  [ud integerForKey:@"firstLaunch_ud"];
    NSLog(@"%d",first);
    
    if(first == 0){
        appdelegate = [[UIApplication sharedApplication] delegate];
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
        [ud setInteger:1 forKey:@"firstLaunch_ud"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 -(BOOL)textFieldShouldReturn:(UITextField*)textField{
     ud = [NSUserDefaults standardUserDefaults];
     [ud setObject:tf.text forKey:@"myNickName_ud"];
     [ud synchronize];
     appdelegate.myNickName = [ud objectForKey:@"myNickName_ud"];
     NSLog(@"ニックネーム：%@",appdelegate.myNickName);
     [tf resignFirstResponder];
     [firstLaunchView removeFromSuperview];
     return YES;
 }



@end
