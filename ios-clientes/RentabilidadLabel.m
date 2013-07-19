//
//  RentabilidadLabel.m
//  ios-clientes
//
//  Created by Pedro Cortez on 19-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "RentabilidadLabel.h"

@implementation RentabilidadLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.positiveColor = [[UIColor alloc]initWithRed: 34.0/255.0 green:139.0/255.0 blue:34.0/255.0 alpha:1];
        self.negativeColor = [UIColor redColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        self.positiveColor = [[UIColor alloc]initWithRed: 34.0/255.0 green:139.0/255.0 blue:34.0/255.0 alpha:1];
        self.negativeColor = [UIColor redColor];
    }
    return self;
}


- (void)setTextWithPercentage:(NSNumber *)percentage bigFontSize:(float)bigFontSize smallFontSize:(float)smallFontSize
{
    NSTextAlignment storyBoardConfig =  self.textAlignment;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"es_CL"]];
    [formatter setPositiveFormat:@"+0.00%"];
    [formatter setNegativeFormat:@"-0.00%"];
    
    if (![self respondsToSelector:@selector(setAttributedText:)]){
        [self setText:[formatter stringFromNumber:percentage]];
        self.font = [UIFont boldSystemFontOfSize:smallFontSize];
        //self.font = [UIFont fontWithName:@"Helvetica-Bold" size:smallFontSize];
        self.textAlignment = storyBoardConfig;
        [self setTextColor:([percentage floatValue]<0.0?self.negativeColor:self.positiveColor)];
    }
    
    NSString *s = [[NSString alloc ]initWithFormat:@"%@",[formatter stringFromNumber:percentage]];
    //is a percentage
    const NSRange range = NSMakeRange([s length]-1, 1);
    
    UIFont *miniFont = [UIFont boldSystemFontOfSize:smallFontSize];
    UIFont *regularFont = [UIFont boldSystemFontOfSize:bigFontSize];
    //UIFont *regularFont = [UIFont fontWithName:@"Helvetica-Bold" size:bigFontSize];
    
    
    // Create the attributed string (text + attributes)
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:s attributes:@{ NSFontAttributeName : regularFont }];
    [attributedText setAttributes:@{ NSFontAttributeName :miniFont} range:range];
    
    // Set it in our UILabel
    [self setAttributedText:attributedText];
    [self setTextColor:([percentage floatValue]<0.0?self.negativeColor:self.positiveColor)];
    self.textAlignment = storyBoardConfig;
}

@end
