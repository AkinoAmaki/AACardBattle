//
//  GetEnemyDataFromServer.m
//  cardBattle
//
//  Created by 秋乃雨弓 on 2014/05/10.
//  Copyright (c) 2014年 秋乃雨弓. All rights reserved.
//

#import "GetEnemyDataFromServer.h"

@implementation GetEnemyDataFromServer

-(void)get{
    [SVProgressHUD showWithStatus:@"データ通信中..." maskType:SVProgressHUDMaskTypeGradient];
    app = [[UIApplication sharedApplication] delegate];
    
    //相手プレイヤーのIDを送信
    NSArray *enemyPlayerID_parameter = [[NSArray alloc] initWithObjects:
                                        [NSNumber numberWithInt:app.enemyPlayerID],nil];
    NSArray *enemyPlayerID_key = [[NSArray alloc] initWithObjects:
                                  @"enemyPlayerID",nil];
    
    //送るデータをキーとともにディクショナリ化する
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:enemyPlayerID_parameter forKeys:enemyPlayerID_key];
    //JSONに変換
    NSString *jsonRequest = [dic JSONRepresentation];
    //JSONに変換)
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    //     //外部から接続する場合
    NSString *url = @"http://utakatanet.dip.jp:58080/enemyData.php";
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLResponse *response;
    NSError *error;
    NSData *result;
    result= [NSURLConnection sendSynchronousRequest:request
                                  returningResponse:&response
                                              error:&error];
    //データがgetできなければ、0.5秒待ったあとに再度get処理する
    while (!result) {
        [NSThread sleepForTimeInterval:0.5];
        result= [NSURLConnection sendSynchronousRequest:request
                                      returningResponse:&response
                                                  error:&error];
        NSLog(@"データのget処理中...");
    }
    
    
    //相手プレイヤーのデータを受信
    // URLからJSONデータを取得(NSData)
    NSData *response2 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // JSONで解析するために、NSDataをNSStringに変換。
    NSString *json_string = [[NSString alloc] initWithData:response2 encoding:NSUTF8StringEncoding];
    // JSONデータをパースする。
    // ここではJSONデータが配列としてパースされるので、NSArray型でデータ取得
    NSArray *statuses = [json_string JSONValue];
    NSLog(@"ぬぬぬ：%d",[statuses count]);
    for (int i = 0; i < [statuses count]; i++) {
        NSLog(@"%@",[statuses objectAtIndex:i]);
    }
    
    
    
    [SVProgressHUD dismiss];
}

@end
