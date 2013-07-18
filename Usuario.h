//
//  Usuario.h
//  ios-clientes
//
//  Created by Pedro Cortez on 17-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ejecutivo, Productos;

@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSString * apellido;
@property (nonatomic, retain) NSNumber * autoLogin;
@property (nonatomic, retain) NSString * celular;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * rut;
@property (nonatomic, retain) NSDate * ultimaModificacion;
@property (nonatomic, retain) NSDate * ultimoLogin;
@property (nonatomic, retain) NSSet *tieneMuchosProductos;
@property (nonatomic, retain) Ejecutivo *tieneUnEjecutivo;
@end

@interface Usuario (CoreDataGeneratedAccessors)

- (void)addTieneMuchosProductosObject:(Productos *)value;
- (void)removeTieneMuchosProductosObject:(Productos *)value;
- (void)addTieneMuchosProductos:(NSSet *)values;
- (void)removeTieneMuchosProductos:(NSSet *)values;

@end
