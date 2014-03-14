//
//  SHDataMapContoller.m
//  SHDataMap
//
//  Created by Scott Hoyt on 3/13/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "SHDataMapContoller.h"

@interface SHDataMapContoller ()

@property (nonatomic) double maxData;
@property (nonatomic) double minData;
@property (nonatomic) double averageData;

@end

@implementation SHDataMapContoller

#pragma mark - Setters/Getters
- (void)setMapView:(MKMapView *)mapView
{
    if (mapView != _mapView) {
        if (_mapView) {
            _mapView.delegate = nil;
        }
        _mapView = mapView;
        if (_mapView) {
            _mapView.delegate = self;
        }
    }
}

- (void)setDataPoints:(NSArray *)dataPoints
{
    if (dataPoints != _dataPoints) {
        if ([[self.mapView overlays] count] > 0) {
            [self removeAllOverlays];
        }
        _dataPoints = nil;
        if (dataPoints) {
            _dataPoints = dataPoints;
            [self calibrateForData];
            [self addAllOverlays];
            
        }
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addAllOverlays];
}

#pragma mark - Main

- (void)addAllOverlays
{
    if (self.dataPoints) {
        for (id item in self.dataPoints) {
            if ([item conformsToProtocol:@protocol(SHDataMapPoint)]) {
                id<SHDataMapPoint> dataPoint = item;
                MKCircle *circle = [MKCircle circleWithCenterCoordinate:[dataPoint coordinate] radius:[dataPoint radius]];
                if ([dataPoint respondsToSelector:@selector(title)]) {
                    circle.title = [dataPoint title];
                }
                [self.mapView addOverlay:circle level:MKOverlayLevelAboveRoads];
            }
        }
    }
}

- (void)removeAllOverlays
{
    NSMutableArray *overlaysToRemove = [[NSMutableArray alloc] init];
    
    for (id overlay in self.mapView.overlays) {
        [overlaysToRemove addObject:overlay];
    }
    
    [self.mapView removeOverlays:overlaysToRemove];
}

#define DEFAULT_MIN_ALPHA 0.2
#define DEFAULT_MAX_ALPHA 0.8

- (UIColor *)colorForData:(double)data
{
    double alphaRange = DEFAULT_MAX_ALPHA - DEFAULT_MIN_ALPHA;
    double dataRange = self.maxData - self.minData;
    double rank = (data - self.minData) / dataRange;
    double alpha = DEFAULT_MIN_ALPHA + (rank * alphaRange);
    return [[UIColor purpleColor] colorWithAlphaComponent:alpha];
}

- (void)calibrateForData
{
    self.maxData = 0;
    self.minData = 0;
    self.averageData = 0;
    
    for (id<SHDataMapPoint> dataPoint in self.dataPoints) {
        self.maxData = MAX(self.maxData, [dataPoint data]);
        self.maxData = MAX(self.maxData, [dataPoint data]);
        self.averageData += [dataPoint data] / [self.dataPoints count];
    }
}

#pragma mark - MKMapViewDelegate methods

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircle *circleOverlay = (MKCircle *)overlay;
        NSUInteger index = [self.mapView.overlays indexOfObject:overlay];
        id<SHDataMapPoint> dataPoint = [self.dataPoints objectAtIndex:index];
        MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:circleOverlay];
        circleRenderer.fillColor = [self colorForData:[dataPoint data]];
        
        return circleRenderer;
    }
    
    return nil; // if we get to this point, return nothing.
}

@end
