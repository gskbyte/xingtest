//
//  NSDictionary+TreeAccess.m
//  xingtest
//
//  Created by Jose Alcalá Correa on 10/05/14.
//  Copyright (c) 2014 joseac. All rights reserved.
//

#import "NSDictionary+TreeAccess.h"

@implementation NSDictionary (TreeAccess)


- (id) get:(NSString*)key
{
    return [self get:key defaultValue:nil];
}

- (id)   get:(NSString*)key
defaultValue:(NSString*)def
{
    NSArray * path = [key componentsSeparatedByString:NSDictionaryTreeAccessSeparator];
    id object = self;
    for(NSString * k in path) {
        if(object == nil) {
            return def;
        } else if([object isKindOfClass:[NSDictionary class]]) {
            object = [object objectForKey:k];
        } else if([object isKindOfClass:[NSArray class]]) {
            object = [object objectAtIndex:k.integerValue];
        } else {
            NSLog(@"Error: accessing invalid path '%@' for dictionary: %@", path, self);
        }
    }
    
    return object;
}

@end
