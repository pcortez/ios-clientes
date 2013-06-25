//
//  BVLoginTests.m
//  ios-clientes
//
//  Created by Pedro Cortez on 19-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BVLoginViewController.h"
#import "BVRutTextField.h"
#import "CommonAlgorithm.h"
#import "BVApiConnection.h"

@interface BVLoginTests : XCTestCase

@end

@implementation BVLoginTests
{
    BVRutTextField *rutTextField;
    UITextField *passwordTextField;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    rutTextField = [[BVRutTextField alloc] init];
    passwordTextField = [[UITextField alloc] init];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testRutFormat
{
    rutTextField.text = @"160957832";
    XCTAssertTrue([[rutTextField getRutConVerificador:YES] isEqualToString:@"16.095.783-2"]);
    XCTAssertTrue([[rutTextField getRutConVerificador:NO] isEqualToString:@"16095783-2"]);
    
    rutTextField.text = @"6066675k";
    XCTAssertTrue([[rutTextField getRutConVerificador:YES] isEqualToString:@"6.066.675-K"]);
    XCTAssertTrue([[rutTextField getRutConVerificador:NO] isEqualToString:@"6066675-K"]);
    
    rutTextField.text = @"62273518";
    XCTAssertTrue([[rutTextField getRutConVerificador:YES] isEqualToString:@"6.227.351-8"]);
    XCTAssertTrue([[rutTextField getRutConVerificador:NO] isEqualToString:@"6227351-8"]);
}

- (void)testRutDigitoVerificador
{
    rutTextField.text = @"160957832";
    NSString *s = [rutTextField.text substringWithRange:NSMakeRange(0,[rutTextField.text length]-1)];
    XCTAssertTrue(rutValidator([s integerValue],[rutTextField.text characterAtIndex:[rutTextField.text length]-1]));
    rutTextField.text = @"16095783K";
    s = [rutTextField.text substringWithRange:NSMakeRange(0,[rutTextField.text length]-1)];
    XCTAssertFalse(rutValidator([s integerValue],[rutTextField.text characterAtIndex:[rutTextField.text length]-1]));
    
    rutTextField.text = @"6066675K";
    s = [rutTextField.text substringWithRange:NSMakeRange(0,[rutTextField.text length]-1)];
    XCTAssertTrue(rutValidator([s integerValue],[rutTextField.text characterAtIndex:[rutTextField.text length]-1]));
    rutTextField.text = @"60666753";
    s = [rutTextField.text substringWithRange:NSMakeRange(0,[rutTextField.text length]-1)];
    XCTAssertFalse(rutValidator([s integerValue],[rutTextField.text characterAtIndex:[rutTextField.text length]-1]));
    
    rutTextField.text = @"62273518";
    s = [rutTextField.text substringWithRange:NSMakeRange(0,[rutTextField.text length]-1)];
    XCTAssertTrue(rutValidator([s integerValue],[rutTextField.text characterAtIndex:[rutTextField.text length]-1]));
    rutTextField.text = @"62273512";
    s = [rutTextField.text substringWithRange:NSMakeRange(0,[rutTextField.text length]-1)];
    XCTAssertFalse(rutValidator([s integerValue],[rutTextField.text characterAtIndex:[rutTextField.text length]-1]));
}

- (void)testAutentificacionExist
{
    rutTextField.text = @"116100878";
    passwordTextField.text = @"123456";
    XCTAssertTrue(userAuthentication([rutTextField getRutConVerificador:NO], passwordTextField.text));
    
}

- (void)testAutentificacionNotExist
{
    rutTextField.text = @"62273518";
    passwordTextField.text = @"PASSWORD_FALSO";
    XCTAssertFalse(userAuthentication([rutTextField getRutConVerificador:NO], passwordTextField.text));
}

@end
