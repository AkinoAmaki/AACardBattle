//
//  IntroductionTool.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/10/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "IntroductionTool.h"

@implementation IntroductionTool
@synthesize forbidTapActionArray;
@synthesize blackBack1;
@synthesize blackBack2;
@synthesize blackBack3;
@synthesize blackBack4;
@synthesize blackBack5;
@synthesize blackBack6;
@synthesize blackBack7;
@synthesize blackBack8;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//イントロダクション時に、画面のうち特定の部分を強調する際に使用するメソッド（特定したフレーム以外の画面を黒半透明のビューで覆う）

- (id)initForHighlightingViewMethod:(CGRect)frame forbidTapActionViewArray:(NSArray *)array{
    self = [super init];
    if (self) {
        // Initialization code
        
        //8枚の黒半透明の画像を使用して強調を実現する
        //1枚目（左上）
        blackBack1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.origin.x, frame.origin.y)];
        //2枚目（真上）
        blackBack2 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.origin.y)];
        //3枚目（右上）
        blackBack3 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width, 0, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), frame.origin.y)];
        //4枚目（真ん中左）
        blackBack4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.origin.y, frame.origin.x, frame.size.height)];
        //5枚目（真ん中右）
        blackBack5 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), frame.size.height)];
        //6枚目（左下）
        blackBack6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.origin.y + frame.size.height, frame.origin.x, [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height))];
        //7枚目（真下）
        blackBack7 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height))];
        //8枚目（右下）
        blackBack8 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height))];
        
        UIImage *backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackBack" ofType:@"png"]];
        blackBack1.image = backImage;
        blackBack2.image = backImage;
        blackBack3.image = backImage;
        blackBack4.image = backImage;
        blackBack5.image = backImage;
        blackBack6.image = backImage;
        blackBack7.image = backImage;
        blackBack8.image = backImage;
        
        blackBack1.alpha = 0.8f;
        blackBack2.alpha = 0.8f;
        blackBack3.alpha = 0.8f;
        blackBack4.alpha = 0.8f;
        blackBack5.alpha = 0.8f;
        blackBack6.alpha = 0.8f;
        blackBack7.alpha = 0.8f;
        blackBack8.alpha = 0.8f;
        
        blackBack1.userInteractionEnabled = NO;
        blackBack2.userInteractionEnabled = NO;
        blackBack3.userInteractionEnabled = NO;
        blackBack4.userInteractionEnabled = NO;
        blackBack5.userInteractionEnabled = NO;
        blackBack6.userInteractionEnabled = NO;
        blackBack7.userInteractionEnabled = NO;
        blackBack8.userInteractionEnabled = NO;
        
        self.userInteractionEnabled = NO;
        
        [self addSubview:blackBack1];
        [self addSubview:blackBack2];
        [self addSubview:blackBack3];
        [self addSubview:blackBack4];
        [self addSubview:blackBack5];
        [self addSubview:blackBack6];
        [self addSubview:blackBack7];
        [self addSubview:blackBack8];
        
        self.forbidTapActionArray = array;
        for (UIView *view in array) {
            view.userInteractionEnabled = NO;
        }
    }
    return self;
}

- (void)permitTapAction:(NSArray *)array{
    for (UIView *view in array) {
        view.userInteractionEnabled = YES;
    }
}

- (void)changeFrame:(CGRect)frame{
    
    //1枚目（左上）
    blackBack1.frame = CGRectMake(0, 0, frame.origin.x, frame.origin.y);
    //2枚目（真上）
    blackBack2.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.origin.y);
    //3枚目（右上）
    blackBack3.frame = CGRectMake(frame.origin.x + frame.size.width, 0, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), frame.origin.y);
    //4枚目（真ん中左）
    blackBack4.frame = CGRectMake(0, frame.origin.y, frame.origin.x, frame.size.height);
    //5枚目（真ん中右）
    blackBack5.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), frame.size.height);
    //6枚目（左下）
    blackBack6.frame = CGRectMake(0, frame.origin.y + frame.size.height, frame.origin.x, [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height));
    //7枚目（真下）
    blackBack7.frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height));
    //8枚目（右下）
    blackBack8.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height));
}

- (void)changeFrameAndPermittionView:(CGRect)frame forbidedArray:(NSArray *)array{
    for (UIView *view in forbidTapActionArray) {
        view.userInteractionEnabled = YES;
    }
    self.forbidTapActionArray = array;
    for (UIView *view in forbidTapActionArray) {
        view.userInteractionEnabled = NO;
    }
    
    //1枚目（左上）
    blackBack1.frame = CGRectMake(0, 0, frame.origin.x, frame.origin.y);
    //2枚目（真上）
    blackBack2.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.origin.y);
    //3枚目（右上）
    blackBack3.frame = CGRectMake(frame.origin.x + frame.size.width, 0, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), frame.origin.y);
    //4枚目（真ん中左）
    blackBack4.frame = CGRectMake(0, frame.origin.y, frame.origin.x, frame.size.height);
    //5枚目（真ん中右）
    blackBack5.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), frame.size.height);
    //6枚目（左下）
    blackBack6.frame = CGRectMake(0, frame.origin.y + frame.size.height, frame.origin.x, [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height));
    //7枚目（真下）
    blackBack7.frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height));
    //8枚目（右下）
    blackBack8.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height, [UIScreen mainScreen].bounds.size.width - (frame.origin.x + frame.size.width), [UIScreen mainScreen].bounds.size.height - (frame.origin.y + frame.size.height));
}



@end
