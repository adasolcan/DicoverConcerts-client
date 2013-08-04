//
//  BandEventsTableViewController.m
//  Discover Concerts
//
//  Created by Laborator iOS on 4/17/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "BandEventsTableViewController.h"
#import "BandAddEventViewController.h"
#import "EventDescriptionViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface BandEventsTableViewController ()

@property (nonatomic, retain) NSMutableArray *listOfEvents;
@property (nonatomic, retain) NSMutableArray *listOfCities;
@property (nonatomic, retain) NSMutableArray *listOfLocations;
@property (nonatomic, retain) NSMutableArray *listOfPrices;
@property (nonatomic, retain) NSMutableArray *listOfDescriptions;
@property (nonatomic, retain) NSMutableArray *listOfDates;
@property (nonatomic, retain) NSMutableArray *listOfTimes;
@property (nonatomic, retain) NSMutableArray *listOfIds;

@end


@implementation BandEventsTableViewController

@synthesize listOfEvents = _listOfEvents;
@synthesize listOfCities = _listOfCities;
@synthesize listOfLocations = _listOfLocations;
@synthesize listOfPrices = _listOfPrices;
@synthesize listOfDescriptions = _listOfDescriptions;
@synthesize listOfDates = _listOfDates;
@synthesize listOfTimes = _listOfTimes;
@synthesize listOfIds = _listOfIds;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             //initWithTitle:@"Add new favorite"
                                             // style:UIBarButtonItemStyleBordered
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                             target:self
                                             action:@selector(AddNewEvent:)];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self populateAllEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listOfEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[_listOfEvents objectAtIndex:indexPath.row];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.minimumFontSize = 14;
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.detailTextLabel.minimumFontSize = 14;
    // cell.imageView.image=[_listOfBandFacebookPicture objectAtIndex:indexPath.row];
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        [_listOfEvents removeObjectAtIndex:indexPath.row];
        [_listOfCities removeObjectAtIndex:indexPath.row];
        [_listOfDates removeObjectAtIndex:indexPath.row];
        [_listOfDescriptions removeObjectAtIndex:indexPath.row];
        [_listOfLocations removeObjectAtIndex:indexPath.row];
        [_listOfPrices removeObjectAtIndex:indexPath.row];
        [_listOfTimes removeObjectAtIndex:indexPath.row];
        
        [self deleteFavoriteFromServer:[_listOfIds objectAtIndex:indexPath.row]];
        
        [_listOfIds removeObjectAtIndex:indexPath.row];

        [tableView endUpdates];
        [tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventDescriptionViewController *eventDescViewController = [[EventDescriptionViewController alloc] initWithNibName:@"EventDescriptionViewController" bundle:nil];
    
    NSLog(@"selectEvent %@",[_listOfEvents objectAtIndex:indexPath.row]);
    eventDescViewController.eventName=[_listOfEvents objectAtIndex:indexPath.row];
    eventDescViewController.eventCity=[_listOfCities objectAtIndex:indexPath.row];
    eventDescViewController.eventLocation=[_listOfLocations objectAtIndex:indexPath.row];
    eventDescViewController.eventPrice=[_listOfPrices objectAtIndex:indexPath.row];
    eventDescViewController.eventDate=[_listOfDates objectAtIndex:indexPath.row];
    eventDescViewController.eventTime=[_listOfTimes objectAtIndex:indexPath.row];
    eventDescViewController.eventDescription=[_listOfDescriptions objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:eventDescViewController animated:YES];
}

-(void)AddNewEvent:(id)sender
{
     BandAddEventViewController *newev=[[BandAddEventViewController alloc] init];
    [self.navigationController pushViewController:newev animated:YES];
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
                 NSString *urlForAllEvents= [NSString stringWithFormat:@"http://discover-concerts.herokuapp.com/concerts/%@%@",[user objectForKey:@"id"],@"/show_by_band_id.json"];
                 NSLog(@"url 1: %@", urlForAllEvents);
                 dispatch_async(kBgQueue, ^{
                     NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlForAllEvents]];
                     [self performSelectorOnMainThread:@selector(fetchedDataEvents:)
                                            withObject:data waitUntilDone:YES];
                 });
             }
         }];
    }
}

//parse out the json concerts data and add the concets from db to _listOfEvents property
-(void) fetchedDataEvents:(NSData*) responseData{
    _listOfEvents = [[NSMutableArray alloc] init];
    _listOfCities = [[NSMutableArray alloc] init];
    _listOfLocations = [[NSMutableArray alloc] init];;
    _listOfPrices = [[NSMutableArray alloc] init];
    _listOfDates = [[NSMutableArray alloc] init];
    _listOfTimes = [[NSMutableArray alloc] init];
    _listOfDescriptions = [[NSMutableArray alloc] init];
    _listOfIds = [[NSMutableArray alloc] init];
    NSError* error;
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData
                     options:kNilOptions
                     error:&error];
    
    for (NSDictionary* object in json) {
        NSString* name = [object objectForKey:@"name"];
        NSString* city = [object objectForKey:@"city"];
        NSString* location = [object objectForKey:@"location"];
        NSString* price = [object objectForKey:@"price"];
        NSString* description = [object objectForKey:@"description"];
        NSString* dateTime = [object objectForKey:@"date_time"];
        NSNumber* eventId = [object objectForKey:@"id"];
        NSString* date = [dateTime substringToIndex:10];
        NSString* time = [[dateTime substringFromIndex:12] substringToIndex:7];
        
        [_listOfEvents addObject:name];
        [_listOfCities addObject:city];
        [_listOfLocations addObject:location];
        [_listOfPrices addObject:price];
        [_listOfDescriptions addObject:description];
        [_listOfDates addObject:date];
        [_listOfTimes addObject:time];
        [_listOfIds addObject:eventId];
        
        NSLog(@"fetchedData _listOfEvents: %@", name);
        NSLog(@"fetchedData _listOfCities: %@", city);
        NSLog(@"fetchedData _listOfLocations: %@", location);
        NSLog(@"fetchedData _listOfPrices: %@", price);
        NSLog(@"fetchedData _listOfDescriptions: %@", description);
        NSLog(@"fetchedData _listOfDates: %@", date);
        NSLog(@"fetchedData _listOfTimes: %@", time);
        NSLog(@"fetchedData _listOfIds: %@", eventId);
    }
    [self.tableView reloadData];
}

- (void) deleteFavoriteFromServer:(NSNumber*) eventId
{
    NSString *urlString= [NSString stringWithFormat:@"http://discover-concerts.herokuapp.com/concerts/%@",eventId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSLog(@"url: %@", urlString);
    
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"DELETE"];
    [NSURLConnection connectionWithRequest:request delegate:self];
}


@end
