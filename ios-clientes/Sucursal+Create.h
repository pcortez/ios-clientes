//
//  Sucursal+Create.h
//  ios-clientes
//
//  Created by Pedro Cortez on 04-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Sucursal.h"

@interface Sucursal (Create)
+(Sucursal *)fromDictionary:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context;
@end
