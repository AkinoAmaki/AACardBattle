//
//  PBImageView.h
//  PokeBattle
//
//  Created by sakamoto on 2014/08/02.
//  Copyright (c) 2014年 YoshikiAkino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenetrateFilter.h"

@interface PBImageView : UIImageView<UITextViewDelegate>

- (id)initWithImageNameAndText:(NSString *)image_name textString:(NSString *)textString;

@end
