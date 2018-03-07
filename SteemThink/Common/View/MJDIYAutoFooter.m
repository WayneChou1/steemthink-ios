//
//  MJDIYAutoFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYAutoFooter.h"

@interface MJDIYAutoFooter()

@property (weak, nonatomic) UIImageView *logo;
@end

@implementation MJDIYAutoFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    self.label.hidden = YES;
    
    // loading
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++) {
        NSMutableString *imgLast = [NSMutableString stringWithFormat:@"0000%d",i];
        if (imgLast.length > 5) {
            [imgLast deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        NSString *imgName = [NSString stringWithFormat:@"loading_v1_%@@2x",imgLast];
        UIImage *image = [UIImage imageNamed:imgName];
        [refreshingImages addObject:image];
    }
    
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.animationImages = refreshingImages;
    logo.animationDuration = 1;
    logo.animationRepeatCount = 0;
    logo.contentMode = UIViewContentModeCenter;
    logo.hidden = YES;
    [self addSubview:logo];
    self.logo = logo;

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    
    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 60);
    self.logo.center = CGPointMake(self.mj_w * 0.5,self.logo.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.logo stopAnimating];
            break;
        case MJRefreshStatePulling:
            [self.logo stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            self.label.hidden = YES;
            self.logo.hidden = NO;
            [self.logo startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = [[NSBundle mainBundle] localizedStringForKey:@"No More Data" value:nil table:nil];
            [self.logo stopAnimating];
            self.logo.hidden = YES;
            [self.logo startAnimating];
        default:
            break;
    }}

@end
