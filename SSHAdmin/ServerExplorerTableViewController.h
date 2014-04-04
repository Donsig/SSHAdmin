//
//  ServerExplorerTableViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 12/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddServerViewController.h"

@interface ServerExplorerTableViewController : UITableViewController <AddServerViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *tableContents;

@end
