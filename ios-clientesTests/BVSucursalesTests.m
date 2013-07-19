//
//  BVSucursalesTests.m
//  ios-clientes
//
//  Created by Pedro Cortez on 08-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Sucursal+Create.h"
#import "BVApiConnection.h"
#import "PhoneNumberFormatter.h"

@interface BVSucursalesTests : XCTestCase{
    //coredata
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStore *persistentStore;
    NSDictionary *data;
}

@end

@implementation BVSucursalesTests

- (void)setUp
{
    [super setUp];
    //core data init
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel];
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType: NSInMemoryStoreType configuration: nil URL: nil options: nil error: NULL];
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator: persistentStoreCoordinator];
    
    data = getSucursales();

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

- (void)testLoadData
{
    XCTAssertTrue([data objectForKey:@"sucursales"]);
    NSArray *sucursales = [data objectForKey:@"sucursales"];
    for (NSDictionary *sucursal in sucursales)
        XCTAssertNoThrow([Sucursal fromDictionary:sucursal inManagedObjectContext:managedObjectContext]);
    XCTAssertNoThrow([managedObjectContext save:nil]);
}

- (void)testConsistencyData
{
    NSLog(@"%@",data);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sucursal"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]];
    
    NSError *error;
    NSArray *matches = [managedObjectContext executeFetchRequest:request error:&error];
    NSArray *sucursales = [data objectForKey:@"sucursales"];
    
    XCTAssertNil(error);
    
    for (Sucursal *sucursalCoredata in matches) {
        for (NSDictionary *sucursalJson in sucursales) {
            XCTAssertNotNil(sucursalCoredata);
            XCTAssertTrue(![sucursalCoredata.codigo isEqualToString:@""]);
            if ([sucursalCoredata.codigo isEqualToString:[sucursalJson objectForKey:@"codigo"]]) {
                
                XCTAssertTrue([sucursalCoredata.nombre isEqualToString:[sucursalJson objectForKey:@"nombre"]]);
                XCTAssertTrue([sucursalCoredata.region isEqualToString:[sucursalJson objectForKey:@"region"]]);
                XCTAssertTrue([sucursalCoredata.direccion isEqualToString:[sucursalJson objectForKey:@"direccion"]]);
                XCTAssertTrue([sucursalCoredata.horario1 isEqualToString:[sucursalJson objectForKey:@"horario1"]]);
                XCTAssertTrue([sucursalCoredata.horario2 isEqualToString:[sucursalJson objectForKey:@"horario2"]]);
                XCTAssertTrue([sucursalCoredata.fono isEqualToString:[sucursalJson objectForKey:@"fono"]]);
                XCTAssertTrue([sucursalCoredata.fono isEqualToString:[sucursalJson objectForKey:@"fax"]]);
                XCTAssertTrue([sucursalCoredata.encargado isEqualToString:[sucursalJson objectForKey:@"encargado"]]);
                XCTAssertTrue([sucursalCoredata.latitud doubleValue] == [[sucursalJson objectForKey:@"latitud"] doubleValue]);
                XCTAssertTrue([sucursalCoredata.longitud doubleValue] == [[sucursalJson objectForKey:@"longitud"] doubleValue]);
            }
        }
    }
}

- (void)testPhoneFormatter
{
    PhoneNumberFormatter *formatter = [[PhoneNumberFormatter alloc] init];
    NSString *number = @"+56228283000";
    XCTAssertTrue([[formatter stringForObjectValue:number] isEqualToString:@"(+562) 2-828-3000"]);
    number = @"28283000";
    XCTAssertTrue([[formatter stringForObjectValue:number] isEqualToString:@"2-828-3000"]);
    number = @"228283000";
    XCTAssertTrue([[formatter stringForObjectValue:number] isEqualToString:@"(2) 2-828-3000"]);
    number = @"56228283000";
    XCTAssertTrue([[formatter stringForObjectValue:number] isEqualToString:@"(+562) 2-828-3000"]);
    
}

- (void)testLoadDataIndividual
{
    XCTAssertTrue([Sucursal fromDictionary:getSucursal(@"S2") inManagedObjectContext:managedObjectContext]);
    XCTAssertNoThrow([managedObjectContext save:nil]);
}

- (void)testLoadDataIndividualBadCode
{
    XCTAssertNil([Sucursal fromDictionary:getSucursal(@"asdf") inManagedObjectContext:managedObjectContext]);
}

@end
