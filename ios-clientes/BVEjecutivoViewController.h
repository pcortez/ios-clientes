//
//  BVEjecutivoViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 15-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GradientBackgroundDelegate.h"
#import "Usuario+Create.h"

@interface BVEjecutivoViewController : UITableViewController<GradientBackgroundDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) Usuario *cliente;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *labelNombres;
@property (weak, nonatomic) IBOutlet UILabel *labelApellidos;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellTelefono;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellEmail;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDireccion;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellRegion;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellNombreJefe;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellTelefonoJefe;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellEmailJefe;


- (IBAction)llamar:(id)sender;
- (IBAction)llamarJefe:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)emailJefe:(id)sender;
- (IBAction)recorrido:(id)sender;

-(float)getWidth;
@end
