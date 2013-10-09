//
//  Productos.h
//  ios-clientes
//
//  Created by Pedro Cortez on 08-10-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PolizaItem, Usuario;

@interface Productos : NSManagedObject

@property (nonatomic, retain) NSString * codigo;
@property (nonatomic, retain) NSString * contratoCodigo;
@property (nonatomic, retain) NSString * contratoEstado;
@property (nonatomic, retain) NSNumber * contratoEstadoCodigo;
@property (nonatomic, retain) NSString * negocioCodigo;
@property (nonatomic, retain) NSString * negocioNombre;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * rentabilidad;
@property (nonatomic, retain) NSDate * vigenciaInicio;
@property (nonatomic, retain) NSDate * vigenciaTermino;
@property (nonatomic, retain) Usuario *tieneUnCliente;
@property (nonatomic, retain) NSSet *tieneUnaPoliza;
@end

@interface Productos (CoreDataGeneratedAccessors)

- (void)addTieneUnaPolizaObject:(PolizaItem *)value;
- (void)removeTieneUnaPolizaObject:(PolizaItem *)value;
- (void)addTieneUnaPoliza:(NSSet *)values;
- (void)removeTieneUnaPoliza:(NSSet *)values;

@end
