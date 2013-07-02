//
//  BVPerfilViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 01-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVPerfilViewController.h"
#import "GradientBackground.h"
#import "GradientBackgroundHeader.h"

@interface BVPerfilViewController ()

@end

@implementation BVPerfilViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /*
    self.nombreCell.detailTextLabel.text = [self.cliente.nombre capitalizedString];
    self.apellidoCell.detailTextLabel.text = [self.cliente.apellido capitalizedString];
    self.rutCell.detailTextLabel.text = [self.cliente.rut uppercaseString];
    self.emailCell.detailTextLabel.text = [self.cliente.email lowercaseString];
    self.direccionCell.detailTextLabel.text = @"Los Juncos 171";
    self.comunaCell.detailTextLabel.text = @"Las Condes";
     */
    
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

    [header setLeftLabelText:(section==0?@"Cliente":@"Información") isFontSizeBig:NO];
    header.haveTopBorder = NO;
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section==0?3:3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ([indexPath section]==0) {
        if ([indexPath row]==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NombreCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = [self.cliente.nombre capitalizedString];
        }
        else if ([indexPath row]==1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"ApellidoCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = [self.cliente.apellido capitalizedString];
        }
        else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"RutCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = [self.cliente.rut uppercaseString];
        }
    }
    else {
        if ([indexPath row]==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"EmailCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = [self.cliente.email lowercaseString];
        }
        else if ([indexPath row]==1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"DireccionCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = @"Los Juncos 171";
        }
        else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ComunaCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = @"Las Condes";
        }
    }

    GradientBackground *cellBackgroundView = [[GradientBackground alloc] initWithDelegate:self];
    cellBackgroundView.colorGradientTop = [UIColor whiteColor];
    cellBackgroundView.colorGradientBottom = [UIColor whiteColor];
    cell.backgroundView = cellBackgroundView;
    
    return cell;
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


-(float)getWidth{
    return self.view.frame.size.width;
}
@end
