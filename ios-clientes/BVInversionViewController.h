//
//  BVInversionViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 19-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientBackgroundDelegate.h"
#import "Usuario+Create.h"
#import "Productos+Create.h"
#import "CoreDataTableViewController.h"

@interface BVInversionViewController : CoreDataTableViewController<GradientBackgroundDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Usuario *cliente;
@property (strong, nonatomic) Productos *producto;

-(float)getWidth;
- (void) loadData;
@end
