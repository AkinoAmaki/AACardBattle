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
    backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    backGroundView.image = [UIImage imageNamed:@"anime"];
    [self.view addSubview:backGroundView];
    
    //コース選択ボタンの実装
    int width = 100;
    int height = 30;
    int w = ([[UIScreen mainScreen] bounds].size.width - 100) / 2;
    int h = 50;
    course1Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    course1Button.frame = CGRectMake(w, h, width, height);
    [course1Button setTitle:@"平地フィールド" forState:UIControlStateNormal];
    [course1Button setTitle:@"平地フィールド" forState:UIControlStateHighlighted];
    course1Button.tag = 1;
    [self.view addSubview:course1Button];
    [course1Button addTarget:self action:@selector(startExploration:)
                    forControlEvents:UIControlEventTouchUpInside];
    h += 50;
    
    course2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    course2Button.frame = CGRectMake(w, h, width, height);
    [course2Button setTitle:@"湖フィールド" forState:UIControlStateNormal];
    [course2Button setTitle:@"湖フィールド" forState:UIControlStateHighlighted];
    course2Button.tag = 2;
    [self.view addSubview:course2Button];
    [course2Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    h += 50;
    
    course3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    course3Button.frame = CGRectMake(w, h, width, height);
    [course3Button setTitle:@"宵闇フィールド" forState:UIControlStateNormal];
    [course3Button setTitle:@"宵闇フィールド" forState:UIControlStateHighlighted];
    course3Button.tag = 3;
    [self.view addSubview:course3Button];
    [course3Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    h += 50;
    
    course4Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    course4Button.frame = CGRectMake(w, h, width, height);
    [course4Button setTitle:@"山岳フィールド" forState:UIControlStateNormal];
    [course4Button setTitle:@"山岳フィールド" forState:UIControlStateHighlighted];
    course4Button.tag = 4;
    [self.view addSubview:course4Button];
    [course4Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    h += 50;
    
    course5Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    course5Button.frame = CGRectMake(w, h, width, height);
    [course5Button setTitle:@"密林フィールド" forState:UIControlStateNormal];
    [course5Button setTitle:@"密林フィールド" forState:UIControlStateHighlighted];
    course5Button.tag = 5;
    [self.view addSubview:course5Button];
    [course5Button addTarget:self action:@selector(startExploration:)
            forControlEvents:UIControlEventTouchUpInside];
    h += 50;
    
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
