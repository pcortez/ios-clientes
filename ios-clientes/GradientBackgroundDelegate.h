//
//  GradientBackgroundDelegate.h
//  ios-clientes
//
//  Created by Pedro Cortez on 28-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GradientBackgroundDelegate <NSObject>
@required
- (float) getWidth;
@end
