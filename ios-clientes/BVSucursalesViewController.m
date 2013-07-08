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

@interface BVSucursalesViewController (){
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
    [locationManager startUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.managedObjectContext = [self managedObjectContext];
    [self reload];
	self.mapa.delegate = self;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locationManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    
    
    //NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    
    //MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:location.coordinate addressDictionary:nil];
    
    CLLocation *minLocation;
    CLLocation *auxLocation;
    CLLocationDistance minDistanceInMeters;
    CLLocationDistance distanceInMeters;
    BOOL first = YES;
    for (id <MKAnnotation> annotation in self.mapa.annotations) {
        if (first) {
            minLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            minDistanceInMeters = [location distanceFromLocation:minLocation];
            first = NO;
        }
        else{
            auxLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            distanceInMeters = [location distanceFromLocation:auxLocation];
            if (minDistanceInMeters>distanceInMeters) {
                minLocation = [[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
                minDistanceInMeters = distanceInMeters;
            }
        }
    }
    
    CGRect boundingRect = CGRectMake(minLocation.coordinate.latitude, minLocation.coordinate.longitude, 0, 0);
    boundingRect = CGRectUnion(boundingRect, CGRectMake(location.coordinate.latitude, location.coordinate.longitude, 0, 0));
    
    boundingRect = CGRectInset(boundingRect, -0.002, -0.002);
    MKCoordinateRegion region;
    region.center.latitude = boundingRect.origin.x + boundingRect.size.width / 2;
    region.center.longitude = boundingRect.origin.y + boundingRect.size.height / 2;
    region.span.latitudeDelta = boundingRect.size.width;
    region.span.longitudeDelta = boundingRect.size.height;
    
    [self.mapa setRegion:region animated:YES];
    
    /*
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey :   MKLaunchOptionsDirectionsModeDriving };
    MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:minLocation.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:@"Destino"];
    [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
    */
    
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
                if ([segue.destinationViewController respondsToSelector:@selector(setSucursal:)]) {
                    [segue.destinationViewController performSelector:@selector(setSucursal:) withObject:auxSucursal];
                }
            }
        }
    }
}

@end
