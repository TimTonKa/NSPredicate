//
//  ViewController.m
//  NSPredicate
//
//  Created by 1134 on 2017/5/8.
//  Copyright © 2017年 1134. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
    
//    [self test2];
    
//    [self test3];
    
//    [self test4];
    
    [self test5];
}

/*
 * 把 arrayFilter 內的有關鍵字 從 arrayContent 去除，
 * 如果刪掉 NOT 就變成搜尋相同的value，
 * 關鍵字需要一模一樣
 */
-(void)test
{
    NSArray *arrayFilter = [NSArray arrayWithObjects:@"abc", @"abc2", nil];
    NSArray *arrayContent = [NSArray arrayWithObjects:@"a1", @"abc1", @"abc4", @"abc2", nil];
    
    /* @"NOT (SELF in %@)" ->去除關鍵字
     * @"(SELF in %@)" ->尋找相同的value
     */
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", arrayFilter];
    arrayContent = [arrayContent filteredArrayUsingPredicate:thePredicate];
    
    NSLog(@"arrayContent = %@",arrayContent);
}

/*
 * arrayContents 取得有包含 arrayFilter 關鍵字的結果
 * ex:arrayContents內只要有包含"ip"的value就會列出結果："ipad","iphone"
 */
-(void)test2
{
    NSArray *arrayFilter = [NSArray arrayWithObjects:@"pict", @"blackrain", @"ip", nil];
    NSArray *arrayContents = [NSArray arrayWithObjects:@"I am a picture.", @"I am a guy", @"I am gagaga", @"ipad", @"iphone", nil];
    
    
    for(int i = 0; i < arrayFilter.count; i++){
        NSString *arrayItem = (NSString *)[arrayFilter objectAtIndex:i];
        
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", arrayItem];
        
        NSLog(@"Filtered array with filter %@, %@", arrayItem, [arrayContents filteredArrayUsingPredicate:filterPredicate]);
    }
}

/*
 * match的用法，
 * 簡單的比較，
 * 關鍵字要完全相同才會被加入
 */
-(void)test3
{
    NSString *match = @"match";
    NSArray *directoryContents = @[@"matchCD",@"match",@"ma",@"CD"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@",match];
    NSArray *result = [directoryContents filteredArrayUsingPredicate:predicate];
    NSLog(@"Result = %@",result);
}

/*
 * 效果同 "SELF == %@"
 */
-(void)test4
{
    NSString *match = @"match";
    NSArray *directoryContents = @[@"matchCD",@"match",@"ma",@"CD"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF like %@",match];
    NSArray *result = [directoryContents filteredArrayUsingPredicate:predicate];
    NSLog(@"Result = %@",result);
}

/*
 * 大小寫比較
 * c表示忽略大小寫
 * d表示不區分發音符號，即忽略重音
 * 可以在一起使用
 */
-(void)test5
{
    NSString *match = @"imagexyz*";
    NSArray *directoryContents = @[@"imagexyz",@"IMAGEXYZ*",@"imagexyz*"];
    
    NSPredicate *predicateC = [NSPredicate predicateWithFormat:@"SELF like[c] %@",match];
    NSArray *resultC = [directoryContents filteredArrayUsingPredicate:predicateC];
    
    NSPredicate *predicateD = [NSPredicate predicateWithFormat:@"SELF like[d] %@",match];
    NSArray *resultD = [directoryContents filteredArrayUsingPredicate:predicateD];
    
    NSPredicate *predicateCD = [NSPredicate predicateWithFormat:@"SELF like[cd] %@",match];
    NSArray *resultCD = [directoryContents filteredArrayUsingPredicate:predicateCD];
    
    NSLog(@"ResultC = %@",resultC);
    NSLog(@"ResultD = %@",resultD);
    NSLog(@"ResultCD = %@",resultCD);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
