//
//  FirstViewController.m
//  Hoot
//
//  Created by Rob McMorran on 26/01/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import "FirstViewController.h"
#import "Location.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "LocationStore.h"
#import "MeetingHome.h"

@interface FirstViewController () <GMSMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;

@end

@implementation FirstViewController{
    GMSCameraPosition *camera;
    GMSMarker *userMarker;
    float userLat;
    float userLong;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //get the singleton location store
    // LocationStore *locationStore = [LocationStore sharedLocationStore];
    //debug purposes but this makes a location object from the singleton we just got
    //(plymouth)
    //Location *tempLocation = [locationStore.locationArray objectAtIndex:0];
    
    //create a 'mylocation' button
    UIButton *button    = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame        = CGRectMake(0, 0, 100, 200);
    [button addTarget:self action:@selector(btnMyLocation:)
       forControlEvents:UIControlEventTouchUpInside];
    UIImage * buttonImage = [[UIImage imageNamed:@"button_my_location@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    Location *tempLocation = [[Location alloc] init];
    tempLocation.Building = @"Plymouth";
    tempLocation.Longitude = -4.1385;
    tempLocation.Latitude = 50.3741;
    
    
    // Create camera on Plymouth uni coordinates
    camera =[GMSCameraPosition cameraWithLatitude:tempLocation.Latitude
                                                            longitude:tempLocation.Longitude
                                                                 zoom:17];
    //show current location
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    [self.view insertSubview:self.mapView atIndex:0];
    self.mapView.delegate = self;
    [self.mapView setMinZoom:17 maxZoom:19];
    self.view = self.mapView;
    
    [self.view addSubview:button];
    
    // Plymouth Uni Marker
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(50.3741, -4.1385);
    marker.title = @"MyMeeting";
    marker.map = self.mapView;
    marker.icon = [UIImage imageNamed:@"PinDropSmall"];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    
    //initialise the user location marker but dont show it yet
    userMarker = [[GMSMarker alloc] init];
    userMarker.title = @"Your Location";
    userMarker.map = self.mapView;
    userMarker.icon = [UIImage imageNamed:@"man"];
    
    [self getCurrentLocation];
    
    
}

- (void)getCurrentLocation {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* loc = [locations lastObject]; // locations is guaranteed to have at least one object
    userLat = loc.coordinate.latitude;
    userLong = loc.coordinate.longitude;
    NSLog(@"%.8f",userLat);
    NSLog(@"%.8f",userLong);
    
    userMarker.position = CLLocationCoordinate2DMake(userLat, userLong);
    userMarker.appearAnimation = kGMSMarkerAnimationPop;

}


- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnMyLocation:(id)sender {
    
    
    
    GMSCameraPosition *userLoc = [GMSCameraPosition cameraWithLatitude:userLat
                                                             longitude:userLong
                                                                  zoom:19];
    [self.mapView setCamera:userLoc];
}

@end
