//
//  Sucursal+Create.m
//  ios-clientes
//
//  Created by Pedro Cortez on 04-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Sucursal+Create.h"
#import "BVApiConnection.h"

@implementation Sucursal (Create)

+(Sucursal *)fromDictionary:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context
{
    //pasa porque el jefe de ejecutivo no tiene sucursal
    if (!data)return nil;
    
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
        sucursal.latitud = [NSNumber numberWithDouble:[[data objectForKey:@"latitud"] doubleValue]];
        sucursal.longitud = [NSNumber numberWithDouble:[[data objectForKey:@"longitud"] doubleValue]];
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
            if([data objectForKey:@"latitud"]) sucursal.latitud = [NSNumber numberWithDouble:[[data objectForKey:@"latitud"] doubleValue]];
            if([data objectForKey:@"longitud"]) sucursal.longitud = [NSNumber numberWithDouble:[[data objectForKey:@"longitud"] doubleValue]];
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

+(Sucursal *)fromCode:(NSString *)code inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sucursal"];
    request.predicate = [NSPredicate predicateWithFormat:@"codigo == %@",code];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    if (!matches) {
        //handler error
        NSLog(@"Error: nil");
        return nil;
    } else if([matches count]==0) {
        //handler error
        NSDictionary *json = getSucursal(code);
        if (json) return [Sucursal fromDictionary:json inManagedObjectContext:context];
        NSLog(@"Error no existe, hay que crearlo: 0");
        return nil;
    } else if([matches count]==1) {
        //handler error
        return [matches lastObject];
    } else {
        NSLog(@"Error no existe, hay varias sucursales con el mismo codigo: >1");
        return [matches lastObject];
    }
}


@end
