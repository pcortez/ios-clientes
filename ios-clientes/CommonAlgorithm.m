//
//  CommonAlgorithm.m
//  ios-clientes
//
//  Created by Pedro Cortez on 18-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "CommonAlgorithm.h"

@implementation CommonAlgorithm


BOOL rutValidator(int rut, char validator)
{
    int m = 0, s = 1;
    for(; rut; rut /= 10) s = (s+rut%10*(9-m++%6))%11;
    return (s ? (char)(s + 47):(char)75) == validator;
}

@end
