//
//  UIView+Layout.m
//  FTLibrary
//
//  Created by Simon Lee on 21/12/2009.
//  Copyright 2009 Fuerte International. All rights reserved.
//

#import "UIView+Layout.h"


@implementation UIView (Layout)

- (void)removeSubviews {
	for(UIView *view in self.subviews) {
		[view removeFromSuperview];
	}
}

- (CGFloat)width {
	CGRect frame = [self frame];
	return frame.size.width;
}

- (void)setWidth:(CGFloat)value {
	CGRect frame = [self frame];
	frame.size.width = round(value);
	[self setFrame:frame];
}

- (CGFloat)height {
	CGRect frame = [self frame];
	return frame.size.height;	
}

- (void)setHeight:(CGFloat)value {
	CGRect frame = [self frame];
	frame.size.height = round(value);
	[self setFrame:frame];
}

- (CGFloat)bottomPosition {
	return ([self height] + [self y]);
}

- (void)setSize:(CGSize)size {
	CGRect frame = [self frame];
	frame.size.width = round(size.width);
	frame.size.height = round(size.height);
	[self setFrame:frame];
}

- (CGSize)size {
	CGRect frame = [self frame];
	return frame.size;
}

- (CGPoint)origin {
	CGRect frame = [self frame];
	return frame.origin;
}

- (void)setOrigin:(CGPoint)point {
	CGRect frame = [self frame];
	frame.origin = point;
	[self setFrame:frame];
}

- (CGFloat)x
{
	CGRect frame = [self frame];
	return frame.origin.x;
}

- (CGFloat)y
{
	CGRect frame = [self frame];
	return frame.origin.y;	
}

- (void)setX:(CGFloat)x
{
	CGRect frame = [self frame];
	frame.origin.x = x;
	[self setFrame:frame];
}

- (void)setY:(CGFloat)y
{
	CGRect frame = [self frame];
	frame.origin.y = y;
	[self setFrame:frame];
}

- (CGFloat)baselinePosition {
	return [self y] + [self height];
}

- (void)positionAtX:(CGFloat)xValue {
	CGRect frame = [self frame];
	frame.origin.x = round(xValue);
	[self setFrame:frame];
}

- (void)positionAtY:(CGFloat)yValue {
	CGRect frame = [self frame];
	frame.origin.y = round(yValue);
	[self setFrame:frame];
}

- (void)positionAtX:(CGFloat)xValue andY:(CGFloat)yValue {
	CGRect frame = [self frame];
	frame.origin.x = round(xValue);
	frame.origin.y = round(yValue);
	[self setFrame:frame];
}

- (void)positionAtX:(CGFloat)xValue andY:(CGFloat)yValue withWidth:(CGFloat)width {
	CGRect frame = [self frame];
	frame.origin.x = round(xValue);
	frame.origin.y = round(yValue);
	frame.size.width = width;
	[self setFrame:frame];	
}

- (void)positionAtX:(CGFloat)xValue andY:(CGFloat)yValue withHeight:(CGFloat)height {
	CGRect frame = [self frame];
	frame.origin.x = round(xValue);
	frame.origin.y = round(yValue);
	frame.size.height = height;
	[self setFrame:frame];	
}

- (void)positionAtX:(CGFloat)xValue withHeight:(CGFloat)height {
	CGRect frame = [self frame];
	frame.origin.x = round(xValue);
	frame.size.height = height;
	[self setFrame:frame];	
}

- (void)centerInParent {
	CGFloat xPos = round((self.superview.frame.size.width - self.frame.size.width) / 2.0);
	CGFloat yPos = round((self.superview.frame.size.height - self.frame.size.height) / 2.0);	
	[self positionAtX:xPos andY:yPos];
}

- (void)aestheticCenterInParent {
	CGFloat xPos = round(([self.superview width] - [self width]) / 2.0);
	CGFloat yPos = round(([self.superview height] - [self height]) / 2.0) - ([self.superview height] / 8.0);
	[self positionAtX:xPos andY:yPos];	
}

- (void)bringToFront {
	[self.superview bringSubviewToFront:self];	
}

- (void)sendToBack {
	[self.superview sendSubviewToBack:self];	
}

// Nudge additions

- (void) moveX:(CGFloat)amount
{
    CGRect frame = self.frame;
    frame.origin.x += amount;
    self.frame = frame;
}

- (void) moveY:(CGFloat)amount
{
    CGRect frame = self.frame;
    frame.origin.y += amount;
    self.frame = frame;
}

- (void) positionAboveView:(UIView*)view
{
    [self positionAboveView:view margin:0];
}
- (void) positionBelowView:(UIView*)view
{
    [self positionBelowView:view margin:0];
}
- (void) positionLeftToView:(UIView*)view
{
    [self positionLeftToView:view margin:0];
}
- (void) positionRightToView:(UIView*)view
{
    [self positionRightToView:view margin:0];
}

