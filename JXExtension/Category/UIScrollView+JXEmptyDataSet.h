//
//  UIScrollView+JXEmptyDataSet.h
//  JXExtension
//
//  Created by Jeason on 2017/6/15.
//  Copyright © 2017年 Jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXEmptyDataSetDataSource <NSObject>

@required
- (UIView *)jx_emptyDataSetViewForScrollView:(UIScrollView *)scrollView;

@optional
- (CGFloat)jx_verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;
- (CGFloat)jx_heightForEmptyDataSet:(UIScrollView *)scrollView;

- (UIView *)emptyDataSetViewForScrollView:(UIScrollView *)scrollView DEPRECATED_MSG_ATTRIBUTE("Please use jx_emptyDataSetViewForScrollView");
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView DEPRECATED_MSG_ATTRIBUTE("Please use jx_verticalOffsetForEmptyDataSet");
- (CGFloat)heightForEmptyDataSet:(UIScrollView *)scrollView DEPRECATED_MSG_ATTRIBUTE("Please use jx_heightForEmptyDataSet");

@end

@interface UIScrollView (JXEmptyDataSet)

@property (nonatomic, weak) IBOutlet id <JXEmptyDataSetDataSource> jx_emptyDataSetDataSource;

- (void)jx_reloadEmptyDataSet;
- (void)jx_removeEmptyDataSet;

@end
