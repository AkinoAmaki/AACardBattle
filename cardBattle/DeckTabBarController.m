//
//  DeckTabBarController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/08/23.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "DeckTabBarController.h"

@interface DeckTabBarController ()

@end

@implementation DeckTabBarController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //タブバーを設置
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    tab1 = [[Deck1 alloc] init];
    tab2 = [[Deck2 alloc] init];
    tab3 = [[Deck3 alloc] init];
    NSArray *tabs = [NSArray arrayWithObjects:tab1, tab2, tab3, nil];
    tabController = [[UITabBarController alloc] init];
    [tabController setViewControllers:tabs animated:NO];
    [_window addSubview:tabController.view];
    [self.window makeKeyAndVisible];
    
    tab1.delegate = self;
    tab2.delegate = self;
    tab3.delegate = self;
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
 *//**
    * デリゲートメソッドその1を実装
    */
- (void)returnToMainView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
