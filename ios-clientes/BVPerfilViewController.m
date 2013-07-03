//
//  BVPerfilViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 01-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVPerfilViewController.h"
#import "BVEditarPerfilViewController.h"
#import "GradientBackground.h"
#import "GradientBackgroundHeader.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(64, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
    
    GradientBackground *cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    
    
    self.cellNombre.detailTextLabel.text = [self.cliente.nombre capitalizedString];
    self.cellNombre.backgroundView = cellBackgroundView;
    
    cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    self.cellApellido.detailTextLabel.text = [self.cliente.apellido capitalizedString];
    self.cellApellido.backgroundView = cellBackgroundView;

    cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    self.cellRut.detailTextLabel.text = [self.cliente.rut uppercaseString];
    self.cellRut.backgroundView = cellBackgroundView;
    
    cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    self.cellEmail.detailTextLabel.text = [self.cliente.email lowercaseString];
    self.cellEmail.backgroundView = cellBackgroundView;
    
    cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    self.cellDireccion.detailTextLabel.text = @"Los Juncos 171";
    self.cellDireccion.backgroundView = cellBackgroundView;
    
    cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    self.cellComuna.detailTextLabel.text = @"Las Condes";
    self.cellComuna.backgroundView = cellBackgroundView;
    
    cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    self.cellCelular.detailTextLabel.text = self.cliente.celular;
    self.cellCelular.backgroundView = cellBackgroundView;

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
    GradientBackgroundHeader *header = [[GradientBackgroundHeader alloc]initWithDelegate:self labelHeight:30.0];
    [header setLeftLabelText:(section==0?@"Cliente":@"Información") isFontSizeBig:NO];
    header.haveTopBorder = NO;
    return header;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"EmailEditarSegue"]) {
        [[segue destinationViewController] performSelector:@selector(setParametro:) withObject:@"E-mail"];
        [[segue destinationViewController] performSelector:@selector(setValor:)withObject:[self.cliente.email lowercaseString]];
    }
    else if ([segue.identifier isEqualToString:@"DireccionEditarSegue"]){
        [[segue destinationViewController] performSelector:@selector(setParametro:) withObject:@"Direccion"];
        [[segue destinationViewController] performSelector:@selector(setValor:)withObject:@"Los Juncos 171"];
    }
    else if ([segue.identifier isEqualToString:@"ComunaEditarSegue"]){
        [[segue destinationViewController] performSelector:@selector(setParametro:) withObject:@"Comuna"];
        [[segue destinationViewController] performSelector:@selector(setValor:)withObject:@"Las Condes"];
    }
    else if ([segue.identifier isEqualToString:@"CelularEditarSegue"]){
        [[segue destinationViewController] performSelector:@selector(setParametro:) withObject:@"Celular"];
        [[segue destinationViewController] performSelector:@selector(setValor:)withObject:self.cliente.celular];
    }
    
}

- (IBAction)unwindToViewControllerProductosCancelar:(UIStoryboardSegue *)segue
{
    
}
- (IBAction)unwindToViewControllerProductosGuardar:(UIStoryboardSegue *)segue
{
    BVEditarPerfilViewController *vc = segue.sourceViewController;
    if ([vc.parametro isEqualToString:@"E-mail"]) {
        self.cliente.email = [vc.valor lowercaseString];
        self.cellEmail.detailTextLabel.text = [vc.valor lowercaseString];
    }
    else if ([vc.parametro isEqualToString:@"Direccion"]) {
        //self.cliente.direccion = [vc.valor capitalizedString];
        self.cellDireccion.detailTextLabel.text = [vc.valor capitalizedString];
    }
    else if ([vc.parametro isEqualToString:@"Comuna"]) {
        //self.cliente.direccion = [vc.valor capitalizedString];
        self.cellComuna.detailTextLabel.text = [vc.valor capitalizedString];
    }
    else if ([vc.parametro isEqualToString:@"Celular"]) {
        self.cliente.celular = [vc.valor lowercaseString];
        self.cellCelular.detailTextLabel.text = [vc.valor lowercaseString];
    }
    
}

-(float)getWidth{
    return self.view.frame.size.width;
}


@end
