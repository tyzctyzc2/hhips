//
//  ViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/3/28.
//  Copyright © 2018年 Steve Wang. All rights reserved.
//

#import "ViewController.h"
#import "PaperSelectController.h"

@interface ViewController () {
    int totalLearnTimeToday;
}

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UILabel *todayLabel;


@end

@implementation ViewController

- (void)ViewController {
    totalLearnTimeToday = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.startButton.layer.borderWidth =2.0f;
    self.startButton.layer.borderColor= self.view.tintColor.CGColor;
    self.startButton.layer.cornerRadius=16.0f;
    
    int mins,secs;
    mins=totalLearnTimeToday/60;
    secs=totalLearnTimeToday%60;
    NSString *timeString =[NSString stringWithFormat:@"%02d:%02d",mins,secs];
    self.todayLabel.text = timeString;
    
}
- (IBAction)buttonTouch:(id)sender {
    NSLog(@"touch uppppp");
    
    /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Puzzle" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Puzzle"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];*/
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PaperSelect" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PaperSelect"];
    PaperSelectController *psc = (PaperSelectController *)vc;
    
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
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



- (IBAction)buttonStart:(id)sender {
    NSLog(@"handleButtonClick");
}

- (void)updateTodayLearnTime:(int)moreTime {
    totalLearnTimeToday = totalLearnTimeToday + moreTime;
}
@end
