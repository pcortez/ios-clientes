//
//  BVProductosTests.m
//  ios-clientes
//
//  Created by Pedro Cortez on 27-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BVApiConnection.h"
#import "Usuario+Create.h"
#import "Productos+Create.h"

@interface BVProductosTests : XCTestCase
@end

@implementation BVProductosTests {
    //core data
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStore *persistentStore;
    //NSFetchedResultsController *fetchedResultsController;
    
    NSDictionary *data;

}

- (void)setUp
{
    [super setUp];
    //core data init
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel];
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType: NSInMemoryStoreType configuration: nil URL: nil options: nil error: NULL];
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator: persistentStoreCoordinator];
    
    data = userData(@"11610087-8");
    [Usuario fromDictionary:data inManagedObjectContext:managedObjectContext];
    [managedObjectContext save:nil];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatEnvironmentWorks
{
    XCTAssertNotNil(persistentStore, @"no persistent store");
    XCTAssertNotNil(data);
}

- (void)testDictionnaryToModelWithConnection
{
    NSLog(@"%@",data);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Productos"];
    request.predicate = [NSPredicate predicateWithFormat:@"tieneUnCliente.id == %@",[data objectForKey:@"id"]];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"negocioNombre" ascending:YES]];
    
    NSError *error;
    NSArray *matches = [managedObjectContext executeFetchRequest:request error:&error];
    NSArray *productos = [data objectForKey:@"productos"];

    XCTAssertNil(error);
    
    for (Productos *productoCoredata in matches) {
        for (NSDictionary *productoJson in productos) {
            XCTAssertNotNil(productoCoredata);
            XCTAssertTrue(![productoCoredata.codigo isEqualToString:@""]);
            if ([productoCoredata.codigo isEqualToString:[productoJson objectForKey:@"codigoProducto"]]) {
                
                XCTAssertTrue([productoCoredata.negocioNombre isEqualToString:[productoJson objectForKey:@"nombreNegocio"]]);
                XCTAssertTrue([productoCoredata.negocioCodigo isEqualToString:[productoJson objectForKey:@"codigoNegocio"]]);
                
                XCTAssertTrue([productoCoredata.contratoCodigo isEqualToString:[productoJson objectForKey:@"codigoContrato"]]);
                XCTAssertTrue([productoCoredata.contratoEstado isEqualToString:[productoJson objectForKey:@"estadoContrato"]]);
                XCTAssertTrue([productoCoredata.contratoEstadoCodigo isEqual:[productoJson objectForKey:@"estadoContratoCodigo"]]);
                
                XCTAssertTrue([productoCoredata.nombre isEqual:[productoJson objectForKey:@"nombreProducto"]]);
                XCTAssertTrue([productoCoredata.codigo isEqualToString:[productoJson objectForKey:@"codigoProducto"]]);
                
                //check format
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
                
                NSString *aux = [data objectForKey:@"inicioVigencia"];
                aux=[aux stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([aux length] - 5,5)];
                XCTAssertTrue(productoCoredata.vigenciaInicio == [dateFormatter dateFromString:aux]);
                if ([productoJson objectForKey:@"terminoVigencia"]) {
                    aux = [data objectForKey:@"terminoVigencia"];
                    aux=[aux stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([aux length] - 5,5)];
                    XCTAssertTrue(productoCoredata.vigenciaTermino == [dateFormatter dateFromString:aux]);
                }
                
                if ([productoJson objectForKey:@"rentabilidadPortafolio"]) {
                    XCTAssertTrue([productoCoredata.rentabilidad floatValue] == [[productoJson objectForKey:@"rentabilidadPortafolio"] floatValue]);
                }
            }
        }
    }
}

@end
