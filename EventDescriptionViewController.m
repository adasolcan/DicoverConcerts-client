//
//  EventDescriptionViewController.m
//  Discover Concerts
//
//  Created by Laborator iOS on 4/17/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "EventDescriptionViewController.h"

@interface EventDescriptionViewController ()

@end

@implementation EventDescriptionViewController

@synthesize eventNameLabel = _eventNameLabel;
@synthesize eventCityLabel = _eventCityLabel;
@synthesize eventLocationLabel = _eventLocationLabel;
@synthesize eventPriceLabel = _eventPriceLabel;
@synthesize eventDateLabel = _eventDateLabel;
@synthesize eventTimeLabel = _eventTimeLabel;
@synthesize eventDescriptionTextView = _eventDescriptionTextView;

@synthesize eventName = _eventName;
@synthesize eventCity = _eventCity;
@synthesize eventLocation = _eventLocation;
@synthesize eventPrice = _eventPrice;
@synthesize eventDate = _eventDate;
@synthesize eventTime = _eventTime;
@synthesize eventDescription = _eventDescription;

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              //initWithTitle:@"Add new favorite"
                                              // style:UIBarButtonItemStyleBordered
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                              target:self
                                              action:@selector(editEvent:)];
    

    _eventNameLabel.text = _eventName;
    _eventLocationLabel.text = _eventLocation;
    _eventCityLabel.text = _eventCity;
    _eventPriceLabel.text = _eventPrice;
    _eventDateLabel.text = _eventDate;
    _eventTimeLabel.text = _eventTime;
    
    _eventDescriptionTextView.text = _eventDescription;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) editEvent
{
    
}

@end
