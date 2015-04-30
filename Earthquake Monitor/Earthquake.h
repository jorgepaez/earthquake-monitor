//
//  Earthquake.h
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/29/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Earthquake : NSObject

@property (nonatomic, strong) NSString *earthquakeId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, strong) NSNumber *tz;
@property (nonatomic, strong) NSNumber *sig;
@property (nonatomic, strong) NSNumber *mag;
@property (nonatomic, strong) NSString *magType;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *depth;

@end
