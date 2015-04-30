//
//  MasterViewController.h
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/29/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "UIImage+ColorImage.h"
#import "Utils.h"

@interface EarthquakeListViewController : UITableViewController <DataManagerDelegate>

@property (nonatomic, strong) DataManager *dataManager;           //Singleton that controls all the data logic
@property (nonatomic, strong) UIRefreshControl *refreshControl;   //Refresh control that implements the pull to refresh functionality

@end

