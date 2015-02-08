//
//  SXCollectionionViewController.m
//  88 - SX团购HD
//
//  Created by 董 尚先 on 15/2/8.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXCollectionViewController.h"
#import "SXDealCell.h"
#import "SXDetailViewController.h"
#import "SXDealTool.h"
#import "UIView+AutoLayout.h"
#import "UIBarButtonItem+Extension.h"

@interface SXCollectionViewController ()
/** 显示的所有团购 */
@property (nonatomic, strong) NSMutableArray *deals;

/** 没有团购数据时显示的提醒图片 */
@property (nonatomic, weak) UIImageView *noDataView;
@end

@implementation SXCollectionViewController

static NSString * const reuseIdentifier = @"deal";
- (UIImageView *)noDataView
{
    if (!_noDataView) {
        UIImageView *noDataView = [[UIImageView alloc] init];
        noDataView.image = [UIImage imageNamed:@"icon_collects_empty"];
        noDataView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:noDataView];
        
        // 约束
        [noDataView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        // 赋值
        self.noDataView = noDataView;
    }
    return _noDataView;
}

- (NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏内容
    [self setupNav];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SXDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = SXColor(230, 230, 230);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 重新刷新数据
    [self.deals removeAllObjects];
    [self.deals addObjectsFromArray:[SXDealTool collectedDeals]];
    [self.collectionView reloadData];
    
    // 控制右上角编辑能否交互
    self.navigationItem.rightBarButtonItem.enabled = (self.deals.count > 0);
    
    // 根据屏幕尺寸设置边距
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:nil];
}

/**
 *  设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"icon_back" HightLightImage:@"icon_back_highlighted" target:self action:@selector(back)];
    
    self.title = @"我的收藏";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
}

- (void)edit
{
    SXLog(@"edit-----");
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 监听屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.itemSize = CGSizeMake(305, 305);
    
    CGFloat screenW = size.width;
    // 根据屏幕尺寸决定每行的列数
    int cols = (screenW == SXScreenMaxWH) ? 3 : 2;
    // 一行之中所有cell的总宽度
    CGFloat allCellW = cols * layout.itemSize.width;
    // cell之间间距
    CGFloat xMargin = (screenW - allCellW)/ (cols + 1);
    CGFloat yMargin = (cols == 3) ? xMargin : 30;
    // 周边的间距
    layout.sectionInset = UIEdgeInsetsMake(yMargin, xMargin, yMargin, xMargin);
    // 每一行中每个cell之间的间距
    layout.minimumInteritemSpacing = xMargin;
    // 每一行之间的间距
    layout.minimumLineSpacing = yMargin;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = self.deals.count;
    self.noDataView.hidden = (count > 0);
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SXDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXDetailViewController *detailVc = [[SXDetailViewController alloc] init];
    detailVc.deal = self.deals[indexPath.item];
    [self presentViewController:detailVc animated:YES completion:nil];
}
@end
