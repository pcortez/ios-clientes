//
//  GradientBackground.m
//  ios-clientes
//
//  Created by Pedro Cortez on 28-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "GradientBackground.h"
#import "CommonDrawing.h"

@implementation GradientBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundWidth = 0.0;
    }
    return self;
}


- (id)initWithDelegate:(id<GradientBackgroundDelegate>)delegate
{
    if ((self = [self initWithDelegate:delegate haveTopBorder:NO])){
        //extra
    }
    return self;
}

- (id)initWithDelegate:(id<GradientBackgroundDelegate>)delegate haveTopBorder:(BOOL) haveTopBorder
{
    
    if ((self = [self initWithBackgroundSize:-1.0 haveTopBorder:haveTopBorder])){
        //extra
        self.delegate = delegate;
    }
    return self;
}


- (id)initWithBackgroundSize:(float)width
{
    if ((self = [self initWithBackgroundSize:width haveTopBorder:NO])){
        //extra
    }
    return self;
}

- (id)initWithBackgroundSize:(float)width haveTopBorder:(BOOL)haveTopBorder;
{
    if ((self = [super init])) {
        self.backgroundWidth = width;
        self.haveTopBorder = haveTopBorder;
        self.colorGradientTop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.colorGradientBottom = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
        self.colorRightSection = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.colorSeparatorLine = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float bgWidth = self.backgroundWidth;
    if (self.backgroundWidth == -1.0) {
        bgWidth = [self.delegate getWidth];
    }
    
    CGRect paperRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, bgWidth, self.bounds.size.height);
    
    if ([self.colorGradientTop isEqual:self.colorGradientBottom])
        drawFillRect(context, paperRect, self.colorGradientBottom.CGColor);
    else
        drawLinearGradient(context, paperRect, self.colorGradientTop.CGColor, self.colorGradientBottom.CGColor);
    
    // Lines
    draw1PxStroke(context,
                  CGPointMake(paperRect.origin.x+paperRect.size.width,paperRect.origin.y),
                  CGPointMake(paperRect.origin.x + paperRect.size.width,paperRect.origin.y + paperRect.size.height),
                  self.colorSeparatorLine.CGColor);
    
    
    //white rect
    if (self.backgroundWidth != -1.0){
        paperRect = CGRectMake(bgWidth+1, self.bounds.origin.y, self.bounds.size.width-bgWidth-1, self.bounds.size.height);
    
        drawFillRect(context, paperRect, self.colorRightSection.CGColor);
    }
    
    draw1PxStroke(context,
                  CGPointMake(self.bounds.origin.x,self.bounds.origin.y + self.bounds.size.height - 1),
                  CGPointMake(self.bounds.origin.x + self.frame.size.width,self.bounds.origin.y + self.bounds.size.height - 1),
                  self.colorSeparatorLine.CGColor);
    
    if (self.haveTopBorder) {
        draw1PxStroke(context,
                      CGPointMake(self.bounds.origin.x,self.bounds.origin.y),
                      CGPointMake(self.bounds.origin.x + self.bounds.size.width,self.bounds.origin.y),
                      self.colorSeparatorLine.CGColor);
    }
}

@end
