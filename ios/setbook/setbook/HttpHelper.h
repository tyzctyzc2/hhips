//
//  HttpHelper.h
//  setbook
//
//  Created by Steve Wang on 2018/5/8.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject {
}

- (NSString *)getNextActiveProblem;
- (NSString *)getNextActiveProblemInPaper: (NSString *) paperID;
- (NSString *)getActivePaper;

- (Boolean) postProblemAnswer: (NSString *) problemID pID: (NSString *) problemDetail base64: (NSString *) paperProblemID pPID: (int) passSecond;
- (Boolean) doPostProblemAnswerBody: (NSString *) postString;

- (Boolean) postProblemGiveup: (NSString *)problemID pID: (NSString *)paperProblemID pPID:(int) passSecond ;
- (NSString *)getJSONResponse: (NSString *) url;

- (NSString *)getTimeString ;

-(NSString *)getWWWResponse: (NSString *)url;
-(Boolean) postData: (NSString *)url txt: (NSString *) body;

@end
