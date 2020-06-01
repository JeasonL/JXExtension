//
//  UIButton+JXHotSpot.m
//  JXExtension
//
//  Created by JeasonLee on 2020/6/1.
//  Copyright © 2020 Jeason.Lee. All rights reserved.
//

#import "UIButton+JXHotSpot.h"
#import <objc/runtime.h>

@implementation UIButton (JXHotSpot)

- (UIEdgeInsets)jx_hotSpotEdgeInsets {
    NSDictionary *dictionary = [self jx_edgeInsetsDictionary];
    CGFloat top = [dictionary[@"top"] floatValue];
    CGFloat left = [dictionary[@"left"] floatValue];
    CGFloat bottom = [dictionary[@"bottom"] floatValue];
    CGFloat right = [dictionary[@"right"] floatValue];
    return UIEdgeInsetsMake(top, left, bottom, right);
}

- (void)setJx_hotSpotEdgeInsets:(UIEdgeInsets)jx_hotSpotEdgeInsets {
    NSDictionary *dictionary = @{ @"top": @(jx_hotSpotEdgeInsets.top),
                                  @"left": @(jx_hotSpotEdgeInsets.left),
                                  @"bottom": @(jx_hotSpotEdgeInsets.bottom),
                                  @"right": @(jx_hotSpotEdgeInsets.right) };
    [self setJx_edgeInsetsDictionary:dictionary];
}

- (void)setJx_edgeInsetsDictionary:(NSDictionary *)jx_edgeInsetsDictionary {
    objc_setAssociatedObject(self, @selector(jx_edgeInsetsDictionary), jx_edgeInsetsDictionary, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)jx_edgeInsetsDictionary {
    return objc_getAssociatedObject(self, @selector(jx_edgeInsetsDictionary));
}

- (CGRect)jx_hotSpotRect {
    UIEdgeInsets edgeInset = self.jx_hotSpotEdgeInsets;
    CGFloat top = edgeInset.top;
    CGFloat left = edgeInset.left;
    CGFloat bottom = edgeInset.bottom;
    CGFloat right = edgeInset.right;
    return CGRectMake(self.bounds.origin.x - left,
                      self.bounds.origin.y - top,
                      self.bounds.size.width + left + right,
                      self.bounds.size.height + top + bottom);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSDictionary *dictionary = [self jx_edgeInsetsDictionary];
    if (dictionary) {
        CGRect rect = [self jx_hotSpotRect];
        if (CGRectEqualToRect(rect, self.bounds)) {
            return [super hitTest:point withEvent:event];
        }
        return CGRectContainsPoint(rect, point) ? self : nil;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

@end
