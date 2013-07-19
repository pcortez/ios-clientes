//
//  BVInversionViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 19-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientBackgroundDelegate.h"

@interface BVInversionViewController : UITableViewController<GradientBackgroundDelegate>
-(float)getWidth;
@end
