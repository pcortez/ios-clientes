//
//  Sucursal.h
//  ios-clientes
//
//  Created by Pedro Cortez on 17-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ejecutivo;

@interface Sucursal : NSManagedObject

@property (nonatomic, retain) NSString * codigo;
@property (nonatomic, retain) NSString * direccion;
@property (nonatomic, retain) NSString * encargado;
@property (nonatomic, retain) NSString * fax;
@property (nonatomic, retain) NSString * fono;
@property (nonatomic, retain) NSString * horario1;
@property (nonatomic, retain) NSString * horario2;
@property (nonatomic, retain) NSNumber * latitud;
@property (nonatomic, retain) NSNumber * longitud;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSSet *trabajan;
@end

@interface Sucursal (CoreDataGeneratedAccessors)

- (void)addTrabajanObject:(Ejecutivo *)value;
- (void)removeTrabajanObject:(Ejecutivo *)value;
- (void)addTrabajan:(NSSet *)values;
- (void)removeTrabajan:(NSSet *)values;

@end
