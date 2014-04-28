//
//  DeckViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/03/11.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "DeckViewController.h"


@interface DeckViewController ()

@end

@implementation DeckViewController

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
    _isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck];
    
    
    allImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1704)];
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = allImage.bounds.size;
    
    UIImage *decideButton = [UIImage imageNamed:@"cardselectdecidebutton.png"];
    UIImageView *cardSelectDecideButton = [[UIImageView alloc] initWithFrame:CGRectMake(200, 30, 50, 20)];
    cardSelectDecideButton.image = decideButton;
    [allImage addSubview:cardSelectDecideButton];
    cardSelectDecideButton.userInteractionEnabled = YES;
    [cardSelectDecideButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(cardSelectDecideButtonPushed)]];
    
    
    UIImage *cancelButton = [UIImage imageNamed:@"cardselectcancelbutton.png"];
    UIImageView *cardSelectCancelButton = [[UIImageView alloc] initWithFrame:CGRectMake(140, 30, 50, 20)];
    cardSelectCancelButton.image = cancelButton;
    [allImage addSubview:cardSelectCancelButton];
    cardSelectCancelButton.userInteractionEnabled = YES;
    [cardSelectCancelButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(cardSelectCancelButtonPushed)]];
    
    for(int i = 0; i < [app.cardList_pngName count]; i++){
        
        [self openSmallCard:i];
        
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(25 + (IMGWIDTH) * (int)(i % NUMBEROFIMAGEINRAW) + ((i % NUMBEROFIMAGEINRAW) * 5), 128 + (IMGHEIGHT) * (int)(i / NUMBEROFIMAGEINRAW) + (i / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT)];
        [txtView setFont:[UIFont systemFontOfSize:8]];
        
        UIColor *black = [UIColor blackColor]; //ボタンの背景を透明にするため、とりあえず黒を設定（下で透明化する）
        UIColor *alphaZero = [black colorWithAlphaComponent:0.0]; //黒を透明化
        txtView.backgroundColor = alphaZero;//テキストビューの背景を透明化
        
        txtView.text = [NSString stringWithFormat:@"%@枚/%@枚",[_isSelectedCards objectAtIndex:i],[app.myCards objectAtIndex:i]];
        txtView.userInteractionEnabled = NO;
        [txtView addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(touchAction:)]];
        [txtView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAcrion:)]];
        txtView.editable = NO;
        txtView.tag = i;
        [allImage addSubview:txtView];
    }
    allImage.userInteractionEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    [scrollView addSubview:allImage];
    [self.view addSubview:scrollView];
    
    changeOfACardCount = 0;
    detailOfACardCount = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchAction: (UITapGestureRecognizer *)sender{
    NSLog(@"タッチ感知 from %ld",sender.view.tag);

    if ([[_isSelectedCards objectAtIndex:sender.view.tag] intValue] == 4 || [[_isSelectedCards objectAtIndex:sender.view.tag] intValue] == [[app.myCards objectAtIndex:sender.view.tag] intValue]) {
        [_isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:0]];
    }else{
        int i = [[_isSelectedCards objectAtIndex:sender.view.tag] intValue];
        i++;
        [_isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:i]];
    }
    
    [allImage removeFromSuperview];
    for(int i = 0; i < [app.cardList_pngName count]; i++){
        
        [self openSmallCard:i];
        
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(25 + (IMGWIDTH) * (int)(i % NUMBEROFIMAGEINRAW) + ((i % NUMBEROFIMAGEINRAW) * 5), 128 + (IMGHEIGHT) * (int)(i / NUMBEROFIMAGEINRAW) + (i / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT)];
        [txtView setFont:[UIFont systemFontOfSize:8]];
        
        UIColor *black = [UIColor blackColor]; //ボタンの背景を透明にするため、とりあえず黒を設定（下で透明化する）
        UIColor *alphaZero = [black colorWithAlphaComponent:0.0]; //黒を透明化
        txtView.backgroundColor = alphaZero;//テキストビューの背景を透明化
        
        txtView.text = [NSString stringWithFormat:@"%@枚/%@枚",[_isSelectedCards objectAtIndex:i],[app.myCards objectAtIndex:i]];
        txtView.userInteractionEnabled = NO;
        [txtView addGestureRecognizer:
         [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(touchAction:)]];
        [txtView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAcrion:)]];
        txtView.editable = NO;
        txtView.tag = i;
        [allImage addSubview:txtView];
    }
    allImage.userInteractionEnabled = YES;
    scrollView.userInteractionEnabled = YES;    
    [scrollView addSubview:allImage];
    [self.view addSubview:scrollView];
    

    
    NSLog(@"カードナンバー%dの所持カード数：%d",sender.view.tag,[[app.myCards objectAtIndex:sender.view.tag] intValue]);
    NSLog(@"デッキに入っているカードナンバー%dの枚数:%d",sender.view.tag , [[_isSelectedCards objectAtIndex:sender.view.tag] intValue]);

}

