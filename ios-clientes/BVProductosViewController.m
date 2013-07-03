//
//  BVProductosViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 26-06-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVProductosViewController.h"
#import "BVEditarPerfilViewController.h"
#import "Productos+Create.h"
#import "GradientBackground.h"
#import "GradientBackgroundHeader.h"

@interface BVProductosViewController ()

@end

@implementation BVProductosViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)setupFetchResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Productos"];
    request.predicate = [NSPredicate predicateWithFormat:@"tieneUnCliente.id == %@",self.cliente.id];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"negocioCodigo" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"negocioNombre" cacheName:nil];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController setTitle:@"Productos"];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.managedObjectContext = [self managedObjectContext];
    [self setupFetchResultsController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return 65.0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GradientBackgroundHeader *header = [[GradientBackgroundHeader alloc]initWithDelegate:self labelHeight:30.0];
    [header setLeftLabelText:[[[[self.fetchedResultsController sections]objectAtIndex:section] name] capitalizedString] isFontSizeBig:NO];
    header.haveTopBorder = NO;
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"ProductoCell" forIndexPath:indexPath];
    GradientBackground *cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    cell.backgroundView = cellBackgroundView;

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Productos *producto = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [producto.nombre capitalizedString];
    //[UIFont preferredFontForTextStyle:UIFontDescriptorTraitExpanded];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Póliza: %@",[producto.contratoCodigo uppercaseString]];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Gradient UIView delegate
-(float)getWidth
{
    return self.tableView.frame.size.width;
}

@end
