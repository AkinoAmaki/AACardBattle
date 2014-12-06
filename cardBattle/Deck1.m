//
//  Deck1.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/08/23.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "Deck1.h"

@interface Deck1 ()

@end

@implementation Deck1
@synthesize delegate;

- (id)init{
    self = [super init];
    if(self){
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"デッキ1" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"border_color-26" ofType:@"png"]] tag:1];
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
    isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck1];
    //各カード毎の画像及び所持枚数を表示
    allTxtView = [[UIView alloc] init];
    
    for(int i = 1; i < [app.cardList_pngName count]; i++){
        
        [super openSmallCard:i];
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(25 + (IMGWIDTH) * (int)((i - 1) % NUMBEROFIMAGEINRAW) + (((i - 1) % NUMBEROFIMAGEINRAW) * 5), 158 + (IMGHEIGHT) * (int)((i - 1) / NUMBEROFIMAGEINRAW) + ((i - 1) / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT)];
        [txtView setFont:[UIFont systemFontOfSize:8]];
        isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck1];
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
    deckName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"deckName1"];
    
    deckEditHasFinished = NO; //NOのままならトップ画面に戻るときに警告を出す。（デッキ編成確定ボタンを押してないってことだから。）
    
    //　広告の読み込み
    [self.view addSubview:self.nadView];
    [self.nadView load];
    
    
    //初回起動ならプロローグを表示
    int first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
    NSLog(@"%d",first);
    if (first == 1) {
        [self startAnimation142];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToMainView:(id)sender {
    if (!deckEditHasFinished) {
        deckEditHasFinishedAlert = [[UIAlertView alloc] initWithTitle:@"デッキ編成未完了" message:@"デッキ編成がまだ終わっていません。\n本当にトップ画面に戻ってよろしいですか？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"よろしい", @"よろしくない", nil];
        [deckEditHasFinishedAlert show];
    }else{
        [self.delegate returnToMainView];
    }
}

- (void)cardSelectDecideButtonPushed{
    AudioServicesPlaySystemSound (tapSoundID);
    int numberOfCardsInDeck = 0;
    for(int i = 1; i < [isSelectedCards count] ; i++){
        numberOfCardsInDeck += [[isSelectedCards objectAtIndex:i] intValue];
    }
    NSLog(@"デッキ枚数：%d",numberOfCardsInDeck);
    if(numberOfCardsInDeck <40){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"デッキ枚数不足" message:[NSString stringWithFormat:@"デッキの枚数が40枚以下(%d枚)です",numberOfCardsInDeck]
                                  delegate:self cancelButtonTitle:@"デッキを組み直す" otherButtonTitles:nil];
        [alert show];
    }else{
        [app.myDeck1 removeAllObjects];
        app.myDeck1 = [[NSMutableArray alloc] initWithArray:isSelectedCards];
        NSUserDefaults *tmp = [NSUserDefaults standardUserDefaults];
        [tmp setObject:app.myDeck1 forKey:@"myDeck_ud1"];
        [tmp synchronize];
        NSLog(@"%@",[tmp arrayForKey:@"myDeck_ud1"]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"デッキ編成完了" message:[NSString stringWithFormat:@"デッキの編成を確定しました。デッキ総枚数は%d枚です。",numberOfCardsInDeck] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        deckEditHasFinished = YES;
        
        //初回起動ならプロローグを表示
        int first =  [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch_ud"];
        if (first == 1) {
            [self startAnimation149];
        }
    }
}
- (void)cardSelectCancelButtonPushed{
    isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck1];
    [super cardSelectCancelButtonPushed];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:deckName.text forKey:@"deckName1"];
    [ud synchronize];
    [deckName resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == deckEditHasFinishedAlert){
        switch (buttonIndex) {
            case 0:
                [self.delegate returnToMainView];
                break;
            case 1:
                break;
        }
    }
}

//-------------------------プロローグ改定案ここから-------------------------//

- (void)startAnimation142{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"さて、この画面では、合計で３つまでデッキを持て、編成ができる。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation143)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation143)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
    [app.blackBack removeFromSuperview];
    app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:allImage.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:nil] coveredView:allImage];
    [allImage addSubview:app.blackBack];
}
- (void)startAnimation143{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"デッキは最低でも60枚以上で組まないといけないぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation143_2)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation143_2)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation143_2{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それとエネルギーカード以外は１種類につき４枚までしかデッキに入れられないから注意が必要だ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation144)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation144)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation144{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"試しにさっき手に入れたカードをデッキに入れてみよう。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation145)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation145)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation145{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:[NSString stringWithFormat:@"確か手に入れたカードは「%@」って名前だったな。", [app.cardList_cardName objectAtIndex:app.cardIGotInTheLastMatch]]  characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation146)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation146)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
    UIImageView *cardImageView = (UIImageView *)[allImage viewWithTag:app.cardIGotInTheLastMatch];
    [app.blackBack changeFrame:cardImageView.frame coveredView:allImage];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation146{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"デッキに新しいカードを入れるには、カードの画像をタップすればいい。›" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation147)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation147)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation147{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"ちなみにロングタップすれば、カードを拡大して表示することが出来るぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation148)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation148)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation148{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあ実際にカードをデッキに入れてみよう。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation149{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"よし、カードがデッキに入ったな。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation150)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation150)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
}
- (void)startAnimation150{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro3" imagePath:@"png" textString:@"それじゃあ戻るボタンを押して、メイン画面に戻ってくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
    app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
    [app.blackBack changeFrame:allImage.frame coveredView:allImage];
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"firstLaunch_ud"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}                                                                           
//-------------------------プロローグ改定案ここまで-------------------------//

