//
//  Ejecutivo+Create.m
//  ios-clientes
//
//  Created by Pedro Cortez on 17-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Ejecutivo+Create.h"
#import "Sucursal+Create.h"

@implementation Ejecutivo (Create)
+(Ejecutivo *)fromDictionary:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context
{
    if (!data)return nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Ejecutivo"];
    request.predicate = [NSPredicate predicateWithFormat:@"rut == %@",[data objectForKey:@"rut"]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombres" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    Ejecutivo *ejecutivo;
    
    if (!matches || [matches count]>1) {
        //handler error
    } else if([matches count]==0) {
        ejecutivo = [NSEntityDescription insertNewObjectForEntityForName:@"Ejecutivo" inManagedObjectContext:context];
        ejecutivo.rut = [[data objectForKey:@"rut"] lowercaseString];
        ejecutivo.nombres = [[data objectForKey:@"nombres"] capitalizedString];
        ejecutivo.apellidos = [[data objectForKey:@"apellidos"] capitalizedString];
        ejecutivo.email = [[data objectForKey:@"email"] lowercaseString];
        ejecutivo.telefono = [[data objectForKey:@"telefono"] lowercaseString];
    } else{
        ejecutivo = [matches lastObject];
        //if (isOldData == NSOrderedAscending) {
        if([data objectForKey:@"nombres"]) ejecutivo.nombres = [[data objectForKey:@"nombres"] capitalizedString];
        if([data objectForKey:@"apellidos"]) [[data objectForKey:@"apellidos"] capitalizedString];
        if([data objectForKey:@"email"]) [[data objectForKey:@"email"] lowercaseString];
        if([data objectForKey:@"telefono"]) [[data objectForKey:@"telefono"] lowercaseString];
    }
    
    if([data objectForKey:@"sucursalCodigo"])
        ejecutivo.sucursal = [Sucursal fromCode:[data objectForKey:@"sucursalCodigo"] inManagedObjectContext:context];
    if([data objectForKey:@"jefe"])
        ejecutivo.jefe = [Ejecutivo fromDictionary:[data objectForKey:@"jefe"] andJefe:ejecutivo inManagedObjectContext:context];
    if([data objectForKey:@"imgURL"]){
        NSString *path = [self guardarImg:[data objectForKey:@"imgURL"] name:[data objectForKey:@"rut"]];
        if (path) ejecutivo.imgNombre = [self guardarImg:[data objectForKey:@"imgURL"] name:[data objectForKey:@"rut"]];
    }
    return ejecutivo;
}

+(Ejecutivo *)fromDictionary:(NSDictionary *)data andJefe:(Ejecutivo *)empleado inManagedObjectContext:(NSManagedObjectContext *)context
{
    if (!data)return nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Ejecutivo"];
    request.predicate = [NSPredicate predicateWithFormat:@"rut == %@",[data objectForKey:@"rut"]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nombres" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    Ejecutivo *ejecutivo;
    
    if (!matches || [matches count]>1) {
        //handler error
    } else if([matches count]==0) {
        ejecutivo = [NSEntityDescription insertNewObjectForEntityForName:@"Ejecutivo" inManagedObjectContext:context];
        ejecutivo.rut = [[data objectForKey:@"rut"] lowercaseString];
        ejecutivo.nombres = [[data objectForKey:@"nombres"] capitalizedString];
        ejecutivo.apellidos = [[data objectForKey:@"apellidos"] capitalizedString];
        ejecutivo.email = [[data objectForKey:@"email"] lowercaseString];
        ejecutivo.telefono = [[data objectForKey:@"telefono"] lowercaseString];
        ejecutivo.sucursal = [Sucursal fromDictionary:[data objectForKey:@"sucursal"] inManagedObjectContext:context];

    } else{
        ejecutivo = [matches lastObject];
        //if (isOldData == NSOrderedAscending) {
        if([data objectForKey:@"nombres"]) ejecutivo.nombres = [[data objectForKey:@"nombres"] capitalizedString];
        if([data objectForKey:@"apellidos"]) [[data objectForKey:@"apellidos"] capitalizedString];
        if([data objectForKey:@"email"]) [[data objectForKey:@"email"] lowercaseString];
        if([data objectForKey:@"telefono"]) [[data objectForKey:@"telefono"] lowercaseString];
        if([data objectForKey:@"sucursal"]) ejecutivo.sucursal = [Sucursal fromDictionary:[data objectForKey:@"sucursal"] inManagedObjectContext:context];
    }
    
    if([data objectForKey:@"sucursalCodigo"])
        ejecutivo.sucursal = [Sucursal fromCode:[data objectForKey:@"sucursalCodigo"] inManagedObjectContext:context];
    if([data objectForKey:@"imgURL"]){
        NSString *path = [self guardarImg:[data objectForKey:@"imgURL"] name:[data objectForKey:@"rut"]];
        if (path) ejecutivo.imgNombre = [self guardarImg:[data objectForKey:@"imgURL"] name:[data objectForKey:@"rut"]];
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Ejecutivo"];
    request.predicate = [NSPredicate predicateWithFormat:@"rut == %@",empleado.rut];
    sort = [NSSortDescriptor sortDescriptorWithKey:@"nombres" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    matches = [context executeFetchRequest:request error:&error];
    
    [ejecutivo addEmpleadosObject:empleado];
    if (!matches || [matches count]==0){
        [ejecutivo addEmpleadosObject:empleado];
    }
    else if ([matches count]>1){
        NSLog(@"ERROR EN BASE DE DATOS");
    }
    
    return ejecutivo;
}

+ (NSString *)guardarImg:(NSString *)url name:(NSString *)name
{

    NSError *error;
    //NSURLRequestReloadIgnoringLocalCacheData
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:20];
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if (error) return nil;
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    else{
        if (error) return nil;
        if (oResponseData){
            // Get an image from the URL below
            UIImage *image = [[UIImage alloc] initWithData:oResponseData];
            // Let's save the file into Document folder.
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            // If you go to the folder below, you will find those pictures
            NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,[name lowercaseString]];
            [[NSData dataWithData:UIImagePNGRepresentation(image)] writeToFile:pngFilePath atomically:YES];
            return [NSString stringWithFormat:@"%@.png",[name lowercaseString]];
        }
        else return nil;
    }
}


//nombes y apellidos ya estan con mayuscula al comienzo
-(NSString *)nombreCompleto{return [[self.nombres stringByAppendingString:@" "] stringByAppendingString:self.apellidos];}
-(NSString *)nombreCompletoJefe{return [[self.jefe.nombres stringByAppendingString:@" "] stringByAppendingString:self.jefe.apellidos];}
-(NSString *)getImgPath
{
    return [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0],self.imgNombre];
}
@end
