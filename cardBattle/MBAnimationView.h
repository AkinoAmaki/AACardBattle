//
//  MBAnimationView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBAnimationView : UIImageView{
    NSMutableArray *arr;
}

- (void)setAnimationImage:(NSString *)imageName :(int)w :(int)h :(int)fnum;
- (void)setAnimationImageVertical:(NSString *)imageName :(int)w :(int)h :(int)fnum;

- (void)setAnimationImageDividedVertical:(NSString *)imageName :(int)x :(int)w :(int)h :(int)fnum;
@end
