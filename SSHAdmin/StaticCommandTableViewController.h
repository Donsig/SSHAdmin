//
//  StaticCommandTableViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 23/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"
#import "AddCommandViewController.h"

@interface StaticCommandTableViewController : UITableViewController <AddCommandViewControllerDelegate>
@property (strong, nonatomic) Server *serv;

@end
