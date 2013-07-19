//
//  RentabilidadLabel.h
//  ios-clientes
//
//  Created by Pedro Cortez on 19-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentabilidadLabel : UILabel

@property (nonatomic,strong)UIColor *positiveColor;
@property (nonatomic,strong)UIColor *negativeColor;
@property (nonatomic,strong)UIFont *customFont;

- (void)setTextWithPercentage:(NSNumber *)percentage bigFontSize:(float)bigFontSize smallFontSize:(float)smallFontSize;


@end
