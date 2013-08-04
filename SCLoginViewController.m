//
//  SCLoginViewController.m
//  Discover Concerts
//
//  Created by Loredana Albulescu on 3/26/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "SCLoginViewController.h"
#import "AppDelegate.h"

@implementation SCLoginViewController

@synthesize spinner;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)performLogin:(id)sender
{
    [self.spinner startAnimating];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}
 //If there is an issue during the authorization flow, for example if the user cancels theauthorization flow, you'll want to do some cleanup, like stopping the activity animation. To do this, define a login failed cleanup method:

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}

@end
