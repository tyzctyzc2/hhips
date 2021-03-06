//
//  NextController.m
//  setbook
//
//  Created by Steve Wang on 01/04/2018.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "PuzzleController.h"
#import "PhotoController.h"
#import "HttpHelper.h"
#import "AppDelegate.h"
#import "paper/PaperFileHelper.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PaperSelectController.h"

@interface PuzzleController () {
    int timeTick;
    NSDate *startTime;
    NSTimer *timer;
    Boolean notAlarm;
    
    PaperFileHelper *myPaperHelper;
}

@property (strong, nonatomic) IBOutlet UIButton *giveupButton;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) IBOutlet UIImageView *problemImg;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation PuzzleController

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"PuzzleController viewDidLoad");
    self->myPaperHelper = [[PaperFileHelper alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getActiveProblemInPaper];
    
    timeTick = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTicker) userInfo:nil repeats:YES];
    startTime = [NSDate date];
    
    [self beautyButton:self.giveupButton];
    [self beautyButton:self.finishButton];
    [self beautyButton:self.cancelButton];
    
    notAlarm = false;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

-(void) viewWillDisappear:(BOOL)animated{
    NSLog(@"PuzzleController viewWillDisappear");
    [timer invalidate];
    timer = nil;
}

-(void)showToastMessage:(NSString *)message {
    
    UIAlertController *toast =[UIAlertController alertControllerWithTitle:nil
                                                                  message:message
                                                           preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:toast animated:YES completion:nil];
    
    int duration = 3; // in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissViewControllerAnimated:YES completion:nil];
    });
}

-(void)switchToPaper {
    NSLog(@"switch to paper");
    PaperSelectController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PaperSelect"];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)getActiveProblemInPaper {
    NSString *paperId = [super getPaperID];
    if (paperId == nil) {
        [self switchToPaper];
        return;
    }
    if ([paperId length]  == 0) {
        [self switchToPaper];
        return;
    }
    NSString*res = [self->myPaperHelper getNextActiveProblem:paperId];
    
    NSData *jsonData = [res dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    
    if (dic == nil) {
        [self switchToPaper];
        return;
    }
    
    NSString *token = [dic valueForKey:@"problemdetail"];
    
    id _Nullable pid =[dic valueForKey:@"idproblem"];//paperproblemid
    myProbelmID = [NSString stringWithFormat:@"%@", pid];
    
    id _Nullable ppid =[dic valueForKey:@"paperproblemid"];//paperproblemid
    myPaperProblemID =[NSString stringWithFormat:@"%@", ppid];
    
    if (pid == 0) {
        NSLog(@"No work today");
        [super switchToMain];
        return;
    }
    
    NSLog(@"got problem to go, problem ID = %@", myProbelmID);
    NSLog(@"got problem to go, problem paper ID = %@", myPaperProblemID);
    
    [myPaperHelper postApplicationStatus:@"take problem" s:myPaperProblemID];
    
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:token options:0];
    UIImage *ret = [UIImage imageWithData:nsdataFromBase64String];
    
    self.problemImg.image = ret;
}

-(void)myTicker{
    //increment the timer
    //timeTick++;
    //if we wanted to count down we could have done "timeTick--"
    
    //set a text label to display the time
    
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval dif = [curDate timeIntervalSinceDate:startTime];
    timeTick = (int) lroundf(dif);
    
    NSInteger mins,secs;
    mins=timeTick/60;
    secs=timeTick%60;
    NSString *timeString =[NSString stringWithFormat:@"%02d:%02d",mins,secs];
    self.timerLabel.text = timeString;
    
    if (timeTick > 1800)
    {
        //NSLog(@"timeTick > 1800-------");
        if (notAlarm == false)
        {
            AudioServicesPlaySystemSound(1109);
            //notAlarm = true;
        }
    }
    else if(timeTick > 1200)
    {
        //NSLog(@"timeTick > 1200-------");
        if (notAlarm == false)
        {
            AudioServicesPlaySystemSound(1103);
            //notAlarm = true;
        }
    }
}

- (IBAction)puzzleDoneTouch:(id)sender {
    [super setProblemId:myProbelmID];
    [super setPaperProblemId:myPaperProblemID];
    [super setPassTicks:timeTick];
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
    
    //UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIDeviceOrientation orientation2 = [[UIDevice currentDevice] orientation];
    if (orientation2 == UIDeviceOrientationLandscapeLeft || orientation2 == UIDeviceOrientationLandscapeRight) {
        NSLog(@"PuzzleController landscape!!!!!!!!");// portrait
    } else {
        NSLog(@"PuzzleController NOT landscape!!!!!!!!");// landscape
    }
}

- (IBAction)buttonCancleTouch:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"容朕想想"message:@"皇上你确定要换个折子批吗？活都是不好干的！"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"换折子" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self->myPaperHelper postApplicationStatus:@"back problem" s:self->myPaperProblemID];
        [self switchToMain];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) doGiveUp {
    [self switchToMain];
    
    [self->myPaperHelper postProblemGiveup:myProbelmID pID:myPaperProblemID pPID:timeTick];
}

- (IBAction)buttonGiveup:(id)sender {
    NSLog(@"buttonGiveup");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"朕要摔笔"message:@"皇上你确定要摔笔吗？母后会不高兴的！"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"摔笔" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self doGiveUp];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
