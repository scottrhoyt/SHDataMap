//
//  ViewController.m
//  SHDataMap
//
//  Created by Scott Hoyt on 3/13/14.
//  Copyright (c) 2014 Wild Onion Labs. All rights reserved.
//

#import "ViewController.h"
#import "School.h"
#import "SHDataMapContoller.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[SHDataMapContoller class]]) {
        SHDataMapContoller *dataMapController = (SHDataMapContoller *)segue.destinationViewController;
        NSArray *data = [School getSchools:10];
        dataMapController.dataPoints = data;
    }
}

@end
