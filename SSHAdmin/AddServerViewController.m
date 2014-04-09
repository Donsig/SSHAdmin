//
//  AddServerViewController.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 10/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "AddServerViewController.h"

static const int DEFAULT_PORT = 22;


@interface AddServerViewController ()

@end


@implementation AddServerViewController

#pragma mark - Save Server

- (IBAction)saveServerButton:(UIBarButtonItem *)sender {

    Server *serv = [[Server alloc] init];

    //Add Server to the explorer.
    [serv addServer:_serverNameInput.text
            Address:_serverAddressInput.text
               Port:[_serverPortInput.text integerValue] ? [_serverPortInput.text integerValue] : DEFAULT_PORT //If nothing is specified, use default port.
           UserName:_serverUserInput.text
           Password:_serverPasswordInput.text];
    [self.delegate AddServerViewControllerDidSave:self withServer:serv];
}


#pragma mark - Default Code

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
