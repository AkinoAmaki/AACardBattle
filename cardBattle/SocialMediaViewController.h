//
//  SocialMediaViewController.h
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/10/27.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>

@interface SocialMediaViewController : UIViewController

- (void)postTwitter :(NSString *)postString viewController:(UIViewController *)viewcontroller;

@end
