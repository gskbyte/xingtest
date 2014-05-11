//
//  NSDictionary+TreeAccess.h
//  xingtest
//
//  Created by Jose Alcalá Correa on 10/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import <Foundation/Foundation.h>

// Implements leveled access using a separator

static NSString * const NSDictionaryTreeAccessSeparator = @".";

@interface NSDictionary (TreeAccess)

- (id) get:(NSString*)key;

- (id)   get:(NSString*)key
defaultValue:(NSString*)def;

@end
