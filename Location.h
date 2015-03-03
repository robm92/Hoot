//
//  Location.h
//  Hoot
//
//  Created by Rob McMorran on 26/01/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
{
    NSInteger ID;
    NSString *Building;
    double longitude;
    double latitude;
}

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, retain) NSString *Building;
@property (nonatomic) double Longitude;
@property (nonatomic) double Latitude;

+ (id)sharedLocation;



@end
