//
//  FirstViewController.h
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"

@interface MyDataStatic :NSObject {
    int pickedNoteId;
}

-(void) setHookedController:(MyBaseViewController *)_controller;
-(MyBaseViewController *) getHookedController;

-(void) setChapterId:(NSString *)_chapterId;
-(NSString *) getChapterId;

-(void) setNoteId:(NSNumber *)_nodeId;
-(int)getNoteId;

//notes map
-(void) setNoteMap: (int)noteId noteId : (UIImage *) img;
-(UIImage *) getNoteMap: (int)noteId;
-(void) clearNoteMap;
-(BOOL) moveToNextNote;

@end

