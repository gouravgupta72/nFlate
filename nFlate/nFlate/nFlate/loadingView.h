//
//  loadingView.h

// class used for create loading view
#import <UIKit/UIKit.h>


@interface loadingView : UIView {
  
	UIActivityIndicatorView	*activityIndicator;
	UIButton *btnCancel;
    UILabel *lblMsg;
	
}
@property(nonatomic,retain) UILabel *lblMsg;
@property(nonatomic,retain)	UIButton *btnCancel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView	*activityIndicator;
- (id) initWithMyFrame:(CGRect )f;
-(BOOL)MyInterfaceChangedCustomMethod;

-(void)rotation :(id)rot;
@end
