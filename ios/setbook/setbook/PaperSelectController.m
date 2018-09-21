//
//  PaperSelectController.h
//  setbook
//
//  Created by Steve Wang on 2018/7/14.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "PaperSelectController.h"
#import "MyBaseViewController.h"
#import "HttpHelper.h"
#import "ViewController.h"

@interface PaperSelectController () {
    NSString *idpapers[5];
}

@property (strong, nonatomic) IBOutlet UIButton *aButton;
@property (strong, nonatomic) IBOutlet UIButton *bButton;
@property (strong, nonatomic) IBOutlet UIButton *cButton;
@property (strong, nonatomic) IBOutlet UIButton *dButton;
@property (strong, nonatomic) IBOutlet UIButton *eButton;
@end

@implementation PaperSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"PaperSelectController viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getActivePaper];
    
    [super beautyButton:_aButton];
    [super beautyButton:_bButton];
    [super beautyButton:_cButton];
    [super beautyButton:_dButton];
    [super beautyButton:_eButton];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight; // or Right of course
}

-(BOOL)shouldAutorotate
{
    //NSLog(@"PaperSelectController shouldAutorotate");
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //NSLog(@"PaperSelectController supportedInterfaceOrientations");
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)getActivePaper {
    HttpHelper *httpH = [HttpHelper new];
    NSString *res = [httpH getActivePaper];
    [_aButton setHidden:true];
    [_bButton setHidden:true];
    [_cButton setHidden:true];
    [_dButton setHidden:true];
    [_eButton setHidden:true];
    
    NSData *jsonData = [res dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        int i = 0;
        for(NSString *item in jsonArray) {
            NSLog(@"Item: %@", item);
            
            NSData *jsonData = [item dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
            
            NSString *name = [jsonObject valueForKey:@"papername"];
            id _Nullable ppid =[jsonObject valueForKey:@"idpaper"];
            NSString *myID = [NSString stringWithFormat:@"%@", ppid];
            idpapers[i] = myID;
            i++;
            switch (i) {
                case 1:
                    [_aButton setTitle:name forState:UIControlStateNormal];
                    [_aButton setHidden:false];
                    break;
                    
                case 2:
                    [_bButton setTitle:name forState:UIControlStateNormal];
                    [_bButton setHidden:false];
                    break;
                    
                case 3:
                    [_cButton setTitle:name forState:UIControlStateNormal];
                    [_cButton setHidden:false];
                    break;
                    
                case 4:
                    [_dButton setTitle:name forState:UIControlStateNormal];
                    [_dButton setHidden:false];
                    break;
                    
                case 5:
                    [_eButton setTitle:name forState:UIControlStateNormal];
                    [_eButton setHidden:false];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
}

- (IBAction)buttonATouch:(id)sender {
    NSLog(@"touch buttonATouch");
    [self paperPicked:idpapers[0]];
}

- (IBAction)buttonBTouch:(id)sender {
    NSLog(@"touch buttonBTouch");
    [self paperPicked:idpapers[1]];
    
}

- (IBAction)buttonCTouch:(id)sender {
    NSLog(@"touch buttonCTouch");
    [self paperPicked:idpapers[2]];
    
}

- (IBAction)buttonDTouch:(id)sender {
    NSLog(@"touch buttonDTouch");
    [self paperPicked:idpapers[3]];
    
}

- (IBAction)buttonETouch:(id)sender {
    NSLog(@"touch buttonETouch");
    [self paperPicked:idpapers[4]];
    
}

- (UIViewController *)updateMainPaperID:(NSString *)paperID {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    ViewController *mv = (ViewController *)vc;
    [mv setPaperID:paperID];
    return vc;
}

-(void)paperPicked:(NSString *) paperID {
    [self updateMainPaperID:paperID];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Puzzle" bundle:nil];
     UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Puzzle"];
     vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    MyBaseViewController *pc = (MyBaseViewController *)vc;
    [pc setPaperID:paperID];
    
     [self presentViewController:vc animated:YES completion:NULL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
