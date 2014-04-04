//
//  SelectScriptTableViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 01/04/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"
#import "Command.h"

@interface SelectScriptTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityMonitor;
@property (strong, nonatomic) Server *serv;
@end
