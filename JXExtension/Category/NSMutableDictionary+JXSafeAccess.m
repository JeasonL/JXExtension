//
//  NSMutableDictionary+JXSafeAccess.m
//  JXExtension
//
//  Created by JeasonLee on 2019/1/21.
//  Copyright © 2019 Jeason.Lee. All rights reserved.
//

#import "NSMutableDictionary+JXSafeAccess.h"

@implementation NSMutableDictionary (JXSafeAccess)

- (void)jx_safeSetObject:(id)object forKey:(id <NSCopying>)key {
    if (object) {
        [self setObject:object forKey:key];
    }
}

@end
