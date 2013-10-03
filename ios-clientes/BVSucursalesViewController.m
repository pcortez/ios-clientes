//
//  BVSucursalesViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 04-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVSucursalesViewController.h"
#import "BVSucursalInfoViewController.h"
#import "Sucursal+MKAnnotation.h"
#import "Sucursal+Create.h"
#import "BVApiConnection.h"

@interface BVSucursalesViewController(){
    CLLocationManager *locationManager;
}

@end

@implementation BVSucursalesViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (CLLocationManager *)locationManager {
    CLLocationManager *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(locationManager)]) {
        context = [delegate locationManager];
    }
    return context;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController setTitle:@"Sucursales"];
    [super viewWillAppear:animated];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.managedObjectContext = [self managedObjectContext];
    [self reload];
	self.mapa.delegate = self;
    locationManager = [self locationManager];//[[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //locationManager.distanceFilter = kCLDistanceFilterNone;
    //locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    //thread
    //se cargan aqui ya que cambian muy poco los datos
    dispatch_queue_t downloadQueue = dispatch_queue_create("autentificacion web service", NULL);
    dispatch_async(downloadQueue, ^{
        NSDictionary *jsonSucursales = getSucursales(self.cliente.accessToken);
        dispatch_async(dispatch_get_main_queue(), ^{
            //sucursales
            if (jsonSucursales) {
                NSArray *sucursales = [jsonSucursales objectForKey:@"sucursales"];
                for (NSDictionary *sucursal in sucursales) {
                    [Sucursal fromDictionary:sucursal inManagedObjectContext:self.managedObjectContext];
                }
                [self.managedObjectContext save:nil];
                [self reload];
            }
        });
    });

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locationManager stopUpdatingLocation];
    //CLLocation *location = [locations lastObject];
    self.currentLocation = [locations lastObject];
    
    CLLocation *minLocation;
    CLLocation *auxLocation;
    CLLocationDistance minDistanceInMeters;
    CLLocationDistance distanceInMeters;
    BOOL first = YES;
    for (id <MKAnnotation> annotation in self.mapa.annotations) {
        if (first) {
            minLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            minDistanceInMeters = [self.currentLocation distanceFromLocation:minLocation];
            first = NO;
        }
        else{
            auxLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            distanceInMeters = [self.currentLocation distanceFromLocation:auxLocation];
            if (minDistanceInMeters>distanceInMeters) {
                minLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
                minDistanceInMeters = distanceInMeters;
            }
        }
    }
    
    CGRect boundingRect = CGRectMake(minLocation.coordinate.latitude, minLocation.coordinate.longitude, 0, 0);
    boundingRect = CGRectUnion(boundingRect, CGRectMake(self.currentLocation.coordinate.latitude, self.currentLocation
                                                        .coordinate.longitude, 0, 0));
    
    boundingRect = CGRectInset(boundingRect, -0.002, -0.002);
    MKCoordinateRegion region;
    region.center.latitude = boundingRect.origin.x + boundingRect.size.width / 2;
    region.center.longitude = boundingRect.origin.y + boundingRect.size.height / 2;
    region.span.latitudeDelta = boundingRect.size.width;
    region.span.longitudeDelta = boundingRect.size.height;
    
    [self.mapa setRegion:region animated:YES];
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *reuseId = @"BVSucursalesViewController";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        view.canShowCallout = YES;
        if ([mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
            view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
    }
    
    return view;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"InfoSegue" sender:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sucursal"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *sucursales = [self.managedObjectContext executeFetchRequest:request error:&error];
    [self.mapa removeAnnotations:self.mapa.annotations];
    [self.mapa addAnnotations:sucursales];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"InfoSegue"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *aView = sender;
            if ([aView.annotation isKindOfClass:[Sucursal class]]) {
                Sucursal *auxSucursal = aView.annotation;
                if ([segue.destinationViewController respondsToSelector:@selector(setSucursal:)] && [segue.destinationViewController respondsToSelector:@selector(setCurrentLocation:)]) {
                    [segue.destinationViewController performSelector:@selector(setSucursal:) withObject:auxSucursal];
                    [segue.destinationViewController performSelector:@selector(setCurrentLocation:) withObject:self.currentLocation];
                }
            }
        }
    }
}

@end
