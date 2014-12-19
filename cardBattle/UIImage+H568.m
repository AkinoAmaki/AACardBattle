//
//  UIImage+H568.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/12/17.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//


//!!!: UIImage+H568.hに関する注意書き
/***
 
 このメソッド、imageWithContentsOfFileの拡張として作ったけど、もしかすると裏で自動でキャッシュをためてるかもしれん。
 （つまり、imageWithContentsOfFileの拡張として作ったのに挙動はimageNamedと同じ）
 後日検証を要する。
 
 ***/



#import "UIImage+H568.h"
#include <objc/runtime.h>

@implementation UIImage (H568)
+ (void)load {
    if  ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) &&
         ([UIScreen mainScreen].bounds.size.height > 480.0f)) {
        method_exchangeImplementations(class_getClassMethod(self, @selector(imageWithContentsOfFile:)),
                                       class_getClassMethod(self, @selector(imageWithContentsOfFileH568:)));
    }
}

+ (UIImage *)imageWithContentsOfFileH568:(NSString *)imageName {
    NSMutableString *imageNameMutable = [imageName mutableCopy];
    
    //Delete png extension
    NSRange extension = [imageName rangeOfString:@".png" options:NSBackwardsSearch | NSAnchoredSearch];
    if (extension.location != NSNotFound) {
        [imageNameMutable deleteCharactersInRange:extension];
    }
    
    //Look for @2x to introduce -568h string
    NSRange retinaAtSymbol = [imageName rangeOfString:@"@2x"];
    if (retinaAtSymbol.location != NSNotFound) {
        [imageNameMutable insertString:@"-568h" atIndex:retinaAtSymbol.location];
    } else {
        [imageNameMutable appendString:@"-568h@2x"];
    }
    
    //拡張子を付け直す
    [imageNameMutable appendString:@".png"];
    
    
    //「ファイル名-568h@2x.png」というファイルがあれば、そちらを用いてイニシャライズする
    if ([[NSFileManager defaultManager] fileExistsAtPath:imageNameMutable]) {
        //Remove the @2x to load with the correct scale 2.0
        [imageNameMutable replaceOccurrencesOfString:@"@2x" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [imageNameMutable length])];
        return [UIImage imageWithContentsOfFileH568:imageNameMutable];
    } else {
        return [UIImage imageWithContentsOfFileH568:imageName];
    }
}
@end
