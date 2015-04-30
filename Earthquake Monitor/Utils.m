//
//  Utils.m
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/30/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIColor *)colorForEarthquakeMagnitude:(NSNumber *)number {
    double magnitude = [number doubleValue];
    if (magnitude >= 0 && magnitude < 1.0) {
        return [UIColor greenColor];
    } else if (magnitude >= 1.0 && magnitude < 9.0) {
        return [UIColor yellowColor];
    } else if (magnitude >= 9.0 && magnitude < 10.0) {
        return [UIColor redColor];
    }
    return [UIColor whiteColor];
}

@end
