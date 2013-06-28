//
//  CommonDrawing.h
//  ios-clientes
//
//  Created by Pedro Cortez on 28-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDrawing : NSObject

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor,CGColorRef  endColor);
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);
CGRect rectFor1PxStroke(CGRect rect);
void drawFillRect(CGContextRef context, CGRect rect, CGColorRef color);


@end
