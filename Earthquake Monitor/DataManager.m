//
//  EarthquakeManager.m
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/29/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

@synthesize feedTitle;
@synthesize earthquakesArray;
@synthesize delegate;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static DataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[self alloc] init];
    });
    return dataManager;
}

- (id)init {
    if (self = [super init]) {
        earthquakesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadData {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (!networkStatus == NotReachable) {                           //There IS internet connection
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:USGS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *responseDict = responseObject;            //This is the dictionary representation of the response.
            [self assignData:responseDict andLoadsFromCache:NO];    //Try to load data from the response.
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self assignData:nil andLoadsFromCache:YES];            //There was some mistake on the call, try to load from cache
        }];
    } else {                                                        //There is NO internet connection
        [self assignData:nil andLoadsFromCache:YES];                //Try to load from cache
    }
    
}

- (void)assignData:(NSDictionary *)responseDict andLoadsFromCache:(BOOL)loadFromCache {
    if (!loadFromCache) {   //Try to parse the response
        if ([self parseData:responseDict]) {
            [self saveCache:responseDict];  //Parse was succesfull save to cache for the future.
            [delegate dataWasLoaded];       //Notify the delegate that new data is ready.
        } else {
            [self assignData:nil andLoadsFromCache:YES];  //Somehow the response was not valid, check if cache is available and load from there.
        }
    } else {
        if ([self parseData:[self loadCache]]) {   //Try to load cache.
            [delegate dataWasLoaded];              //Load from cache was succesfull notify the delegate that data is ready.
            [delegate dataLoadedFromCache];        //Tell the delegate that data was loaded from cache to posibly present a message to the user.
        } else {
            [delegate dataFailedToLoad];           //The data failed to load, notify the delegate to present the corresponding message.
        }
    }
}

- (void)saveCache:(NSDictionary *)responseDict {
    if (responseDict) {
        // Use GCD's background queue to prevent from blocking the main thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseDict];
            NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
            NSURL *documentsURL = [paths lastObject];
            NSURL *path = [documentsURL URLByAppendingPathComponent:CACHE_FILENAME];
            [data writeToURL:path atomically:YES];
        });
    }
}

- (NSDictionary *)loadCache {
    //Load cache from disk, todo load in different queue to prevent blocking the main thread.
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    NSURL *path = [documentsURL URLByAppendingPathComponent:CACHE_FILENAME];
    NSData *data = [NSData dataWithContentsOfURL:path];
    if (data) {
        NSDictionary *response = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return response;
    } else {
        return nil;
    }
}

- (BOOL)parseData:(NSDictionary *)responseDict {
    @try {
        if (responseDict) {
            feedTitle = responseDict[@"metadata"][@"title"];
            earthquakesArray = [self parseEarthquakesData:responseDict[@"features"]];
            return YES;
        } else {
            return NO;
        }
    }
    @catch (NSException *exception) {
        return NO;
    }
}

- (NSMutableArray *)parseEarthquakesData:(NSArray *)features {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *quake in features) {
        
        Earthquake *newEarthquake = [[Earthquake alloc] init];
        newEarthquake.earthquakeId = quake[@"id"];
        newEarthquake.title = quake[@"properties"][@"title"];
        newEarthquake.place = quake[@"properties"][@"place"];
        newEarthquake.tz = quake[@"properties"][@"tz"];
        newEarthquake.url = quake[@"properties"][@"url"];
        newEarthquake.status = quake[@"properties"][@"status"];
        newEarthquake.type = quake[@"properties"][@"type"];
        newEarthquake.detail = quake[@"properties"][@"detail"];
        newEarthquake.time = quake[@"properties"][@"time"];
        newEarthquake.tz = quake[@"properties"][@"tz"];
        newEarthquake.sig = quake[@"properties"][@"sig"];
        newEarthquake.mag = quake[@"properties"][@"mag"];
        newEarthquake.magType = quake[@"properties"][@"magType"];
        newEarthquake.longitude = quake[@"geometry"][@"coordinates"][0];
        newEarthquake.latitude = quake[@"geometry"][@"coordinates"][1];
        newEarthquake.depth = quake[@"geometry"][@"coordinates"][2];
        
        [arr addObject:newEarthquake];
    }
    return arr;
}

@end
