//
//  ExecuteCommandViewController.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 25/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "ExecuteCommandViewController.h"

@interface ExecuteCommandViewController ()

@end

@implementation ExecuteCommandViewController

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
    __weak typeof(self) weakSelf = self; //We don't want any memory cycles in the block!
    dispatch_queue_t newQueue = dispatch_queue_create("myQ", DISPATCH_QUEUE_SERIAL);
    dispatch_async(newQueue, ^(void)
    {
        NSString *cmdResponse = @"Error in thread"; //This string should never show.
        cmdResponse = [weakSelf.cmd executeCommand];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf appendOutput:cmdResponse];
            [weakSelf.activityMonitor stopAnimating];
        });
        
    });
    //[self appendOutput:[self.cmd executeCommand]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
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
- (void)threadTest:(Command *)cmd
{
    [self appendOutput:cmd.executeCommand];
}

-(void)appendOutput:(NSString *)output
{
    self.outputTextView.text = [self.outputTextView.text stringByAppendingString:output];
}
@end
