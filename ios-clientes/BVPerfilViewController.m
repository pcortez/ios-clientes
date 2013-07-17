//
//  BVPerfilViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 01-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVPerfilViewController.h"
#import "BVEditarPerfilViewController.h"
#import "GradientBackgroundHeader.h"
#import "PhoneNumberFormatter.h"

@interface BVPerfilViewController ()

@end

@implementation BVPerfilViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController setTitle:@"Configuración"];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setContentInset:UIEdgeInsetsMake(64, self.tableView.contentInset.left, self.tableView.contentInset.bottom+48, self.tableView.contentInset.right)];
    
    self.cellNombre.detailTextLabel.text = [self.cliente.nombre capitalizedString];
    self.cellApellido.detailTextLabel.text = [self.cliente.apellido capitalizedString];
    self.cellRut.detailTextLabel.text = [self.cliente.rut uppercaseString];
    
    if (!self.cliente.email || [self.cliente.email isEqualToString:@""])
        [(UILabel *)[self.cellEmail viewWithTag:10] setText:@"editar e-mail"];
    else
        [(UILabel *)[self.cellEmail viewWithTag:10] setText:[self.cliente.email lowercaseString]];
    
    [(UILabel *)[self.cellDireccion viewWithTag:10] setText: @"Los Juncos 171"];
    [(UILabel *)[self.cellComuna viewWithTag:10] setText: @"Las Condes"];

    if (!self.cliente.celular || [self.cliente.celular isEqualToString:@""]) {
        [(UILabel *)[self.cellCelular viewWithTag:10] setText: @"editar celular"];
    }
    else{
        PhoneNumberFormatter *formatter = [[PhoneNumberFormatter alloc] init];
        NSString *formattedNumber = [formatter stringForObjectValue:self.cliente.celular];
        [(UILabel *)[self.cellCelular viewWithTag:10] setText: formattedNumber];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GradientBackgroundHeader *header=[[GradientBackgroundHeader alloc]initWithDelegate:self labelHeight:30.0];
    [header setLeftLabelText:(section==0?@"Cliente":@"Información") isFontSizeBig:NO];
    header.haveTopBorder = !(section==0);
    return header;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    UINavigationController *navController = (UINavigationController *) [segue destinationViewController];
    
    BVEditarPerfilViewController *vc = (BVEditarPerfilViewController *) [[navController viewControllers] objectAtIndex:0];
    
    
    if ([segue.identifier isEqualToString:@"EmailEditarSegue"]) {
        [vc performSelector:@selector(setParametro:) withObject:@"E-mail"];
        [vc performSelector:@selector(setValor:)withObject:[self.cliente.email lowercaseString]];
    }
    else if ([segue.identifier isEqualToString:@"DireccionEditarSegue"]){
        [vc performSelector:@selector(setParametro:) withObject:@"Direccion"];
        [vc performSelector:@selector(setValor:)withObject:@"Los Juncos 171"];
    }
    else if ([segue.identifier isEqualToString:@"ComunaEditarSegue"]){
        [vc performSelector:@selector(setParametro:) withObject:@"Comuna"];
        [vc performSelector:@selector(setValor:)withObject:@"Las Condes"];
    }
    else if ([segue.identifier isEqualToString:@"CelularEditarSegue"]){
        [vc performSelector:@selector(setParametro:) withObject:@"Celular"];
        [vc performSelector:@selector(setValor:)withObject:self.cliente.celular];
    }
    
}

- (IBAction) editEmail:(id)sender{[self performSegueWithIdentifier:@"EmailEditarSegue" sender:self];}
- (IBAction) editDireccion:(id)sender{[self performSegueWithIdentifier:@"DireccionEditarSegue" sender:self];}
- (IBAction) editComuna:(id)sender{[self performSegueWithIdentifier:@"ComunaEditarSegue" sender:self];}
- (IBAction) editCeluar:(id)sender{ [self performSegueWithIdentifier:@"CelularEditarSegue" sender:self]; }

- (IBAction)unwindToViewControllerProductosCancelar:(UIStoryboardSegue *)segue{}
- (IBAction)unwindToViewControllerProductosGuardar:(UIStoryboardSegue *)segue
{
    
    BVEditarPerfilViewController *vc = segue.sourceViewController;
    if ([vc.valor isEqualToString:@""]) return;
    
    if ([vc.parametro isEqualToString:@"E-mail"]) {
        self.cliente.email = [vc.valor lowercaseString];
        [(UILabel *)[self.cellEmail viewWithTag:10] setText:[vc.valor lowercaseString]];
    }
    else if ([vc.parametro isEqualToString:@"Direccion"]) {
        //self.cliente.email = [vc.valor lowercaseString];
        [(UILabel *)[self.cellDireccion viewWithTag:10] setText: [vc.valor capitalizedString]];
    }
    else if ([vc.parametro isEqualToString:@"Comuna"]) {
        //self.cliente.email = [vc.valor lowercaseString];
        [(UILabel *)[self.cellComuna viewWithTag:10] setText: [vc.valor capitalizedString]];
    }
    else if ([vc.parametro isEqualToString:@"Celular"]) {
        self.cliente.celular = [vc.valor lowercaseString];
        PhoneNumberFormatter *formatter = [[PhoneNumberFormatter alloc] init];
        NSString *formattedNumber = [formatter stringForObjectValue:[vc.valor lowercaseString]];
        [(UILabel *)[self.cellCelular viewWithTag:10] setText: formattedNumber];
    }
    
}

-(float)getWidth{
    return self.view.frame.size.width;
}


@end
