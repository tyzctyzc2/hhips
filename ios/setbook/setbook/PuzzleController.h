//
//  NextController.h
//  setbook
//
//  Created by Steve Wang on 01/04/2018.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"

@interface PuzzleController : MyBaseViewController {
     NSString *myProbelmID;
    NSString *myPaperProblemID;
    
}
- (IBAction)buttonStart:(id)sender;

@end

