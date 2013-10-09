//
//  Productos+Create.m
//  ios-clientes
//
//  Created by Pedro Cortez on 27-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Productos+Create.h"
#import "PolizaItem+Create.h"

@implementation Productos (Create)

+(Productos *)fromDictionary:(NSDictionary *)data isOldData:(int)isOldData inManagedObjectContext:(NSManagedObjectContext *)context
{
    if (!data)return nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Productos"];
    request.predicate = [NSPredicate predicateWithFormat:@"contratoCodigo == %@",[data objectForKey:@"codigoContrato"]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    //check format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    
    Productos *product;
    
    if (!matches || [matches count]>1) {
        //handler error
    } else if([matches count]==0) {
        product = [NSEntityDescription insertNewObjectForEntityForName:@"Productos" inManagedObjectContext:context];
        product.nombre = [data objectForKey:@"nombreProducto"];
        product.codigo = [data objectForKey:@"codigoProducto"];
        product.contratoCodigo = [data objectForKey:@"codigoContrato"];
        product.contratoEstado = [data objectForKey:@"estadoContrato"];
        product.contratoEstadoCodigo = [data objectForKey:@"estadoContratoCodigo"];
        product.negocioNombre = [data objectForKey:@"nombreNegocio"];
        product.negocioCodigo = [data objectForKey:@"codigoNegocio"];
        
        if([data objectForKey:@"rentabilidadFondo"]) product.rentabilidad = [data objectForKey:@"rentabilidadFondo"];
        
        
        NSString *aux = [data objectForKey:@"inicioVigencia"];
        aux=[aux stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([aux length] - 5,5)];
        product.vigenciaInicio = [dateFormatter dateFromString:aux];
        
        aux = [data objectForKey:@"terminoVigencia"];
        aux=[aux stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([aux length] - 5,5)];
        product.vigenciaTermino = [dateFormatter dateFromString:aux];
        
    } else{
        product = [matches lastObject];
        if (isOldData == NSOrderedAscending) {
            if([data objectForKey:@"nombreProducto"]) product.nombre = [data objectForKey:@"nombreProducto"];
            if([data objectForKey:@"codigoProducto"]) product.codigo = [data objectForKey:@"codigoProducto"];
            if([data objectForKey:@"nombreNegocio"]) product.negocioNombre = [data objectForKey:@"nombreNegocio"];
            if([data objectForKey:@"codigoNegocio"]) product.negocioCodigo = [data objectForKey:@"codigoNegocio"];
            if([data objectForKey:@"rentabilidadFondo"]) product.rentabilidad = [data objectForKey:@"rentabilidadFondo"];
            if([data objectForKey:@"codigoContrato"]) product.contratoEstado = [data objectForKey:@"codigoContrato"];
            if([data objectForKey:@"estadoContratoCodigo"]) product.contratoEstadoCodigo = [data objectForKey:@"estadoContratoCodigo"];
            if([data objectForKey:@"estadoContrato"]) product.contratoEstado = [data objectForKey:@"estadoContrato"];
            
            if([data objectForKey:@"inicioVigencia"]){
                NSString *aux = [data objectForKey:@"inicioVigencia"];
                aux=[aux stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([aux length] - 5,5)];
                product.vigenciaInicio = [dateFormatter dateFromString:aux];
            }
            if([data objectForKey:@"terminoVigencia"]){
                NSString *aux = [data objectForKey:@"terminoVigencia"];
                aux=[aux stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([aux length] - 5,5)];
                product.vigenciaTermino = [dateFormatter dateFromString:aux];
            }
        }
        else if (isOldData == NSOrderedDescending){
            //send data to server
        }
    }
    
    return product;
}


- (void) setPolizaFromDictionary: (NSDictionary *) data inManagedObjectContext:(NSManagedObjectContext *)context{
    
    if (data) {
        self.tieneUnaPoliza = [PolizaItem createPolizaFromDictionary:data withContratoCodigo:self.contratoCodigo inManagedObjectContext:context];
    }
    
}

@end
