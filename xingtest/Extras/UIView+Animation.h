//
//  UIView+TypicalAnimations.h
//  BiolekRezepte
//
//  Created by Jose Alcala on 09.09.13.
//  Copyright (c) 2013 Nudge Gmbh. All rights reserved.
//

#import <UIKit/UIKit.h>

const static NSTimeInterval UIViewDefaultAnimationDuration = 0.4;

@interface UIView (Animation)

- (void) animateExpandFactor:(CGFloat)factor
              expandDuration:(NSTimeInterval)expandDuration
              shrinkDuration:(NSTimeInterval)shrinkDuration;

- (void) setHidden:(BOOL)hidden
          animated:(BOOL)animated;
- (void) setHidden:(BOOL)hidden
          duration:(NSTimeInterval)duration;

@end
