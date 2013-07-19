//
//  DineroLabel.h
//  ios-clientes
//
//  Created by Pedro Cortez on 19-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DineroLabel : UILabel

- (void)setTextWithNumber:(NSNumber *)value bigFontSize:(float)bigFontSize smallFontSize:(float)smallFontSize isShareValue: (BOOL)isShareValue;

@end
