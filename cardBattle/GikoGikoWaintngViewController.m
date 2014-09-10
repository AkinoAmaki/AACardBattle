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
}

- (void)viewDidAppear:(BOOL)animated{
    waiting = [[WaitingForInternetBattleViewController alloc] init];
    [NSThread sleepForTimeInterval:1.0];
    [self presentViewController:waiting animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
