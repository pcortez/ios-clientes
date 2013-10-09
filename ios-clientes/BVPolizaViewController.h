//
//  BVPolizaViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 09-10-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "GradientBackgroundDelegate.h"
#import "PolizaItem+Create.h"
#import "PolizaItem+Create.h"

@interface BVPolizaViewController : CoreDataTableViewController<GradientBackgroundDelegate>

@property (strong, nonatomic) Productos *producto;

-(float)getWidth;
@end