- (void)removeViewOnPrologue:(UITapGestureRecognizer *)sender{
    for (UIView *view in app.pbImage.subviews) {
        [view removeFromSuperview];
    }
    [app.pbImage removeFromSuperview];
}

                                                                           
//- (void)startAnimation142{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro141" imagePath:@"png" textString:@"それじゃあこれからデッキ編成の説明を始めるぞ" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation143)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation143)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//   [app.blackBack removeFromSuperview];
//   app.blackBack = [[IntroductionTool alloc] initForHighlightingViewMethod:allImage.frame forbidTapActionViewArray:[[NSArray alloc] initWithObjects:nil] coveredView:allImage];
//   [allImage addSubview:app.blackBack];
//}
//- (void)startAnimation143{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro142" imagePath:@"png" textString:@"この説明が終われば、ひとまず全体的な説明はおしまいだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation144)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation144)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation144{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro143" imagePath:@"png" textString:@"分かったお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation145)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation145)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation145{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro144" imagePath:@"png" textString:@"さて、この画面では、合計で３つまでデッキを持て、編成ができる。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation146)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation146)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation146{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro143" imagePath:@"png" textString:@"「？」が表示されているのはなんだお？" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation147)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation147)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation147{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro144" imagePath:@"png" textString:@"「？」が表示されているカードはまだ未発見のカードだ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation148)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation148)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation148{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro147" imagePath:@"png" textString:@"デッキは最低４０枚以上で、エネルギーカード以外は１種類につき最大４枚までしかデッキに入れられない。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation149)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation149)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation149{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro148" imagePath:@"png" textString:@"さて、試しにさっき手に入れたカードをデッキに入れてみよう。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation150)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation150)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation150{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro150" imagePath:@"png" textString:@"デッキに新しいカードを入れるには、カードの画像をタップすればいい。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation151)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation151)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation151{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro150" imagePath:@"png" textString:@"ちなみにロングタップすれば、カードを拡大して表示することが出来るぞ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation152)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation152)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation152{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro152" imagePath:@"png" textString:@"やってみるお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation153)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation153)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation153{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro152" imagePath:@"png" textString:[NSString stringWithFormat:@"確かやる夫が手に入れたのは「%@」ってカードだったお。", [app.cardList_cardName objectAtIndex:app.cardIGotInTheLastMatch]] characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//   UIImageView *cardImageView = (UIImageView *)[allImage viewWithTag:app.cardIGotInTheLastMatch];
//   [app.blackBack changeFrame:cardImageView.frame coveredView:allImage];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//
//
//- (void)startAnimation157{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro156" imagePath:@"png" textString:@"あ、終わったみたいだお。" characterIsOnLeft:YES];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation158)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation158)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//}
//- (void)startAnimation158{[app.pbImage removeFromSuperview];app.pbImage = [[PBImageView alloc] initWithImageNameAndText:@"pro157" imagePath:@"png" textString:@"それじゃあ戻るボタンを押して、メイン画面に戻ってくれ。" characterIsOnLeft:NO];[self.view addSubview:app.pbImage];[app.pbImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];[app.pbImage.textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewOnPrologue:)]];
//   app.pbImage.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 100);
//   [app.blackBack changeFrame:allImage.frame coveredView:allImage];
//   [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"firstLaunch_ud"];
//   [[NSUserDefaults standardUserDefaults] synchronize];
//}

                                                                           
                                                                           
                                                                           
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
