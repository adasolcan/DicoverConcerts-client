//
//  EventDetailViewController.m
//  Discover Concerts
//
//  Created by Laborator iOS on 4/22/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "UserEventDetailViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <EventKit/EventKit.h>

@interface UserEventDetailViewController ()

@end

@implementation UserEventDetailViewController

@synthesize eventsList, eventStore, defaultCalendar, detailViewController;

@synthesize eventNameLabel = _eventNameLabel;
@synthesize eventDescriptionLabel = _eventDescriptionLabel;
@synthesize eventDateLabel = _eventDateLabel;
@synthesize eventTimeLabel = _eventTimeLabel;
@synthesize eventCityLabel = _eventCityLabel;
@synthesize eventLocationLabel = _eventLocationLabel;
@synthesize eventPriceLabel = _eventPriceLabel;
@synthesize eventBand = _eventBand;

@synthesize eventId = _eventId;
@synthesize eventName = _eventName;
@synthesize eventDescription = _eventDescription;
@synthesize eventDate = _eventDate;
@synthesize eventTime = _eventTime;
@synthesize eventCity = _eventCity;
@synthesize eventLocation = _eventLocation;
@synthesize eventPrice = _eventPrice;
@synthesize eventBandId = _eventBandId;
@synthesize showEventButton = _showEventButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eventStore = [[EKEventStore alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                             //initWithTitle:@"Add new favorite"
                                             // style:UIBarButtonItemStyleBordered
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                             target:self
                                             action:@selector(shareEventToFacebook:)];

    
    
    _eventNameLabel.text = self.eventName;
    _eventDescriptionLabel.text = self.eventDescription;
    _eventDateLabel.text = self.eventDate;
    _eventTimeLabel.text = self.eventTime;
    _eventCityLabel.text = self.eventCity;
    _eventLocationLabel.text = self.eventLocation;
    _eventPriceLabel.text = self.eventPrice;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    if ([self.showEventButton hasPrefix:@"YES"])
    {
        
        //dinamically create buttons " add to calendar & attend"
        UIButton* attendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        attendButton.frame = CGRectMake(10.0, 300, 150.0, 35.0);
        UIImage *buttonAttendEventBackground = [ UIImage imageNamed:@"attend event blue.png"];
        [attendButton setBackgroundImage:buttonAttendEventBackground forState:UIControlStateNormal];
        //[attendButton setTitle:@"Attend" forState:UIControlStateNormal];
        [attendButton addTarget:self action:@selector(attendToEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:attendButton];
        
        UIButton* addToCalendarButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        addToCalendarButton.frame = CGRectMake (160.0, 300, 150.0, 34.0); //x y width height
        UIImage *buttonCalendarBackground = [ UIImage imageNamed:@"add to calendar.jpg"];
        [addToCalendarButton setBackgroundImage:buttonCalendarBackground forState:UIControlStateNormal];
       // [addToCalendarButton setTitle:@"Add to calendar" forState:UIControlStateNormal];
        [addToCalendarButton addTarget:self action:@selector(addEventToCalendar:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addToCalendarButton];
    }
}


-(IBAction)attendToEvent:(id)sender
{
    //de adaugat in baza de date
    [self addToDatabaseUserAttendEvent];
    
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)shareEventToFacebook
{
    
}



- (void) addToDatabaseUserAttendEvent
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [user objectForKey:@"id"],@"user_id",
                                       self.eventId,@"concert_id",nil];
                 
                 
                 NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info
                                                                    options:NSJSONWritingPrettyPrinted
                                                                      error:&error];
                 
                 NSLog(@"addToDatabaseUserAttendEvent :%@", info);
                 
                 
                 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://discover-concerts.herokuapp.com/participates"]];
                 
                 [request setHTTPMethod:@"POST"];
                 [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                 [request setHTTPBody:jsonData];
                 [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
             }
         }];
    }
}

#pragma mark -
#pragma mark Add a new event

// If event is nil, a new event is created and added to the specified event store. New events are
// added to the default calendar. An exception is raised if set to an event that is not in the
// specified event store.

-(IBAction)addEventToCalendar:(id)sender
{
    EKEventStore *es = [[EKEventStore alloc] init];
    [es requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        /* This code will run when uses has made his/her choice */
    }];
    
    // When add button is pushed, create an EKEventEditViewController to display the event.
    EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
    // set the addController's event store to the current event store.
    addController.eventStore = self.eventStore;

    // present EventsAddViewController as a modal view controller
    [self presentModalViewController:addController animated:YES];
    
    addController.editViewDelegate = self;
}

#pragma mark -
#pragma mark EKEventEditViewDelegate

// Overriding EKEventEditViewDelegate method to update event store according to user actions.
- (void)eventEditViewController:(EKEventEditViewController *)controller
          didCompleteWithAction:(EKEventEditViewAction)action {
	
	NSError *error = nil;
    controller.event.title=@"yey";
	EKEvent *thisEvent = controller.event;
    thisEvent.title = @"YEY";
    thisEvent.location = @"me";
    
	
	switch (action) {
		case EKEventEditViewActionCanceled:
			// Edit action canceled, do nothing.
			break;
			
		case EKEventEditViewActionSaved:
			// When user hit "Done" button, save the newly created event to the event store,
			// and reload table view.
			// If the new event is being added to the default calendar, then update its
			// eventsList.
			if (self.defaultCalendar ==  thisEvent.calendar) {
				[self.eventsList addObject:thisEvent];
			}
			[controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
			break;
			
		case EKEventEditViewActionDeleted:
			// When deleting an event, remove the event from the event store,
			// and reload table view.
			// If deleting an event from the currenly default calendar, then update its
			// eventsList.
			if (self.defaultCalendar ==  thisEvent.calendar) {
				[self.eventsList removeObject:thisEvent];
			}
			[controller.eventStore removeEvent:thisEvent span:EKSpanThisEvent error:&error];
			break;
			
		default:
			break;
	}
	// Dismiss the modal view controller
	[controller dismissModalViewControllerAnimated:YES];
	
}


// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller {
	EKCalendar *calendarForEdit = self.defaultCalendar;
	return calendarForEdit;
}

@end
