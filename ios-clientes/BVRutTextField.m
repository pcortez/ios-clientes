//
//  BVRutTextField.m
//  ios-clientes
//
//  Created by Pedro Cortez on 18-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVRutTextField.h"
#import "CommonAlgorithm.h"

@implementation BVRutTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self initValue];
    }
    return self;
}

- (void) initValue {
    [self setKeyboardType:UIKeyboardTypeNumberPad];
    self.placeholder = @"usuario";
    [self addTarget:self action:@selector(editBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(editChangeEnd:) forControlEvents:UIControlEventEditingChanged];
    //[self addTarget:self action:@selector(textFieldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



- (NSString *)getFormatRut
{
    if (!self.text || [self.text isEqualToString:@""]) return @"";
    if ([self.text rangeOfString:@"-"].location == NSNotFound) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"es_CL"]];
        [formatter setPositiveFormat:@"#,###,###,##0"];
        [formatter setNegativeFormat:@"#,###,###,##0"];
        
        NSString *s = [self.text substringWithRange:NSMakeRange(0,[self.text length]-1)];
        s = [formatter stringFromNumber:[NSNumber numberWithFloat:[s floatValue]]];
        s = [s stringByAppendingString:@"-"];
        return [s stringByAppendingString:[self.text substringWithRange:NSMakeRange([self.text length]-1,1)]];
    }
    else {
        return self.text;
    }
    
}

-(IBAction)editBegin:(id)sender
{
    //self.font = [UIFont systemFontOfSize:15.0f];
    if (![self.text isEqualToString:@""]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"es_CL"]];
        [formatter setPositiveFormat:@"#,###,###,##0"];
        [formatter setNegativeFormat:@"#,###,###,##0"];
        
        NSNumber *aux=[formatter numberFromString:[self.text substringWithRange:NSMakeRange(0,[self.text length]-2)]];
        self.text = [NSString stringWithFormat:@"%d%@",[aux intValue],[self.text substringWithRange:NSMakeRange([self.text length]-1,1)]];
    }
    self.text = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(IBAction)editDidEnd:(id)sender
{
    if (![self.text isEqualToString:@""]){
        //self.font = [UIFont systemFontOfSize:18.0f];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"es_CL"]];
        [formatter setPositiveFormat:@"#,###,###,##0"];
        [formatter setNegativeFormat:@"#,###,###,##0"];
        
        
        NSString *s = [self.text substringWithRange:NSMakeRange(0,[self.text length]-1)];
        
        //validator
        [self.customDelegate isCorrectInput:rutValidator([s integerValue],[self.text characterAtIndex:[self.text length]-1])];
        
        s = [formatter stringFromNumber:[NSNumber numberWithFloat:[s floatValue]]];
        s = [s stringByAppendingString:@"-"];
        self.text = [s stringByAppendingString:[self.text substringWithRange:NSMakeRange([self.text length]-1,1)]];
    }
    self.text = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(IBAction)editChangeEnd:(id)sender
{
    if (![self.text isEqualToString:@""]){
        NSString *s = [self.text substringWithRange:NSMakeRange(0,[self.text length]-1)];
        //validator
        [self.customDelegate isCorrectInput:rutValidator([s integerValue],[self.text characterAtIndex:[self.text length]-1])];
    }
}

@end
