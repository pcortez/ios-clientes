//
//  BVEditarPerfilViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 02-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVEditarPerfilViewController.h"
#import "GradientBackground.h"

@interface BVEditarPerfilViewController ()

@end

@implementation BVEditarPerfilViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.labelParametro.text = [self.parametro stringByAppendingString:@":"];
    self.labelParametro.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline1];//systemFontOfSize:20.0f];
    self.textFieldValor.placeholder = self.valor;
    
    GradientBackground *cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    cellBackgroundView.haveTopBorder = NO;
    self.cellValor.backgroundView = cellBackgroundView;
    
    //gestos
    // Gesto para esconder teclado al momento de tocar el background
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [self.tableView  setContentInset:UIEdgeInsetsMake(20, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];

    
    if ([self.parametro isEqualToString:@"Celular"])
        self.textFieldValor.KeyboardType = UIKeyboardTypeNumberPad;
    else if ([self.parametro isEqualToString:@"E-mail"])
        self.textFieldValor.KeyboardType = UIKeyboardTypeEmailAddress;
    else
        self.textFieldValor.KeyboardType = UIKeyboardTypeDefault;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"unwindToViewControllerProductosGuardar"]) {
        self.valor = self.textFieldValor.text;
        
    }
}

- (void)hideKeyboard
{
    [self.textFieldValor resignFirstResponder];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

-(float)getWidth
{
    return self.tableView.frame.size.width;
}
@end
