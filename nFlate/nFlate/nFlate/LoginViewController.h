//
//  LoginViewController.h
//  nFlate
//
//  Created by mac-007 on 24/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollView.h"
@interface LoginViewController : UIViewController<ScrollDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtuserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)tapLogin:(id)sender;
@property (weak, nonatomic) IBOutlet CustomScrollView *pageScroll;


@end
