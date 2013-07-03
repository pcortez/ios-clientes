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
@property (weak, nonatomic) IBOutlet UITableViewCell *cellNombre;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellApellido;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellRut;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellEmail;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDireccion;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellComuna;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellCelular;

-(float)getWidth;
- (IBAction)unwindToViewControllerProductosGuardar:(UIStoryboardSegue *)segue;
- (IBAction)unwindToViewControllerProductosCancelar:(UIStoryboardSegue *)segue;

@end
