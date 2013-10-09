//
//  PolizaItem+Create.m
//  ios-clientes
//
//  Created by Pedro Cortez on 09-10-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "PolizaItem+Create.h"

@implementation PolizaItem (Create)

+(PolizaItem *)fromDictionary:(NSDictionary *)data withContratoCodigo:(NSString *)contratoCodigo inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PolizaItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"nombre == %@ && categoria == %@ && tieneUnProducto.contratoCodigo == %@",[data objectForKey:@"nombre"],[data objectForKey:@"categoria"],contratoCodigo];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    PolizaItem *item;
    if (!matches || [matches count]>1) {
        //handler error
        item = [matches lastObject];
        NSLog(@"Error Insurance Multiple item with same name and contractCode");
    } else if([matches count]==0) {
        item = [NSEntityDescription insertNewObjectForEntityForName:@"PolizaItem" inManagedObjectContext:context];
        item.nombre = [data objectForKey:@"nombre"];
        item.valor = [data objectForKey:@"valor"];
        item.categoria = [data objectForKey:@"categoria"];
    } else{
        item = [matches lastObject];
        if([data objectForKey:@"nombre"])item.nombre = [data objectForKey:@"nombre"];
        if([data objectForKey:@"valor"])item.valor = [data objectForKey:@"valor"];
        if([data objectForKey:@"categoria"])item.categoria = [data objectForKey:@"categoria"];
    }
    
    return item;
}


+(NSSet *)createPolizaFromDictionary:(NSDictionary *)data withContratoCodigo:(NSString *)contratoCodigo inManagedObjectContext:(NSManagedObjectContext *) context
{
    NSMutableArray *poliza = [NSMutableArray array];
    for (NSDictionary *item in [data objectForKey:@"poliza"]) {
        [poliza addObject:[PolizaItem fromDictionary:item withContratoCodigo:contratoCodigo inManagedObjectContext:context]];
    }
    return [NSSet setWithArray:poliza];
}


@end
