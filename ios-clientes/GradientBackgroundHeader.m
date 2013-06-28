//
//  GradientBackgroundHeader.m
//  ios-clientes
//
//  Created by Pedro Cortez on 28-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "GradientBackgroundHeader.h"
#import "CommonDrawing.h"

@implementation GradientBackgroundHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithDelegate:(id<GradientBackgroundDelegate>)delegate labelHeight:(float) labelHeight
{
    if ((self = [super initWithDelegate:delegate haveTopBorder:NO])){
        fontSmallSize = 10.0;
        fontNormalSize = 12.0;
        fontBigSize = 15.0;
        self.height = labelHeight;
    }
    return self;
}
//font size (section!=3)?12.0:16.0
- (void)setLeftLabelText:(NSString *)text isFontSizeBig:(BOOL)isFontSizeBig
{
    //rectFor1PxStroke
    self.labelLeft = [[UILabel alloc]initWithFrame:CGRectMake(10,0,250,self.height)];
    self.labelLeft.backgroundColor=[UIColor clearColor];
    self.labelLeft.textColor = [UIColor blackColor];
    self.labelLeft.font = [UIFont boldSystemFontOfSize:((isFontSizeBig?fontBigSize:fontNormalSize))];
    self.labelLeft.text = text;
    [self addSubview:self.labelLeft];
}


- (void)setRightLabelText:(NSString *)text
{
    self.labelRight = [[UILabel alloc]initWithFrame:CGRectMake(150,0,70,self.height-1)];
    self.labelRight.backgroundColor=[UIColor clearColor];
    self.labelRight.textColor = [UIColor blackColor];
    self.labelRight.font = [UIFont boldSystemFontOfSize:(fontSmallSize)];
    self.labelRight.text = text;
    
    [self.labelRight setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.labelRight];
    
    NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:0 toItem:self.labelRight attribute:NSLayoutAttributeRight multiplier:1 constant:10.f];
    
    [self addConstraint:con1];
}

@end
