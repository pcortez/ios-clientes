//
//  BVEditarPerfilViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 02-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientBackgroundDelegate.h"

@interface BVEditarPerfilViewController : UITableViewController<GradientBackgroundDelegate,UIBarPositioningDelegate>

@property (strong, nonatomic) NSString *valor;
@property (strong, nonatomic) NSString *parametro;

@property (weak, nonatomic) IBOutlet UILabel *labelParametro;
@property (weak, nonatomic) IBOutlet UITextField *textFieldValor;

@property (weak, nonatomic) IBOutlet UITableViewCell *cellParametro;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellValor;


-(IBAction)hideKeyboard;
-(float)getWidth;
@end
