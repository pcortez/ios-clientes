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
    
    //screen config
    [self.view setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroundLogin"]]];
    
    //la vista como delegate
    self.textFieldUsuario.customDelegate = self;
    //boton desactivado hasta que se valide el rut
    self.UIButtonEntrar.enabled = NO;
    //esconder activityIndicator
    self.activityIndicatorCargando.hidden = YES;
}

- (void) viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction) slideFrameUp
{
    [self slideFrame:YES];
}

-(IBAction) slideFrameDown
{
    [self slideFrame:NO];
}

-(void) slideFrame:(BOOL) up
{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];

    const int movementDistance = (orientation==UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight?150:200); // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


//boton entrar
//esconder text field, botones y mostrar activityIndicatorCargando.hidden
-(IBAction)buttonEntrar:(id)sender {
    self.textFieldUsuario.hidden = YES;
    self.textFieldPassword.hidden = YES;
    self.UIButtonEntrar.hidden = YES;
    self.activityIndicatorCargando.hidden = NO;
    [self.activityIndicatorCargando startAnimating];
    
    if (userAuthentication([self.textFieldUsuario getRutConVerificador:NO], self.textFieldPassword.text)) {
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
}

//delegate
- (void)isCorrectInput:(BOOL) value {
    self.UIButtonEntrar.enabled = value;
}

//autenticacion
/*
- (BOOL)checkLogin
{
    NSLog(@"----- %@",self.textFieldUsuario);
    
    if (self.textFieldUsuario && [[self.textFieldUsuario getRutConVerificador:NO] length]>4) {
        NSData* data;
        NSURL *urlPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login/%@",[self.mainBundle objectForInfoDictionaryKey:@"BiceVidaApiURL"],[self.textFieldUsuario getRutConVerificador:NO]]];

        NSLog(@" +++++ %@",urlPath);
        NSError *error;
        data = [NSData dataWithContentsOfURL:urlPath options:NSDataReadingUncached error:&error];
        if (error) return NO;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) return NO;
        
        if ([json objectForKey:@"autentificado"]){
            return [[json objectForKey:@"autentificado"] boolValue];
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}
 */

@end
