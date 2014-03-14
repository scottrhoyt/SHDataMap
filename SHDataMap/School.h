//
//  School.h
//  SHDataMap
//
//  Created by Scott Hoyt on 3/13/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHDataMapContoller.h"

@interface School : NSObject <SHDataMapPoint>

@property (nonatomic, strong) NSString *name;
@property (nonatomic) CLLocationDistance radius;
@property (nonatomic) double data;
@property (nonatomic) CLLocationCoordinate2D coordinate;

+ (NSArray *)getSchools:(NSUInteger)numSchools;

@end
