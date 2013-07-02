//
//  BVPerfilViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 01-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Usuario.h"
#import "GradientBackgroundDelegate.h"

@interface BVPerfilViewController : UITableViewController<GradientBackgroundDelegate>

@property (strong, nonatomic) Usuario *cliente;

/*
@property (weak, nonatomic) IBOutlet UITableViewCell *nombreCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *apellidoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *rutCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *comunaCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *direccionCell;
*/
-(float)getWidth;

@end
