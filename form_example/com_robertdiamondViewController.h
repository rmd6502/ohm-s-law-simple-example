//
//  com_robertdiamondViewController.h
//  form_example
//
//  Created by Robert Diamond on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface com_robertdiamondViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,assign) IBOutlet UITextField *volts;
@property (nonatomic,assign) IBOutlet UITextField *ohms;
@property (nonatomic,assign) IBOutlet UITextField *amps;

@property (nonatomic,assign) IBOutlet UIButton *resetButton;

- (id)init;
- (void)dealloc;

- (IBAction) calculate:(id)sender;
- (IBAction) reset:(id)sender;
- (IBAction) checkResetButton:(id)sender;

- (void)kbWillShow:(NSNotification *)notif;
- (void)kbWillHide:(NSNotification *)notif;

@end
