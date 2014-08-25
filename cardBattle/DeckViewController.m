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

@synthesize selectedCards;
@synthesize isSelectedCards;
@synthesize detailOfACard;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //AppDelegateの呼び出し
    app = [[UIApplication sharedApplication] delegate];
    
    allImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 160 + NUMBEROFCARDS / 2 * (IMGHEIGHT + 5))];
    
    
    //スクロールビューの設定
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = allImage.bounds.size;
    
    
    //決定ボタンを実装
    UIImage *decideButton = [UIImage imageNamed:@"cardselectdecidebutton.png"];
    UIImageView *cardSelectDecideButton = [[UIImageView alloc] initWithFrame:CGRectMake(200, 50, 50, 20)];
    cardSelectDecideButton.image = decideButton;
    [allImage addSubview:cardSelectDecideButton];
    cardSelectDecideButton.userInteractionEnabled = YES;
    [cardSelectDecideButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(cardSelectDecideButtonPushed)]];
    
    //キャンセルボタンを実装
    UIImage *cancelButton = [UIImage imageNamed:@"cardselectcancelbutton.png"];
    UIImageView *cardSelectCancelButton = [[UIImageView alloc] initWithFrame:CGRectMake(140, 50, 50, 20)];
    cardSelectCancelButton.image = cancelButton;
    [allImage addSubview:cardSelectCancelButton];
    cardSelectCancelButton.userInteractionEnabled = YES;
    [cardSelectCancelButton addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(cardSelectCancelButtonPushed)]];
    
    _returnToMainViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_returnToMainViewButton setTitle:@"戻る" forState:UIControlStateNormal];
    [allImage addSubview:_returnToMainViewButton];
    _returnToMainViewButton.frame = CGRectMake(20,35, 30, 50);
    [_returnToMainViewButton addTarget:self action:@selector(returnToMainView:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    changeOfACardCount = 0;
    detailOfACardCount = 0;
    detailOfACard = [[UIImageView alloc] initWithFrame:CGRectMake(40, scrollView.contentOffset.y + 40, 240, 360)];
    
    
    //デッキ名入れるテキスト画面入れる
    UILabel *deckNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 50, 30)];
    deckNameLabel.text = @"デッキ名";
    deckNameLabel.adjustsFontSizeToFitWidth = YES;
    [allImage addSubview:deckNameLabel];
    deckName = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, [[UIScreen mainScreen] bounds].size.width - 80, 30)];
    deckName.textAlignment = NSTextAlignmentCenter;
    deckName.clearButtonMode = UITextFieldViewModeAlways;
    deckName.borderStyle = UITextBorderStyleBezel;
    [allImage addSubview:deckName];
    
    
    
    
    //カードタップ音
    mainBundle = CFBundleGetMainBundle ();
    tapSoundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("se_maoudamashii_system49"),CFSTR ("mp3"),NULL);
    AudioServicesCreateSystemSoundID (tapSoundURL, &tapSoundID);
    CFRelease (tapSoundURL);
    //キャンセルボタンタップ音
    cancelSoundURL  = CFBundleCopyResourceURL (mainBundle,CFSTR ("se_maoudamashii_system10"),CFSTR ("mp3"),NULL);
    AudioServicesCreateSystemSoundID (cancelSoundURL, &cancelSoundID);
    CFRelease (cancelSoundURL);
}

- (void) touchAction: (UITapGestureRecognizer *)sender{
    NSLog(@"タッチ感知 from %d",sender.view.tag);
    
    if ([[isSelectedCards objectAtIndex:sender.view.tag] intValue] == 4 || [[isSelectedCards objectAtIndex:sender.view.tag] intValue] == [[app.myCards objectAtIndex:sender.view.tag] intValue]) {
        [isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:0]];
    }else{
        int i = [[isSelectedCards objectAtIndex:sender.view.tag] intValue];
        i++;
        [isSelectedCards replaceObjectAtIndex:sender.view.tag withObject:[NSNumber numberWithInt:i]];
    }
    
    UITextView *tmpTextView = (UITextView *)[allTxtView viewWithTag:sender.view.tag];
    tmpTextView.text = [NSString stringWithFormat:@"%@枚/%@枚",[isSelectedCards objectAtIndex:sender.view.tag],[app.myCards objectAtIndex:sender.view.tag]];
    [[allTxtView viewWithTag:sender.view.tag] removeFromSuperview];
    tmpTextView.tag = sender.view.tag;
    [allTxtView addSubview:tmpTextView];
    
    NSLog(@"カードナンバー%dの所持カード数：%d",sender.view.tag,[[app.myCards objectAtIndex:sender.view.tag] intValue]);
    NSLog(@"デッキに入っているカードナンバー%dの枚数:%d",sender.view.tag , [[isSelectedCards objectAtIndex:sender.view.tag] intValue]);
    
}

