//
//  SXDeal.m
//  88 - SX团购HD
//
//  Created by 董 尚先 on 15/2/5.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXDeal.h"

@implementation SXDeal

// 因为出现了关键字重复，把模型里的desc指定成plist里的description
+ (NSDictionary *)replacedKeyFromPropertyName   // $$$$$
{
    return @{@"desc" : @"description"};
}

@end
