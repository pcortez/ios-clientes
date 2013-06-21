//
//  BVDetailViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 12-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVLoginViewController.h"
#import "Usuario+Create.h"
#import "BVApiConnection.h"

@interface BVLoginViewController ()

@end

@implementation BVLoginViewController

#pragma mark - Managing the detail item
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Revisando datos de usuario en db local
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"ultimoLogin" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    self.matches = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (self.matches && [self.matches count]>0){
        self.client = [self.matches lastObject];
        if (self.client.autoLogin) {
            self.textFieldUsuario.text = self.client.rut;
            self.textFieldPassword.text = self.client.password;
            [self performSegueWithIdentifier:@"LoadingSegue" sender:self];
        }
        else {
            self.client = nil;
        }
    }
    
	// Gesto para esconder teclado al momento de tocar el background
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //la vista como delegate
    self.textFieldUsuario.customDelegate = self;
    //boton desactivado hasta que se valide el rut
    self.UIButtonEntrar.enabled = NO;
    //esconder activityIndicator
    self.activityIndicatorCargando.hidden = YES;
    //scroll view
    [self.scrollViewContenedor setBackgroundColor: [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroundLogin"]]];
}

- (void)hideKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    [self.textFieldUsuario resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//esconder teclado
- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)keyboardWillShow:(NSNotification*)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    
    self.scrollViewContenedor.contentInset = contentInsets;
    self.scrollViewContenedor.scrollIndicatorInsets = contentInsets;
    
    CGRect rect = self.view.frame;
    rect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(rect, self.textFieldUsuario.frame.origin)) {
        CGPoint scrollPoint=CGPointMake(0.0, self.textFieldUsuario.frame.origin.y-(keyboardSize.height-15));
        [self.scrollViewContenedor setContentOffset:scrollPoint animated:YES];
    }

}

-(void)keyboardWillHide:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.2f];
    self.scrollViewContenedor.contentInset = contentInsets;
    self.scrollViewContenedor.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}


//boton entrar
//esconder text field, botones y mostrar activityIndicatorCargando.hidden
-(IBAction)buttonEntrar:(id)sender {
    self.textFieldUsuario.hidden = YES;
    self.textFieldPassword.hidden = YES;
    self.UIButtonEntrar.hidden = YES;
    self.activityIndicatorCargando.hidden = NO;
    [self.activityIndicatorCargando startAnimating];
    
    //thread autenticacion
    dispatch_queue_t downloadQueue = dispatch_queue_create("autentificacion web service", NULL);
    dispatch_async(downloadQueue, ^{
        BOOL isValidado = userAuthentication([self.textFieldUsuario getRutConVerificador:NO], self.textFieldPassword.text);
        //este thread no se ejecuta antes de terminar el primer thread creado
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isValidado) {
                //segue
                [self.activityIndicatorCargando stopAnimating];
            }
            else {
                [self.activityIndicatorCargando stopAnimating];
                self.textFieldUsuario.hidden = NO;
                self.textFieldPassword.hidden = NO;
                self.UIButtonEntrar.hidden = NO;
                self.activityIndicatorCargando.hidden = YES;
            
                self.textFieldPassword.text = @"";
                self.textFieldUsuario.text = @"";
            }
        });
    });
}

//delegate
- (void)isCorrectInput:(BOOL) value {
    self.UIButtonEntrar.enabled = value;
    if(!value){
        [self.UIButtonEntrar setBackgroundColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f]];
    }
    else{
        [self.UIButtonEntrar setBackgroundColor:[UIColor colorWithRed:(79.0f / 255.0f) green:(205.0f / 255.0f) blue:(18.0f / 255.0f) alpha:1.0f]];
    }
}


@end
