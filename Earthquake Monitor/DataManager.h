//
//  EarthquakeManager.h
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/29/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Earthquake.h"
#import "Reachability.h"

@protocol DataManagerDelegate;

@interface DataManager : NSObject

@property (nonatomic, retain) NSString *feedTitle;                  //String with the title of the feed to be used in the navigationBar
@property (nonatomic, retain) NSMutableArray *earthquakesArray;     //Array with Earthquakes models to be presented in table.
@property (nonatomic, weak) id<DataManagerDelegate> delegate;       //Delegate to be notified of changes in the data.

+ (id)sharedManager;            //Method to retrieve the singleton instance of the class.
- (void)loadData;               //Method to be called to refresh the data

@end

@protocol DataManagerDelegate <NSObject>

@required
- (void)dataWasLoaded;            //Is called when data is loaded from the web or from cache to notify that data needs to be reloaded on screen.
- (void)dataFailedToLoad;         //Method called when neither the internet nor cache was available to load data.
- (void)dataLoadedFromCache;      //Method that notifies that data was loaded but from cache not from the internet.
@end
