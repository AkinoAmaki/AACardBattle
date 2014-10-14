//
//  IntroductionTool.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/10/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionTool : UIImageView

@property (nonatomic) NSArray *forbidTapActionArray;
@property (nonatomic) UIImageView *blackBack1;
@property (nonatomic) UIImageView *blackBack2;
@property (nonatomic) UIImageView *blackBack3;
@property (nonatomic) UIImageView *blackBack4;
@property (nonatomic) UIImageView *blackBack5;
@property (nonatomic) UIImageView *blackBack6;
@property (nonatomic) UIImageView *blackBack7;
@property (nonatomic) UIImageView *blackBack8;
- (id)initForHighlightingViewMethod:(CGRect)frame forbidTapActionViewArray:(NSArray *)array;
- (void)permitTapAction:(NSArray *)array;
- (void)changeFrame:(CGRect)frame;
- (void)changeFrameAndPermittionView:(CGRect)frame forbidedArray:(NSArray *)array;
@end
