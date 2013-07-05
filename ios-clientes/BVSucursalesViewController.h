//
//  BVSucursalesViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 04-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BVSucursalesViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet MKMapView *mapa;

@end
