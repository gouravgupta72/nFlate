//
//  LoadingView.m
//  CustomLoadingView
//
//  Created by Mac-005 on 14/03/14.
//  Copyright (c) 2014 Hushain Mubarik Khan. All rights reserved.
//
/*Class Description
    This Class is used for creating loading view.
*/
#import "LoadingView.h"

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)


@implementation LoadingView
{
    UIActivityIndicatorView *activityIndicator;
    UILabel *lblLoading;
    UIView *moveView;
}
-(void)releaseObject
{
    [activityIndicator stopAnimating];
  	[self removeFromSuperview];
}
-(id)initWithCustomFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	[self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7]];
	
    //get orientation and add view according to orientation
    if(orientation==UIInterfaceOrientationPortrait){
        moveView=[[UIView alloc]initWithFrame:CGRectMake(240, 200, 200, 200)];
        [moveView setBackgroundColor:[UIColor clearColor]];
        moveView.center=CGPointMake((SCREEN_WIDTH/2), (SCREEN_HEIGHT/2));
        float   angle = 0;  //rotate o°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }else if(orientation==UIInterfaceOrientationLandscapeRight){
        moveView=[[UIView alloc]initWithFrame:CGRectMake(240, 200, 200, 200)];
        [moveView setBackgroundColor:[UIColor clearColor]];
        moveView.center=CGPointMake((SCREEN_HEIGHT/2), (SCREEN_WIDTH/2));
        float   angle = M_PI/2;  //rotate 90°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }else if(orientation==UIInterfaceOrientationLandscapeLeft){
        moveView=[[UIView alloc]initWithFrame:CGRectMake(240, 200, 200, 200)];
        [moveView setBackgroundColor:[UIColor clearColor]];
        moveView.center=CGPointMake((SCREEN_HEIGHT/2), (SCREEN_WIDTH/2));
        float   angle = M_PI+M_PI/2;  //rotate 270°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }else if(orientation==UIInterfaceOrientationPortraitUpsideDown){
        moveView=[[UIView alloc]initWithFrame:CGRectMake(240, 200, 200, 200)];
        [moveView setBackgroundColor:[UIColor clearColor]];
        moveView.center=CGPointMake((SCREEN_WIDTH/2), (SCREEN_HEIGHT/2));
        float   angle = M_PI;  //rotate 180°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }
    [self addSubview:moveView];
	//Activity Indicator
    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(70,80,68,68)];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	[moveView addSubview:activityIndicator];
	//Loading Label
    lblLoading=[[UILabel alloc] initWithFrame:CGRectMake(70,150,80,20)];
    lblLoading.text=@"Loading...";
    lblLoading.backgroundColor=[UIColor clearColor];
    lblLoading.textColor=[UIColor lightGrayColor];
    //Start Activity Indicator
    [activityIndicator startAnimating];
    
    [moveView addSubview:lblLoading];

    return self;
}
//roteted view accoring to orientation
-(void)rotation
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation==UIInterfaceOrientationPortrait){
        float   angle = 0;  //rotate o°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }else if(orientation==UIInterfaceOrientationLandscapeRight){
        float   angle = M_PI/2;  //rotate 90°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }else if(orientation==UIInterfaceOrientationLandscapeLeft){
        float   angle = M_PI+M_PI/2;  //rotate 270°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }else if(orientation==UIInterfaceOrientationPortraitUpsideDown){
    float   angle = M_PI;  //rotate 180°
        moveView.layer.transform = CATransform3DMakeRotation(angle, 0, 0.0, 1.0);
    }
}
@end
