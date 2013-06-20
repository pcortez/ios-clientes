//
//  BVApiConnection.h
//  ios-clientes
//
//  Created by Pedro Cortez on 19-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BVApiConnection : NSObject

BOOL userAuthentication(NSString *usuario, NSString *password);
@end
