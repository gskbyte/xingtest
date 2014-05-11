//
//  UIColor+Extension.h
//  poiproto
//
//  Created by Jose Alcalá Correa on 05.05.14.
//  Copyright (c) 2014 Nudge GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *) ColorWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
+ (UIColor *) ColorFromHexString:(NSString *)hexString;

- (UIColor*) colorWithRGBFactor:(CGFloat)factor;
- (UIColor*) colorWithBrightnessFactor:(CGFloat)factor;

@end
