//
//  ServerDetailViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 14/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@interface ServerDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *portLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) Server *serv;

@end
