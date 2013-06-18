//
//  BVRutTextField.m
//  ios-clientes
//
//  Created by Pedro Cortez on 18-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVRutTextField.h"

@implementation BVRutTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setKeyboardType:UIKeyboardTypeNumberPad];
        self.font = [UIFont systemFontOfSize:15.0f];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
