//
//  SAAutoCompletingTextFieldDemoMainViewController.h
//  AutoCompletingTextFieldDemo
//
//  Created by Kramer on 12/23/13.
//  Copyright (c) 2013 Shmoopi LLC. All rights reserved.
//

#import "SAAutoCompletingTextFieldDemoFlipsideViewController.h"

// AutoCompletingTextField
#import "SAAutoCompletingTextField.h"

@interface SAAutoCompletingTextFieldDemoMainViewController : UIViewController <UITextFieldDelegate, SAAutoCompletingTextFieldDemoFlipsideViewControllerDelegate>

// TextField
@property (strong, nonatomic) IBOutlet SAAutoCompletingTextField *textField;

// Autocomplete the textfield
- (IBAction)completeAuto:(id)sender;

@end
