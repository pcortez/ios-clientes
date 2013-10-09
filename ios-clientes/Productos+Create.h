//
//  Productos+Create.h
//  ios-clientes
//
//  Created by Pedro Cortez on 27-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "Productos.h"

@interface Productos (Create)

+(Productos *)fromDictionary:(NSDictionary *)data isOldData:(int) isOldData inManagedObjectContext:(NSManagedObjectContext *)context;
- (void) setPolizaFromDictionary: (NSDictionary *) data inManagedObjectContext:(NSManagedObjectContext *)context;
//-(double)getDoublePortfolioBalance:(NSManagedObjectContext *)context;
//-(NSNumber *)getNSNumberPortfolioBalance:(NSManagedObjectContext *)context;
//-(double)portfolioRescueTheAmountOf:(double)amount inContext: (NSManagedObjectContext *)context;
//-(void)portfolioAddTheAmountOf:(double)amount withTheDistribution:(double *)distribution inContext:(NSManagedObjectContext *)context;
//-(void)portfolioDistributeFundWith:(double *)distribution inContext:(NSManagedObjectContext *)context;

@end
