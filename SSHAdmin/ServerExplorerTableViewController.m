//
//  ServerExplorerTableViewController.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 12/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "ServerExplorerTableViewController.h"
#import "Server.h"
#import "ServerDetailViewController.h"

@interface ServerExplorerTableViewController ()


@end

@implementation ServerExplorerTableViewController

- (NSArray *)tableContents
{
    
    if (! _tableContents){
        //_tableContents = @[@"Hello", @"iOS7", @"Table", @"View", @"Example"];
        _tableContents = [[NSMutableArray alloc]init];
        
    }
    
    return _tableContents;
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

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Properties

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections. There will always only be 1 section.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//
    // Return the number of rows in the section.
    return self.tableContents.count;
}

#pragma mark - Table Logic

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    id object = [self.tableContents objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[Server class]])
    {
        cell.textLabel.text = [(Server *)object serverName];
        cell.detailTextLabel.text = [(Server *)object serverAddress];
    }
    else
    {
        cell.textLabel.text = @"Cell is broken!";
    }
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self deleteCellFromView:indexPath.row];
        //Auto generated to remove from view with animation.
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)deleteCellFromView:(long)row
{
    if (self.tableContents[row])
    {
        [self.tableContents removeObjectAtIndex:row];
        [self.tableView reloadData];
    }
}


#pragma mark - Segues

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addServerSeque"]) //Name defined in the storyboard
    {
        if ([segue.destinationViewController isKindOfClass:[UIViewController class]])
        {
            AddServerViewController *destination = (AddServerViewController *)segue.destinationViewController;
            destination.title = @"Add Server";
            destination.delegate = self;
        }
        else
        {
            NSLog(@"Something went wrong when calling addServerSegue");
        }
    }
    else if ([segue.identifier isEqualToString:@"ServerDetailSegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[ServerDetailViewController class]]){
            ServerDetailViewController *destination = (ServerDetailViewController *)segue.destinationViewController;
            if ([sender isKindOfClass:[UITableViewCell class]]) {
                Server *serv = self.tableContents[[self.tableView indexPathForCell:sender].row];
                destination.title = serv.serverName;
                destination.serv = serv;
            }
        }
        else
        {
            NSLog(@"Something went wrong when calling ServerDetailSegue");
        }
    }
    else
    {
        NSLog(@"Unidentified segue! %@", segue.identifier);
        exit(1);
    }
}


#pragma mark - Delegates

- (void) AddServerViewControllerDidSave:(AddServerViewController *)controller
                             withServer:(Server *)server
{
    NSMutableArray *tempContents = self.tableContents.mutableCopy;
    [tempContents addObject:server];
    self.tableContents = tempContents;
    
    //Insert Object at the last row in the first section.
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.tableContents count]-1
                                                                inSection:0]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
     
    [self.navigationController popViewControllerAnimated:YES];
    
}

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







@end