- (void) alignCenter:(UIView*)view
{
    CGRect frame = self.frame;
    CGRect otherFrame = view.frame;
    frame.origin.x = otherFrame.origin.x + (otherFrame.size.width - frame.size.width)/2;
    frame.origin.y = otherFrame.origin.y + (otherFrame.size.height - frame.size.height)/2;
    self.frame = frame;
}

- (void) alignCenterHorizontal:(UIView*)view
{
    [self alignCenterHorizontal:view
                         margin:0];
}

- (void) alignCenterVertical:(UIView*)view
{
    [self alignCenterVertical:view
                       margin:0];
}

- (void) alignCenterVertical:(UIView*)view
                      margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    CGRect otherFrame = view.frame;
    frame.origin.y = otherFrame.origin.y + (otherFrame.size.height - frame.size.height)/2 + margin;
    self.frame = frame;
}

- (void) alignCenterHorizontal:(UIView*)view
                        margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    CGRect otherFrame = view.frame;
    frame.origin.x = otherFrame.origin.x + (otherFrame.size.width - frame.size.width)/2 + margin;
    self.frame = frame;
}

- (void) alignTop:(UIView*)view
{
    [self alignTop:view margin:0];
}
- (void) alignBottom:(UIView*)view
{
    [self alignBottom:view margin:0];
}
- (void) alignLeft:(UIView*)view
{
    [self alignLeft:view margin:0];
}
- (void) alignRight:(UIView*)view
{
    [self alignRight:view margin:0];
}


- (void) alignParentCenterHorizontal
{
    CGRect frame = self.frame;
    CGRect parentFrame = self.superview.frame;
    frame.origin.x = (parentFrame.size.width - frame.size.width)/2;
    self.frame = frame;
}

- (void) alignParentCenterVertical
{
    CGRect frame = self.frame;
    CGRect parentFrame = self.superview.frame;
    frame.origin.y = (parentFrame.size.height - frame.size.height)/2;
    self.frame = frame;
}

- (void) alignParentTop
{
    [self alignParentTopWithMargin:0];
}
- (void) alignParentBottom
{
    [self alignParentBottomWithMargin:0];
}
- (void) alignParentLeft
{
    [self alignParentLeftWithMargin:0];
}
- (void) alignParentRight
{
    [self alignParentRightWithMargin:0];
}

- (void) positionAboveView:(UIView*)view
                    margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.y = view.frame.origin.y - frame.size.height - margin;
    self.frame = frame;
}

- (void) positionBelowView:(UIView*)view
                    margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.y = view.frame.origin.y + view.frame.size.height + margin;
    self.frame = frame;
}

- (void) positionLeftToView:(UIView*)view
                     margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.x = view.frame.origin.x - frame.size.width - margin;
    self.frame = frame;
}

- (void) positionRightToView:(UIView*)view
                      margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.x = view.frame.origin.x + view.frame.size.width + margin;
    self.frame = frame;
}

- (void) alignTop:(UIView*)view
           margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.y = view.frame.origin.y + margin;
    self.frame = frame;
}

- (void) alignBottom:(UIView*)view
              margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    CGRect otherFrame = view.frame;
    frame.origin.y = otherFrame.origin.y + otherFrame.size.height - frame.size.height - margin;
    self.frame = frame;
}

- (void) alignLeft:(UIView*)view
            margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.x = view.frame.origin.x + margin;
    self.frame = frame;
}

- (void) alignRight:(UIView*)view
             margin:(CGFloat)margin
{
    CGRect frame = self.frame;
    CGRect otherFrame = view.frame;
    frame.origin.x = otherFrame.origin.x + otherFrame.size.width - frame.size.width - margin;
    self.frame = frame;
}

- (void) alignParentTopWithMargin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.y = margin;
    self.frame = frame;
}

- (void) alignParentBottomWithMargin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.y = self.superview.frame.size.height - frame.size.height - margin;
    self.frame = frame;
}

- (void) alignParentLeftWithMargin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.x = margin;
    self.frame = frame;
}

- (void) alignParentRightWithMargin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.x = self.superview.frame.size.width - frame.size.width - margin;
    self.frame = frame;
}

- (void) setPositionAndSizeFromView:(UIView*)view
{
    self.frame = view.frame;
}

- (void) setPositionAndSizeFromView:(UIView*)view
                             margin:(CGFloat)margin
{
    CGRect frame = view.frame;
    
    frame.origin.x += margin;
    frame.origin.y += margin;
    frame.size.width -= margin;
    frame.size.height -= margin;
    
    self.frame = frame;
}

- (void) fillParent
{
    self.frame = self.superview.bounds;
}

- (void) fillParentWithMargin:(CGFloat)margin
{
    CGRect frame = self.superview.frame;
    
    frame.origin.x = margin;
    frame.origin.y = margin;
    frame.size.width -= margin*2;
    frame.size.height -= margin*2;
    
    self.frame = frame;
}

@end
