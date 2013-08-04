//
//  EventDetailViewController.h
//  Discover Concerts
//
//  Created by Laborator iOS on 4/22/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface UserEventDetailViewController : UIViewController

@property(nonatomic,retain) IBOutlet UILabel *eventNameLabel;
@property(nonatomic,retain) IBOutlet UITextView *eventDescriptionLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventDateLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventTimeLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventCityLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventLocationLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventPriceLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventBand;

@property (retain) NSString* eventId;
@property (retain) NSString* eventName;
@property (retain) NSString* eventDescription;
@property (retain) NSString* eventDate;
@property (retain) NSString* eventTime;
@property (retain) NSString* eventCity;
@property (retain) NSString* eventLocation;
@property (retain) NSString* eventPrice;
@property (retain) NSString* eventBandId;
@property (retain) NSString* showEventButton;


-(IBAction)attendToEvent:(id)sender;
-(IBAction)addEventToCalander:(id)sender;
-(void)shareEventToFacebook:(id)sender;

@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *defaultCalendar;
@property (nonatomic, retain) NSMutableArray *eventsList;
@property (nonatomic, retain) EKEventViewController *detailViewController;

@end

