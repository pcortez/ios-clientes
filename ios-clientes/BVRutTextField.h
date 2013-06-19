//
//  BVRutTextField.h
//  ios-clientes
//
//  Created by Pedro Cortez on 18-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVRutTextFieldDelegate.h"

@interface BVRutTextField : UITextField

@property (weak, nonatomic) id<BVRutTextFieldDelegate> customDelegate;
- (NSString *)getRutConVerificador:(BOOL)verificador;

-(IBAction)editBegin:(id)sender;
-(IBAction)editDidEnd:(id)sender;
-(IBAction)editChangeEnd:(id)sender;

@end