- (void)cardSelectDecideButtonPushed{
    //子クラスで実装
}

- (void)cardSelectCancelButtonPushed{
    AudioServicesPlaySystemSound (cancelSoundID);
    NSLog(@"%@",isSelectedCards);
    
    for (UIView *view in allTxtView.subviews) {
        [view removeFromSuperview];
    }
    
    for(int i = 0; i < [app.cardList_pngName count]; i++){
        
        [self openSmallCard:i];
        
        txtView = [[UITextView alloc] initWithFrame:CGRectMake(25 + (IMGWIDTH) * (int)(i % NUMBEROFIMAGEINRAW) + ((i % NUMBEROFIMAGEINRAW) * 5), 128 + (IMGHEIGHT) * (int)(i / NUMBEROFIMAGEINRAW) + (i / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT)];
        [txtView setFont:[UIFont systemFontOfSize:8]];
        
        UIColor *black = [UIColor blackColor]; //ボタンの背景を透明にするため、とりあえず黒を設定（下で透明化する）
        UIColor *alphaZero = [black colorWithAlphaComponent:0.0]; //黒を透明化
        txtView.backgroundColor = alphaZero;//テキストビューの背景を透明化
        
        txtView.text = [NSString stringWithFormat:@"%@枚/%@枚",[isSelectedCards objectAtIndex:i],[app.myCards objectAtIndex:i]];
        txtView.editable = NO;
        txtView.tag = i;
        [allTxtView addSubview:txtView];
    }
    [allImage addSubview:allTxtView];
}

- (void)longTouchAcrion:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"感知 from %d",sender.view.tag);
    detailOfACard.image = [UIImage imageNamed:[NSString stringWithFormat:@"card%d",(int)sender.view.tag]];
    [self.view addSubview:detailOfACard];
    detailOfACard.userInteractionEnabled = YES;
    [detailOfACard addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(removeDetailOfACard)]];
    [self touchesPermittion:NO];
}

- (void)removeDetailOfACard{
    NSLog(@"うん");
    [detailOfACard removeFromSuperview];
    [self touchesPermittion:YES];
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
    if(permit){
        [scrollView setScrollEnabled:YES];
        allImage.userInteractionEnabled = YES;
    }else{
        [scrollView setScrollEnabled:NO];
        allImage.userInteractionEnabled = NO;
    }
}

- (void)cancelButtonTouched:(UIButton *)sender{
    [sender removeFromSuperview];
    [detailOfACard removeFromSuperview];
    [self touchesPermittion:YES];
    detailOfACardCount = 0;
    
}

- (void)openSmallCard:(int)i{
    
    UIImage *img;
    if([[app.myCards objectAtIndex:i] intValue] == 0){
        img = [UIImage imageNamed:@"question.png"];
    }else{
        img = [UIImage imageNamed:[NSString stringWithFormat:@"%@_D.JPG",[app.cardList_pngName objectAtIndex:i]]];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(touchAction:)]];
    [imgView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAcrion:)]];
    imgView.frame = CGRectMake(10 + (IMGWIDTH) * (int)(i % NUMBEROFIMAGEINRAW) + ((i % NUMBEROFIMAGEINRAW) * 5), 100 + (IMGHEIGHT) * (int)(i / NUMBEROFIMAGEINRAW) + (i / NUMBEROFIMAGEINRAW * 5), IMGWIDTH, IMGHEIGHT);
    imgView.tag = i;
    [allImage addSubview:imgView];
}





@end

