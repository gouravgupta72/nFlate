//
//  loadingView.m
// class used for create loading view

#import "loadingView.h"

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

@implementation loadingView
@synthesize activityIndicator,btnCancel,lblMsg;
-(void)clickMe
{
	[self.activityIndicator stopAnimating];
  	[self removeFromSuperview];
}
- (id) initWithMyFrame:(CGRect )f
{
	self=[super initWithFrame:f];
	[self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7]];
	CGPoint p=[self center];
	self.activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(p.x-37/2, p.y-32/2, 37, 37)];
	[self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	[self addSubview:self.activityIndicator];
    
	lblMsg=[[UILabel alloc] initWithFrame:CGRectMake(p.x-50/2,CGRectGetMaxY(self.activityIndicator.frame), 200, 30)];
    lblMsg.text=@"Logging...";
    lblMsg.backgroundColor=[UIColor clearColor];
    lblMsg.textColor=[UIColor lightGrayColor];
    
    [self addSubview:lblMsg];
    
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	return self;
}


-(void)layoutSubviews
{
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
}

-(void)rotation :(id)rot
{
    int i= (int)rot;
    if(i==3){
        
        self.activityIndicator.frame =CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)-40,68,68);
        lblMsg.frame=CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)+30,80,20);
    }else if(i==4){
        
        self.activityIndicator.frame=CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)-40,68,68);
        lblMsg.frame=CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)+30,80,20);
    }else if(i==1){
        
        self.activityIndicator.frame= CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)-40,68,68);
        lblMsg.frame=CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)+30,80,20);
    }else if(i==2){
        
        self.activityIndicator.frame =CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)-40,68,68);
        lblMsg.frame=CGRectMake((SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)+30,80,20);
        
    }
}


-(BOOL)MyInterfaceChangedCustomMethod
{
    return YES;
}
@end
