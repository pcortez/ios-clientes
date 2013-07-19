//
//  BVEjecutivoTests.m
//  ios-clientes
//
//  Created by Pedro Cortez on 18-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BVApiConnection.h"
#import "Usuario+Create.h"
#import "Ejecutivo+Create.h"
#import "Sucursal+Create.h"

@interface BVEjecutivoTests : XCTestCase

@end

@implementation BVEjecutivoTests {
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
    [super setUp];
    //core data init
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel];
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType: NSInMemoryStoreType configuration: nil URL: nil options: nil error: NULL];
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator: persistentStoreCoordinator];
    
    data = userData(@"11610087-8");
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testLoadData
{
    XCTAssertTrue([Usuario fromDictionary:data inManagedObjectContext:managedObjectContext]);
    XCTAssertNoThrow([managedObjectContext save:nil]);
}

- (void)testLoadDataIndividual
{
    XCTAssertTrue([Ejecutivo fromDictionary:getEjecutivoDeCuenta(@"11610087-8") inManagedObjectContext:managedObjectContext]);
    XCTAssertNoThrow([managedObjectContext save:nil]);
}

- (void)testLoadDataIndividualBadRut
{
    XCTAssertNil([Ejecutivo fromDictionary:getEjecutivoDeCuenta(@"11611187-8") inManagedObjectContext:managedObjectContext]);
}

- (void)testThatEnvironmentWorks
{
    XCTAssertNotNil(persistentStore, @"no persistent store");
    XCTAssertNotNil(data);
}

- (void)testDictionnaryToModelWithConnection
{
    XCTAssertNotNil(data);
    
    Usuario *cliente = [Usuario fromDictionary:data inManagedObjectContext:managedObjectContext];
    XCTAssertNotNil(cliente);
    XCTAssertNoThrow([managedObjectContext save:nil]);
    
    NSDictionary *ejecutivo = [data objectForKey:@"ejecutivo"];
    
    XCTAssertTrue(![cliente.tieneUnEjecutivo.rut isEqualToString:@""]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.rut isEqualToString:[[ejecutivo objectForKey:@"rut"] lowercaseString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.nombres isEqualToString:[[ejecutivo objectForKey:@"nombres"] capitalizedString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.apellidos isEqualToString:[[ejecutivo objectForKey:@"apellidos"] capitalizedString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.telefono isEqualToString:[[ejecutivo objectForKey:@"telefono"] lowercaseString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.email isEqualToString:[[ejecutivo objectForKey:@"email"] lowercaseString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.sucursal.codigo isEqual:[[ejecutivo objectForKey:@"sucursalCodigo"] uppercaseString]]);

    NSDictionary *jefe = [ejecutivo objectForKey:@"jefe"];
    
    XCTAssertTrue([cliente.tieneUnEjecutivo.jefe.rut isEqualToString:[[jefe objectForKey:@"rut"] lowercaseString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.jefe.nombres isEqualToString:[[jefe objectForKey:@"nombres"] capitalizedString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.jefe.apellidos isEqualToString:[[jefe objectForKey:@"apellidos"] capitalizedString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.jefe.telefono isEqualToString:[[jefe objectForKey:@"telefono"] lowercaseString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.jefe.email isEqualToString:[[jefe objectForKey:@"email"] lowercaseString]]);
    XCTAssertTrue([cliente.tieneUnEjecutivo.jefe.sucursal.codigo isEqual:[[jefe objectForKey:@"sucursalCodigo"] uppercaseString]]);
}

- (void)testNombreCompleto
{
    XCTAssertNotNil(data);
    
    Usuario *cliente = [Usuario fromDictionary:data inManagedObjectContext:managedObjectContext];
    XCTAssertNotNil(cliente);
    XCTAssertNoThrow([managedObjectContext save:nil]);
    
    NSDictionary *ejecutivo = [data objectForKey:@"ejecutivo"];
    
    NSString *nombreCompletoData = [cliente.tieneUnEjecutivo nombreCompleto];
    NSString *nombreCompletoJson = [[[[ejecutivo objectForKey:@"nombres"] stringByAppendingString:@" "] stringByAppendingString:[ejecutivo objectForKey:@"apellidos"]] capitalizedString];
    
    XCTAssertTrue([nombreCompletoData isEqual:nombreCompletoJson]);
}


- (void)testNombreCompletoJefe
{
    XCTAssertNotNil(data);
    
    Usuario *cliente = [Usuario fromDictionary:data inManagedObjectContext:managedObjectContext];
    XCTAssertNotNil(cliente);
    XCTAssertNoThrow([managedObjectContext save:nil]);
    
    NSDictionary *jefe = [[data objectForKey:@"ejecutivo"] objectForKey:@"jefe"];
    
    NSString *nombreCompletoData = [cliente.tieneUnEjecutivo nombreCompletoJefe];
    NSString *nombreCompletoJson = [[[[jefe objectForKey:@"nombres"] stringByAppendingString:@" "] stringByAppendingString:[jefe objectForKey:@"apellidos"]] capitalizedString];
    
    XCTAssertTrue([nombreCompletoData isEqual:nombreCompletoJson]);
}


@end
