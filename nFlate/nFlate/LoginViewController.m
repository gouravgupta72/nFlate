//
//  LoginViewController.m
//  nFlate
//
//  Created by mac-007 on 24/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.txtuserName setValue:[UIColor colorWithRed:42.0/255.0 green:111.0/255.0 blue:37.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.txtPassword setValue:[UIColor colorWithRed:42.0/255.0 green:111.0/255.0 blue:37.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];

}

/**
 *  Dlegate Method for Custom scroll view.
 *
 *  @param touches no.Of Touches.
 *  @param event   touch Event.
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self setPreviousPosition];
}

-(void) setPreviousPosition{
    [self.pageScroll setContentSize:CGSizeMake(240,267)];
    self.pageScroll.contentOffset=CGPointMake(0, 0);
    
    [self.txtuserName resignFirstResponder];
    
    [self.txtPassword resignFirstResponder];
}

#pragma -mark UITextField Method
//Delegate Method of text field for performing action when user click return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.pageScroll setContentSize:CGSizeMake(240,350)];
    if ([textField isEqual:self.txtPassword] )
	{
		[self setPreviousPosition];
       
        [self.pageScroll setContentSize:CGSizeMake(240,267)];
	}
	else if ([textField isEqual:self.txtuserName])
	{
		[self.txtPassword becomeFirstResponder];
        
        
	}
    
    return YES;
}

#pragma -mark UITextField Method
//Delegate method call when textfield click
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        if ([textField isEqual:self.txtuserName]) {
            
            [self.pageScroll setContentOffset:CGPointMake(0, self.txtPassword.frame.origin.y-110) animated:YES];
        }
        if ([textField isEqual:self.txtPassword]) {
            
            [self.pageScroll setContentOffset:CGPointMake(0, self.txtPassword.frame.origin.y) animated:YES];
        }
    }
    [self.pageScroll setContentSize:CGSizeMake(240,200)];
     
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.txtPassword] )
	{
		
    
        [textField resignFirstResponder];
        [self setPreviousPosition];
	}
	else if ([textField isEqual:self.txtuserName])
	{
		
        [textField resignFirstResponder];
        [self setPreviousPosition];
        
        
	}
    
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  method for Login .
 *
 *  @param sender sneder id.
 */
- (IBAction)tapLogin:(id)sender {

    
    if ([self.txtuserName.text isEqualToString:@""]) {
        if ([self.txtPassword.text isEqualToString:@""])
        {
        showAlert(@"Faliure", @"Please Enter User Name and Password", self);
        }
        else
        {
            showAlert(@"Faliure", @"Please Enter User Name ", self);
        }
    }
    else if ([self.txtPassword.text isEqualToString:@""])
    {
        showAlert(@"Faliure", @"Please Enter Password", self);
    }
    
    else
    {
        
    }
}
@end
