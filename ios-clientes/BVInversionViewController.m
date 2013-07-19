//
//  BVInversionViewController.m
//  ios-clientes
//
//  Created by Pedro Cortez on 19-07-13.
//  Copyright (c) 2013 Bice Vida. All rights reserved.
//

#import "BVInversionViewController.h"
#import "RentabilidadLabel.h"
#import "DineroLabel.h"
#import "GradientBackgroundHeader.h"

@interface BVInversionViewController ()

@end

@implementation BVInversionViewController

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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section != 3)?26.0:40.0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GradientBackgroundHeader *header = [[GradientBackgroundHeader alloc]initWithDelegate:self labelHeight:((section!=3)?26:40)];
    header.haveTopBorder = YES;
    if (section==0){
        [header setLeftLabelText:@"Rentabilidad del Portafolio" isFontSizeBig:NO];
        [header setRightLabelText:@"14/02/2012"];
    }
    else if(section == 1){
        [header setLeftLabelText:@"Saldo Total" isFontSizeBig:NO];
        [header setRightLabelText:@"14/02/2012"];
    }
    else if(section == 2){
        [header setLeftLabelText:@"Póliza" isFontSizeBig:NO];
    }
    else {
        [header setLeftLabelText:@"Portafolio" isFontSizeBig:YES];
        [header setRightLabelText:@"14/02/2012"];
    }
    
    return header;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return (section!=3?1:3);
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    // Return the number of rows in the section.
    if ([indexPath section] == 0 || [indexPath section] == 1 || [indexPath section] == 2){
        return 70.0;
    }
    else if([indexPath section] == 3)
        return 54.0;
    else
        return 54.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    if ([indexPath section]==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RentabilidadCell" forIndexPath:indexPath];
        [(RentabilidadLabel *)[cell viewWithTag:10] setTextWithPercentage:[NSNumber numberWithDouble:-0.0223] bigFontSize:40.0 smallFontSize:20.0];
    }
    else if ([indexPath section]==1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DineroCell" forIndexPath:indexPath];
        [(DineroLabel *)[cell viewWithTag:10] setTextWithNumber:[NSNumber numberWithInt:1000000] bigFontSize:40.0 smallFontSize:20.0 isShareValue:NO];
    }
    else if ([indexPath section]==2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PolizaCell" forIndexPath:indexPath];
        [(UILabel *)[cell viewWithTag:10] setText:@"APV-70001"];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FondoCell" forIndexPath:indexPath];
        
        if ([indexPath row] == 0) {
            [(UIView *)[cell viewWithTag:13] setBackgroundColor:[UIColor redColor]];
            [(UILabel *)[cell viewWithTag:11] setText:@"Best Mercados Emergentes"];
            [(UILabel *)[cell viewWithTag:10] setText:@"20%"];
            [(RentabilidadLabel *)[cell viewWithTag:12] setTextWithPercentage:[NSNumber numberWithDouble:-0.11] bigFontSize:18.0 smallFontSize:12.0];
        }
        else if ([indexPath row] == 1) {
            [(UIView *)[cell viewWithTag:13] setBackgroundColor:[UIColor greenColor]];
            [(UILabel *)[cell viewWithTag:11] setText:@"Index"];
            [(UILabel *)[cell viewWithTag:10] setText:@"50%"];
            [(RentabilidadLabel *)[cell viewWithTag:12] setTextWithPercentage:[NSNumber numberWithDouble:-0.0123] bigFontSize:18.0 smallFontSize:12.0];
        }
        else {
            [(UIView *)[cell viewWithTag:13] setBackgroundColor:[UIColor orangeColor]];
            [(UILabel *)[cell viewWithTag:11] setText:@"Master"];
            [(UILabel *)[cell viewWithTag:10] setText:@"30%"];
            [(RentabilidadLabel *)[cell viewWithTag:12] setTextWithPercentage:[NSNumber numberWithDouble:0.0213] bigFontSize:18.0 smallFontSize:12.0];
        }
        
    }
    
    return cell;
}


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
