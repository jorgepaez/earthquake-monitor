//
//  MasterViewController.m
//  Earthquake Monitor
//
//  Created by Jorge Paez on 4/29/15.
//  Copyright (c) 2015 Jorge Paez. All rights reserved.
//

#import "EarthquakeListViewController.h"
#import "EarthquakeDetailViewController.h"

@interface EarthquakeListViewController ()
@end

@implementation EarthquakeListViewController

@synthesize dataManager;
@synthesize refreshControl;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //Add the refresh button to the navigation bar right corner
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    //Add the refresh control for the pull to refresh feature.
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    //Load the data manager singleton to the ivar.
    dataManager = [DataManager sharedManager];
    [dataManager setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [dataManager loadData];   //Data is loaded in didAppear to permit the delegate call to present the UIAlertView,
                              //otherwise since this VC isnt yet presented on screen, the alertview call will be ignored.
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [dataManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable:(id)sender {
    [[self tableView] reloadData];
    if ([dataManager feedTitle] && ([[dataManager feedTitle] length] > 0)) {
        self.navigationItem.title = dataManager.feedTitle;
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Earthquake *quake = [[dataManager earthquakesArray] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailEarthquake:quake];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[dataManager earthquakesArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Earthquake *quake = [[dataManager earthquakesArray] objectAtIndex:indexPath.row];
    cell.textLabel.text = [quake place];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [quake mag], [quake magType]];
    cell.imageView.image = [UIImage imageWithColor:[Utils colorForEarthquakeMagnitude:[quake mag]]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Data Manager

- (void)dataWasLoaded {
    [self refreshTable:nil];         //Data was loaded, time to refresh the tableview
    [refreshControl endRefreshing];  //Stop the pull to refresh animation
}

- (void)dataFailedToLoad {
    [refreshControl endRefreshing];  //Stop the pull to refresh animation and present and alertview with message
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Data failed to load, check your connection."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)dataLoadedFromCache {        //Notify that data was loaded from cache.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Data failed to load, cache was loaded instead."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



@end
