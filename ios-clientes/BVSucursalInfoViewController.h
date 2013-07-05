//
//  BVSucursalInfoViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 05-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sucursal.h"
#import "GradientBackgroundDelegate.h"

@interface BVSucursalInfoViewController : UITableViewController<GradientBackgroundDelegate>

@property (nonatomic, strong) Sucursal *sucursal;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellEncargado;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellTelefono;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellFax;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDireccion;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellHorarioA;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellHorarioB;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellRegion;


-(float)getWidth;
@end
