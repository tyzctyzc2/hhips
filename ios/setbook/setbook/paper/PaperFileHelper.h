//
//  FileHelper.h
//  setbook
//
//  Created by Steve Wang on 2018/11/3.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaperFileHelper : NSObject
-(BOOL) getOnLineMode;
-(void)setOnLineMode: (BOOL) newMode;

-(void)listAllFile;

-(NSArray *)getOnLinePaperIdList;
-(void)downloadPaper: (NSString *)paperId;

-(NSArray *)getOffLineWorkList;
-(Boolean)uploadWork: (NSString *)workFileName;

-(NSString *)getNextActiveProblem: (NSString *)paperId;
-(NSString *)getPaperList;

- (Boolean) postProblemAnswer: (NSString *) problemID pID: (NSString *) problemDetail base64: (NSString *) paperProblemID pPID: (int) passSecond;
- (Boolean) postProblemGiveup: (NSString *) problemID pID: (NSString *) paperProblemID pPID: (int) passSecond;

-(void) postApplicationStatus: (NSString *) status s: (NSString *) parameter;

@property NSString *rootPathName;
@end

NS_ASSUME_NONNULL_END
