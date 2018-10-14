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
}

-(UIImage *)getNoteMap:(int)noteId {
    return notesImgMap[@(noteId)];
}

-(void)clearNoteMap {
    
}
@end
