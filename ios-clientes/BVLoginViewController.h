//
//  BVDetailViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 12-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BVLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldUsuario;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;


-(IBAction)textFieldReturn:(id)sender;
@end
