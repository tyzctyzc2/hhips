//
//  UINavigationController+gg.h
//  setbook
//
//  Created by Steve Wang on 2018/9/10.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "LifeTimeCounterController.h"
#import "HttpHelper.h"

@interface LifeTimeCounterController () {
    NSString *idLife[30];
    int totalLife;
    NSString *fullResponse;
    
    NSTimer *timer;
    BOOL inCount;
    int timeTick;
    NSDate *startTime;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *counterImg;
@property (strong, nonatomic) IBOutlet UILabel *counterText;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation LifeTimeCounterController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"LifeSelectController viewDidLoad");
    
    if (fullResponse.length == 0)
        [self getCounterDetail];
    
    inCount = false;
    timeTick = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTicker) userInfo:nil repeats:YES];
    
    [self beautyCancelButton:_cancelButton];
    [self beautyStartButton:_startButton];
}

- (void)getCounterDetail {
    HttpHelper *httpH = [HttpHelper new];
    NSString *url = [NSString stringWithFormat:@"/life/counterdetail?idtimecounterlookup=%@", wantPaperId];
    fullResponse = [httpH getJSONResponse:url];
    
    NSData *jsonData = [fullResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonObject) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {

        NSString *image = [jsonObject valueForKey:@"timecounterimage"];
        
        NSData *nsdataFromBase64String = [[NSData alloc]
                                          initWithBase64EncodedString:image options:0];
        
        UIImage *ret = [UIImage imageWithData:nsdataFromBase64String];
        
        self.counterImg.image = ret;

    }
    
}

-(void)myTicker{

    NSDate *curDate = [NSDate date];
    NSTimeInterval dif = [curDate timeIntervalSinceDate:startTime];
    timeTick = (int) lroundf(dif);
    
    int mins,secs;
    mins=timeTick/60;
    secs=timeTick%60;
    NSString *timeString =[NSString stringWithFormat:@"%02d:%02d",mins,secs];
    self.counterText.text = timeString;
    
}

- (IBAction)startTouch:(id)sender {
    if (inCount == false) {
        //start case
        startTime = [NSDate date];
        inCount = true;
        [timer fire];
        [_startButton setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else {
        //stop case
        [timer invalidate];
        inCount = false;
        [self processCounterType];
        
    }
}

- (void)processCounterType {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入成绩" message:@"请输入完成的数量" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self switchToMain];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入完成的数量";
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)cancelTouch:(id)sender {
    NSLog(@"ffffffff");

    [self switchToMain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
