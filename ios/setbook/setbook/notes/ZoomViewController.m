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

@interface ZoomViewController ()
@property (nonatomic, strong) IBOutlet UIImageView *mainImage;


@end

@implementation ZoomViewController

-(void) viewDidLoad {
    self.dataStatic = [[MyDataStatic alloc] init];
    
}

-(void) viewWillAppear:(BOOL)animated {
    UIImage *img = [self.dataStatic getNoteMap:[self.dataStatic getNoteId]];
    CGSize sourceFrame = [img size];
    CGRect targetFrame = _mainImage.frame;
    targetFrame.size.height = targetFrame.size.width * sourceFrame.height / sourceFrame.width;
    [self.mainImage setFrame:targetFrame];
    [self.mainImage setImage:[self.dataStatic getNoteMap:[self.dataStatic getNoteId]]];
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
    
   
}

@end
