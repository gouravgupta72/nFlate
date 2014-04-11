//
//  Request.m
//

#import "Request.h"
#import "JSONKit.h"
#import "nFlateViewController.h"
@implementation Request
@synthesize delegate;

/**
 *  method for get request
 *
 *  @param Action    action is basic url
 *  @param parameter parameter is post to send data
 */
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

/**
 *  method for post request
 *
 *  @param dict the parameter json data to post
 */
-(void)postRequest:(NSDictionary*)dict url:(NSString*)urlstr
{
    if (!validateNetwork(self))
    {
        
        NSMutableData *data = [[NSMutableData alloc] init];
        webData = data;
        NSString *finalurl=[NSString stringWithFormat:@"%@%@",BASEURL,urlstr];
        NSURL *url=[NSURL URLWithString:finalurl];
               NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSError *err;
        
        NSData* dataRequest = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&err];
        
        [postRequest setHTTPMethod:@"POST"];
        [postRequest setValue:[NSString stringWithFormat:@"%d", dataRequest.length] forHTTPHeaderField:@"Content-Length"];
        [postRequest setValue:@"application/json charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [postRequest setHTTPBody:dataRequest];
        
        
        [postRequest setTimeoutInterval:10.0];
        
        conn = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self];
        if(conn)
        {
            
            webData = [[NSMutableData alloc] init];
        }
        else
        {
            [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];
            NSLog(@"theConnection is NULL");
        }
        
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
    if (error!=nil)
    {
        if ([self.delegate conformsToProtocol:@protocol(RequestDelegate)])
        {
            if ([self.delegate respondsToSelector:@selector(getError:)])
            {
                [self.delegate getError:error.localizedDescription];
            }
            [[nFlateAppDelegate sharedAppDelegate] removeLoadingView];

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
//    
    responseString = [self JSONString:responseString];
    
    NSError *e = nil;
   // NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:webData options: kNilOptions error: &e];
//     id result =[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding];
    
    
    if ([self.delegate conformsToProtocol:@protocol(RequestDelegate)])
    {
        if ([self.delegate respondsToSelector:@selector(getResult:)])
        {
            [self.delegate getResult:JSON];
        }
    }
}
@end
