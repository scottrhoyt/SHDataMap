//
//  School.m
//  SHDataMap
//
//  Created by Scott Hoyt on 3/13/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "School.h"

@implementation School

#define MIN_LATITUDE 41.0
#define MAX_LATITUDE 42.0
#define MIN_LONGITUDE -88.0
#define MAX_LONGITUDE -87.0

+(NSArray *)getSchools:(NSUInteger)numSchools
{
    NSMutableArray *schools = [NSMutableArray arrayWithCapacity:numSchools];
    
    for (int i = 0; i < numSchools; i++) {
        School *school = [[School alloc] init];
        CLLocationDegrees latitude = MIN_LATITUDE + ((MAX_LATITUDE - MIN_LATITUDE) * drand48());
        CLLocationDegrees longitude = MIN_LONGITUDE + ((MAX_LONGITUDE - MIN_LONGITUDE) * drand48());
        
        school.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        school.name = [NSString stringWithFormat:@"School %d", i];
        school.data = arc4random() % 100;
        school.radius = 16000;
        [schools addObject:school];
    }
    
    return schools;
}

@end
