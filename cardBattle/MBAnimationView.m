//
//  MBAnimationView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBAnimationView.h"

@implementation MBAnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setAnimationImage:(NSString *)imageName :(int)w :(int)h :(int)fnum{
    NSLog(@"MBAnimationView setAnimationImage");
    
    UIImage *e = [UIImage imageNamed:imageName];
    arr = [[NSMutableArray alloc] init];
    // イメージのトリミング
    for(int i = 0; i < fnum; i++){
        CGRect rect = CGRectMake(w*i, 0, w, h);
        CGImageRef e_ref = CGImageCreateWithImageInRect(e.CGImage, rect);
        UIImage *e_trim = [UIImage imageWithCGImage:e_ref];
        [arr addObject:e_trim];
    }
    
    self.animationImages = arr;
    self.animationRepeatCount = 1;
}

- (void)setAnimationImageVertical:(NSString *)imageName :(int)w :(int)h :(int)fnum{
    NSLog(@"MBAnimationView setAnimationImage");
    
    UIImage *e = [UIImage imageNamed:imageName];
    arr = [[NSMutableArray alloc] init];
    // イメージのトリミング
    for(int i = 0; i < fnum; i++){
        CGRect rect = CGRectMake(0, h*i, w, h);
        CGImageRef e_ref = CGImageCreateWithImageInRect(e.CGImage, rect);
        UIImage *e_trim = [UIImage imageWithCGImage:e_ref];
        [arr addObject:e_trim];
    }
    
    self.animationImages = arr;
    self.animationRepeatCount = 1;
}

- (void)setAnimationImageDividedVertical:(NSString *)imageName :(int)x :(int)w :(int)h :(int)fnum{
    NSLog(@"MBAnimationView setAnimationImage");
    
    UIImage *e = [UIImage imageNamed:imageName];
    arr = [[NSMutableArray alloc] init];
    // イメージのトリミング
    for(int i = 0; i < fnum; i++){
        CGRect rect = CGRectMake(x, h*i, w, h);
        CGImageRef e_ref = CGImageCreateWithImageInRect(e.CGImage, rect);
        UIImage *e_trim = [UIImage imageWithCGImage:e_ref];
        [arr addObject:e_trim];
    }
    
    self.animationImages = arr;
    self.animationRepeatCount = 1;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
