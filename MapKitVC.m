//
//  MapKitVC.m
//  Hoot
//
//  Created by Rob McMorran on 27/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "MapKitVC.h"
#define hootLocationGET @"http://hoot.cloudapp.net/HootAPI/API/Locations"
#import "Location.h"


@implementation MapKitVC
{
    NSMutableArray *_locationArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _MapView.showsUserLocation = YES;
    
    CLLocationDegrees latitude = 50.3741;
    CLLocationDegrees longitude = -4.1385;
    
    CLLocationCoordinate2D yourLocation = CLLocationCoordinate2DMake(latitude, longitude);
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = yourLocation;
    point.title = @"Plymouth University";
    point.subtitle = @"Where dreams are made!";
    
    _MapView.delegate = self;
    
    [_MapView addAnnotation:point];
    
    //show map on uni
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        yourLocation, 500, 500);
    [_MapView setRegion:region animated:YES];
    
    _locationArray = [[NSMutableArray alloc] init];
    
    [self retrieveData];
    
}

- (IBAction)zoomIn:(id)sender {
    
    MKUserLocation *userLocation = _MapView.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 500, 500);
    [_MapView setRegion:region animated:NO];
    
}

- (IBAction)changeMapType:(id)sender {
    
    if (_MapView.mapType == MKMapTypeStandard)
        _MapView.mapType = MKMapTypeSatellite;
    else
        _MapView.mapType = MKMapTypeStandard;
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
                               
                           }];
    //release spinner animation
    //[[self.view viewWithTag:12] removeFromSuperview];
}








@end
