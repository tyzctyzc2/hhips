//
//  HttpHelper.m
//  setbook
//
//  Created by Steve Wang on 2018/5/8.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "HttpHelper.h"

NSString *const baseUrl=@"http://%@:8080/hhipsair/";

@implementation HttpHelper
- (NSString *)getNextActiveProblemInPaper: (NSString *) paperID {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *address = [userDefaults objectForKey:@"serveraddress_preference"];
    NSString *baseAddress = [NSString stringWithFormat:baseUrl ,address];
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@%@", baseAddress ,@"Problem?active=5&idpaper=", paperID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:fullUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/json"
   forHTTPHeaderField:@"Content-type"];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSInteger myInteger = [responseCode statusCode];
        NSLog(@"Error getting next problem , HTTP status code %d", (int)myInteger);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (NSString *)getNextActiveProblem {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *address = [userDefaults objectForKey:@"serveraddress_preference"];
    NSString *baseAddress = [NSString stringWithFormat:baseUrl ,address];
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", baseAddress ,@"Problem?active=5"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:fullUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/json"
   forHTTPHeaderField:@"Content-type"];
        
        NSError *error = nil;
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSInteger myInteger = [responseCode statusCode];
            NSLog(@"Error getting next problem , HTTP status code %d", (int)myInteger);
            return nil;
        }
        
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];

}

-(NSString *)getJSONResponse:(NSString *)url {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *address = [userDefaults objectForKey:@"serveraddress_preference"];
    NSString *baseAddress = [NSString stringWithFormat:baseUrl ,address];
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", baseAddress ,url];
    NSLog(fullUrl);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:fullUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/json"
   forHTTPHeaderField:@"Content-type"];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSInteger myInteger = [responseCode statusCode];
        NSLog(@"Error getting getJSONResponse , HTTP status code %d", (int)myInteger);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (NSString *)getActivePaper {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *address = [userDefaults objectForKey:@"serveraddress_preference"];
    NSString *baseAddress = [NSString stringWithFormat:baseUrl ,address];
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", baseAddress ,@"Paper/active"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:fullUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/json"
   forHTTPHeaderField:@"Content-type"];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSInteger myInteger = [responseCode statusCode];
        NSLog(@"Error getting next problem , HTTP status code %d", (int)myInteger);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    
}

- (NSString *)getTimeString {
    NSDate * now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd' 'HH:mm:ss"];
    NSString *newDateString = [dateFormatter stringFromDate:now];
    return newDateString;
}

- (Boolean) doPostProblemAnswerBody: (NSString *) postString {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *address = [userDefaults objectForKey:@"serveraddress_preference"];
    NSString *baseAddress = [NSString stringWithFormat:baseUrl ,address];
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", baseAddress ,@"Work"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:fullUrl]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/json"
   forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSInteger myInteger = [responseCode statusCode];
        NSLog(@"Error post work , HTTP status code %d", (int)myInteger);
        NSLog(@"%@", oResponseData);
        return false;
    }
    return true;
}

- (Boolean) postProblemAnswer: (NSString *) problemID pID: (NSString *) problemDetail base64: (NSString *) paperProblemID pPID: (int) passSecond {
    NSString *postString =[NSString stringWithFormat:@"{\"workdate\":\"%@\",\"idproblem\":%@,\"usedtime\":\"%d\",\"paperproblemid\":\"%@\",\"workdetail\":\"%@\"}", [self getTimeString], problemID ,passSecond,paperProblemID, problemDetail];
    
    return [self doPostProblemAnswerBody:postString];
}

- (Boolean) postProblemGiveup: (NSString *)problemID pID: (NSString *)paperProblemID pPID:(int) passSecond {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *address = [userDefaults objectForKey:@"serveraddress_preference"];
    NSString *baseAddress = [NSString stringWithFormat:baseUrl ,address];
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", baseAddress ,@"Work"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:fullUrl]];
    NSString *postString =[NSString stringWithFormat:@"{\"workdate\":\"%@\",\"idproblem\":%@,\"usedtime\":\"%d\",\"paperproblemid\":\"%@\"}", [self getTimeString], problemID, passSecond ,paperProblemID];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/json"
   forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSInteger myInteger = [responseCode statusCode];
        NSLog(@"Error post work , HTTP status code %d", (int)myInteger);
        NSLog(@"%@", oResponseData);
        return false;
    }
    
    return true;
}
@end
