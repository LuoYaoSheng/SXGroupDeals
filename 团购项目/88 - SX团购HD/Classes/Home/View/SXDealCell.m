//
//  SXDealCell.m
//  88 - SX团购HD
//
//  Created by 董 尚先 on 15/2/5.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXDealCell.h"
#import "UIImageView+WebCache.h"

@interface SXDealCell ()

/** 展示图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 产品标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 描述信息 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
/** 当前价格 */
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
/** 原价 */
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
/** 购买数量 */
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;

@end
@implementation SXDealCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}

- (void)setDeal:(SXDeal *)deal
{
    _deal = deal;
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"%.2f元",deal.current_price];
    self.listPriceLabel.text = [NSString stringWithFormat:@"%.2f元",deal.list_price];
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"%d人已疯抢",deal.purchase_count];
    
    
}

@end
