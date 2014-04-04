//
//  Request.h
//

#import <Foundation/Foundation.h>


@protocol RequestDelegate;
@interface Request : NSObject
{
    NSURLConnection *conn;
    NSMutableData *webData;
    id<RequestDelegate>delegate;
    int RequestId;
    NSString *a,*b;
    NSMutableArray *DataArray;
     NSString *jsonString;
}
@property(nonatomic,retain)id<RequestDelegate>delegate;
-(void)request:(NSString *)Action Parameter:(NSString *)parameter ;
-(void)postRequest:(NSString*)dictStr url:(NSString*)urlstr;

@end

@protocol RequestDelegate <NSObject>
-(void)getResult:(id)jsonData;
-(void)getError:(id)error;
@end