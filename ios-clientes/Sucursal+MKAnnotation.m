//
//  Sucursal+MKAnnotation.m
//  ios-clientes
//
//  Created by Pedro Cortez on 04-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Sucursal+MKAnnotation.h"

@implementation Sucursal (MKAnnotation)

// part of the MKAnnotation protocol

- (NSString *)title
{
    return self.nombre;
}

// part of the MKAnnotation protocol

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%@", self.direccion ];
}

// (required) part of the MKAnnotation protocol
// just picks the location of a random photo by this photographer

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.latitud doubleValue];
    coordinate.longitude = [self.longitud doubleValue];
    return coordinate;
}


@end
