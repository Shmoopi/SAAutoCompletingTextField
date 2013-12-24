//
//  APAutocompleteTextField.h
//  APAutocompleteTextField
//
//  Created by Shmoopi LLC on 13.23.13.
//  Copyright (c) 2013 Shmoopi LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@class SAAutoCompletingTextField;

@interface SAAutoCompletingTextField : UITextField

// AFHTTPRequestOperation
@property (strong, nonatomic) AFHTTPRequestOperation *req;

// Google Suggestions Array of Suggestions
@property (strong, nonatomic) NSMutableArray *suggestionsArray;

// Did Autocomplete the Text
@property (nonatomic, readonly) BOOL didAutoComplete;

// TextField Selection Color
@property (nonatomic, strong) UIColor *selectionColor;

// Apply the Completion
- (void)applyCompletion;
// Remove the Completion
- (void)removeCompletion;

@end
