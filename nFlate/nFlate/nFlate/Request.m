//
//  Request.m
//

#import "Request.h"
#import "JSONKit.h"
@implementation Request
@synthesize delegate;


-(void)request:(NSString *)Action Parameter:(NSString *)parameter 
{
    if (!validateNetwork(self))
    {
        NSString *queryForServer=[NSString stringWithFormat:@"%@%@",Action,parameter];
       
        
        NSLog(@"%@",queryForServer);
        
        NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:queryForServer]
                                                                       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                                   timeoutInterval:120];
        conn = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
        [urlRequest setHTTPMethod:@"GET"];
        
        if(conn)
        {
            
            webData = [[NSMutableData alloc] init];
        }
        else
        {
            [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
            NSLog(@"theConnection is NULL");
        }
    }else
    {
        [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (error!=nil) {
        if ([self.delegate conformsToProtocol:@protocol(RequestDelegate)])
        {
            if ([self.delegate respondsToSelector:@selector(getError:)])
            {
                [self.delegate getError:error];
            }
        }
    }
}

-(NSString *)JSONString:(NSString *)aString
{
    if ([aString hasPrefix:@"\""] && [aString length] > 1) {
        aString = [aString substringFromIndex:1];
    }
    
    if ([aString hasSuffix:@"\""] && [aString length] > 1) {
        aString = [aString substringToIndex:[aString length]-1];
    }
    
    return [NSString stringWithString:aString];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    responseString = [self JSONString:responseString];
    
    NSError *e = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
    
    
    if ([self.delegate conformsToProtocol:@protocol(RequestDelegate)])
    {
        if ([self.delegate respondsToSelector:@selector(getResult:)])
        {
            [self.delegate getResult:JSON];
        }
    }
}
@end
