//
//  EventDescriptionViewController.h
//  Discover Concerts
//
//  Created by Laborator iOS on 4/17/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDescriptionViewController : UIViewController
@property(nonatomic,retain) IBOutlet UILabel *eventNameLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventCityLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventLocationLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventPriceLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventDateLabel;
@property(nonatomic,retain) IBOutlet UILabel *eventTimeLabel;
@property(nonatomic,retain) IBOutlet UITextView *eventDescriptionTextView;

@property (retain) NSString* eventName;
@property (retain) NSString* eventCity;
@property (retain) NSString* eventLocation;
@property (retain) NSString* eventPrice;
@property (retain) NSString* eventDate;
@property (retain) NSString* eventTime;
@property (retain) NSString* eventDescription;

@end
