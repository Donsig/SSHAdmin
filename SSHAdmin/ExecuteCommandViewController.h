//
//  ExecuteCommandViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 25/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"
#import "Server.h"
#import <NMSSH/NMSSH.h>


@interface ExecuteCommandViewController : UIViewController

@property (strong, nonatomic) Command *cmd;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityMonitor;

-(void) appendOutput:(NSString *)output;

@end
