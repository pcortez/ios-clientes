//
//  Sucursal+Create.m
//  ios-clientes
//
//  Created by Pedro Cortez on 04-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Sucursal+Create.h"

@implementation Sucursal (Create)


+(Sucursal *)fromDictionary:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sucursal"];
    request.predicate = [NSPredicate predicateWithFormat:@"codigo == %@",[data objectForKey:@"codigo"]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    Sucursal *sucursal;
    
    if (!matches || [matches count]>1) {
        //handler error
    } else if([matches count]==0) {
        sucursal = [NSEntityDescription insertNewObjectForEntityForName:@"Sucursal" inManagedObjectContext:context];
        sucursal.nombre = [[data objectForKey:@"nombre"] capitalizedString];
        sucursal.codigo = [data objectForKey:@"codigo"];
        sucursal.latitud = [data objectForKey:@"latitud"];
        sucursal.longitud = [data objectForKey:@"longitud"];
        sucursal.region = [[data objectForKey:@"region"] capitalizedString];
        sucursal.direccion = [[data objectForKey:@"direccion"] capitalizedString];
        sucursal.horario1 = [data objectForKey:@"horario1"];
        sucursal.horario2 = [data objectForKey:@"horario2"];
        sucursal.fono = [data objectForKey:@"fono"];
        sucursal.fax = [data objectForKey:@"fax"];
        sucursal.encargado = [data objectForKey:@"encargado"];
    } else{
        sucursal = [matches lastObject];
        //if (isOldData == NSOrderedAscending) {
            if([data objectForKey:@"nombre"]) sucursal.nombre = [[data objectForKey:@"nombre"] capitalizedString];
            if([data objectForKey:@"latitud"]) sucursal.latitud = [data objectForKey:@"latitud"];
            if([data objectForKey:@"longitud"]) sucursal.longitud = [data objectForKey:@"longitud"];
            if([data objectForKey:@"region"]) sucursal.region = [[data objectForKey:@"region"] capitalizedString];
            if([data objectForKey:@"direccion"]) sucursal.direccion = [[data objectForKey:@"direccion"] capitalizedString];
            if([data objectForKey:@"horario1"]) sucursal.horario1 = [data objectForKey:@"horario1"];
            if([data objectForKey:@"horario2"]) sucursal.horario2 = [data objectForKey:@"horario2"];
            if([data objectForKey:@"fono"]) sucursal.fono = [data objectForKey:@"fono"];
            if([data objectForKey:@"fax"]) sucursal.fax = [data objectForKey:@"fax"];
            if([data objectForKey:@"encargado"]) sucursal.encargado = [data objectForKey:@"encargado"];
        //else if (isOldData == NSOrderedDescending){
            //send data to server
        //}
    }
    
    return sucursal;
}



@end
