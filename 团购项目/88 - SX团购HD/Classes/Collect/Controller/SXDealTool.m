//
//  SXDealTool.m
//  88 - SX团购HD
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXDealTool.h"
#import "SXDeal.h"

// $$$$$
#define SXSaveFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collectDeals.data"]

@implementation SXDealTool

static NSMutableArray *_collectedDeals;

+ (void)initialize
{
    _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:SXSaveFile];
    if (_collectedDeals == nil) {
        _collectedDeals = [NSMutableArray array];
    }
}

+ (NSArray *)collectedDeals
{
    return _collectedDeals;
}

#warning 怎么保存了？
+ (BOOL)isCollected:(SXDeal *)deal
{
    return [_collectedDeals containsObject:deal]; // $$$$$
}

+ (void)collect:(SXDeal *)deal{
    [_collectedDeals insertObject:deal atIndex:0]; // $$$$$
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:SXSaveFile];
    
}

+ (void)uncollect:(SXDeal *)deal{
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:SXSaveFile];
}

@end
