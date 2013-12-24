//
//  SAAutoCompletingTextFieldDemoMainViewController.m
//  AutoCompletingTextFieldDemo
//
//  Created by Kramer on 12/23/13.
//  Copyright (c) 2013 Shmoopi LLC. All rights reserved.
//

#import "SAAutoCompletingTextFieldDemoMainViewController.h"

@interface SAAutoCompletingTextFieldDemoMainViewController ()

@end

@implementation SAAutoCompletingTextFieldDemoMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField applyCompletion];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(SAAutoCompletingTextFieldDemoFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)completeAuto:(id)sender {
    [self.textField applyCompletion];
    [self.textField resignFirstResponder];
}

@end
