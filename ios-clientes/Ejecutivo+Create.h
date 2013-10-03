//
//  Ejecutivo+Create.h
//  ios-clientes
//
//  Created by Pedro Cortez on 17-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Ejecutivo.h"

@interface Ejecutivo (Create)
//+(Ejecutivo *)fromDictionary:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context;
+(Ejecutivo *)fromDictionary:(NSDictionary *)data andCliente:(Usuario *)client inManagedObjectContext:(NSManagedObjectContext *)context;
//+(Ejecutivo *)fromDictionary:(NSDictionary *)data andJefe:(Ejecutivo *)empleado inManagedObjectContext:(NSManagedObjectContext *)context;
+(Ejecutivo *)fromDictionary:(NSDictionary *)data cliente:(Usuario *)cliente andJefe:(Ejecutivo *)empleado inManagedObjectContext:(NSManagedObjectContext *)context;
-(NSString *)nombreCompleto;
-(NSString *)nombreCompletoJefe;
-(NSString *)getImgPath;
@end
