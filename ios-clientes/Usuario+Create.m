//
//  Usuario+Create.m
//  ios-clientes
//
//  Created by Pedro Cortez on 19-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Usuario+Create.h"
#import "Productos+Create.h"
#import "Ejecutivo+Create.h"
#import "BVApiConnection.h"


@implementation Usuario (Create)

//
//IMPORTANT
//data must have id, rut and fechaUltimaModificacion
//
//check what happend if a key does not exist
+(Usuario *)fromDictionary:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context
{
    return [self updateFromDictionary:data client:nil inManagedObjectContext:context];
}

//
//IMPORTANT
//data must have id, rut and fechaUltimaModificacion
//
+(Usuario *)updateFromDictionary:(NSDictionary *)data client:(Usuario *)client inManagedObjectContext:(NSManagedObjectContext *)context
{
    if (!data)return nil;
    //check format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    
    NSString *aux = [data objectForKey:@"fechaUltimaModificacion"];
    aux=[aux stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([aux length] - 5,5)];
    NSDate *date = [dateFormatter dateFromString:aux];
    
    
    if (!client) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
        request.predicate = [NSPredicate predicateWithFormat:@"id == %@",[data objectForKey:@"id"]];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sort];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || [matches count]>1) {
            //handler error
        } else if([matches count]==0) {
            client = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
            client.rut = [data objectForKey:@"rut"];
            client.id = [data objectForKey:@"id"];
            client.ultimaModificacion = [NSDate distantPast];
        } else{
            client = [matches lastObject];
        }
    }
    else{
        if (![client.id isEqualToNumber:[data objectForKey:@"id"]]) {
            client = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
            client.rut = [data objectForKey:@"rut"];
            client.id = [data objectForKey:@"id"];
            client.ultimaModificacion = [NSDate distantPast];
        }
    }
    
    //client.lastModification is later than date
    if ([client.ultimaModificacion compare:date]==NSOrderedAscending) {
        //client.legalId = [data objectForKey:@"rut"];
        if ([data objectForKey:@"nombre"]) client.nombre = [data objectForKey:@"nombre"];
        if ([data objectForKey:@"apellidoPaterno"]) client.apellido = [data objectForKey:@"apellidoPaterno"];
        //if ([data objectForKey:@"apellidoMaterno"]) client.maternalName = [data objectForKey:@"apellidoMaterno"];
        if ([data objectForKey:@"nombre"]) client.ultimaModificacion = date;
        if ([data objectForKey:@"celular"]) client.celular = [data objectForKey:@"celular"];
        if ([data objectForKey:@"email"]) client.email = [[data objectForKey:@"email"] lowercaseString];
    }
    else if([client.ultimaModificacion compare:date]==NSOrderedDescending){
        //send data to server
    }
    
    
    if ([data objectForKey:@"ejecutivo"])
        client.tieneUnEjecutivo = [Ejecutivo fromDictionary:[data objectForKey:@"ejecutivo"] andCliente:client inManagedObjectContext:context];
    
    for (NSDictionary *product in [data objectForKey:@"productos"]) {
        Productos *p = [Productos fromDictionary:product isOldData:[client.ultimaModificacion compare:date] inManagedObjectContext:context];
        /*
        for (NSDictionary *fund in [product objectForKey:@"portafolio"])
            [p addPortfolioObject:[Fund fromDictionary:fund contractCode:p.contractCode isOldData:[client.lastModification compare:date] inManagedObjectContext:context]];
         */
        /*
        for (NSDictionary *item in [product objectForKey:@"poliza"]){
            [p addInsuranceObject:[InsuranceItem fromDictionary:item contractCode:p.contractCode isOldData:[client.lastModification compare:date] inManagedObjectContext:context]];
        }
         */
        [client addTieneMuchosProductosObject:p];
    }
    
    return client;
}

-(NSString *)convertUltimaModificacionToURLFormat
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    
    NSString *dateString = [format stringFromDate:self.ultimaModificacion];
    dateString = [NSString stringWithFormat:@"%@:%@", [dateString substringWithRange:NSMakeRange(0, [dateString length]-2)], [dateString substringWithRange:NSMakeRange([dateString length]-2, 2)]];
    return dateString;
}

@end
