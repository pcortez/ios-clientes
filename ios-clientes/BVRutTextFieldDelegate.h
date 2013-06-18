//
//  BVRutTextFieldDelegate.h
//  ios-clientes
//
//  Created by Pedro Cortez on 18-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BVRutTextFieldDelegate <NSObject>
@required
- (void)isCorrectInput:(BOOL) value;
@end
