//
//  BVDetailViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 12-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVLoginViewController.h"

@interface BVLoginViewController ()
//- (void)configureView;
@end

@implementation BVLoginViewController

#pragma mark - Managing the detail item
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Gesto para esconder teclado al momento de tocar el background
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //screen config
    [self.view setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"backgroundLogin"]]];    
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



@end
