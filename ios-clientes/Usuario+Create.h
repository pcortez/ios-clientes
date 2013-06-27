//
//  Usuario+Create.h
//  ios-clientes
//
//  Created by Pedro Cortez on 19-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Usuario.h"

@interface Usuario (Create)

+(Usuario *)fromDictionary:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context;
+(Usuario *)updateFromDictionary:(NSDictionary *)data client:(Usuario *)client inManagedObjectContext:(NSManagedObjectContext *)context;

-(NSString *)convertUltimaModificacionToURLFormat;

@end
