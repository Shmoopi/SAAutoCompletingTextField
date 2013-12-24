//
//  APAutocompleteTextField.m
//  APAutocompleteTextField
//
//  Created by Shmoopi LLC on 13.23.13.
//  Copyright (c) 2013 Shmoopi LLC. All rights reserved.
//

#import "SAAutoCompletingTextField.h"
#import "TouchXML/TouchXML.h"

@implementation SAAutoCompletingTextField {
    BOOL _didAutoComplete;
    NSUInteger _lengthOriginString;
}

@synthesize selectionColor = _selectionColor;
@synthesize didAutoComplete = _didAutoComplete;

#pragma mark - init

- (void)awakeFromNib {
    // Set the variables
    _didAutoComplete = NO;
    // Set the selection color
    self.selectionColor = [UIColor colorWithRed:0.8f green:0.87f blue:0.93f alpha:1.f];
}

- (id)init {
    self = [super init];
    if (self) {
        // Set the variables
        _didAutoComplete = NO;
        // Set the selection color
        self.selectionColor = [UIColor colorWithRed:0.8f green:0.87f blue:0.93f alpha:1.f];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set the variables
        _didAutoComplete = NO;
        // Set the selection color
        self.selectionColor = [UIColor colorWithRed:0.8f green:0.87f blue:0.93f alpha:1.f];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Set the variables
        _didAutoComplete = NO;
        // Set the selection color
        self.selectionColor = [UIColor colorWithRed:0.8f green:0.87f blue:0.93f alpha:1.f];
    }
    return self;
}

#pragma mark - Public Methods

// Apply the autocompletion
- (void)applyCompletion
{
    if (_didAutoComplete) {
        NSAttributedString *notMarkedString = [[NSAttributedString alloc] initWithString:self.text];
        
        self.attributedText = notMarkedString;
        _didAutoComplete = NO;
    }
}

// Remove the autocompletion
- (void)removeCompletion
{
    if (_didAutoComplete) {
        NSString *notComplitedString = [self.text substringToIndex:_lengthOriginString];
        NSAttributedString *notComplitedAndNotMarkedString = [[NSAttributedString alloc] initWithString:notComplitedString];
        
        self.attributedText = notComplitedAndNotMarkedString;
        _didAutoComplete = NO;
    }
}

#pragma mark - UIKeyInput

// Delete key - remove autocompletion input
- (void)deleteBackward
{
    if (_didAutoComplete) {
        [self removeCompletion];
    }
    else {
        [super deleteBackward];
    }
}

