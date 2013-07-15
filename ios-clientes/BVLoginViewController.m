//
//  BVDetailViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 12-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVLoginViewController.h"
#import "BVProductosViewController.h"
#import "BVPerfilViewController.h"

#import "BVApiConnection.h"

#import "Sucursal+Create.h"
#import "Usuario+Create.h"


@interface BVLoginViewController ()

@end

@implementation BVLoginViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //scroll view
    self.scrollViewContenedor.contentSize = self.view.frame.size;
    [self.scrollViewContenedor setBackgroundColor: [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroundLogin"]]];
    
    [self crearFormulario];
	// Gesto para esconder teclado al momento de tocar el background
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //Revisando datos de usuario en db local
    /*
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"ultimoLogin" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error;
    NSArray *matches = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (matches && [matches count]>0){
        self.cliente = [matches lastObject];
        if (self.cliente.autoLogin) {
            self.usuario.text = self.cliente.rut;
            self.password.text = self.cliente.password;
            [self login];
        }
    }
    */
}


- (void)crearFormulario
{
    //password
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(131.0f, self.view.frame.size.height-70.0f, 107.0f, 40.0f)];
    self.password.placeholder = @"Contraseña";
    self.password.backgroundColor = [UIColor darkGrayColor];
    [self.password setAlpha:0.7f];
    [self.password setTextColor:[UIColor whiteColor]];
    [self.password setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.password setTextAlignment:NSTextAlignmentCenter];
    [self.password setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.password setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.password setBorderStyle:UITextBorderStyleNone];
    self.password.secureTextEntry = YES;
    [self.password addTarget:self action:@selector(buttonEntrar:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.password addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.password addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    [self.scrollViewContenedor addSubview:self.password];
    
    //usuario
    self.usuario = [[BVRutTextField alloc] initWithFrame:CGRectMake(20.0f, self.view.frame.size.height-70.0f, 107.0f, 40.0f)];
    self.usuario.customDelegate = self;
    self.usuario.placeholder = @"Usuario";
    self.usuario.backgroundColor = [UIColor darkGrayColor];
    [self.usuario setAlpha:0.7f];
    [self.usuario setTextColor:[UIColor whiteColor]];
    [self.usuario setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.usuario setTextAlignment:NSTextAlignmentCenter];
    [self.usuario setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.usuario setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.usuario setBorderStyle:UITextBorderStyleNone];
    //[self.usuario addTarget:self action:@selector(hideOneKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.usuario addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.usuario addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [self.scrollViewContenedor addSubview:self.usuario];
    
    //Entrar
    self.entrar = [[UIButton alloc]initWithFrame:CGRectMake(242.0f, self.view.frame.size.height-70.0f, 58.0f, 40.0f)];
    [self.entrar setTitle:@"Entrar" forState:UIControlStateNormal];
    [self.entrar setTitleColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];

    self.entrar.backgroundColor = [UIColor colorWithRed:79.0f/255.0f green:205.0f/255.0f blue:18.0f/255.0f alpha:0.7f];
    [self.entrar.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.entrar setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.entrar setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    self.entrar.enabled = NO;
    [self.entrar addTarget:self action:@selector(buttonEntrar:) forControlEvents:UIControlEventTouchDown];
    [self.scrollViewContenedor addSubview:self.entrar];
    
    //loading
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loading.frame = CGRectMake(self.view.bounds.size.width/2-20.0f, self.view.frame.size.height-70.0f, 40.0f, 40.0f);
    self.loading.hidden = YES;
    self.loading.color = [UIColor whiteColor];
    [self.scrollViewContenedor addSubview:self.loading];
    
}


- (void)hideKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    [self.activeField resignFirstResponder];
}

-(IBAction)hideOneKeyboard:(id)sender {
    [sender resignFirstResponder];
}

//guardar text field activo
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//esconder teclado
- (void)viewWillAppear:(BOOL)animated
{
    //scroll view
    self.scrollViewContenedor.contentInset = UIEdgeInsetsZero;
    self.scrollViewContenedor.scrollIndicatorInsets = UIEdgeInsetsZero;
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
    if (!CGRectContainsPoint(rect, self.activeField.frame.origin)) {
        CGPoint scrollPoint=CGPointMake(0.0, self.view.frame.origin.y+(keyboardSize.height));
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


//boton entrar
//esconder text field, botones y mostrar activityIndicatorCargando.hidden
-(IBAction)buttonEntrar:(id)sender {
    [self login];
}

- (void) login
{
    self.usuario.hidden = YES;
    self.password.hidden = YES;
    self.entrar.hidden = YES;
    self.loading.hidden = NO;
    [self.loading startAnimating];
    
    //thread autenticacion
    dispatch_queue_t downloadQueue = dispatch_queue_create("autentificacion web service", NULL);
    dispatch_async(downloadQueue, ^{
        BOOL isValidado = userAuthentication([self.usuario getRutConVerificador:NO], self.password.text);
        NSDictionary *jsonData = nil;
        if (isValidado) jsonData = userData([self.usuario getRutConVerificador:NO]);
        
        //este thread no se ejecuta antes de terminar el primer thread creado
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isValidado && jsonData) {
                //segue
                //NSDictionary *jsonData = userData([self.usuario getRutConVerificador:NO]);
                self.cliente=[Usuario updateFromDictionary:jsonData client:self.cliente inManagedObjectContext:self.managedObjectContext];
                self.cliente.ultimoLogin = [NSDate date];
                self.cliente.autoLogin = [NSNumber numberWithBool:YES];

                [self.managedObjectContext save:nil];
                [self.loading stopAnimating];
                [self performSegueWithIdentifier:@"ProductosSegue" sender:self];
            }
            else {
                self.password.text = @"";
                //self.usuario.text = @"";
                [self.loading stopAnimating];
                self.loading.hidden = YES;
                self.usuario.hidden = NO;
                self.password.hidden = NO;
                self.entrar.hidden = NO;
            }
        });
    });
}

//delegate
- (void)isCorrectInput:(BOOL) value {
    self.entrar.enabled = value;
    if(!value){
        [self.entrar setBackgroundColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f]];
    }
    else{
        [self.entrar setBackgroundColor:[UIColor colorWithRed:(79.0f / 255.0f) green:(205.0f / 255.0f) blue:(18.0f / 255.0f) alpha:1.0f]];
    }
}


//segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ProductosSegue"]) {
        
        UITabBarController *tabBarViewController = (UITabBarController *) [segue destinationViewController];
        UINavigationController *navController = [[tabBarViewController viewControllers] objectAtIndex:0];
        
        BVProductosViewController *ProductosVc = (BVProductosViewController *) [[navController viewControllers] objectAtIndex:0];
        BVPerfilViewController *perfilVc = (BVPerfilViewController *) [[navController viewControllers] objectAtIndex:1];

        [ProductosVc performSelector:@selector(setCliente:) withObject:self.cliente];
        [perfilVc performSelector:@selector(setCliente:) withObject:self.cliente];
    }
}

@end
