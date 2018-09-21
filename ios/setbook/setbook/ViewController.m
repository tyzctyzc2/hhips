//
//  ViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/3/28.
//  Copyright © 2018年 Steve Wang. All rights reserved.
//

#import "ViewController.h"
#import "PaperSelectController.h"
#import "PuzzleController.h"

static NSString *targetPaperId;

@interface ViewController () {
    int totalLearnTimeToday;
    
}

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UILabel *todayLabel;
@property (strong, nonatomic) IBOutlet UIButton *changePaperButton;
@property (strong, nonatomic) IBOutlet UIButton *lifeButton;


@end

@implementation ViewController

- (void)ViewController {
    totalLearnTimeToday = 0;
    targetPaperId = @"";
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight; // or Right of course
}

-(BOOL)shouldAutorotate
{
    NSLog(@"shouldAutorotate");
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    NSLog(@"supportedInterfaceOrientations");
    return UIInterfaceOrientationMaskLandscapeRight;
}
/*
- (void)updateLayoutsForCurrentOrientation:(UIInterfaceOrientation)toInterfaceOrientation view:(UIView *)view {
    CGAffineTransform transform = CGAffineTransformIdentity;
    view.transform = transform;
    
    NSLog(@"updateLayoutsForCurrentOrientation");
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation
                                         duration:(NSTimeInterval)duration {
    NSLog(@"qqqqqqqqqqqq");
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    NSLog(@"deviceOrientationDidChange");
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self willRotateToInterfaceOrientation:orientation duration:1.0];
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    
    [super beautyButton:_startButton];
    [self beautyButton:_changePaperButton];
    [self beautyButton:_lifeButton];
    //_lifeButton.hidden = true;
    
    int mins,secs;
    mins=totalLearnTimeToday/60;
    secs=totalLearnTimeToday%60;
    NSString *timeString =[NSString stringWithFormat:@"%02d:%02d",mins,secs];
    self.todayLabel.text = timeString;
    
    //UINavigationController *controllerChain = [[UINavigationController alloc] initWithRootViewController:self];
    //[super setControllerChain:controllerChain];
    
}

- (void)goToSelectPaper {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PaperSelect" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PaperSelect"];
    PaperSelectController *psc = (PaperSelectController *)vc;
    
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (IBAction)buttonTouch:(id)sender {
    NSLog(@"touch start button");
    
    if (targetPaperId.length > 0)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Puzzle" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Puzzle"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        PuzzleController *pc = (PuzzleController *)vc;
        [pc setPaperID:targetPaperId];
        
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else
    {
        [self goToSelectPaper];
    }
}

- (void)setPaperID:(NSString *)paperID {
    targetPaperId = paperID;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonClick:(id)sender {
    NSLog(@"handleButtonClick");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
}

- (IBAction)changePaperButtonTouch:(id)sender {
    [self goToSelectPaper];
}
- (IBAction)lifeButtonTouch:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LifeSelect" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LifeSelect"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    MyBaseViewController *pc = (MyBaseViewController *)vc;
    
    [self presentViewController:vc animated:NO completion:NULL];
    
}


- (IBAction)buttonStart:(id)sender {
    NSLog(@"handleButtonClick");
}

- (void)updateTodayLearnTime:(int)moreTime {
    totalLearnTimeToday = totalLearnTimeToday + moreTime;
}
@end
