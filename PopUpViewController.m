//
//  PopUpViewController.m
//  VolunteerInRomania
//
//  Created by Loredana Albulescu on 5/12/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

@synthesize bandNameLabel = _bandNameLabel;
@synthesize bandName = _bandName;

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
    self.bandNameLabel.text=self.bandName;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
//    CGRect mainrect = [[UIScreen mainScreen] bounds];
//    CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, mainrect.size.height);
//    [UIView animateWithDuration:0.8
//                     animations:^{
//                         self.view.frame = newRect;
//                     } completion:^(BOOL finished) {
//                         [self.view removeFromSuperview];
//                     }];
}


@end
