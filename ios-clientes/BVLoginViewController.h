//
//  BVDetailViewController.h
//  ios-clientes
//
//  Created by Pedro Cortez on 12-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVRutTextFieldDelegate.h"
#import "BVRutTextField.h"

@interface BVLoginViewController : UIViewController <BVRutTextFieldDelegate>

@property (weak, nonatomic) IBOutlet BVRutTextField *textFieldUsuario;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *UIButtonEntrar;


-(IBAction)textFieldReturn:(id)sender;
-(IBAction) slideFrameUp;
-(IBAction) slideFrameDown;
-(void) slideFrame:(BOOL) up;

//delegate
- (void)isCorrectInput:(BOOL) value;
@end
