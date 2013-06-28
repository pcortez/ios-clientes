//
//  GradientBackground.h
//  ios-clientes
//
//  Created by Pedro Cortez on 28-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GradientBackgroundDelegate.h"

@interface GradientBackground : UIView
@property (assign) float backgroundWidth;
@property (assign) BOOL haveTopBorder;
@property (nonatomic,strong) UIColor *colorGradientTop;
@property (nonatomic,strong) UIColor *colorGradientBottom;
@property (nonatomic,strong) UIColor *colorRightSection;
@property (nonatomic,strong) UIColor *colorSeparatorLine;
@property (weak, nonatomic) id<GradientBackgroundDelegate> delegate;


- (id)initWithDelegate:(id<GradientBackgroundDelegate>)delegate;
- (id)initWithDelegate:(id<GradientBackgroundDelegate>)delegate haveTopBorder:(BOOL) haveTopBorder;
- (id)initWithBackgroundSize:(float)width;
- (id)initWithBackgroundSize:(float)width haveTopBorder:(BOOL)haveTopBorder;

@end
