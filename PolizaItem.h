//
//  PolizaItem.h
//  ios-clientes
//
//  Created by Pedro Cortez on 08-10-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Productos;

@interface PolizaItem : NSManagedObject

@property (nonatomic, retain) NSString * valor;
@property (nonatomic, retain) NSString * categoria;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) Productos *tieneUnProducto;

@end
