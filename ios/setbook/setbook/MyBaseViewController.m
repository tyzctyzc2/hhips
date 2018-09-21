//
//  NSObject+MyBaseViewController.h
//  setbook
//
//  Created by Steve Wang on 2018/7/15.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "MyBaseViewController.h"


@interface MyBaseViewController () {
    MyBaseViewController *controllerChain;
}

@end

@implementation MyBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *cl =  NSStringFromClass([self class]);
    NSLog(@"viewWillAppear%@", cl);
}

- (void)setPaperID:(NSString *)paperID {
    wantPaperId = paperID;
}

- (void)beautyButton:(UIButton *)button {
    button.layer.borderWidth =2.0f;
    button.layer.borderColor= self.view.tintColor.CGColor;
    button.layer.cornerRadius=16.0f;
}

-(void)beautyCancelButton:(UIButton *)button {
    button.layer.cornerRadius=40.0f;
    button.clipsToBounds=true;
    button.layer.backgroundColor = self.view.tintColor.CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGRect      buttonFrame = button.frame;
    buttonFrame.size = CGSizeMake(80, 80);
    buttonFrame.origin = CGPointMake(screenWidth-100, screenHeight-100);
    button.frame = buttonFrame;
}

-(void)beautyStartButton:(UIButton *)button {
    button.layer.cornerRadius=80;
    button.clipsToBounds=true;
    button.layer.backgroundColor = self.view.tintColor.CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGRect      buttonFrame = button.frame;
    buttonFrame.size = CGSizeMake(160, 160);
    buttonFrame.origin = CGPointMake(screenWidth-200, screenHeight-500);
    button.frame = buttonFrame;
}

- (void) switchToMain {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:NO completion:NULL];
}

@end
