//
//  UIView+Layout.h
//  FTLibrary
//
//  Created by Simon Lee on 21/12/2009.
//  Copyright 2009 Fuerte International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView (Layout)

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)bottomPosition;

- (CGSize)size;
- (void)setSize:(CGSize)size;

- (CGPoint)origin;
- (void)setOrigin:(CGPoint)point;

- (CGFloat)x;
- (CGFloat)y;
- (void) setX:(CGFloat)x;
- (void) setY:(CGFloat)y;

- (CGFloat)baselinePosition;

- (void)positionAtX:(CGFloat)xValue;
- (void)positionAtY:(CGFloat)yValue;
- (void)positionAtX:(CGFloat)xValue andY:(CGFloat)yValue;

- (void)positionAtX:(CGFloat)xValue andY:(CGFloat)yValue withWidth:(CGFloat)width;
- (void)positionAtX:(CGFloat)xValue andY:(CGFloat)yValue withHeight:(CGFloat)height;

- (void)positionAtX:(CGFloat)xValue withHeight:(CGFloat)height;

- (void)removeSubviews;

- (void)centerInParent;
- (void)aestheticCenterInParent;

- (void)bringToFront;
- (void)sendToBack;

// Nudge additions

- (void) moveX:(CGFloat)amount;
- (void) moveY:(CGFloat)amount;

- (void) positionAboveView:(UIView*)view;
- (void) positionBelowView:(UIView*)view;
- (void) positionLeftToView:(UIView*)view;
- (void) positionRightToView:(UIView*)view;

- (void) alignCenter:(UIView*)view;
- (void) alignCenterVertical:(UIView*)view;
- (void) alignCenterHorizontal:(UIView*)view;
- (void) alignCenterVertical:(UIView*)view
                      margin:(CGFloat)margin;
- (void) alignCenterHorizontal:(UIView*)view
                        margin:(CGFloat)margin;

- (void) alignTop:(UIView*)view;
- (void) alignBottom:(UIView*)view;
- (void) alignLeft:(UIView*)view;
- (void) alignRight:(UIView*)view;

- (void) alignParentCenterVertical;
- (void) alignParentCenterHorizontal;
- (void) alignParentTop;
- (void) alignParentBottom;
- (void) alignParentLeft;
- (void) alignParentRight;


- (void) positionAboveView:(UIView*)view
                    margin:(CGFloat)margin;
- (void) positionBelowView:(UIView*)view
                    margin:(CGFloat)margin;
- (void) positionLeftToView:(UIView*)view
                     margin:(CGFloat)margin;
- (void) positionRightToView:(UIView*)view
                      margin:(CGFloat)margin;

- (void) alignTop:(UIView*)view
           margin:(CGFloat)margin;
- (void) alignBottom:(UIView*)view
              margin:(CGFloat)margin;
- (void) alignLeft:(UIView*)view
            margin:(CGFloat)margin;
- (void) alignRight:(UIView*)view
             margin:(CGFloat)margin;

- (void) alignParentTopWithMargin:(CGFloat)margin;
- (void) alignParentBottomWithMargin:(CGFloat)margin;
- (void) alignParentLeftWithMargin:(CGFloat)margin;
- (void) alignParentRightWithMargin:(CGFloat)margin;


- (void) setPositionAndSizeFromView:(UIView*)view;
- (void) setPositionAndSizeFromView:(UIView*)view
                             margin:(CGFloat)margin;
- (void) fillParent;
- (void) fillParentWithMargin:(CGFloat)margin;

@end
