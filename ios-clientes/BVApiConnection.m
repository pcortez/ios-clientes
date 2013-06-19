//
//  BVApiConnection.m
//  ios-clientes
//
//  Created by Pedro Cortez on 19-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVApiConnection.h"

@implementation BVApiConnection

BOOL userAuthentication(NSString *usuario, NSString *password)
{
    if (usuario && [usuario length]>4) {
        NSBundle* mainBundle;
        mainBundle = [NSBundle mainBundle];
        
        NSData* data;
        NSURL *urlPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login/%@",[mainBundle objectForInfoDictionaryKey:@"BiceVidaApiURL"],usuario]];
        
        NSError *error;
        data = [NSData dataWithContentsOfURL:urlPath options:NSDataReadingUncached error:&error];
        if (error) return NO;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) return NO;
        
        if ([json objectForKey:@"autentificado"]){
            return [[json objectForKey:@"autentificado"] boolValue];
        }
        else return NO;
    }
    else return NO;
}

@end
