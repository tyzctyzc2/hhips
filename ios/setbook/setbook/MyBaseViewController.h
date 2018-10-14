//
//  MyBaseViewController .h
//  setbook
//
//  Created by Steve Wang on 2018/7/15.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyBaseViewController : UIViewController {
    
    
}
- (void)setPaperID:(NSString *)paperID;
- (NSString *)getPaperID;

- (void)setProblemId:(NSString *)problemId;
- (NSString *)getProblemId;

- (void)setPaperProblemId:(NSString *)paperProblemId;
- (NSString *)getPaperProblemId;

- (void)setPassTicks:(int)passTicks;
- (int)getPassTicks;

- (void)beautyButton:(UIButton *)button;
- (void)switchToMain;
- (void)beautyCancelButton:(UIButton *)button;
- (void)beautyStartButton:(UIButton *)button;
- (void)showFlashImage:(UIImageView *)image2Show :(UIImageView *)image2Hide;


-(void)updateToPicked:(NSString *)picked;
@end
