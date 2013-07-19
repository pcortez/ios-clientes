//
//  DineroLabel.m
//  ios-clientes
//
//  Created by Pedro Cortez on 19-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "DineroLabel.h"

@implementation DineroLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
    }
    return self;
}


- (void)setTextWithNumber:(NSNumber *)value bigFontSize:(float)bigFontSize smallFontSize:(float)smallFontSize isShareValue: (BOOL)isShareValue
{
    NSTextAlignment storyBoardConfig =  self.textAlignment;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"es_CL"]];
    if (isShareValue) {
        [formatter setPositiveFormat:@"#,##0.0¤¤"];
        [formatter setNegativeFormat:@"-#,##0.0¤¤"];
    }
    else{
        [formatter setPositiveFormat:@"##,###,##0¤¤"];
        [formatter setNegativeFormat:@"-##,###,##0¤¤"];
    }
    
    
    if (![self respondsToSelector:@selector(setAttributedText:)]){
        [self setText:[formatter stringFromNumber:value]];
        self.font = [UIFont fontWithName:@"Helvetica-Bold" size:smallFontSize];
        self.textAlignment = storyBoardConfig;
    }
    
    NSString *s = [[NSString alloc ]initWithFormat:@"%@",[formatter stringFromNumber:value]];
    //is money
    const NSRange range = NSMakeRange([s length]-3, 3);
    
    UIFont *miniFont = [UIFont boldSystemFontOfSize:smallFontSize];
    UIFont *regularFont = [UIFont fontWithName:@"Helvetica-Bold" size:bigFontSize];
    
    
    // Create the attributed string (text + attributes)
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:s attributes:@{ NSFontAttributeName : regularFont }];
    [attributedText setAttributes:@{ NSFontAttributeName :miniFont} range:range];
    
    // Set it in our UILabel
    [self setAttributedText:attributedText];
    self.textAlignment = storyBoardConfig;
}

@end
