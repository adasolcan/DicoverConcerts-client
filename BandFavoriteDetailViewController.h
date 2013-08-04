//
//  BandFavoriteDetailViewController.h
//  Discover Concerts
//
//  Created by Laborator iOS on 4/16/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface BandFavoriteDetailViewController : UIViewController

@property(nonatomic,retain) IBOutlet UILabel *bandNameLabel;
@property(nonatomic,retain) IBOutlet UITextView *bandDescriptionTextView;
@property(strong,nonatomic) IBOutlet FBProfilePictureView *bandProfileImage;
@property (retain) NSString* bandName;
@property (retain) NSString* bandDescription;
@property (retain) NSNumber* bandId;
@property (retain) NSString* bandFbId;
@property (retain) UIImage* bandPicture;

@end
