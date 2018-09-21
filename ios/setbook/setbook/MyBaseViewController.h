//
//  MyBaseViewController .h
//  setbook
//
//  Created by Steve Wang on 2018/7/15.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBaseViewController : UIViewController {
    NSString *wantPaperId;
    
}
- (void)setPaperID:(NSString *)paperID;
- (void)beautyButton:(UIButton *)button;
- (void)switchToMain;
- (void)beautyCancelButton:(UIButton *)button;
- (void)beautyStartButton:(UIButton *)button;
@end
