//
//  BVPolizaViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 09-10-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVPolizaViewController.h"
#import "GradientBackgroundHeader.h"
#import "Productos+Create.h"

@interface BVPolizaViewController ()

@end

@implementation BVPolizaViewController

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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PolizaItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"tieneUnProducto.contratoCodigo == %@",self.producto.contratoCodigo];
    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"categoria" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"categoria" cacheName:nil];
}

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
    self.title = @"Póliza";
    [self setupFetchResultsController];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GradientBackgroundHeader *header = [[GradientBackgroundHeader alloc]initWithDelegate:self labelHeight:30.0];
    [header setLeftLabelText:[[[[self.fetchedResultsController sections]objectAtIndex:section] name] capitalizedString] isFontSizeBig:NO];
    header.haveTopBorder = !(section==0);
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PolizaItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell;
    
    if ([item.valor isEqualToString:item.nombre])
        cell = [tableView dequeueReusableCellWithIdentifier:@"itemEqualCell" forIndexPath:indexPath];
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"itemPolizaCell" forIndexPath:indexPath];
        //[(UILabel *)[cell viewWithTag:10] setText:[item.valor capitalizedString]];
        cell.detailTextLabel.text = [item.valor capitalizedString];
    }
    
    
    cell.textLabel.text = [item.nombre capitalizedString];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Gradient UIView delegate
-(float)getWidth
{
    return self.tableView.frame.size.width;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
