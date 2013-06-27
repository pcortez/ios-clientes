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
#import "Usuario+Create.h"

@interface BVLoginViewController : UIViewController <BVRutTextFieldDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (strong, nonatomic) NSArray *matches;
@property (strong, nonatomic) Usuario *cliente;

//lo tuve que hacer programaticamente por que el scrollview no me permitia hacer
//correcto autolayout para iphone 5
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewContenedor;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *activeField;
@property (strong, nonatomic) IBOutlet BVRutTextField *usuario;
@property (strong, nonatomic) IBOutlet UIButton *entrar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;


-(IBAction)hideOneKeyboard:(id)sender;
-(IBAction)buttonEntrar:(id)sender;
- (void)hideKeyboard:(UIGestureRecognizer *)gestureRecognizer;
-(void)keyboardWillShow:(NSNotification*)notification;
-(void)keyboardWillHide:(NSNotification*)notification;

//delegate
- (void)isCorrectInput:(BOOL) value;
@end
