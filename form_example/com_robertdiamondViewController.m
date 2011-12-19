//
//  com_robertdiamondViewController.m
//  form_example
//
//  Created by Robert Diamond on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "com_robertdiamondViewController.h"

@implementation com_robertdiamondViewController
@synthesize volts;
@synthesize ohms;
@synthesize amps;
@synthesize resetButton;

- (id)init {
    self = [super init];
    if (self != nil) {
        // Do stuff here
    }
    return self;
}
- (void)dealloc {
    // free stuff here
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ((UIScrollView *)self.view).contentSize = self.view.bounds.size;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)kbWillShow:(NSNotification *)notif {
    CGRect ht = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect fr = self.view.frame;
    fr.size.height -= ht.size.height;
    self.view.frame = fr;
    [self.view setNeedsLayout];
}

- (void)kbWillHide:(NSNotification *)notif {
    CGRect ht = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect fr = self.view.frame;
    fr.size.height += ht.size.height;
    self.view.frame = fr;
    [self.view setNeedsLayout];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// PjSwr8SS
- (IBAction) calculate:(id)sender {
    float voltValue, ohmValue, ampValue;
    
    [volts resignFirstResponder];
    [ohms resignFirstResponder];
    [amps resignFirstResponder];
    
    voltValue = [volts.text floatValue];
    ohmValue = [ohms.text floatValue];
    ampValue = [amps.text floatValue];
    
    @try {
        if ([volts.text length] == 0) {
            // E = I * R
            voltValue = ohmValue * ampValue;
            volts.text = [NSString stringWithFormat:@"%.3f V", voltValue];
        } else if ([ohms.text length] == 0) {
            // R = E / I
            if (ampValue == 0.0) {
                @throw [NSException exceptionWithName:@"Problem" reason:@"Amps can't be zero" userInfo:nil];
            }
            ohmValue = voltValue / ampValue;
            ohms.text = [NSString stringWithFormat:@"%.3f Ω", ohmValue];
        } else {    // calculate amps by default
            // I = E / R
            if (ohmValue == 0.0) {
                @throw [NSException exceptionWithName:@"Problem" reason:@"Ohms can't be zero" userInfo:nil];
            }
            ampValue = voltValue / ohmValue;
            amps.text = [NSString stringWithFormat:@"%.3f A", ampValue];
        }
    } @catch (NSException *ex) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:ex.name message:ex.reason delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [av show];
        [av release];
    }
}

- (IBAction)reset:(id)sender {
    resetButton.hidden = YES;
    volts.text = @"";
    ohms.text = @"";
    amps.text = @"";
}

//http://pastebin.com/fyibebQV
- (IBAction) checkResetButton:(id)sender {
    if ([ohms.text length] == 0 && [volts.text length] == 0 && [amps.text length] == 0) {
        resetButton.hidden = YES;
    } else {
        resetButton.hidden = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self calculate:textField];
    return YES;
}
@end
