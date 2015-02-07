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
/** 新单图标 */
@property (weak, nonatomic) IBOutlet UIImageView *dealNewMark;

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
    
    // 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%@", deal.list_price];
    // 现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@", deal.current_price];
    // 购买数
    
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"%d人已疯抢",deal.purchase_count];
    // 加载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateNow = [fmt stringFromDate:[NSDate date]];
    
    // 字符串比较大小
    NSComparisonResult result = [dateNow compare:deal.publish_date];
    
    // 结果如果是降序，就说明前面的比后面的大，就是出版时间小于现在的时间就是 旧的，标志就隐藏
    self.dealNewMark.hidden = (result == NSOrderedDescending);
    
}

@end
