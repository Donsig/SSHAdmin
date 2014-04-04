//
//  StaticCommandTableViewController.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 23/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "StaticCommandTableViewController.h"
#import "ExecuteCommandViewController.h"

@interface StaticCommandTableViewController ()

@property (strong, nonatomic) NSMutableArray *commandList;

@end

@implementation StaticCommandTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSMutableArray *)commandList
{
    
    if (! _commandList){
        
        _commandList = [[NSMutableArray alloc]init];
        Command *cmd = [[Command alloc]init];
        cmd.input = @"sudo apt-get update";
        cmd.expectedOutput = nil;
        cmd.server = self.serv;
        [self.commandList addObject:cmd];
        //[self.tableView reloadData];
    }
    
    return _commandList;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.commandList.count;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    static NSString *cellIdentifier = @"CommandCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id object = [self.commandList objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[Command class]])
    {
        cell.textLabel.text = [(Command *)object input];
    }else
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddCommandSegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[AddCommandViewController class]])
        {
            AddCommandViewController *destination = (AddCommandViewController *)segue.destinationViewController;
            destination.serv = self.serv;
            destination.delegate = self;
            destination.title = @"Add New Command";
        }
    }
    else if ([segue.identifier isEqualToString:@"CommandActivatedSegue"])
    {
        if ([sender isKindOfClass:[UITableViewCell class]])
        {
            if([segue.destinationViewController isKindOfClass:[ExecuteCommandViewController class]])
            {
                ExecuteCommandViewController *destination = (ExecuteCommandViewController *) segue.destinationViewController;
                Command *cmd = self.commandList[[self.tableView indexPathForCell:sender].row];
                destination.title = cmd.input;
                destination.cmd = cmd;
            }
        }
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Delegates

-(void) AddCommandViewControllerDidSave:(AddCommandViewController *)controller withCommand:(Command *)input
{
    NSLog(@"Delegate Called");
    if ([input isKindOfClass:[Command class]] && ![input.input isEqualToString:@""]) {
        input.server = self.serv;
        [self.commandList addObject:input];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.commandList count]-1
                                                                    inSection:0]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



@end