// Insert text - get new suggestions
- (void)insertText:(NSString *)text
{
    if ([self isItReturnButtonPressed:text]) {
        [self handleReturnButton];
        return;
    }
    
    [self removeCompletion];
    
    [super insertText:text];
    _lengthOriginString = self.text.length;
    
    // obtain the text to be search from self
	NSString *strSearch = self.text;
    if (!strSearch || strSearch.length < 1) {
        // Remove all objects & hide the table.
		if(self.suggestionsArray && self.suggestionsArray.count) {
			[self.suggestionsArray removeAllObjects];
		}
        // Return
        return;
    }
	// trim the spaces
	strSearch = [strSearch stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	// ensure the lenght of text
	if(strSearch && strSearch.length) {
		// create a URL
		strSearch = [@"http://google.com/complete/search?output=toolbar&q=" stringByAppendingString:strSearch];
		// add PercentEscapes
		strSearch = [strSearch stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		// cancel previous requests if any
		if(self.req) {
			[self.req cancel];
			self.req=nil;
		}
        
		// create new request
		self.req = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strSearch]]];
        
        __weak typeof(self) weakSelf = self;
        
        // See if the request was successful or failed
        [self.req setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // Success!
            
            // after receiving response remove all previous data
            if(weakSelf.suggestionsArray && weakSelf.suggestionsArray.count) {
                [weakSelf.suggestionsArray removeAllObjects];
            }
            // create empty array
            weakSelf.suggestionsArray = [NSMutableArray array];
            
            // logic for parsing beings ----
            // create DOM document
            CXMLDocument *doc = [[CXMLDocument alloc] initWithData:responseObject encoding:NSUTF8StringEncoding options:0 error:nil];
            // grab child nodes of topLevel
            NSArray *ar = [doc nodesForXPath:@"//toplevel/*" error:nil];
            for (CXMLNode *node in ar) {
                NSString *strNodeName = [node name];
                if(strNodeName && [strNodeName isKindOfClass:[NSString class]] && strNodeName.length && [strNodeName isEqualToString:@"CompleteSuggestion"]) {
                    // grab child nodes of CompleteSuggestion
                    NSArray *arInnerNodes = [node children];
                    for (CXMLNode *nodeInner in arInnerNodes) {
                        strNodeName = [nodeInner name];
                        if(strNodeName && [strNodeName isKindOfClass:[NSString class]] && strNodeName.length && [strNodeName isEqualToString:@"suggestion"]) {
                            // grab suggestion node attribues
                            CXMLElement *element = (CXMLElement*)nodeInner;
                            NSArray *attr = [element attributes];
                            for (CXMLNode *nodeAttr in attr) {
                                strNodeName = [nodeAttr name];
                                if(strNodeName && [strNodeName isKindOfClass:[NSString class]] && strNodeName.length && [strNodeName isEqualToString:@"data"] && [nodeAttr stringValue] && [[nodeAttr stringValue] isKindOfClass:[NSString class]] && [[nodeAttr stringValue] length]) {
                                    // grab value of attribute named 'data' & add it into an array
                                    [weakSelf.suggestionsArray addObject:[nodeAttr stringValue]];
                                }
                            }
                        }
                    }
                }
            }
            // logic for parsing over ---------
            
            // Now apply the completion if the top level string is part of the current string
            if ([weakSelf.suggestionsArray count] && [[weakSelf.suggestionsArray objectAtIndex:0] rangeOfString:weakSelf.text options:NSCaseInsensitiveSearch].location != NSNotFound) {
                [weakSelf completeString];
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // Failed
            NSLog(@"request failed %@", [error description]);
        }];
		// start async call
		[self.req start];
	} else {
        // if search text length is 0
		// cancel previous request
		if(self.req) {
			[self.req cancel];
			self.req=nil;
		}
		// remove all objects & hide the table.
		if(self.suggestionsArray && self.suggestionsArray.count) {
			[self.suggestionsArray removeAllObjects];
		}
	}
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect caretRect = CGRectZero;
    if (!_didAutoComplete) {
        caretRect = [super caretRectForPosition:position];
    }
    return caretRect;
}

- (BOOL)canResignFirstResponder {
    [self removeCompletion];
    return YES;
}

#pragma mark - Properties

- (void)setText:(NSString *)text
{
    [self removeCompletion];
    [super setText:text];
}

#pragma mark - Internal

- (BOOL)isItReturnButtonPressed:(NSString *)text
{
    unichar symbol = [text characterAtIndex:0];
    
    BOOL isItReturnButton = (symbol == 10);
    return isItReturnButton;
}

- (void)handleReturnButton
{
    if (_didAutoComplete) {
        NSAttributedString *stringWithoutSelection = [[NSAttributedString alloc] initWithString:self.text];
        self.attributedText = stringWithoutSelection;
        
        _didAutoComplete = NO;
    }
}

- (void)completeString
{
    NSMutableAttributedString *complitedAndMarkedString = nil;
    
    NSString *endingString = [self endingString];
    if (endingString.length > 0) {
        NSString *completedString = [NSString stringWithFormat:@"%@%@", self.text, endingString];
        
        NSRange markRange = NSMakeRange(_lengthOriginString, endingString.length);
        UIColor *markColor = self.selectionColor;
        complitedAndMarkedString = [[NSMutableAttributedString alloc] initWithString:completedString];
        [complitedAndMarkedString addAttribute:NSBackgroundColorAttributeName value:markColor range:markRange];
    }
    
    if (complitedAndMarkedString.length > 0) {
        self.attributedText = complitedAndMarkedString;
        _didAutoComplete = YES;
    }
}

- (NSString *)endingString
{
    NSString *endingString = nil;
    
    if (self.text.length > 0) {
        NSString *complitedString = [self.suggestionsArray objectAtIndex:0];
        
        if (complitedString.length > 0) {
            NSRange rangeOriginString = [complitedString rangeOfString:self.text options:NSCaseInsensitiveSearch];
            NSAssert(rangeOriginString.location != NSNotFound, @"Invalid completion string");
            
            endingString = [complitedString substringFromIndex:self.text.length];
        }
    }
    return endingString;
}

@end


