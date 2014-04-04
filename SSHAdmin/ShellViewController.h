//
//  ShellViewController.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 31/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITextView *output;

@end
