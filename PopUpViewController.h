//
//  PopUpViewController.h
//  VolunteerInRomania
//
//  Created by Loredana Albulescu on 5/12/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpViewController : UIViewController

@property(nonatomic,retain) IBOutlet UILabel *bandNameLabel;
@property (retain) NSString* bandName;


- (IBAction)dismissView:(id)sender;
@end
