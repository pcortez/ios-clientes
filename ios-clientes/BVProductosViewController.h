//
//  BVProductosViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 26-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "GradientBackgroundDelegate.h"
#import "Usuario.h"

@interface BVProductosViewController: CoreDataTableViewController<GradientBackgroundDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Usuario *cliente;

-(float)getWidth;
@end
