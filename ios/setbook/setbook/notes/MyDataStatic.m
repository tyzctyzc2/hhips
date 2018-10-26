//
//  FirstViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "MyDataStatic.h"
#import "MyBaseViewController.h"

@interface MyDataStatic ()

@end

@implementation MyDataStatic
static MyBaseViewController *sHookedController;
static NSString *sChapterId;
static NSNumber *sPickedNoteId;
static NSMutableDictionary *notesImgMap;
static int allNotesId[1000];
static int notesCount;

-(void) setHookedController:(MyBaseViewController *)_controller {
    sHookedController = _controller;
}

-(MyBaseViewController *) getHookedController {
    return sHookedController;
}

-(void) setChapterId:(NSString *)_chapterId {
    sChapterId = _chapterId;
}

-(NSString *) getChapterId {
    return sChapterId;
}

-(void) setNoteId:(NSNumber *)_nodeId {
    sPickedNoteId = _nodeId;
}
-(int)getNoteId {
    return sPickedNoteId.intValue;
}

//map
-(void)setNoteMap:(int)noteId noteId:(UIImage *)img {
    if (notesImgMap == nil) {
        notesImgMap = [NSMutableDictionary dictionary];
    }
    
    notesImgMap[@(noteId)] = img;
    allNotesId[notesCount] = noteId;
    notesCount++;
}
-(UIImage *)getNoteMap:(int)noteId {
    return notesImgMap[@(noteId)];
}
-(void)clearNoteMap {
    notesImgMap = [NSMutableDictionary dictionary];
    notesCount = 0;
}
-(BOOL) moveToNextNote {
    if (notesCount == 1)
        return false;
    
    for(int i = 0; i < notesCount; ++i) {
        if (allNotesId[i] == sPickedNoteId.intValue) {
            int newId = 0;
            if (i == (notesCount - 1)) {
                newId = allNotesId[0];
            }
            else {
                newId = allNotesId[i+1];
            }
            [self setNoteId: [[NSNumber alloc] initWithInt:newId]];
            break;
        }
    }
    
    return  true;
}
@end
