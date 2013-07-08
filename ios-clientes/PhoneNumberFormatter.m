//
//  PhoneNumberFormatter.m
//  ios-clientes
//
//  Created by Pedro Cortez on 08-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "PhoneNumberFormatter.h"

@interface PhoneNumberFormatter(Private)
- (NSString *)parseString:(NSString *)input;
- (NSString *)parseStringStartingWithOne:(NSString *)input;
- (NSString *)parsePartialStringStartingWithOne:(NSString *)input;
- (NSString *)parseLastSevenDigits:(NSString *)basicNumber;

- (NSString *)stripNonDigits:(NSString *)input;
- (NSUInteger)formattedNewLocationFromOldFormatted:(NSString *)formattedOld formattedNew:(NSString *)formattedNew formattedOldLocation:(NSUInteger)formattedOldLocation lengthAdded:(NSUInteger)lengthAdded;
@end

@implementation PhoneNumberFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSString class]]) return nil;
    if ([anObject length] < 1) return nil;
    
    
    
    NSCharacterSet *doNotWant = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *unformatted = [[(NSString *)anObject componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    if (unformatted.length == 0) return nil;
    
    NSString *firstNumber = [unformatted substringToIndex:1],
    *output;
    
    if ([firstNumber isEqualToString:@"1"]) {
        output = [self parseStringStartingWithOne:unformatted];
    } else {
        output = [self parseString:unformatted];
    }
    return output;
}

- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error {
    *anObject = (id)[self stripNonDigits:string];
    return YES;
}

- (NSString *)stripNonDigits:(NSString *)input
{
    NSCharacterSet *doNotWant = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [[input componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
}

- (NSUInteger)formattedNewLocationFromOldFormatted:(NSString *)formattedOld formattedNew:(NSString *)formattedNew formattedOldLocation:(NSUInteger)formattedOldLocation lengthAdded:(NSUInteger)lengthAdded
{
    NSUInteger unformattedLocationOld = [[self stripNonDigits:[formattedOld substringToIndex:formattedOldLocation]] length];
    NSUInteger unformattedLocationNew = unformattedLocationOld + lengthAdded;
    NSUInteger formattedLocationNew   = 0;
    
    while (unformattedLocationNew > 0 && formattedLocationNew < formattedNew.length) {
        unichar currentCharacter = [formattedNew characterAtIndex:formattedLocationNew];
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:currentCharacter]) {
            unformattedLocationNew--;
        }
        
        formattedLocationNew++;
    }
    
    return formattedLocationNew;
}

- (BOOL)isPartialStringValid:(NSString **)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString **)error
{
    NSString *formattedOld      = origString;
    NSString *proposedNewString = *partialStringPtr;
    NSString *formattedNew      = [self stringForObjectValue:proposedNewString];
    NSUInteger formattedLocationNew = 0;
    NSUInteger lengthAdded          = 0;
    
    if (formattedOld.length > proposedNewString.length) { // removing characters
        lengthAdded = -(origSelRange.location - (*proposedSelRangePtr).location);
    } else if (formattedOld.length < proposedNewString.length) { // adding characters
        lengthAdded = (*proposedSelRangePtr).location - origSelRange.location;
    } else { // replace characters
        lengthAdded = origSelRange.length;
    }
    
    formattedLocationNew = [self formattedNewLocationFromOldFormatted:formattedOld formattedNew:formattedNew formattedOldLocation:origSelRange.location lengthAdded:lengthAdded];
    
    *partialStringPtr = formattedNew;
    *proposedSelRangePtr = NSMakeRange(formattedLocationNew, (*proposedSelRangePtr).length);
    
    return NO;
}

- (NSString *)parseLastSevenDigits:(NSString *)input {
    NSString *output;
    NSMutableString *obj = [NSMutableString stringWithString:input];
    
    if ([obj length] >= 4 && [obj length] <= 7) {
        [obj insertString:@"-" atIndex:3];
        output = obj;
    } else {
        output = obj;
    }
    return output;
}

- (NSString *)parseLastEightDigits:(NSString *)input {
    NSString *output;
    NSMutableString *obj = [NSMutableString stringWithString:input];
    
    if ([obj length] >= 7 && [obj length] < 8) {
        [obj insertString:@"-" atIndex:4];
        output = obj;
    } else if ([obj length] == 8){
        [obj insertString:@"-" atIndex:4];
        [obj insertString:@"-" atIndex:1];
        output = obj;
    } else {
        output = obj;
    }
    return output;
}

- (NSString *)parseString:(NSString *)input {
    NSMutableString *obj = [NSMutableString stringWithString:input];
    NSString *output;
    NSUInteger len = input.length;

    /*
    if (len >= 8 && len <= 10) {
        NSString *areaCode  = [obj substringToIndex:3];
        NSString *lastSeven = [self parseLastSevenDigits:[obj substringFromIndex:3]];
        output = [NSString stringWithFormat:@"(%@) %@", areaCode, lastSeven];
     */
    if (len == 8) {
        NSString *lastEight = [self parseLastEightDigits:obj];
        output = [NSString stringWithFormat:@"%@", lastEight];
    } else if (len == 9) {
        NSString *areaCode  = [obj substringToIndex:1];
        NSString *lastEight = [self parseLastEightDigits:[obj substringFromIndex:1]];
        output = [NSString stringWithFormat:@"(%@) %@", areaCode, lastEight];
    } else if (len == 10) {
        NSString *areaCode  = [obj substringToIndex:2];
        NSString *lastEight = [self parseLastEightDigits:[obj substringFromIndex:2]];
        output = [NSString stringWithFormat:@"(%@) %@", areaCode, lastEight];
    } else if (len == 11) {
        NSString *areaCode  = [obj substringToIndex:3];
        NSString *lastEight = [self parseLastEightDigits:[obj substringFromIndex:3]];
        output = [NSString stringWithFormat:@"(+%@) %@", areaCode, lastEight];
    /*
    } else if (len == 12) {
        NSString *areaCode  = [obj substringToIndex:4];
        NSString *lastEight = [self parseLastEightDigits:[obj substringFromIndex:4]];
        output = [NSString stringWithFormat:@"(+%@) %@", areaCode, lastEight];
     */
    } else {
        output = obj;
    }
    return output;
}

- (NSString *)parsePartialStringStartingWithOne:(NSString *)input {
    NSMutableString *partialAreaCode = [NSMutableString stringWithString:[input substringFromIndex:1]];
    NSUInteger numSpaces = 3 - partialAreaCode.length, i;
    
    for (i = 0; i < numSpaces; i++) {
        [partialAreaCode appendString:@" "];
    }
    return [NSString stringWithFormat:@"1 (%@)", partialAreaCode];
}

- (NSString *)parseStringStartingWithOne:(NSString *)input {
    NSUInteger len = input.length;
    NSString *output;
    
    if (len == 1 || len >= 12) {
        output = input;
    } else if (len > 4) {
        NSString *firstPart  = [self parsePartialStringStartingWithOne:[input substringToIndex:4]];
        NSString *secondPart = [self parseLastSevenDigits:[input substringFromIndex:4]];
        output = [NSString stringWithFormat:@"%@ %@", firstPart, secondPart];
    } else {
        output = [NSString stringWithFormat:@"%@", [self parsePartialStringStartingWithOne:input]];
    }
    
    return output;
}

@end

void Init_PhoneNumberFormatter(void);
void Init_PhoneNumberFormatter(void)
{
    // Do nothing. This function is required by the MacRuby runtime when this
    // file is compiled as a C extension bundle.
}
