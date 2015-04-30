//
//  DetailViewController.h
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/29/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Earthquake.h"
#import "Utils.h"


@interface EarthquakeDetailViewController : UIViewController

@property (strong, nonatomic) Earthquake* detailEarthquake;              //Current Earthquake object represented in the view
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;                //Google Maps View
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;    //Description of the earthquake label.

@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;            
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *depthLabel;
@property (weak, nonatomic) IBOutlet UILabel *magnitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end