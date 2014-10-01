//
//  PBImageView.m
//  PokeBattle
//
//  Created by sakamoto on 2014/08/02.
//  Copyright (c) 2014年 YoshikiAkino. All rights reserved.
//

#import "PBImageView.h"

@implementation PBImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImageNameAndText:(NSString *)image_name textString:(NSString *)textString{
    self = [super initWithImage:[UIImage imageNamed:image_name]];
    if(self){
        // initialization code
        self.userInteractionEnabled = YES;
        self.alpha = 0.8;
        super.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100 , [UIScreen mainScreen].bounds.size.width, 100);
        UITextView *textView = [[UITextView alloc] init];
        [super addSubview:textView];
        textView.userInteractionEnabled = YES;
        textView.editable = NO;
        [PenetrateFilter penetrate:textView];
        textView.frame = CGRectMake(10 , 10, [UIScreen mainScreen].bounds.size.width - 20, 80);
        textView.text = textString;
        [textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)]];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"タッチ");
    //アニメーションの対象となるコンテキスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //アニメーションを実行する時間
    [UIView setAnimationDuration:0.2];
    //アニメーションイベントを受け取るview
    [UIView setAnimationDelegate:self];
    //アニメーション終了後に実行される
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    
    self.alpha = 0.0;
    
    // アニメーション開始
    [UIView commitAnimations];
}

/* 名刺バトラーからのコピペ
- (void)startAnimation{
    //_dungeonListView.frame = CGRectMake(320, 50, 320, self.frame.size.height-50);
    
    CGRect list_frame = _dungeonListView.frame;
    list_frame.origin.x = 0;
    
    //アニメーションの対象となるコンテキスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //アニメーションを実行する時間
    [UIView setAnimationDuration:0.2];
    //アニメーションイベントを受け取るview
    [UIView setAnimationDelegate:self];
    //アニメーション終了後に実行される
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    title.frame = CGRectMake(-5, 4, 310, 40);
    _dungeonListView.frame = CGRectMake(0, 50, 320, self.frame.size.height-50);
    
    // アニメーション開始
    [UIView commitAnimations];
}
 */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
