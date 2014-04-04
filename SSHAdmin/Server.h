//
//  Server.h
//  SSHAdmin
//
//  Created by Anders Lyhne Donsig on 10/03/14.
//  Copyright (c) 2014 Anders Lyhne Donsig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject
@property (nonatomic, strong) NSString *serverName;
@property (nonatomic, strong) NSString *serverAddress;
@property (nonatomic) NSUInteger serverPort;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPassword;
@property (nonatomic, strong) NSString *serverOS; //Commands are often OS specific.

- (void)addServer:(NSString *)name 
          Address:(NSString *)address
             Port:(NSUInteger)port
         UserName:(NSString *)user
         Password:(NSString *)password;


@end
