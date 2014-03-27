//
//  CustomScrollView.m


#import "CustomScrollView.h"


@implementation CustomScrollView

@synthesize maindelegate;

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) 
	{
        self.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//NSLog(@"customscrollview touches began");
    if ([self.maindelegate respondsToSelector:@selector(touchesBegan:withEvent:)]) {
        [self.maindelegate touchesBegan:touches withEvent:event];
    }

}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//NSLog(@"customscrollview touches end");
    if ([self.maindelegate respondsToSelector:@selector(touchesEnded:withEvent:)]) {
        [self.maindelegate touchesEnded:touches withEvent:event];
    }
	
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//NSLog(@"customscrollview touches moved");
    if ([self.maindelegate respondsToSelector:@selector(touchesMoved:withEvent:)]) {
        [self.maindelegate touchesMoved:touches withEvent:event];
    }
	
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//NSLog(@"customscrollview touches cancelled");
    if ([self.maindelegate respondsToSelector:@selector(touchesCancelled:withEvent:)]) {
        [self.maindelegate touchesCancelled:touches withEvent:event];
    }
}	




@end
