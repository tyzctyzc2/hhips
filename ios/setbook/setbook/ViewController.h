//
//  ViewController.h
//  setbook
//
//  Created by Steve Wang on 2018/3/28.
//  Copyright © 2018年 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)buttonStart:(id)sender;
- (void)updateTodayLearnTime:(int)moreTime;
- (void)setPaperID:(NSString *)paperID;
@end

