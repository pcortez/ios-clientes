//
//  BVEjecutivoViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 15-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVEjecutivoViewController.h"

#import "GradientBackgroundHeader.h"

@interface BVEjecutivoViewController ()

@end

@implementation BVEjecutivoViewController

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
    [self.tabBarController setTitle:@"Ejecutivo de Cuenta"];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(64, self.tableView.contentInset.left, self.tableView.contentInset.bottom+48, self.tableView.contentInset.right)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section==0?0:30.0);
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return nil;
    
    GradientBackgroundHeader *header=[[GradientBackgroundHeader alloc]initWithDelegate:self labelHeight:30.0];
    header.haveTopBorder = !(section==0);
    
    if (section==1)
        [header setLeftLabelText:@"Información" isFontSizeBig:NO];
    else if (section==2)
        [header setLeftLabelText:@"Sucursal" isFontSizeBig:NO];
    else if (section==3)
        [header setLeftLabelText:@"Jefe de Unidad" isFontSizeBig:NO];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==1 && indexPath.row==0)
        [self hacerLlamadaA:@"+56982093175"];
    else if ([indexPath section]==1 && indexPath.row==1)
        [self mandarEmailA:@"pcortez@gmail.com"];
    else if ([indexPath section]==3 && indexPath.row==1)
        [self hacerLlamadaA:@"+56982093175"];
    else if ([indexPath section]==3 && indexPath.row==2)
        [self mandarEmailA:@"pcortez@gmail.com"];
}


-(void)hacerLlamadaA:(NSString *)numero
{
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:numero];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

-(void)mandarEmailA:(NSString *)direccion
{
    NSString *url = [@"mailto:" stringByAppendingString:direccion];
    url = [url stringByAppendingString:@"?subject=Bice%20Vida%20Ayuda"];
    ///NSString *url = [NSString stringWithString: @"mailto:foo@example.com?cc=bar@example.com&subject=Greetings%20from%20Cupertino!&body=Wish%20you%20were%20here!"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


- (IBAction)email:(id)sender{ [self mandarEmailA:@"pcortez@gmail.com"];}
- (IBAction)emailJefe:(id)sender{ [self mandarEmailA:@"pcortez@gmail.com"];}

- (IBAction)llamar:(id)sender{[self hacerLlamadaA:@"+56982093175"];}
- (IBAction)llamarJefe:(id)sender{[self hacerLlamadaA:@"+56982093175"];}

-(float)getWidth
{
    return self.tableView.frame.size.width;
}

@end
