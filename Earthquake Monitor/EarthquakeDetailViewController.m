//
//  DetailViewController.m
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/29/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import "EarthquakeDetailViewController.h"

@interface EarthquakeDetailViewController ()
@end

@implementation EarthquakeDetailViewController

@synthesize detailEarthquake;
@synthesize mapView;

#pragma mark - Managing the detail item

- (void)setDetailEarthquake:(Earthquake *)newEarthquake {
    if (detailEarthquake != newEarthquake) {
        detailEarthquake = newEarthquake;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailEarthquake) {
        self.navigationItem.title = detailEarthquake.title;
        
        self.detailDescriptionLabel.text = [detailEarthquake title];
        self.longitudeLabel.text = [[detailEarthquake longitude] description];
        self.latitudeLabel.text = [[detailEarthquake latitude] description];
        self.depthLabel.text = [[detailEarthquake depth] description];
        self.magnitudeLabel.text = [NSString stringWithFormat:@"%@ %@", [detailEarthquake mag], [detailEarthquake magType]];
        
        NSDate *quakeDate = [NSDate dateWithTimeIntervalSince1970:([[detailEarthquake time] longValue] / 1000)];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
        
        self.dateLabel.text = [formatter stringFromDate:quakeDate];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[[detailEarthquake latitude] doubleValue]
                                                                longitude:[[detailEarthquake longitude] doubleValue]
                                                                     zoom:6];
        
        
        [mapView setCamera:camera];
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = camera.target;
        marker.snippet = detailEarthquake.title;
        marker.icon = [GMSMarker markerImageWithColor:[Utils colorForEarthquakeMagnitude:[detailEarthquake mag]]];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
