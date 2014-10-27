//
//  SocialMediaViewController.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/10/27.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "SocialMediaViewController.h"

@interface SocialMediaViewController ()

@end

@implementation SocialMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Twitter
- (void)postTwitter :(NSString *)postString viewController:(UIViewController *)viewcontroller{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) { //利用可能チェック
        NSString *serviceType = SLServiceTypeTwitter;
        SLComposeViewController *composeCtl = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        [composeCtl setInitialText:postString];
        [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultDone) {
                //投稿成功時の処理
                NSLog(@"投稿成功");
            }
        }];
        [viewcontroller presentViewController:composeCtl animated:YES completion:nil];
    }
}

//// LINE
//- (IBAction)postLine:(id)sender {
//    NSString* postContent = [NSString stringWithFormat:@"投稿内容"];
//    [Line shareToLine:postContent];
//}
// Facebook
- (IBAction)postFacebook :(NSString *)postString viewController:(UIViewController *)viewcontroller{
    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString* postContent = [NSString stringWithFormat:@"投稿内容"];
    [facebookPostVC setInitialText:postContent];
    [facebookPostVC addURL:[NSURL URLWithString:@"url"]]; // URL文字列
    [facebookPostVC addImage:[UIImage imageNamed:@"image_name_string"]]; // 画像名（文字列）
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
