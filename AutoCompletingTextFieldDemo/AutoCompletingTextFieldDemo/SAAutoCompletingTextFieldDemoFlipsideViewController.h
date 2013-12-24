//
//  SAAutoCompletingTextFieldDemoFlipsideViewController.h
//  AutoCompletingTextFieldDemo
//
//  Created by Kramer on 12/23/13.
//  Copyright (c) 2013 Shmoopi LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAAutoCompletingTextFieldDemoFlipsideViewController;

@protocol SAAutoCompletingTextFieldDemoFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(SAAutoCompletingTextFieldDemoFlipsideViewController *)controller;
@end

@interface SAAutoCompletingTextFieldDemoFlipsideViewController : UIViewController

@property (weak, nonatomic) id <SAAutoCompletingTextFieldDemoFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
