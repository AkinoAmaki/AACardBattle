//
//  AAButton.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/09/30.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "AAButton.h"

@implementation AAButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithImageAndText:(NSString *)imageString imagePath:(NSString *)path textString:(NSString *)textString tag:(int)tag CGRect:(CGRect)rect{
    self = [super init];
    if(self){
        // initialization code
        [self setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonBack" ofType:@"png"]] forState:UIControlStateNormal];
        [self setTitle:textString forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
        self.frame = rect;
        self.tag = tag;
        UIImageView *tempImage = [[UIImageView alloc] init];
        tempImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageString ofType:path]];
        [self addSubview:tempImage];
        tempImage.frame = CGRectMake(self.bounds.size.width / 15, self.bounds.size.height / 6, self.bounds.size.height * 2 / 3, self.bounds.size.height * 2 / 3);
        
        UIImageView *tempImage2 = [[UIImageView alloc] init];
        tempImage2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageString ofType:path]];
        [self addSubview:tempImage2];
        tempImage2.frame = CGRectMake((self.bounds.size.width * 14 / 15) - (self.bounds.size.height * 2 / 3), self.bounds.size.height / 6, self.bounds.size.height * 2 / 3, self.bounds.size.height * 2 / 3);
        
    }
    return self;

}

@end
