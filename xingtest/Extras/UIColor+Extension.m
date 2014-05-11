//
//  UIColor+Extension.m
//  poiproto
//
//  Created by Jose Alcalá Correa on 05.05.14.
//  Copyright (c) 2014 Nudge GmbH. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *) ColorWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
}

+ (UIColor *) ColorFromHexString:(NSString *)hexString
{    
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor*) colorWithRGBFactor:(CGFloat)factor
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MIN(r*factor, 1.0)
                               green:MIN(g*factor, 1.0)
                                blue:MIN(b*factor, 1.0)
                               alpha:a];
    } else {
        return self;
    }
}

- (UIColor*) colorWithBrightnessFactor:(CGFloat)factor
{
    CGFloat h,s,b,a;
    if([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b*factor
                               alpha:a];
    } else {
        return self;
    }
}

@end
