//
//  UIView+TypicalAnimations.m
//  BiolekRezepte
//
//  Created by Jose Alcala on 09.09.13.
//  Copyright (c) 2013 Nudge Gmbh. All rights reserved.
//

#import "UIView+Animation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (TypicalAnimations)

- (void) animateExpandFactor:(CGFloat)factor
              expandDuration:(NSTimeInterval)expandDuration
              shrinkDuration:(NSTimeInterval)shrinkDuration
{
    [self.layer removeAllAnimations];
    
    CGRect origFrame = self.frame;
    CGRect expandFrame = self.frame;
    
    CGFloat relFactor = factor>1?factor-1:factor+1;
    CGFloat wdif = expandFrame.size.width*relFactor;
    CGFloat hdif = expandFrame.size.height*relFactor;
    
    expandFrame.size.width += wdif;
    expandFrame.size.height += hdif;
    expandFrame.origin.x -= (wdif*0.5);
    expandFrame.origin.y -= (hdif*0.5);
    
    [UIView animateWithDuration:expandDuration
                     animations:^{
                         self.frame = expandFrame;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:shrinkDuration
                                          animations:^{
                                              self.frame = origFrame;
                                          }];
                     }];
}

- (void) setHidden:(BOOL)hidden
          animated:(BOOL)animated
{
    [self setHidden:hidden
           duration:UIViewDefaultAnimationDuration];
}

- (void) setHidden:(BOOL)hidden
          duration:(NSTimeInterval)duration;
{
    if(duration == 0) {
        if(self.alpha == 0)
            self.alpha = 1;
        [self setHidden:hidden];
    } else {
        if(self.hidden) {
            self.alpha = 0;
            self.hidden = NO;
        }
        [UIView animateWithDuration:UIViewDefaultAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            self.alpha = hidden ? 0 : 1;
        } completion:^(BOOL finished) {
            self.hidden = hidden;
        }];
    }
}



@end
