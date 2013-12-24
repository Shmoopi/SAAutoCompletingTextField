//
//  SAAutoCompletingTextFieldDemoFlipsideViewController.m
//  AutoCompletingTextFieldDemo
//
//  Created by Kramer on 12/23/13.
//  Copyright (c) 2013 Shmoopi LLC. All rights reserved.
//

#import "SAAutoCompletingTextFieldDemoFlipsideViewController.h"

@interface SAAutoCompletingTextFieldDemoFlipsideViewController ()

@end

@implementation SAAutoCompletingTextFieldDemoFlipsideViewController

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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
