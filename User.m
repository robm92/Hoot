//
//  User.m
//  Hoot
//
//  Created by Rob McMorran on 25/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize FirstName,SecondName,UserID,Password,Longitude,Latitude;

- (id) initWithName: (NSString *) firstName secondName: (NSString *) secondName
             userID: (NSInteger *) userID password: (NSString *) password
          longitude: (double) longitude lontitude: (double) latitude
{
    self = [super init];
    if (self)
    {
        FirstName = firstName;
        SecondName = secondName;
        UserID = userID;
        Password = password;
        Longitude = longitude;
        Latitude = latitude;
    }
    return self;
}


@end
