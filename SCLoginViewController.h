//
//  SCLoginViewController.h
//  Discover Concerts
//
//  Created by Loredana Albulescu on 3/26/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCLoginViewController : UIViewController

- (IBAction)performLogin:(id)sender;
- (void)loginFailed;
@property(strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

