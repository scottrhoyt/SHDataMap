//
//  SHDataMapContoller.h
//  SHDataMap
//
//  Created by Scott Hoyt on 3/13/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol SHDataMapPoint <MKAnnotation>

///@brief Must implement this method to provide the data to the map
- (double)data;

///@brief Must implement this method and provide the radius in meters
- (CLLocationDistance)radius;

@end

@interface SHDataMapContoller : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

///@brief This is an array of of data points.  Each must conform to <SHDataMapPoint>
@property (strong, nonatomic) NSArray *dataPoints;

@end
