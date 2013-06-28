//
//  GradientBackgroundHeader.h
//  ios-clientes
//
//  Created by Pedro Cortez on 28-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientBackground.h"

@interface GradientBackgroundHeader : GradientBackground {
// will be private in class
@private
float fontSmallSize;
float fontNormalSize;
float fontBigSize;
}

@property (nonatomic,strong) UILabel *labelLeft;
@property (nonatomic,strong) UILabel *labelRight;
@property (assign) float height;


- (id)initWithDelegate:(id<GradientBackgroundDelegate>)delegate labelHeight:(float) labelHeight;
- (void)setLeftLabelText:(NSString *)text isFontSizeBig:(BOOL)isFontSizeBig;
- (void)setRightLabelText:(NSString *)text;
@end
