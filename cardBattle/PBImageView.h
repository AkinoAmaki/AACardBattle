//
//  PBImageView.h
//  PokeBattle
//
//  Created by sakamoto on 2014/08/02.
//  Copyright (c) 2014年 YoshikiAkino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenetrateFilter.h"

@interface PBImageView : UIImageView<UITextViewDelegate>{
        UIViewController *rootViewController;
}

@property (nonatomic) UITextView *textView;
- (id)initWithImageNameAndText:(NSString *)image_name imagePath:(NSString *)imagePath textString:(NSString *)textString characterIsOnLeft:(BOOL)characterIsOnLeft;
- (void)startAnimation21;
- (void)startAnimation22;
@end
