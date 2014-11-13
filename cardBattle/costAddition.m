//
//  costAddition.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/11/13.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "costAddition.h"

@implementation costAddition

//コストとカードナンバーを付加した画像を保存するメソッド
-(void)getCostImageView:(int)cardNum{
    //コスト・カードナンバーが無い画像ビューを用意
    UIImageView *cardImageView = [[UIImageView alloc] init];
    UIImage *temp = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"card%d", cardNum] ofType:@"PNG"]];
    cardImageView.image = temp;
    cardImageView.frame = CGRectMake(0, 0, 480, 720);
    
    //コストの画像を用意
    NSArray *tempArray = [[NSArray alloc] initWithArray:[self caliculateEnergyCost:cardNum]];
    
    int costImageWidth = 0; //コスト画像を描画する際のwidthを規定する
    
    //コストを表示するのに必要な画像数を格納する(たとえばWW2なら3,BBB4なら4)
    int costImageMount = 0;
    for (int i = 0;  i < [tempArray count] - 1; i++) {
        costImageMount += [tempArray[i] intValue];
    }
    if ([tempArray[5] intValue] != 0) {
        costImageMount++;
    }
    
    //有色のコストの画像を描画する
    for (int i = 0; i < [tempArray count] - 1; i++) {
        for (int k = 0; k < [[tempArray objectAtIndex:i] intValue]; k++) {
            UIImageView *costView = [[UIImageView alloc] init];
            switch (i) {
                case 0:
                {
                    costView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"whiteEnergyImage" ofType:@"png"]];
                }
                    break;
                case 1:
                {
                    costView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blueEnergyImage" ofType:@"png"]];
                }
                    break;
                case 2:
                {
                    costView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackEnergyImage" ofType:@"png"]];
                }
                    break;
                case 3:
                {
                    costView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"redEnergyImage" ofType:@"png"]];
                }
                    break;
                case 4:
                {
                    costView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"greenEnergyImage" ofType:@"png"]];
                }
                    break;
                default:
                    break;
            }
            [cardImageView addSubview:costView];
                costView.frame = CGRectMake(costView.superview.bounds.size.width - (60 + 32 * costImageMount--), 62, 30, 30);
                costImageWidth += 22;
        }
    }
    
    //無色のコストの画像を描画する
    UIImageView *costView2 = [[UIImageView alloc] init];
    [cardImageView addSubview:costView2];
    costView2.frame = CGRectMake(costView2.superview.bounds.size.width - (60 + 32 * costImageMount--), 62, 30, 30);
    costView2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"noColor%d",[[tempArray objectAtIndex:5] intValue]] ofType:@"png"]];
    
    //カードナンバーを付加する
    UILabel *cardNo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    cardNo.text = [NSString stringWithFormat:@"No.%d",cardNum];
    UIFont *nameFont = [UIFont fontWithName:@"Tanuki-Permanent-Marker" size:15];
    cardNo.font = nameFont;
    [cardNo sizeToFit];
    [cardImageView addSubview:cardNo];
    cardNo.center = CGPointMake(410, 410);
    
    //保存する画像を指定
    UIImage *gouseigoImage = [costAddition imageWithView:cardImageView];
    UIImage *image = gouseigoImage;
    
    // 保存ディレクトリを指定
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString* docDir = @"/Users/AkinoAmaki/Downloads/temp";
    if([fm fileExistsAtPath:docDir]){
        NSLog(@"OK");
        // 保存ディレクトリ＋ファイル名を指定
        NSString* photoFilePath = [NSString stringWithFormat:@"%@/card_%d.jpg", docDir,cardNum];
        // 圧縮率を指定しJPEGファイルで保存する
        [UIImageJPEGRepresentation(image, 0.7f) writeToFile:photoFilePath atomically:YES];
    }else{
        NSLog(@"ダウンロードする先のファイルパスが不正です");
    }
}

//対象のカードのエネルギーコストを配列に収める（カードナンバー）
- (NSArray *)caliculateEnergyCost:(int)cardNum{
    app = [[UIApplication sharedApplication] delegate];
    
    
    int whiteNumber = 0;//必要な白エネルギーの数を集計する
    int blueNumber = 0;//必要な青エネルギーの数を集計する
    int blackNumber = 0;//必要な黒エネルギーの数を集計する
    int redNumber = 0;//必要な赤エネルギーの数を集計する
    int greenNumber = 0;//必要な緑エネルギーの数を集計する
    int otherNumber = 0;//任意の色でよいエネルギーの数を集計する
    
    NSMutableArray *array = [[NSMutableArray alloc] init]; //白・青・黒・赤・緑・無色の配列順でコストがどれだけかかるかを管理する。
    NSString *energyCost = [app.cardList_cost objectAtIndex:cardNum]; //コストの文字列を取得
    int costLength = (int)[energyCost length];
    for (int i = 0; i < costLength; i++) {
        if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"W"]){
            whiteNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"U"]){
            blueNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"B"]){
            blackNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"R"]){
            redNumber++;
        }else if([[energyCost substringWithRange:NSMakeRange(i,1)] isEqualToString:@"G"]){
            greenNumber++;
        }else{
            otherNumber += [[energyCost substringWithRange:NSMakeRange(i, 1)] intValue];
        }
    }
    
    [array addObject:[NSNumber numberWithInt:whiteNumber]];
    [array addObject:[NSNumber numberWithInt:blueNumber]];
    [array addObject:[NSNumber numberWithInt:blackNumber]];
    [array addObject:[NSNumber numberWithInt:redNumber]];
    [array addObject:[NSNumber numberWithInt:greenNumber]];
    [array addObject:[NSNumber numberWithInt:otherNumber]];
    
    NSLog(@"白：%d",[[array objectAtIndex: 0] intValue]);
    NSLog(@"青：%d",[[array objectAtIndex: 1] intValue]);
    NSLog(@"黒：%d",[[array objectAtIndex: 2] intValue]);
    NSLog(@"赤：%d",[[array objectAtIndex: 3] intValue]);
    NSLog(@"緑：%d",[[array objectAtIndex: 4] intValue]);
    NSLog(@"他：%d",[[array objectAtIndex: 5] intValue]);
    
    return  array;
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end
