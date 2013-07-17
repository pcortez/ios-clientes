//
//  BVEjecutivoViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 15-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientBackgroundDelegate.h"
@interface BVEjecutivoViewController : UITableViewController<GradientBackgroundDelegate>

-(void)hacerLlamadaA:(NSString *)numero;
- (IBAction)llamar:(id)sender;
- (IBAction)llamarJefe:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)emailJefe:(id)sender;

-(float)getWidth;
@end
