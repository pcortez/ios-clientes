//
//  BVApiConnection.m
//  ios-clientes
//
//  Created by Pedro Cortez on 19-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVApiConnection.h"
@implementation NSURLRequest(AllowAllCerts)

+ (BOOL) allowsAnyHTTPSCertificateForHost:(NSString *) host {
    return YES;
}
@end
@implementation BVApiConnection


NSString* base64String(NSString *str)
//+ (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

/*
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
*/

NSDictionary* userAuthentication(NSString *usuario, NSString *password)
{
    if (usuario && [usuario length]>4) {
        NSError *error;
        
        NSURL *urlPath = [NSURL URLWithString:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaOauth2TokenURL"]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlPath cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:20];
        
        [request setHTTPMethod:@"POST"];
        // This is how we set header fields
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSString *authString = base64String([NSString stringWithFormat:@"%@:%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaApiPublicKey"],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"BiceVidaApiPrivateKey"]]);
        
        [request setValue:[NSString stringWithFormat:@"Basic %@",authString] forHTTPHeaderField:@"Authorization"];
        // Convert your data and set your request's HTTPBody property
        request.HTTPBody = [[NSString stringWithFormat:@"grant_type=password&username=%@&password=%@",usuario,password] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSHTTPURLResponse *responseCode = nil;
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if (error) return nil;
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %i", urlPath, [responseCode statusCode]);
            return NO;
        }
        else{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
            if (error) return nil;
            if ([json objectForKey:@"access_token"] && [json objectForKey:@"refresh_token"]) return json;
            else return nil;
        }
        
    }
    else return nil;
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
