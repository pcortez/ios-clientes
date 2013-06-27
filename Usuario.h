//
//  Usuario.h
//  ios-clientes
//
//  Created by Pedro Cortez on 27-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Productos;

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
@property (nonatomic, retain) NSSet *tieneMuchos;
@end

@interface Usuario (CoreDataGeneratedAccessors)

- (void)addTieneMuchosObject:(Productos *)value;
- (void)removeTieneMuchosObject:(Productos *)value;
- (void)addTieneMuchos:(NSSet *)values;
- (void)removeTieneMuchos:(NSSet *)values;

@end
