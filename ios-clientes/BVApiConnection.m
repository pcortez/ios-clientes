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
        NSError *error;
        
        NSURL *urlPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login/",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaApiURL"]]];
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlPath cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:20];
        
        [request setHTTPMethod:@"POST"];
        // This is how we set header fields
        [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        // Convert your data and set your request's HTTPBody property
        request.HTTPBody = [[NSString stringWithFormat:@"rut=%@&password=%@",usuario,password] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSHTTPURLResponse *responseCode = nil;
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if (error) return NO;
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %i", urlPath, [responseCode statusCode]);
            return NO;
        }
        else{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
            if (error) return NO;
            if ([json objectForKey:@"autentificado"])
                return [[json objectForKey:@"autentificado"] boolValue];
            else return NO;
        }

    }
    else return NO;
}

NSDictionary* userData(NSString *usuario)
{
    usuario = [usuario substringWithRange:NSMakeRange(0,[usuario length]-2)];
    if (usuario && [usuario length]>4) {
        NSError *error;
        
        NSURL *urlPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cliente/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaApiURL"],usuario]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlPath cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
        
        NSHTTPURLResponse *responseCode = nil;
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if (error) return nil;
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %i", urlPath, [responseCode statusCode]);
            return nil;
        }
        else{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
            if (error) return nil;
            if ([json objectForKey:@"rut"] && [json objectForKey:@"id"])
                return json;
            else return nil;
        }
    }
    else return nil;
}

NSDictionary* getSucursales()
{
    NSError *error;
        
    NSURL *urlPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sucursales",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaApiURL"]]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlPath cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
        
        NSHTTPURLResponse *responseCode = nil;
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if (error){
            NSLog(@"error: %@",error.description);
            return nil;
        }
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %i", urlPath, [responseCode statusCode]);
            return nil;
        }
        else{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
            if (error){
                NSLog(@"error: %@",error.description);
                return nil;
            }
     
            return json;
        
        }
}

NSDictionary* getSucursal(NSString *codigo)
{
    NSError *error;
    
    NSURL *urlPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sucursal/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaApiURL"],codigo]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlPath cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if (error){
        NSLog(@"error: %@",error.description);
        return nil;
    }
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", urlPath, [responseCode statusCode]);
        return nil;
    }
    else{
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
        if (error){
            NSLog(@"error: %@",error.description);
            return nil;
        }
        return ([json objectForKey:@"codigo"]?json:nil);
    }
}

NSDictionary* getEjecutivoDeCuenta(NSString *rutCliente)
{

    if (rutCliente && [rutCliente length]>4) {
        NSError *error;
        
        NSURL *urlPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cliente/ejecutivo/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaApiURL"],rutCliente]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlPath cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
        
        NSHTTPURLResponse *responseCode = nil;
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if (error) return nil;
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %i", urlPath, [responseCode statusCode]);
            return nil;
        }
        else{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
            if (error) return nil;
            if ([json objectForKey:@"rut"])
                return json;
            else return nil;
        }
    }
    else return nil;
    
}

@end
