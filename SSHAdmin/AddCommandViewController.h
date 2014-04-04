//
//  AddCommandViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 25/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"
#import "Command.h"

@class AddCommandViewController;

@protocol AddCommandViewControllerDelegate <NSObject>
- (void)AddCommandViewControllerDidSave:(AddCommandViewController *)controller
                            withCommand:(Command *)input;
@end

@interface AddCommandViewController : UIViewController
@property (weak, nonatomic) id <AddCommandViewControllerDelegate> delegate;
@property (strong, nonatomic) Server *serv;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UITextField *outputField;


- (IBAction)saveCommandButton:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveCommandButton;

@end
