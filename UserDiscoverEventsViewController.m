//
//  UserDiscoverEventsViewController.m
//  Discover Concerts
//
//  Created by Laborator iOS on 4/22/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "UserDiscoverEventsViewController.h"
#import "UserEventDetailViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface UserDiscoverEventsViewController ()

//properties to send to EventDetailViewController
@property (nonatomic, retain) NSMutableArray *listOfEventsId;
@property (nonatomic, retain) NSMutableArray *listOfEventsName;
@property (nonatomic, retain) NSMutableArray *listOfEventsDescription;
@property (nonatomic, retain) NSMutableArray *listOfEventsDate;
@property (nonatomic, retain) NSMutableArray *listOfEventsTime;
@property (nonatomic, retain) NSMutableArray *listOfEventsCity;
@property (nonatomic, retain) NSMutableArray *listOfEventsLocation;
@property (nonatomic, retain) NSMutableArray *listOfEventsPrice;
@property (nonatomic, retain) NSMutableArray *listOfEventsBandId;

@end

@implementation UserDiscoverEventsViewController

@synthesize listOfEventsId= _listOfEventsId;
@synthesize listOfEventsName = _listOfEventsName;
@synthesize listOfEventsDescription = _listOfEventsDescription;
@synthesize listOfEventsDate = _listOfEventsDate;
@synthesize listOfEventsTime = _listOfEventsTime;
@synthesize listOfEventsCity = _listOfEventsCity;
@synthesize listOfEventsLocation = _listOfEventsLocation;
@synthesize listOfEventsPrice = _listOfEventsPrice;
@synthesize listOfEventsBandId = _listOfEventsBandId;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    self.title=@"Discover Concerts";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self populateAllEvents];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_listOfEventsName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[_listOfEventsName objectAtIndex:indexPath.row];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.minimumScaleFactor = 14;
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.detailTextLabel.minimumScaleFactor = 14;
    cell.detailTextLabel.text =[_listOfEventsDescription objectAtIndex:indexPath.row];
    cell.frame = CGRectMake(0,0,320,100);
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserEventDetailViewController *eventDetailViewController = [[UserEventDetailViewController alloc] initWithNibName:@"UserEventDetailViewController" bundle:nil];
    
    NSLog(@"selectEvent %@",[_listOfEventsName objectAtIndex:indexPath.row]);
    
    eventDetailViewController.eventId = [_listOfEventsId objectAtIndex:indexPath.row];
    eventDetailViewController.eventName = [_listOfEventsName objectAtIndex:indexPath.row];
    eventDetailViewController.eventDescription = [_listOfEventsDescription objectAtIndex:indexPath.row];
    eventDetailViewController.eventDate = [_listOfEventsDate objectAtIndex:indexPath.row];
    eventDetailViewController.eventTime = [_listOfEventsTime objectAtIndex:indexPath.row];
    eventDetailViewController.eventCity = [_listOfEventsCity objectAtIndex:indexPath.row];
    eventDetailViewController.eventLocation = [_listOfEventsLocation objectAtIndex:indexPath.row];
    eventDetailViewController.eventPrice = [_listOfEventsPrice objectAtIndex:indexPath.row];
    eventDetailViewController.eventBandId = [_listOfEventsBandId objectAtIndex:indexPath.row];
    eventDetailViewController.showEventButton=@"YES"; //show the add to calendar and attend buttons    
    
    [self.navigationController pushViewController:eventDetailViewController animated:YES];
}
    

//Get all events from db
- (void)populateAllEvents
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSString *urlForAllBand= [NSString stringWithFormat:@"http://discover-concerts.herokuapp.com/concerts.json"];
                 NSLog(@"url 1: %@", urlForAllBand);
                 dispatch_async(kBgQueue, ^{
                     NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlForAllBand]];
                     [self performSelectorOnMainThread:@selector(fetchedDataEvents:)
                                            withObject:data waitUntilDone:YES];
                 });
             }
         }];
    }
}

//parse out the json 
-(void) fetchedDataEvents:(NSData*) responseData
{
    _listOfEventsId = [[NSMutableArray alloc] init];
    _listOfEventsName = [[NSMutableArray alloc] init];
    _listOfEventsDescription = [[NSMutableArray alloc] init];
    _listOfEventsDate = [[NSMutableArray alloc]init];
    _listOfEventsTime = [[NSMutableArray alloc] init];
    _listOfEventsCity = [[NSMutableArray alloc] init];
    _listOfEventsLocation = [[NSMutableArray alloc] init];
    _listOfEventsPrice = [[NSMutableArray alloc]init];
    _listOfEventsBandId = [[NSMutableArray alloc] init];
    
    NSError* error;
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData
                     options:kNilOptions
                     error:&error];
    
    for (NSDictionary* object in json) {
        NSString* eventId = [object objectForKey:@"id"];
        NSString* eventName = [object objectForKey:@"name"];
        NSString* eventDescription = [object objectForKey:@"description"];
        NSString* eventDateTime = [object objectForKey:@"date_time"];
        NSString* eventDate = [eventDateTime substringToIndex:10];
        NSString* eventTime = [[eventDateTime substringFromIndex:12] substringToIndex:7];
        NSString* eventCity = [object objectForKey:@"city"];
        NSString* eventLocation = [object objectForKey:@"location"];
        NSString* eventPrice = [object objectForKey:@"price"];
        NSString* eventBandId =[object objectForKey:@"band_id"];
        NSString* dateTime = [object objectForKey:@"date_time"];
        
        
        
        [_listOfEventsId addObject:eventId];
        [_listOfEventsName addObject:eventName];
        [_listOfEventsDescription addObject:eventDescription];
        [_listOfEventsDate addObject:eventDate];
        [_listOfEventsTime addObject:eventTime];
        [_listOfEventsCity addObject:eventCity];
        [_listOfEventsLocation addObject:eventLocation];
        [_listOfEventsPrice addObject:eventPrice];
        [_listOfEventsBandId addObject:eventBandId];
        
        [_listOfEventsBandId addObject:eventBandId];
        
        NSLog(@"fetchedDataDiscoverConcerts: %@", eventName);
        
    }
    //_dictionaryWithAllBands = [[NSDictionary alloc] initWithObjects:_listOfBandsGenre forKeys:_listOfBands];
    [self.tableView reloadData];
}


@end
