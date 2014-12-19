//
//  UILabel+kylib.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/12/16.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "UILabel+kylib.h"

@implementation UILabel (kylib)



- (void) fitSizeOfFont:(UIFont *)font {
    NSString *label = self.text;
    
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    CGSize labelSize;
    
    int i;
    for(i = font.pointSize; i > self.minimumFontSize; i--) {
        font = [font fontWithSize:i];
        
        labelSize = [label sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        
        if(labelSize.height <= height)
            break;
    }
    
    self.font = font;
}


@end
