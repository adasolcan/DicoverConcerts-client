//
//  BandAddEventViewController.m
//  Discover Concerts
//
//  Created by Laborator iOS on 4/17/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "BandAddEventViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kBandsURL [NSURL URLWithString:@"http://discover-concerts.herokuapp.com/bands"]

@interface BandAddEventViewController ()
@property(nonatomic,retain) NSMutableArray *listOfUsersFacebookId;
@end

@implementation BandAddEventViewController
@synthesize nameTextField = _nameTextField;
@synthesize cityTextField = _cityTextField;
@synthesize locationTextField = _locationTextField;
@synthesize priceTextField = _priceTextField;
@synthesize dateTimeTextField = _dateTimeTextField;
@synthesize descriptionTextField = _descriptionTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.title= @"Add event";
        [self GetAllUserFromFavorites];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)AddEvent:(id)sender
{    
    //de adaugat in baza de date
    [self addToDatabaseEvent];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Added event"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) addToDatabaseEvent
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 //get data from date picker
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
                 NSDate   *date = self.datePicker.date;
                 NSString *dateAsString = [dateFormatter stringFromDate:date];
                 NSLog(@"%@", [date description]);

                 NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                                       _nameTextField.text,@"name",
                                       _cityTextField.text,@"city",
                                       _locationTextField.text,@"location",
                                       _priceTextField.text,@"price",
                                       dateAsString,@"date_time",
                                       _descriptionTextField.text,@"description",
                                       [user objectForKey:@"id"],@"band_id",nil];
                 
                 
                 NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info
                                                                    options:NSJSONWritingPrettyPrinted
                                                                      error:&error];
                 
                 NSLog(@"json :%@", info);
                 
                 
                 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://discover-concerts.herokuapp.com/concerts"]];
                 
                 [request setHTTPMethod:@"POST"];
                 [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                 [request setHTTPBody:jsonData];
                 [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
             }
         }];
    }
}


//Get all bands from db
- (void)GetAllUserFromFavorites
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSString *urlForAllUsers= [NSString stringWithFormat:@"http://discover-concerts.herokuapp.com/favorites/%@%@",user.id,@"/show_favorites_of_band_id.json"];
                 NSLog(@"user favorites: %@", urlForAllUsers);
                 dispatch_async(kBgQueue, ^{
                     NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlForAllUsers]];
                     [self performSelectorOnMainThread:@selector(fetchedDataFavoritesUsers:)
                                            withObject:data waitUntilDone:YES];
                 });
             }
         }];
    }
}

//parse out the json genres data and add the favorites bands
-(void) fetchedDataFavoritesUsers:(NSData*) responseData
{
    _listOfUsersFacebookId = [[NSMutableArray alloc] init];
    
    NSError* error;
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:responseData //1
                     options:kNilOptions
                     error:&error];
    
    for (NSDictionary* object in json) {
        NSString* userFacebookId = [object objectForKey:@"user_id"];
        [_listOfUsersFacebookId addObject:userFacebookId];
        NSLog(@"fetchedDataFavoritesBands: %@", userFacebookId);
    }
  //send a Notification to _listOfUsersFacebookId
}


#pragma mark - 
#pragma mark AlerView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
