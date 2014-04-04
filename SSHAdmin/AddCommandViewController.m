//
//  AddCommandViewController.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 25/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "AddCommandViewController.h"

@interface AddCommandViewController ()

@end

@implementation AddCommandViewController

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

- (IBAction)saveCommandButton:(UIBarButtonItem *)sender
{
    NSLog(@"preparing for delegate");
    Command *cmd = [[Command alloc]init];
    [cmd addCommand:self.inputField.text ExpectedOutput:self.outputField.text];
    NSLog(self.inputField.text);
    [self.delegate AddCommandViewControllerDidSave:self withCommand:cmd];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
