//
//  PolizaItem+Create.h
//  ios-clientes
//
//  Created by Pedro Cortez on 09-10-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "PolizaItem.h"

@interface PolizaItem (Create)

+(PolizaItem *)fromDictionary:(NSDictionary *)data withContratoCodigo:(NSString *)contratoCodigo inManagedObjectContext:(NSManagedObjectContext *)context;
+(NSSet *)createPolizaFromDictionary:(NSDictionary *)data withContratoCodigo:(NSString *)contratoCodigo inManagedObjectContext:(NSManagedObjectContext *)context;

@end
