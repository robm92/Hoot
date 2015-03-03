//
//  FirstViewController.h
//  Hoot
//
//  Created by Rob McMorran on 26/01/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <GoogleMaps/GoogleMaps.h>


@interface FirstViewController : UIViewController

- (void)getCurrentLocation;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
- (IBAction)btnMyLocation:(id)sender;

@end

