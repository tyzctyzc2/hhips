//
//  FileHelper.m
//  setbook
//
//  Created by Steve Wang on 2018/11/3.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "PaperFileHelper.h"
#import "HttpHelper.h"

@interface PaperFileHelper () {
    HttpHelper *myHttpHelper;
    NSString *settingFileName;
}

@end

@implementation PaperFileHelper

static BOOL isOnLineMode = true;

- (id) init {
    self = [super init];
    myHttpHelper = [[HttpHelper alloc] init];
    self.rootPathName = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/"];
    settingFileName = @"setting";
    [self loadSetting];
    return self;
}

-(void)setOnLineMode: (BOOL) newMode {
    isOnLineMode = newMode;
    //to do , save to file
    [self saveSetting];
}
-(BOOL)getOnLineMode {
    return isOnLineMode;
}

-(void)saveSetting {
    NSString * setting = @"true";
    if (isOnLineMode == false) {
        setting = @"false";
    }
    [self saveFile:settingFileName fileBody:setting];
}

-(void)loadSetting {
    NSString *setting = [self loadFile:settingFileName];
    
    if ([setting containsString:@"false"] == true) {
        isOnLineMode = false;
    }
    else {
        isOnLineMode = true;
    }
}

-(NSString *)getPaperList {
    if (isOnLineMode == true) {
        HttpHelper *httpH = [HttpHelper new];
        NSString *res = [httpH getActivePaper];
        return res;
    }
    
    NSString *fileName = [NSString stringWithFormat:@"paperall"];
    NSString *allPaper = [self loadFile:fileName];
    
    [self listAllFile];
    
    return allPaper;
}

- (NSString *)getNextActiveProblem:(NSString *)paperId {
    if (isOnLineMode == true) {
        HttpHelper *httpH = [HttpHelper new];
        NSString *res = [httpH getNextActiveProblemInPaper:paperId];
        return res;
    }
    
    NSString *nextProblem = @"";
    NSString *fileName = [NSString stringWithFormat:@"paper_%@", paperId];
    NSString *allProblem = [self loadFile:fileName];
    
    NSData *jsonData = [allProblem dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        
        for(NSString *item in jsonArray) {
            NSData *jsonData = [item dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
            
            //to do if we have work for this problem, we will pass it
            
            id _Nullable ppid =[jsonObject valueForKey:@"paperproblemid"];//paperproblemid
            NSString *workFileName =[NSString stringWithFormat:@"work_%@", ppid];
            BOOL existWork = [self isFileExist:workFileName];
            
            if (existWork == false) {
                nextProblem = item;
                break;
            }
        }
    }
    return nextProblem;
}

- (Boolean) postProblemGiveup: (NSString *) problemID pID: (NSString *) paperProblemID pPID: (int) passSecond {
    if (isOnLineMode == true) {
        return [self->myHttpHelper postProblemGiveup:problemID pID:paperProblemID pPID:passSecond];
    }
    
    NSString *postString =[NSString stringWithFormat:@"{\"workdate\":\"%@\",\"idproblem\":%@,\"usedtime\":\"%d\",\"paperproblemid\":\"%@\"}", [self->myHttpHelper getTimeString], problemID, passSecond ,paperProblemID];
    NSString *fileName = [NSString stringWithFormat:@"work_%@", paperProblemID];
    [self saveFile:fileName fileBody:postString];
    
    return true;
}

- (Boolean) postProblemAnswer: (NSString *) problemID pID: (NSString *) problemDetail base64: (NSString *) paperProblemID pPID: (int) passSecond {
    if (isOnLineMode == true) {
        return [self->myHttpHelper postProblemAnswer:problemID pID:problemDetail base64:paperProblemID pPID:passSecond];
    }
    
    NSString *postString =[NSString stringWithFormat:@"{\"workdate\":\"%@\",\"idproblem\":%@,\"usedtime\":\"%d\",\"paperproblemid\":\"%@\",\"workdetail\":\"%@\"}", [self->myHttpHelper getTimeString], problemID ,passSecond,paperProblemID, problemDetail];
    NSString *fileName = [NSString stringWithFormat:@"work_%@", paperProblemID];
    [self saveFile:fileName fileBody:postString];
    
    return true;
}

- (NSArray *)getOnLinePaperIdList {
    [self deleteAllFile];
    [self setOnLineMode:false];
    
    HttpHelper *httpH = [HttpHelper new];
    NSString *res = [httpH getActivePaper];
    
    [self saveFile:@"paperall" fileBody:res];
    
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
            NSString *curPaperId = [NSString stringWithFormat:@"%@", ppid];
            
            
            [allIdList addObject:curPaperId];
        }
    }
    
    return allIdList;
}

-(void)downloadPaper:(NSString *)paperId {
    HttpHelper *httpH = [HttpHelper new];
    NSString *url = [NSString stringWithFormat:@"paper/allactiveproblembypaper?paperid=%@", paperId];
    NSString *fullResponse = [httpH getJSONResponse:url];
    NSString *fileName = [NSString stringWithFormat:@"paper_%@", paperId];
    
    [self saveFile:fileName fileBody:fullResponse];
}

-(NSArray *)getOffLineWorkList {
    NSArray *libraryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.rootPathName error:nil];
    NSMutableArray *allWorkNameList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<libraryContents.count; i++) {
        NSString *cur = libraryContents[i];
        if ([cur containsString:@"work"] == false) {
            continue;
        }
        
        [allWorkNameList addObject:cur];
    }
    return allWorkNameList;
}

-(Boolean) uploadWork:(NSString *)workFileName {
    NSString *body = [self loadFile:workFileName];
    return [self->myHttpHelper doPostProblemAnswerBody:body];
}

-(void)saveFile :(NSString *)fileName fileBody :(NSString *)text {
    
    NSString *filepath = [[NSString alloc] init];
    NSError *err;
    
    filepath = [self.rootPathName stringByAppendingPathComponent:fileName];
    
    NSLog(@"%@", filepath);
    
    BOOL ok = [text writeToFile:filepath atomically:YES encoding:NSUnicodeStringEncoding error:&err];
    
    if (!ok) {
        NSLog(@"Error writing file at %@\n%@",
              filepath, [err localizedFailureReason]);
    }
}

-(NSString *)loadFile :(NSString *)fileName {
    NSString *filepath = [[NSString alloc] init];
    NSError *error;
    filepath = [self.rootPathName stringByAppendingPathComponent:fileName];
    NSString *txtInFile = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUnicodeStringEncoding error:&error];
    
    if(!txtInFile)
    {
        return @"";
    }
    return txtInFile;
}

-(void)listAllFile {
    NSArray *libraryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.rootPathName error:nil];
    
    for (int i = 0; i<libraryContents.count; i++) {
        NSString *cur = libraryContents[i];
        NSLog(@"%@", cur);
    }
}

-(void)deleteAllFile {
    NSArray *libraryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.rootPathName error:nil];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    for (int i = 0; i<libraryContents.count; i++) {
        NSString *cur = libraryContents[i];
        if ([cur compare:@"setting"] == true) {
            continue;
        }
        NSLog(@"%@", cur);
        NSError *error;
        BOOL success = [fileMgr removeItemAtPath:self.rootPathName error:&error];
        
        if (success == false) {
            NSLog(@"failed when delete %@", cur);
        }
        else {
            NSLog(@"file was deleted -----%@", cur);
        }
    }
}

-(BOOL)isFileExist: (NSString *)fileName {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *filePathName = [self.rootPathName stringByAppendingPathComponent:fileName];
    
    return [fileMgr fileExistsAtPath:filePathName];
}

@end
