//
//  UIScrollView+JXEmptyDataSet.h
//  JXExtension
//
//  Created by Jeason on 2017/6/15.
//  Copyright © 2017年 Jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@protocol JXEmptyDataSetDataSource <NSObject>

@required
- (UIView *)emptyDataSetViewForScrollView:(UIScrollView *)scrollView;

@optional
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;
- (CGFloat)heightForEmptyDataSet:(UIScrollView *)scrollView;

@end

@interface UIScrollView (JXEmptyDataSet)

@property (nonatomic, weak) IBOutlet id <JXEmptyDataSetDataSource> emptyDataSetDataSource;

- (void)reloadEmptyDataSet;
- (void)removeEmptyDataSet;


@end
