//
//  Meeting.m
//  Hoot
//
//  Created by Rob McMorran on 25/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "Meeting.h"

@implementation Meeting

@synthesize Name,Room,Description,MeetingID,Start,End,Reoccuring,Frequency,Instances,LocationID;

- (id) initWithName: (NSString *) name room: (NSString *) room
        description: (NSString *) description meetingID: (NSInteger *) meetingID
              start: (NSDate *) start end: (NSDate *) end reoccuring: (BOOL *) reoccuring
          frequency: (NSInteger *) frequency instances: (NSInteger *) instances
         locationID: (NSInteger *) locationID
{
    self = [super init];
    if (self)
    {
        Name = name;
        Room = room;
        Description = description;
        MeetingID = meetingID;
        Start = start;
        End = end;
        Reoccuring = reoccuring;
        Frequency = frequency;
        Instances = instances;
        LocationID = locationID;
    }
    return self;
}
@end
