//
//  Command.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 21/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NMSSH/NMSSH.h>
#import "Server.h"

@interface Command : NSObject

@property (strong, nonatomic) Server *server; //Which server to execute the command on.

@property (strong, nonatomic) NSString *input; //Command
@property (strong, nonatomic) NSString *output; //Response from server (probably not needed,as methods returns strings instead.)
@property (strong, nonatomic) NSString *expectedOutput; //Expected output (probably not needed either, but consider using it for error checking.)
@property BOOL executeAsSudo;

- (void)addCommand:(NSString *)input
    ExpectedOutput:(NSString *)expectedOutput;
- (NSString *)executeCommand;
-(NSArray *)getDirectoryList:(NSString *)path;

@end 