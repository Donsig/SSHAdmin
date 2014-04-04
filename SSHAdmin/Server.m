//
//  Server.m
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 10/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import "Server.h"

@implementation Server

@synthesize serverName, serverAddress, serverPort, userName, userPassword;

- (void)addServer:(NSString *)name
          Address:(NSString *)address
             Port:(NSUInteger)port
         UserName:(NSString *)user
         Password:(NSString *)password
{
    serverName = name;
    serverAddress = address;
    serverPort = port ? port : 22;
    userName = user;
    userPassword = password;
}

@end
