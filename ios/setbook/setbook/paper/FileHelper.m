//
//  FileHelper.m
//  setbook
//
//  Created by Steve Wang on 2018/11/3.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "FileHelper.h"
#import "HttpHelper.h"

@implementation FileHelper
- (NSArray *)getOnLinePaperIdList {
    HttpHelper *httpH = [HttpHelper new];
    NSString *res = [httpH getActivePaper];
    
    NSMutableArray *allIdList = [[NSMutableArray alloc] init];
    
    NSData *jsonData = [res dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        
        for(NSString *item in jsonArray) {
            NSLog(@"Item: %@", item);
            
            NSData *jsonData = [item dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
            
            //NSArrayNSString *name = [jsonObject valueForKey:@"papername"];
            id _Nullable ppid =[jsonObject valueForKey:@"idpaper"];
            
            [allIdList addObject:ppid];
        }
    }
    
    return allIdList;
}

@end
