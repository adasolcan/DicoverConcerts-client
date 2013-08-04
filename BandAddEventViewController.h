//
//  BandAddEventViewController.h
//  Discover Concerts
//
//  Created by Laborator iOS on 4/17/13.
//  Copyright (c) 2013 Loredana Albulescu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BandAddEventViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITextField *nameTextField;
@property(nonatomic,retain) IBOutlet UITextField *cityTextField;
@property(nonatomic,retain) IBOutlet UITextField *locationTextField;
@property(nonatomic,retain) IBOutlet UITextField *priceTextField;
@property(nonatomic,retain) IBOutlet UITextField *dateTimeTextField;
@property(nonatomic,retain) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end
