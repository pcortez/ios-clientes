//
//  BVEjecutivoViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 15-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVEjecutivoViewController.h"

#import "GradientBackgroundHeader.h"

@interface BVEjecutivoViewController(){
    CLLocationManager *locationManager;
}

@end

@implementation BVEjecutivoViewController

- (CLLocationManager *)locationManager {
    CLLocationManager *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(locationManager)]) {
        context = [delegate locationManager];
    }
    return context;
}

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
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(64, self.tableView.contentInset.left, self.tableView.contentInset.bottom+48, self.tableView.contentInset.right)];
    
    locationManager = [self locationManager];
    locationManager.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locationManager stopUpdatingLocation];
    self.currentLocation = [locations lastObject];
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
    else if ([indexPath section]==2 && indexPath.row==0)
        [self recorridoA:-33.425227 and: -70.614542];
    else if ([indexPath section]==3 && indexPath.row==1)
        [self hacerLlamadaA:@"+56982093175"];
    else if ([indexPath section]==3 && indexPath.row==2)
        [self mandarEmailA:@"pcortez@gmail.com"];
}


- (void)hacerLlamadaA:(NSString *)numero
{
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:numero];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)mandarEmailA:(NSString *)direccion
{
    NSString *url = [@"mailto:" stringByAppendingString:direccion];
    url = [url stringByAppendingString:@"?subject=Bice%20Vida%20Ayuda"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)recorridoA:(double)latitud and:(double)longitud
{
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking};
    //current location
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.currentLocation.coordinate addressDictionary:nil];
    MKMapItem *currentLocationMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [currentLocationMapItem setName:@"Yo"];
    
    //posicion sucursal
    CLLocationCoordinate2D aux = CLLocationCoordinate2DMake(latitud, longitud);
    
    MKPlacemark *placemarkSucursal = [[MKPlacemark alloc] initWithCoordinate:aux addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemarkSucursal];
    [mapItem setName:@"Sucursal"];
    
    [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
}


- (IBAction)recorrido:(id)sender{ [self recorridoA:-33.425227 and: -70.614542];}

- (IBAction)email:(id)sender{ [self mandarEmailA:@"pcortez@gmail.com"];}
- (IBAction)emailJefe:(id)sender{ [self mandarEmailA:@"pcortez@gmail.com"];}

- (IBAction)llamar:(id)sender{[self hacerLlamadaA:@"+56982093175"];}
- (IBAction)llamarJefe:(id)sender{[self hacerLlamadaA:@"+56982093175"];}

-(float)getWidth
{
    return self.tableView.frame.size.width;
}

@end
