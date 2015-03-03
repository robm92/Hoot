//
//  Meeting.h
//  Hoot
//
//  Created by Rob McMorran on 25/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meeting : NSObject

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Room;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, assign) NSInteger *MeetingID;
@property (nonatomic, strong) NSDate *Start;
@property (nonatomic, strong) NSDate *End;
@property (nonatomic) BOOL *Reoccuring;
@property (nonatomic, assign) NSInteger *Frequency;
@property (nonatomic, assign) NSInteger *Instances;
@property (nonatomic, assign) NSInteger *LocationID;


- (id) initWithName: (NSString *) name room: (NSString *) room
        description: (NSString *) description meetingID: (NSInteger *) meetingID
           start: (NSDate *) start end: (NSDate *) end reoccuring: (BOOL *) reoccuring
          frequency: (NSInteger *) frequency instances: (NSInteger *) instances
          locationID: (NSInteger *) locationID;



@end
