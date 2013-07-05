//
//  BVSucursalInfoViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 05-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVSucursalInfoViewController.h"
#import "GradientBackgroundHeader.h"

@interface BVSucursalInfoViewController ()

@end

@implementation BVSucursalInfoViewController

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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = [self.sucursal.nombre capitalizedString];
    self.cellEncargado.textLabel.text = [self.sucursal.encargado capitalizedString];
    [(UILabel *)[self.cellDireccion viewWithTag:1] setText:self.sucursal.direccion];
    self.cellRegion.detailTextLabel.text = self.sucursal.region;
    [(UILabel *)[self.cellTelefono viewWithTag:1] setText:self.sucursal.fono];
    self.cellFax.detailTextLabel.text = self.sucursal.fax;
    self.cellHorarioA.detailTextLabel.text = self.sucursal.horario1;
    self.cellHorarioB.detailTextLabel.text = self.sucursal.horario2;
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
    header.haveTopBorder = NO;
    
    if (section==0)
        [header setLeftLabelText:@"Información" isFontSizeBig:NO];
    else if (section==1)
            [header setLeftLabelText:@"Dirección" isFontSizeBig:NO];
    else if (section==2)
        [header setLeftLabelText:@"Horarios" isFontSizeBig:NO];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0 && indexPath.row==1)
        [self hacerLlamadaA:self.sucursal.fono];
    else if ([indexPath section]==1 && indexPath.row==0){
        NSLog(@"apple map");
    }
    
}

-(void)hacerLlamadaA:(NSString *)numero
{
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:numero];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)llamar:(id)sender
{
    [self hacerLlamadaA:self.sucursal.fono];
}

-(float)getWidth
{
    return self.tableView.frame.size.width;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
