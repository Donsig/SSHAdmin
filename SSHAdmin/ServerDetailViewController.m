//
//  ServerDetailViewController.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 14/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "ServerDetailViewController.h"
#import "StaticCommandTableViewController.h"
#import "SelectScriptTableViewController.h"
@interface ServerDetailViewController ()

@end

@implementation ServerDetailViewController

@synthesize addressLabel, portLabel, userNameLabel, serv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View loaded!");
    if (serv){
        if (serv.serverAddress) {
            addressLabel.text = serv.serverAddress;
        }
        
        if (serv.serverPort) {
            portLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)serv.serverPort];
        }
        
        if (serv.userName) {
            userNameLabel.text = serv.userName;
        }
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectCommandSegue"])
    {
        
        if ([segue.destinationViewController isKindOfClass:[StaticCommandTableViewController class]])
        {
            StaticCommandTableViewController *destination = (StaticCommandTableViewController *) segue.destinationViewController;
            destination.serv = self.serv;
        }
    }
    else if ([segue.identifier isEqualToString:@"SelectScriptSegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[SelectScriptTableViewController class]])
        {
            SelectScriptTableViewController *destination = (SelectScriptTableViewController *) segue.destinationViewController;
            destination.serv = self.serv;
        }
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
