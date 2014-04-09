//
//  SelectScriptTableViewController.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 01/04/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "SelectScriptTableViewController.h"
#import "ExecuteCommandViewController.h"
@interface SelectScriptTableViewController ()

@property (strong, nonatomic) NSMutableArray *scripts;

@end

@implementation SelectScriptTableViewController


- (NSMutableArray *)scripts
{
    
    if (! _scripts){
        
        _scripts = [[NSMutableArray alloc]init];
        [self getServerScripts];
    }
    
    return _scripts;
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.scripts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    static NSString *cellIdentifier = @"ScriptCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id object = [self.scripts objectAtIndex:indexPath.row];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ScriptSelectedSegue"])
    {
        if ([sender isKindOfClass:[UITableViewCell class]])
        {
            if([segue.destinationViewController isKindOfClass:[ExecuteCommandViewController class]])
            {
                ExecuteCommandViewController *destination = (ExecuteCommandViewController *) segue.destinationViewController;
                Command *cmd = self.scripts[[self.tableView indexPathForCell:sender].row];
                destination.title = cmd.input;
                destination.cmd = cmd;
            }
        }
    }
}

#pragma mark - Logic

-(void)getServerScripts
{
    
    NSString *homedir = [NSString stringWithFormat:@"/home/%@",self.serv.userName];
    NSString *relativeScriptsDir = @".scripts"; //This should be changable through the server page.
    NSString *scriptsDir = [NSString stringWithFormat:@"%@/%@",homedir,relativeScriptsDir];
    
    Command *cmd = [[Command alloc]init];
    cmd.input = nil; //no command is needed, as we simply need the command to look up the directory.
    cmd.expectedOutput = nil;
    cmd.server = self.serv;
    
    __weak typeof(self) weakSelf = self; //We don't want any memory cycles in the block!
    
    dispatch_queue_t newQueue = dispatch_queue_create("myQ", DISPATCH_QUEUE_SERIAL);
    dispatch_async(newQueue, ^(void)
                   {
                       
                       NSArray *directoryListing = [cmd getDirectoryList:scriptsDir];
                       for (NMSFTPFile *files in directoryListing)
                       {
                           if ([files.filename hasSuffix:@".sh"]) //Check if it's a script file
                           {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [weakSelf addCommandToView:[NSString stringWithFormat:@"./%@/%@",relativeScriptsDir,files.filename]];
                               });
                           }
                       }
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [weakSelf.activityMonitor stopAnimating];
                       });

                       
                   });
    
}

- (void)addCommandToView:(NSString *)input
{
    Command *cmd = [[Command alloc]init];
    cmd.input = input;
    cmd.expectedOutput = nil;
    cmd.server = self.serv;
    [self performSelectorOnMainThread:@selector(addCommandToViewWithCommand:) withObject:cmd waitUntilDone:true];
}

- (void)addCommandToViewWithCommand:(Command *)cmd
{
    [self.scripts addObject:cmd];
    [self.tableView reloadData];
    
}


@end
