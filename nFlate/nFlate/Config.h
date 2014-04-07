//
//  Config.h
//  nFlate


#import <Foundation/Foundation.h>
#import "Reachability.h"


#define TESTING_APPLICATION YES
//#define TESTING_APPLICATION NO

//#define SERVER_DOMAIN @"http://www.CatList.php?"
#define SERVER_DOMAIN @"http://www.appfoster.com/webservices/init?"

#define FONT_11 [UIFont fontWithName:@"Qlassik Bold" size:11.0f]
#define FONT_12 [UIFont fontWithName:@"Qlassik Bold" size:12.0f]
#define FONT_13 [UIFont fontWithName:@"Qlassik Bold" size:13.0f]
#define FONT_14 [UIFont fontWithName:@"Qlassik Bold" size:14.0f]
#define FONT_15 [UIFont fontWithName:@"Qlassik Bold" size:15.0f]
#define FONT_16 [UIFont fontWithName:@"Qlassik Bold" size:16.0f]
#define FONT_18 [UIFont fontWithName:@"Qlassik Bold" size:18.0f]
#define FONT_20 [UIFont fontWithName:@"Qlassik Bold" size:20.0f]
#define FONT_22 [UIFont fontWithName:@"Qlassik Bold" size:22.0f]
#define FONT_24 [UIFont fontWithName:@"Qlassik Bold" size:24.0f]
#define FONT_25 [UIFont fontWithName:@"Qlassik Bold" size:25.0f]

#define FONT_27 [UIFont fontWithName:@"Qlassik Bold" size:27.0f]
#define FONT_28 [UIFont fontWithName:@"Qlassik Bold" size:28.0f]

#define FONT_30 [UIFont fontWithName:@"Qlassik Bold" size:30.0f]
#define FONT_35 [UIFont fontWithName:@"Qlassik Bold" size:35.0f]
#define FONT_40 [UIFont fontWithName:@"Qlassik Bold" size:40.0f]
#define FONT_42 [UIFont fontWithName:@"Qlassik Bold" size:42.0f]
#define FONT_45 [UIFont fontWithName:@"Qlassik Bold" size:45.0f]
#define FONT_50 [UIFont fontWithName:@"Qlassik Bold" size:50.0f]
#define FONT_52 [UIFont fontWithName:@"Qlassik Bold" size:52.0f]
#define FONT_55 [UIFont fontWithName:@"Qlassik Bold" size:55.0f]

#define FONT_ARIAL_BOLD_12 [UIFont fontWithName:@"Bold" size:12.0f]
#define BASEURL @"http://192.168.0.110:8888/nFlate_PHP/getViewList.php?"

#define GETVIEWURL @"http://192.168.0.110:8888/nFlate_PHP/getView_Data.php"
#define LOGINURL @"http://192.168.0.110:8888/nFlate_PHP/nfLogin.php?"



UIButton *backButton,*infoButton;
UIImageView *topImage ;


inline static unsigned long long int folderSize(NSString *folderPath)
{
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    return fileSize;
}




inline static BOOL validateNetwork (id Self)
{
    [[Reachability sharedReachability] setHostName:@"www.google.com"];
	NetworkStatus internetStatus = [[Reachability sharedReachability] remoteHostStatus];
    if (internetStatus == ReachableViaWiFiNetwork)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"WiFi" forKey:@"internetStatus"];
    }
	if((internetStatus != ReachableViaWiFiNetwork) && (internetStatus != ReachableViaCarrierDataNetwork))
	{
        
		UIAlertView  *myAlert = [[UIAlertView alloc] initWithTitle: @"No Connection" message:@"NETWORK_ERROR" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[myAlert  show];
		myAlert =nil;
		
		return YES;
	}
	
	return NO;
}


inline static void showAlert(NSString *alertTitle,NSString *alertMessage,id alertdelegate)
{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        NSArray* arrSubviews = window.subviews;
        if ([arrSubviews count] > 0)
        {
            for (UIView *cc in arrSubviews) {
                if (cc.tag == 9999) {
                    return ;
                }
            }
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:alertdelegate cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    alert.tag=9999;
    [alert show];
}


inline static UIImage *imagetinting(UIImage *img,UIColor *color)
{
    // load the image
    //    NSString *name = @"badge.png";
    //    UIImage *img = [UIImage imageNamed:name];
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}
/**
 *  enum for table type
 */
typedef enum
{
    table1=0,
    table2
}ComboBox;



/**
 *  Returns UIColor after conversion of Hex color
 *
 *  @param NSString *hex
 *
 *  @return UIColor
 */
inline static UIColor *colorWithHexString(NSString *hex)
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip " "
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
    cString=[cString stringByTrimmingCharactersInSet:charSet];
    
    //strip #
    if ([cString hasPrefix:@"#"])
    {
        cString=[cString substringFromIndex:1];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/**
 *  Returns complement UIColor after conversion of Hex color
 *
 *  @param NSString *hex
 *
 *  @return UIColor
 */
inline static UIColor *complementryColorWithHexString(NSString *hex)
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip " "
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
    cString=[cString stringByTrimmingCharactersInSet:charSet];
    
    //strip #
    if ([cString hasPrefix:@"#"])
    {
        cString=[cString substringFromIndex:1];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:1-((float) r / 255.0f)
                           green:1-((float) g / 255.0f)
                            blue:1-((float) b / 255.0f)
                           alpha:1.0f];
    
}


/**
 *  enum for request response
 */
typedef enum
{
    request1=0,
    request2,
    request3
}requestType;
# define CELL_SIZE_1 44
# define CELL_SIZE_2 55
# define MAX_DISPLAY_ROWS_TABLE_1 4
# define MAX_DISPLAY_ROWS_TABLE_2 6

inline static BOOL checkIsDictionaryValueNullOrNil(NSMutableDictionary *dict, NSString *strKey)
{
    if ([[dict valueForKey:strKey] isKindOfClass:[NSNull class]] || [dict valueForKey:strKey] == nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