- (void)cardSelectDecideButtonPushed{
    int numberOfCardsInDeck = 0;
    for(int i = 0; i < [_isSelectedCards count] ; i++){
        numberOfCardsInDeck += [[_isSelectedCards objectAtIndex:i] intValue];
    }
    NSLog(@"デッキ枚数：%d",numberOfCardsInDeck);
    if(numberOfCardsInDeck <40){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"デッキ枚数不足" message:[NSString stringWithFormat:@"デッキの枚数が40枚以下(%d枚)です",numberOfCardsInDeck]
                                  delegate:self cancelButtonTitle:@"デッキを組み直す" otherButtonTitles:nil];
        [alert show];
    }else{
        [app.myDeck removeAllObjects];
        app.myDeck = [[NSMutableArray alloc] initWithArray:_isSelectedCards];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:app.myDeck forKey:@"myDeck_ud"];
        [ud synchronize];
        NSLog(@"%@",[ud arrayForKey:@"myDeck_ud"]);
        
    }
}

- (void)cardSelectCancelButtonPushed{
    _isSelectedCards = [[NSMutableArray alloc] initWithArray:app.myDeck];
    NSLog(@"%@",_isSelectedCards);
}



- (void)longTouchAcrion:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"感知 from %ld",sender.view.tag);
    if(detailOfACardCount == 0){
        [self detailOfACard:sender.view.tag];
        detailOfACardCount = 1;
    }
}

- (void)detailOfACard:(int)tagNum{
    
    _detailOfACard = [[UIImageView alloc] initWithFrame:CGRectMake(40, scrollView.contentOffset.y + 40, 240, 360)];
    _detailOfACard.image = [UIImage imageNamed:@"detailImage.png"];
    [scrollView addSubview:_detailOfACard];
    [self putACancelButton:CGRectMake(45,scrollView.contentOffset.y + 45, 25, 25)];
    [self touchesPermittion:NO];
}

- (void)putACancelButton:(CGRect)rect{
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancelButton.png"] forState:UIControlStateNormal];
    cancelButton.frame = rect;
    [cancelButton addTarget:self action:@selector(cancelButtonTouched:)
  forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cancelButton];
}

- (void) touchesPermittion:(BOOL)permit{
    if(permit == YES){
        [scrollView setScrollEnabled:YES];
        allImage.userInteractionEnabled = YES;
    }else{
        [scrollView setScrollEnabled:NO];
        allImage.userInteractionEnabled = NO;
    }
}

- (void)cancelButtonTouched:(UIButton *)sender{
    [sender removeFromSuperview];
    [_detailOfACard removeFromSuperview];
    [self touchesPermittion:YES];
    detailOfACardCount = 0;
    
}

- (void)openSmallCard:(int)i{
    
    UIImage *img;
    if([[app.myCards objectAtIndex:i] intValue] == 0){
        img = [UIImage imageNamed:@"question.png"];
    }else{
        img = [UIImage imageNamed:[app.cardList_pngName objectAtIndex:i]];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchAction:)]];
    [imgView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAcrion:)]];
    imgView.frame = CGRectMake(20 + (IMGWIDTH) * (int)(i % NUMBEROFIMAGEINRAW) + ((i % NUMBEROFIMAGEINRAW) * 5), 100 + (IMGHEIGHT) * (int)(i / NUMBEROFIMAGEINRAW) + (i / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT);
    imgView.tag = i;
    [allImage addSubview:imgView];
}

@end
