//
//  Ejecutivo.h
//  ios-clientes
//
//  Created by Pedro Cortez on 18-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ejecutivo, Sucursal, Usuario;

@interface Ejecutivo : NSManagedObject

@property (nonatomic, retain) NSString * apellidos;
@property (nonatomic, retain) NSString * nombres;
@property (nonatomic, retain) NSString * rut;
@property (nonatomic, retain) NSString * telefono;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * imgNombre;
@property (nonatomic, retain) Sucursal *sucursal;
@property (nonatomic, retain) Ejecutivo *jefe;
@property (nonatomic, retain) NSSet *empleados;
@property (nonatomic, retain) NSSet *tieneVariosClientes;
@end

@interface Ejecutivo (CoreDataGeneratedAccessors)

- (void)addEmpleadosObject:(Ejecutivo *)value;
- (void)removeEmpleadosObject:(Ejecutivo *)value;
- (void)addEmpleados:(NSSet *)values;
- (void)removeEmpleados:(NSSet *)values;

- (void)addTieneVariosClientesObject:(Usuario *)value;
- (void)removeTieneVariosClientesObject:(Usuario *)value;
- (void)addTieneVariosClientes:(NSSet *)values;
- (void)removeTieneVariosClientes:(NSSet *)values;

@end
