//
//  Deck2.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/08/23.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "Deck2.h"

@interface Deck2 ()

@end

@implementation Deck2
@synthesize delegate;

- (id)init{
    self = [super init];
    if(self){
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1];
            isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck2];
    }
    return  self;
}

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
    //各カード毎の画像及び所持枚数を表示
    allTxtView = [[UIView alloc] init];
    
    for(int i = 0; i < [app.cardList_pngName count]; i++){
        
        [super openSmallCard:i];
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(25 + (IMGWIDTH) * (int)(i % NUMBEROFIMAGEINRAW) + ((i % NUMBEROFIMAGEINRAW) * 5), 128 + (IMGHEIGHT) * (int)(i / NUMBEROFIMAGEINRAW) + (i / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT)];
        [txtView setFont:[UIFont systemFontOfSize:8]];
        isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck2];
        txtView.text = [NSString stringWithFormat:@"%@枚/%@枚",[isSelectedCards objectAtIndex:i],[app.myCards objectAtIndex:i]];
        UIColor *black = [UIColor blackColor]; //ボタンの背景を透明にするため、とりあえず黒を設定（下で透明化する）
        UIColor *alphaZero = [black colorWithAlphaComponent:0.0]; //黒を透明化
        txtView.backgroundColor = alphaZero;//テキストビューの背景を透明化
        txtView.editable = NO;
        txtView.tag = i;
        [allTxtView addSubview:txtView];
    }
    [allImage addSubview:allTxtView];
    
    
    
    allImage.userInteractionEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    [scrollView addSubview:allImage];
    [self.view addSubview:scrollView];
    
    deckName.delegate = self;
    deckName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"deckName2"];
    
    //　広告の読み込み
    [self.view addSubview:self.nadView];
    [self.nadView load];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToMainView:(id)sender {
    [self.delegate returnToMainView];
}

- (void)cardSelectDecideButtonPushed{
    AudioServicesPlaySystemSound (tapSoundID);
    int numberOfCardsInDeck = 0;
    for(int i = 0; i < [isSelectedCards count] ; i++){
        numberOfCardsInDeck += [[isSelectedCards objectAtIndex:i] intValue];
    }
    NSLog(@"デッキ枚数：%d",numberOfCardsInDeck);
    if(numberOfCardsInDeck <40){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"デッキ枚数不足" message:[NSString stringWithFormat:@"デッキの枚数が40枚以下(%d枚)です",numberOfCardsInDeck]
                                  delegate:self cancelButtonTitle:@"デッキを組み直す" otherButtonTitles:nil];
        [alert show];
    }else{
        [app.myDeck2 removeAllObjects];
        app.myDeck2 = [[NSMutableArray alloc] initWithArray:isSelectedCards];
        NSUserDefaults *tmp = [NSUserDefaults standardUserDefaults];
        [tmp setObject:app.myDeck2 forKey:@"myDeck_ud2"];
        [tmp synchronize];
        NSLog(@"%@",[tmp arrayForKey:@"myDeck_ud2"]);
        
    }
}
- (void)cardSelectCancelButtonPushed{
    isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck2];
    [super cardSelectCancelButtonPushed];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:deckName.text forKey:@"deckName2"];
    [ud synchronize];
    [deckName resignFirstResponder];
    return YES;
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
