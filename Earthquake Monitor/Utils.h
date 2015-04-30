//
//  Utils.h
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/30/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (UIColor *)colorForEarthquakeMagnitude:(NSNumber *)number;   //Method that returns the correct color given an earthquakes magnitude.

@end
