//
//  LoginViewController.m
//  nFlate
//
//  Created by mac-007 on 24/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "LoginViewController.h"
#import "nFlateViewController.h"
#import "GameDataClass.h"
#import "nFlateAppDelegate.h"
@interface LoginViewController ()
{
    NSMutableArray *arrGame;
    NSString *idStr;
}
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
    [self.navigationController setNavigationBarHidden:YES];
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
        [[nFlateAppDelegate sharedAppDelegate] addloadingView];
        Request *req=[[Request alloc]init];
        req.delegate=self;
       NSString *postParam=[NSString stringWithFormat:@"dID=%@",self.txtuserName.text];
        NSLog(@"%@",postParam);
        [req postRequest:postParam url:LOGINURL];
    
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"loginSegue"])
    {
        // Get reference to the destination view controller
        nFlateViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.gameArr=arrGame;
    }
}

-(void)getError:(id)error
{
    [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
    NSString *errStr=[NSString stringWithFormat:@"%@",error];
    showAlert(@"Failure", errStr, self);
    
}

-(void)getResult:(id)jsonData
{
    
    
    
    NSLog(@"jsonData=%@",jsonData);
    
    
    if ([jsonData isKindOfClass:[NSDictionary class]])
    {
        
        if ([jsonData valueForKey:@"Error_Code"]) {
            NSString *err_code=[NSString stringWithFormat:@"%@",[jsonData valueForKey:@"Error_Code"]];
                NSString *message=[jsonData valueForKey:@"Message"];
            
            
            if ([err_code isEqualToString:@"100"]) {
                [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];

                showAlert(@"Failure", message, self);
                [self setPreviousPosition];
            }
            else if ([err_code isEqualToString:@"1"])
            {
                [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];

                showAlert(@"Failure", message, self);
                [self setPreviousPosition];
            }
        }
            else
            {
                    if (!arrGame)
                    {
                        arrGame = [[NSMutableArray alloc]init];
                    }else
                    {
                        [arrGame removeAllObjects];
                    }
                  if (![[jsonData  valueForKey:@"dID"] isKindOfClass:[NSNull class]])
                   {
                       [nFlateAppDelegate sharedAppDelegate].userID=[NSString stringWithFormat:@"%@", [jsonData  valueForKey:@"dID"]];
                   }
                    if (![[jsonData  valueForKey:@"game_List"] isKindOfClass:[NSNull class]])
                    {
                        id gameList=[jsonData  valueForKey:@"game_List"];
                        
                        if ([gameList isKindOfClass:[NSArray class]]) {
                            for (int i=0; i<[gameList count]; i++) {
                                
                                GameDataClass *objgameData=[[GameDataClass alloc]init];
                                id itemdict=[gameList objectAtIndex:i];
                                if (![itemdict isKindOfClass:[NSNull class]]) {
                                    
                                    if (![[itemdict valueForKey:@"game_id"] isKindOfClass:[NSNull class]])
                                    {
                                        objgameData.gameID=[itemdict valueForKey:@"game_id"];
                                        
                                    }
                                    if (![[itemdict valueForKey:@"gameName"] isKindOfClass:[NSNull class]])
                                    {
                                        objgameData.gameName=[itemdict valueForKey:@"gameName"];
                                        
                                    }
                                    if (![[itemdict valueForKey:@"game_Color"] isKindOfClass:[NSNull class]]) {
                                        objgameData.gameColor=[itemdict valueForKey:@"game_Color"];
                                        
                                    }
                                }
                                
                                
                                
                                [arrGame addObject:objgameData];
                            }
                            
                            
                            
                        }
                        
                    }
                    [self performSegueWithIdentifier:@"loginSegue" sender:self];
                    
                }
            }
        
        
        
    
    
}





@end
