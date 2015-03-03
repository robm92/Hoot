//
//  NewMeeting.m
//  Hoot
//
//  Created by Rob McMorran on 25/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "NewMeeting.h"
#import "location.h"
#import "Meeting.h"
#import "MeetingParticipant.h"
#define hootLocationGET @"http://hoot.cloudapp.net/HootAPI/API/Locations"

@implementation NewMeeting
{
    NSMutableArray *_locationArray;
}

@synthesize locationTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _locationArray = [[NSMutableArray alloc] init];
    
    self.locationTable.dataSource = self;
    self.locationTable.delegate = self;
    
    [self retrieveData];
    
}

- (void) retrieveData
{
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:hootLocationGET]];
    
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
                                   Location * location = [[Location alloc] init];
                                   location.Building = [item valueForKey:@"Building"];
                                   location.ID = [[item valueForKey:@"ID"]longValue];
                                   location.Latitude = [[item valueForKey:@"Latitude"]intValue];
                                   location.Longitude = [[item valueForKey:@"Longitude"]intValue];
                                   [_locationArray addObject: location];
                               }
                               [self.locationTable reloadData];
                               
                           }];
    //release spinner animation
    //[[self.view viewWithTag:12] removeFromSuperview];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueParticipants"])
    {
        // Get reference to the destination view controller
        MeetingParticipant *meet = [segue destinationViewController];
        Meeting *meeting = [[Meeting alloc] init];
        NSInteger selectedLocation = [[_locationArray objectAtIndex:[locationTable indexPathForSelectedRow].row]integerValue];
        meeting.LocationID = &(selectedLocation);
        
        // Pass any objects to the view controller here, like...
        [meet passMeeting:meeting];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_locationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Location *loc = [_locationArray objectAtIndex:indexPath.row];
    cell.textLabel.text = loc.Building;
    return cell;
}

@end
