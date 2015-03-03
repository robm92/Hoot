//
//  Location.m
//  Hoot
//
//  Created by Rob McMorran on 26/01/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize Longitude,Latitude,ID,Building;


+ (id)sharedLocation
{
    static Location *sharedLocation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocation = [[self alloc] init];
    });
    return sharedLocation;
}

- (id)init
{
    if (self = [super init])
    {
        ID = 0;
        Building = @"DefaultBuilding";
        Longitude = 0.0;
        Latitude = 0.0;
    }
    return self;
}

@end


