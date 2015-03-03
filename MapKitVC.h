//
//  MapKitVC.h
//  Hoot
//
//  Created by Rob McMorran on 27/02/2015.
//  Copyright (c) 2015 Rob McMorran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapKitVC : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *MapView;
- (IBAction)zoomIn:(id)sender;
- (IBAction)changeMapType:(id)sender;


@end

