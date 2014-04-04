//
//  AddServerViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 10/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"
@class AddServerViewController;

@protocol AddServerViewControllerDelegate <NSObject>
- (void)AddServerViewControllerDidSave:(AddServerViewController *)controller
                            withString:(NSString *)input;
- (void)AddServerViewControllerDidSave:(AddServerViewController *)controller
                            withServer:(Server *)input;
@end

@interface AddServerViewController : UIViewController

@property (weak, nonatomic) id <AddServerViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *serverNameInput;
@property (weak, nonatomic) IBOutlet UITextField *serverAddressInput;
@property (weak, nonatomic) IBOutlet UITextField *serverPortInput;
@property (weak, nonatomic) IBOutlet UITextField *serverUserInput;
@property (weak, nonatomic) IBOutlet UITextField *serverPasswordInput;

- (IBAction)saveServerButton:(UIBarButtonItem *)sender;

@end
