//
//  NextController.m
//  setbook
//
//  Created by Steve Wang on 01/04/2018.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "PuzzleController.h"
#import "PhotoController.h"
#import "ViewController.h"
#import "HttpHelper.h"
#import "AppDelegate.h"

@interface PuzzleController () {
    int timeTick;
    NSTimer *timer;
}

@property (strong, nonatomic) IBOutlet UIButton *giveupButton;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;

@property (strong, nonatomic) IBOutlet UIImageView *problemImg;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation PuzzleController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getActiveProblem];
    
    timeTick = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTicker) userInfo:nil repeats:YES];
    
    self.giveupButton.layer.borderWidth =2.0f;
    self.giveupButton.layer.borderColor= self.view.tintColor.CGColor;
    self.giveupButton.layer.cornerRadius=16.0f;
    
    self.finishButton.layer.borderWidth =2.0f;
    self.finishButton.layer.borderColor= self.view.tintColor.CGColor;
    self.finishButton.layer.cornerRadius=16.0f;
    
   
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

- (void)getActiveProblem {
     HttpHelper *httpH = [HttpHelper new];
     NSString *res = [httpH getNextActiveProblem];
     //NSLog(res);
     
     NSData *jsonData = [res dataUsingEncoding:NSUTF8StringEncoding];
     
     
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
     options:NSJSONReadingMutableContainers
     error:nil];
     NSString *token = [dic valueForKey:@"problemdetail"];
     
     id _Nullable pid =[dic valueForKey:@"idproblem"];//paperproblemid
     myProbelmID = [NSString stringWithFormat:@"%@", pid];
    
    id _Nullable ppid =[dic valueForKey:@"paperproblemid"];//paperproblemid
    myPaperProblemID =[NSString stringWithFormat:@"%@", ppid];
    
    if (pid == 0) {
        NSLog(@"No work today");
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:vc animated:YES completion:NULL];
        return;
    }
     
     NSLog(@"got problem to go, problem ID = %@", myProbelmID);
     NSLog(@"got problem to go, problem paper ID = %@", myPaperProblemID);
     
     NSData *nsdataFromBase64String = [[NSData alloc]
     initWithBase64EncodedString:token options:0];
     UIImage *ret = [UIImage imageWithData:nsdataFromBase64String];
     
     self.problemImg.image = ret;
}
- (IBAction)buttonTouch:(id)sender {
    NSLog(@"touch uppppp");
    
}

-(void)myTicker{
    //increment the timer
    timeTick++;
    //if we wanted to count down we could have done "timeTick--"
    
    //set a text label to display the time
    NSInteger mins,secs;
    mins=timeTick/60;
    secs=timeTick%60;
    NSString *timeString =[NSString stringWithFormat:@"%02d:%02d",mins,secs];
    self.timerLabel.text = timeString;
}

- (IBAction)puzzleDoneTouch:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Photo" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Photo"];
    PhotoController *pc = (PhotoController *)vc;
    pc.myProbelmID=myProbelmID;
    pc.myPaperProblemID = myPaperProblemID;
    pc.timerTicks = timeTick;
    
    
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



- (IBAction)buttonGiveup:(id)sender {
    NSLog(@"buttonGiveup");
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    ViewController *mv = (ViewController *)vc;
    [mv updateTodayLearnTime:timeTick];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
    
    HttpHelper *httpH = [HttpHelper new];
    [httpH postProblemGiveup:myProbelmID pID: myPaperProblemID pPID: timeTick];
}
@end
