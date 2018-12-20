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
    
    UIImageView *tickerShowImg;
    UIImageView *tickerHideImg;
    
    NSTimer *timer;
    int timeTick;
    int maxTick;
    NSDate *startTime;
}

@end

@implementation MyBaseViewController
static NSString* wantPaperId = @"";
static NSString* sProblemId = @"";
static NSString* sPaperProblemId = @"";
static int  sPassTicks = 0;

-(void)updateToPicked:(NSString *)picked {
    NSLog(@"base updateToPicked called");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *cl =  NSStringFromClass([self class]);
    NSLog(@"viewWillAppear -- %@", cl);
    
    maxTick = 5;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *cl =  NSStringFromClass([self class]);
    NSLog(@"viewWillDisappear -- %@", cl);
}

- (void)setPaperID:(NSString *)paperID {
    wantPaperId = paperID;
}
-(NSString *)getPaperID {
    return wantPaperId;
}
- (void)setProblemId:(NSString *)problemId {
    sProblemId = problemId;
}
- (NSString *)getProblemId {
    return sProblemId;
}

- (void)setPaperProblemId:(NSString *)paperProblemId {
    sPaperProblemId = paperProblemId;
}
- (NSString *)getPaperProblemId {
    return sPaperProblemId;
}

- (void)setPassTicks:(int)passTicks {
    sPassTicks = passTicks;
}
- (int)getPassTicks {
    return sPassTicks;
}

- (void)beautyButton:(UIButton *)button {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    int h = button.frame.size.height;
    CGRect s = button.frame;
    s.size.width = s.size.height * 8;
    if (screenHeight < 400)
    {
        s.size.width = s.size.width / 2;
        s.size.height = s.size.height / 2;
        [button setFrame:s];
    }
    button.layer.borderWidth =0.0f;
    button.layer.backgroundColor = self.view.tintColor.CGColor;
    [button setTitleColor:[UIColor colorWithRed:254/255.0 green:254/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:h/3];
    button.layer.cornerRadius=h/2;
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
    //[self dismissViewControllerAnimated:false completion:nil];
    [self.navigationController popToRootViewControllerAnimated:false];
}

- (void)showFlashImage:(UIImageView *)image2Show :(UIImageView *)image2Hide {
    if (image2Hide != nil) {
        image2Hide.hidden = true;
    }
    tickerShowImg = image2Show;
    tickerHideImg = image2Hide;
    image2Show.hidden = false;
    startTime = [NSDate date];
    
    timeTick = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showImageTicker) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)showImageTicker{
    NSDate *curDate = [NSDate date];
    NSTimeInterval dif = [curDate timeIntervalSinceDate:startTime];
    timeTick = (int) lroundf(dif);
    
    if (timeTick > maxTick) {
        tickerShowImg.hidden = true;
        tickerShowImg = nil;
        if (tickerHideImg !=nil) {
            tickerHideImg.hidden = false;
            tickerHideImg = nil;
        }
        [timer invalidate];
    }
    
}

@end
