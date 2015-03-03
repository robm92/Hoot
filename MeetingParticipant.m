//
//  MeetingParticipant.m
//  Hoot
//
//  Created by Rob McMorran on 25/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "MeetingParticipant.h"
#define hootFriendsGET @"http://hoot.cloudapp.net/HootAPI/API/hooters/"
#import "User.h"

@implementation MeetingParticipant
{
    NSMutableArray *_friendsArray;
    Meeting * passedMeeting;
}

@synthesize friendsTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _friendsArray = [[NSMutableArray alloc] init];
    
    self.friendsTable.dataSource = self;
    self.friendsTable.delegate = self;
    
    [self prepareGetFriends];
    
}
- (void) prepareGetFriends
{
    //change to whichever user is logged in
    NSString *ID = 0;
    
    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:ID,@"id", nil];
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    [self getFriends:postData];
}

- (void) passMeeting:(Meeting*)meeting
{
    passedMeeting = [[Meeting alloc] init];
    passedMeeting = meeting;
    
}

- (void) getFriends:(NSData *)jsonRequestData
{
    NSURL *url = [NSURL URLWithString:hootFriendsGET];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonRequestData];
    
    __block NSMutableDictionary *json;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:nil];
                               NSLog(@"Async JSON: %@", json);//output the json dictionary raw
                               
                               for(NSDictionary *item in json)//for every department in the responseArr, add their respective details to the arrays
                               {
                                   User * user = [[User alloc] init];
                                   user.FirstName = [item valueForKey:@"firstname"];
                                   user.SecondName = [item valueForKey:@"secondname"];
                                   user.UserID = [[item valueForKey:@"ID"]longValue];
                                   user.Latitude = [[item valueForKey:@"Latitude"]intValue];
                                   user.Longitude = [[item valueForKey:@"Longitude"]intValue];
                                   [_friendsArray addObject: user];
                               }
                               [self.friendsTable reloadData];
                               
                           }];
    //release spinner animation
    //[[self.view viewWithTag:12] removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    User *user = [_friendsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = user.FirstName;
    return cell;
}


@end
