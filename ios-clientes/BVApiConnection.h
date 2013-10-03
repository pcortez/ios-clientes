//
//  BVApiConnection.h
//  ios-clientes
//
//  Created by Pedro Cortez on 19-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BVApiConnection : NSObject

NSString* base64String(NSString *str);

NSDictionary* userAuthentication(NSString *usuario, NSString *password);
NSDictionary* refreshUser(NSString *refreshToken);

NSDictionary* userData(NSString *accessToken);
NSDictionary* getSucursales(NSString *accessToken);
NSDictionary* getSucursal(NSString *accessToken,NSString *codigo);
NSDictionary* getEjecutivoDeCuenta(NSString *rutCliente);
@end
