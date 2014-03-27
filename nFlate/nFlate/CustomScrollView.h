//
//  CustomScrollView.h


#import <UIKit/UIKit.h>

@protocol ScrollDelegate;
@interface CustomScrollView : UIScrollView
{
	id<ScrollDelegate>maindelegate;
}

@property (retain, nonatomic) id<ScrollDelegate> maindelegate;

@end
@protocol ScrollDelegate <NSObject>
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end