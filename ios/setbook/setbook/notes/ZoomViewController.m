//
//  FirstViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "ZoomViewController.h"
#import "HttpHelper.h"
#import "MyDataStatic.h"

@interface ZoomViewController (){
    UISwipeGestureRecognizer *rightSwipe, *leftSwipe;
}
@property (nonatomic, strong) IBOutlet UIImageView *mainImage;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

@implementation ZoomViewController

-(void) viewDidLoad {
    self.dataStatic = [[MyDataStatic alloc] init];
    
    leftSwipe = [[UISwipeGestureRecognizer alloc ]initWithTarget:self action:@selector(handleRightSwipe:)];
    
    leftSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.scrollView addGestureRecognizer:leftSwipe];
    
    rightSwipe = [[UISwipeGestureRecognizer alloc ]initWithTarget:self action:@selector(handleLeftSwipe:)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.scrollView addGestureRecognizer:rightSwipe];
}

- (void)handleRightSwipe:(UISwipeGestureRecognizer *)swipeGesture {
    NSLog(@"swip to right");
}

- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)swipeGesture {
    NSLog(@"swip to left");
    BOOL moved = [self.dataStatic moveToNextNote];
    if (moved) {
        [self updateNoteImage];
    }
    
}

-(void) viewWillAppear:(BOOL)animated {
    [self updateNoteImage];
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
   
}

-(void) updateNoteImage {
    UIImage *img = [self.dataStatic getNoteMap:[self.dataStatic getNoteId]];
    CGSize sourceFrame = [img size];
    CGRect targetFrame = _mainImage.frame;
    targetFrame.origin.x = 0;
    targetFrame.size.width = sourceFrame.width;
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    if (targetFrame.size.width > screenSize.width) {
        targetFrame.size.width = screenSize.width;
    }
    targetFrame.size.height = targetFrame.size.width * sourceFrame.height / sourceFrame.width;
    targetFrame.origin.y = 0;
    [self.mainImage setFrame:targetFrame];
    [self.mainImage setImage:[self.dataStatic getNoteMap:[self.dataStatic getNoteId]]];
    
    CGSize ff = CGSizeMake(targetFrame.size.width, targetFrame.size.height + 10);
    [self.scrollView setContentSize:ff];
}

@end
