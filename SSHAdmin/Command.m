//
//  Command.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 21/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "Command.h"
#import "ExecuteCommandViewController.h"

@interface Command () <NMSSHSessionDelegate, NMSSHChannelDelegate>

@end

@implementation Command

#pragma mark - NMSSH Logic

- (NSString *)executeCommand
{
#warning NMSSH has a bunch of errors that are not handled. Make sure to handle these!

    
    NMSSHSession *session = [NMSSHSession connectToHost:self.server.serverAddress
                                           withUsername:self.server.userName];
    NSString *response = @"An error has occurred. Please try again."; //If for some reason the response can't be read, this will be returned.
    if (session.isConnected) {
        @try
        {
            [session authenticateByPassword:self.server.userPassword];
            
            if (session.isAuthorized) {
                
                
                NSLog(@"Authentication succeeded");
                NSError *error = nil;
                #warning WILL raise a Thread SIGABRT if used a few times.
                if([session.channel startShell:&error]) //Assertion failed: (remainbuf >= 0), function _libssh2_transport_read, file transport.c, line 345.
                {
                    response = [session.channel execute:self.input error:&error];
                    NSLog(@"Executing command. %@", response);
                
                    
                }
            }
        }
        @catch(NSException *exception)
        {
            NSLog(@"Error.");
            NSLog([exception name]);
        }
        @finally
        {
            if (session.isConnected)
            {
                [session disconnect];
            }
        }
    }
    return response;
}

-(NSArray *)getDirectoryList:(NSString *)path
{
    NMSSHSession *session = [NMSSHSession connectToHost:self.server.serverAddress
                                           withUsername:self.server.userName];
    NSArray *returnArr = [[NSArray alloc] init];
    
    if (session.isConnected) {
        bool authenticated = [session authenticateByPassword:self.server.userPassword];
        
        if (authenticated) {
            [session.sftp connect];
            returnArr = [session.sftp contentsOfDirectoryAtPath:path];
            
        }
        [session disconnect];
    }

    
    return returnArr;
}

-(void)addCommand:(NSString *)input
   ExpectedOutput:(NSString *)expectedOutput
{
    self.input = input;
    self.expectedOutput = expectedOutput;
}

@end
