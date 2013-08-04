//
//  BandFavoriteDetailViewController.m
//  Discover Concerts
//
//  Created by Laborator iOS on 4/16/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "BandFavoriteDetailViewController.h"
#import "UserFavoriteBandsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface BandFavoriteDetailViewController ()

@end

@implementation BandFavoriteDetailViewController
@synthesize bandNameLabel=_bandNameLabel;
@synthesize bandName=_bandName;
@synthesize bandDescriptionTextView =_bandDescriptionTextView;
@synthesize bandDescription=_bandDescription;
@synthesize bandProfileImage=_bandProfileImage;
@synthesize bandPicture=_bandPicture;
@synthesize bandId=_bandId;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.title=@"Details";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getBandProfileImage];
    self.bandNameLabel.text = self.bandName;
    self.bandDescriptionTextView.text=self.bandDescription;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getBandProfileImage
{
    NSString *fbuid = self.bandFbId;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?", fbuid]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _bandPicture = [[UIImage alloc] initWithData:data];
    
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 90)];
    imageHolder.image = _bandPicture;
    [self.view addSubview:imageHolder];
}

@end
