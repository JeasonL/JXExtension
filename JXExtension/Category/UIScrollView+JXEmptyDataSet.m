//
//  UIScrollView+JXEmptyDataSet.m
//  JXExtension
//
//  Created by Jeason on 2017/6/15.
//  Copyright © 2017年 Jeason. All rights reserved.
//

#import "UIScrollView+JXEmptyDataSet.h"
#import <objc/runtime.h>

static NSMutableDictionary *_impLookupTable;
static NSString *const JXSwizzleInfoPointerKey = @"JXSwizzleInfoPointerKey";
static NSString *const JXSwizzleInfoOwnerKey = @"JXSwizzleInfoOwnerKey";
static NSString *const JXSwizzleInfoSelectorKey = @"JXSwizzleInfoSelectorKey";

@interface UIScrollView ()

@property (nonatomic, strong) UIView *jx_emptyDataSetView;
@property (nonatomic, assign) NSInteger jx_numberOfItems;

@end

@implementation UIScrollView (JXEmptyDataSet)

#pragma mark - Public method

- (void)jx_reloadEmptyDataSet {
    if (![self canDisplay]) {
        return;
    }

    BOOL isEmpty = !self.jx_numberOfItems;
    if (!isEmpty != !self.jx_emptyDataSetView) {
        if (isEmpty) {
            //Set view
            if ([self.jx_emptyDataSetDataSource respondsToSelector:@selector(jx_emptyDataSetViewForScrollView:)]) {
                self.jx_emptyDataSetView = [self.jx_emptyDataSetDataSource jx_emptyDataSetViewForScrollView:self];
                [self addSubview:self.jx_emptyDataSetView];
            }
        } else {
            [[self.jx_emptyDataSetView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self jx_removeEmptyDataSet];
        }
    } else if (isEmpty) {
        [self bringSubviewToFront:self.jx_emptyDataSetView];
    } else {
        if (self.jx_emptyDataSetView) {
            [self jx_removeEmptyDataSet];
        }
    }
}

- (void)jx_removeEmptyDataSet {
    [self.jx_emptyDataSetView removeFromSuperview];
    [self setJx_emptyDataSetView:nil];
}

#pragma mark - Swizzling

void jx_original_implementation(id self, SEL _cmd)
{
    // Fetch original implementation from lookup table
    NSString *key = jx_implementationKey(self, _cmd);

    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:JXSwizzleInfoPointerKey];

    IMP impPointer = [impValue pointerValue];

    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self jx_reloadEmptyDataSet];

    // If found, call original implementation
    if (impPointer) {
        ((void (*)(id, SEL))impPointer)(self, _cmd);
    }
}

NSString * jx_implementationKey(id target, SEL selector) {
    if (!target || !selector) {
        return nil;
    }

    Class baseClass;
    if ([target isKindOfClass:[UITableView class]]) {
        baseClass = [UITableView class];
    } else if ([target isKindOfClass:[UICollectionView class]]) {
        baseClass = [UICollectionView class];
    } else if ([target isKindOfClass:[UIScrollView class]]) {
        baseClass = [UIScrollView class];
    } else {
        return nil;
    }

    NSString *className = NSStringFromClass([baseClass class]);
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@", className, selectorName];
}

- (void)swizzleIfPossible:(SEL)selector {
    // Check if the target responds to selector
    if (![self respondsToSelector:selector]) {
        return;
    }

    // Create the lookup table
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:2];
    }

    // We make sure that setImplementation is called once per class kind, UITableView or UICollectionView.
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:JXSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:JXSwizzleInfoSelectorKey];

        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }

    NSString *key = jx_implementationKey(self, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:JXSwizzleInfoPointerKey];

    // If the implementation for this class already exist, skip!!
    if (impValue || !key) {
        return;
    }

    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod([self class], selector);
    IMP jx_newImplementation = method_setImplementation(method, (IMP)jx_original_implementation);

    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{ JXSwizzleInfoOwnerKey: [self class],
                                    JXSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                    JXSwizzleInfoPointerKey: [NSValue valueWithPointer:jx_newImplementation] };

    [_impLookupTable setObject:swizzledInfo forKey:key];
}

#pragma mark - Property method

- (id <JXEmptyDataSetDataSource>)jx_emptyDataSetDataSource {
    return objc_getAssociatedObject(self, @selector(jx_emptyDataSetDataSource));
}

- (void)setJx_emptyDataSetDataSource:(id<JXEmptyDataSetDataSource>)jx_emptyDataSetDataSource {
    objc_setAssociatedObject(self, @selector(jx_emptyDataSetDataSource), jx_emptyDataSetDataSource, OBJC_ASSOCIATION_ASSIGN);
    if (jx_emptyDataSetDataSource && [self canDisplay]) {
        // We add method sizzling for injecting -dzn_reloadData implementation to the native -reloadData implementation
        [self swizzleIfPossible:@selector(reloadData)];

        // Exclusively for UITableView, we also inject -dzn_reloadData to -endUpdates
        if ([self isKindOfClass:[UITableView class]]) {
            [self swizzleIfPossible:@selector(endUpdates)];
        }
    } else {
        if (self.jx_emptyDataSetView) {
            [self jx_removeEmptyDataSet];
        }
    }
}

- (UIView *)jx_emptyDataSetView {
    return objc_getAssociatedObject(self, @selector(jx_emptyDataSetView));
}

- (void)setJx_emptyDataSetView:(UIView *)jx_emptyDataSetView {
    if (jx_emptyDataSetView) {
        CGRect frame = self.frame;
        if ([self.jx_emptyDataSetDataSource respondsToSelector:@selector(jx_verticalOffsetForEmptyDataSet:)]) {
            frame.origin.y = [self.jx_emptyDataSetDataSource jx_verticalOffsetForEmptyDataSet:self];
        }
        if ([self.jx_emptyDataSetDataSource respondsToSelector:@selector(jx_heightForEmptyDataSet:)]) {
            frame.size.height = [self.jx_emptyDataSetDataSource jx_heightForEmptyDataSet:self];
        }
        jx_emptyDataSetView.frame = frame;
    }
    objc_setAssociatedObject(self, @selector(jx_emptyDataSetView), jx_emptyDataSetView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)jx_numberOfItems {
    NSInteger items = 0;
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    if ([self isKindOfClass:[UITableView class]]) {
        id <UITableViewDataSource> dataSource = [self performSelector:@selector(dataSource)];
        UITableView *tableView = (UITableView *)self;
        NSInteger sections = 1;
        if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        for (NSInteger i = 0; i < sections; i++) {
            items += [dataSource tableView:tableView numberOfRowsInSection:i];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        id <UICollectionViewDataSource> dataSource = [self performSelector:@selector(dataSource)];
        UICollectionView *collectionView = (UICollectionView *)self;
        NSInteger sections = 1;
        if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        for (NSInteger i = 0; i < sections; i++) {
            items += [dataSource collectionView:collectionView numberOfItemsInSection:i];
        }
    }
    return items;
}

- (BOOL)canDisplay {
    if (self.jx_emptyDataSetDataSource && [self.jx_emptyDataSetDataSource conformsToProtocol:@protocol(JXEmptyDataSetDataSource)]) {
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]] || [self isKindOfClass:[UIScrollView class]]) {
            return YES;
        }
    }
    return NO;
}

@end
