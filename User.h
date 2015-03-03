//
//  User.h
//  Hoot
//
//  Created by Rob McMorran on 25/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *FirstName;
@property (nonatomic, strong) NSString *SecondName;
@property (nonatomic, strong) NSString *Password;
@property (nonatomic) double Longitude;
@property (nonatomic) double Latitude;
@property (nonatomic, assign) NSInteger UserID;

- (id) initWithName: (NSString *) firstName secondName: (NSString *) secondName
             userID: (NSInteger ) userID password: (NSString *) password
          longitude: (double) longitude lontitude: (double) latitude;


@end
