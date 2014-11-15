//
//  PBImageView.m
//  PokeBattle
//
//  Created by sakamoto on 2014/08/02.
//  Copyright (c) 2014年 YoshikiAkino. All rights reserved.
//

#import "PBImageView.h"

@implementation PBImageView
@synthesize textView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImageNameAndText:(NSString *)image_name imagePath:(NSString *)imagePath textString:(NSString *)textString characterIsOnLeft:(BOOL)characterIsOnLeft{
    self = [super initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"whiteBack" ofType:@"png"]]];
    if(self){
        // initialization code
        self.userInteractionEnabled = YES;
        super.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100 , [UIScreen mainScreen].bounds.size.width, 100);
        
        textView = [[UITextView alloc] init];
        [super addSubview:textView];
        [textView setFont:[UIFont systemFontOfSize:16.0f]];
        textView.userInteractionEnabled = YES;
        textView.editable = NO;
        [PenetrateFilter penetrate:textView];
        textView.text = textString;
        
        UIImageView *characterAnimation = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:image_name ofType:imagePath]]];
        [PenetrateFilter penetrate:characterAnimation];
        characterAnimation.contentMode = UIViewContentModeScaleAspectFit;
        [super addSubview:characterAnimation];
        if (characterIsOnLeft) {
            textView.frame = CGRectMake(105 , 5, [UIScreen mainScreen].bounds.size.width - 110, 90);
            characterAnimation.frame = CGRectMake(0, 0, 100, 100);
        }else{
            textView.frame = CGRectMake(5 , 5, [UIScreen mainScreen].bounds.size.width - 110, 90);
            characterAnimation.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 100, 100);
        }
    }
    
    //最前面に来ているビューコントローラを取得
    rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
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

@end
