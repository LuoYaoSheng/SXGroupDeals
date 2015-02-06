//
//  SXDeal.h
//  88 - SX团购HD
//
//  Created by 董 尚先 on 15/2/5.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXDeal : NSObject

/** 团购单ID */
@property (copy, nonatomic) NSString *deal_id;
/** 团购标题 */
@property (copy, nonatomic) NSString *title;
/** 团购描述 */
@property (copy, nonatomic) NSString *desc;
/** 团购包含商品原价值 */
@property (assign, nonatomic) double list_price;
/** 团购价格 */
@property (assign, nonatomic) double current_price;
/** 团购当前已购买数 */
@property (assign, nonatomic) int purchase_count;

@end
