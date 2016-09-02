//
//  ISAPIManager.m
//  Antilog Vacations
//
//  Created by Arshdeep Singh on 15/06/15.
//  Copyright (c) 2015 Rootfly Infotech. All rights reserved.
//

#import "ISAPIManager.h"
#import "Constants.h"

@implementation ISAPIManager

+ (id)sharedInstance
{
    static ISAPIManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ISAPIManager alloc] init];
    });
    
    return _sharedClient;
}


//>>    Post API Call
- (void)POST:(NSString *)apiUrl parameters:(NSDictionary *)dictionary success:(void (^)(id responseObject, NSError *error))success failure:(void(^)(id responseObject, NSError *error))failure
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary != nil ? dictionary : [NSDictionary dictionary]
                                                       options:kNilOptions
                                                         error:nil];
#ifdef DEBUG
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"Data posting : %@",string);
#endif
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    dispatch_async(queue, ^{
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",K_Base_URL,apiUrl];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        //>>    Set request
        
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:jsonData];
        [request setValue:[NSString stringWithFormat:@"%ld",(long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];\
        
      //  NSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (responseData)
            {
                NSError *error;
                
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
                
                if ([json[K_Result] boolValue])
                {
                    if (error == nil)
                    {
                        success (json, nil);
                    }
                    else
                    {
                        success (nil, error);
                    }
                }
                else
                {
                    success (nil, [NSError errorWithDomain:@"You passed wrong values." code:response.statusCode userInfo:json]);
                }
            }
            else
            {
                failure (nil, [NSError errorWithDomain:error.description code:response.statusCode userInfo:nil]);
            }
        });
        
    });
}

- (void)GET:(NSString *)apiUrl parameters:(NSDictionary *)dictionary success:(void (^)(id responseObject, NSError *error))success failure:(void(^)(id responseObject, NSError *error))failure
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    dispatch_async(queue, ^{
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",K_Base_URL,apiUrl];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        //>>    Set request
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (responseData)
            {
                NSError *error;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
                if ([json[K_Result] boolValue])
                {
                    if (error == nil)
                    {
                        success (json, nil);
                    }
                    else
                    {
                        success (nil, error);
                    }
                }
                else
                {
                    success (nil, [NSError errorWithDomain:@"You passed wrong values. Please check and try again" code:response.statusCode userInfo:nil]);
                }
            }
            else
            {
                failure (nil, [NSError errorWithDomain:error.description code:response.statusCode userInfo:nil]);
            }
        });
        
    });
}

- (void)multistagePOST:(NSString *)apiUrl parameters:(NSDictionary *)dictionary attachImage:(UIImage *)image success:(void (^)(id responseObject, NSError *error))success failure:(void(^)(id responseObject, NSError *error))failure
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",K_Base_URL,apiUrl];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary != nil ? dictionary : [NSDictionary dictionary]
                                                         options:kNilOptions
                                                           error:nil];
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
#ifdef DEBUG
    NSLog(@"Data posting : %@",string);
#endif
    
    NSMutableData *dataBody = [NSMutableData data];
    
    //>>    user detail
    [dataBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"value\"\r\n\r\n%@",string] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   
    //>>    Get Image name
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"ddMMhhmmssyyyy"];
    NSString *strImgName = [NSString stringWithFormat:@"%@.jpeg",[dateFormat stringFromDate:[NSDate date]]];
    
    //>>    Image
    [dataBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataBody appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n",strImgName]] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataBody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [dataBody appendData:[NSData dataWithData:UIImagePNGRepresentation(image)]];
    [dataBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
#ifdef DEBUG
    NSLog(@"Image data length : %ld",(long)[UIImagePNGRepresentation(image) length]);
#endif
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    dispatch_async(queue, ^{
        
        NSString *strUrl = [NSString stringWithFormat:@"%@%@",K_Base_URL,apiUrl];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        //>>    Set request
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:jsonData];
        [request setValue:[NSString stringWithFormat:@"%ld",(long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-w ww-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
        
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];\
        
        NSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (responseData)
            {
                NSError *error;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
                
                if (json[K_Result])
                {
                    if (error == nil)
                    {
                        success (json, nil);
                    }
                    else
                    {
                        success (nil, error);
                    }
                }
                else
                {
                    success (nil, [NSError errorWithDomain:@"You passed wrong values." code:response.statusCode userInfo:nil]);
                }
            }
            else
            {
                failure (nil, [NSError errorWithDomain:error.description code:response.statusCode userInfo:nil]);
            }
        });
        
    });
}




@end
