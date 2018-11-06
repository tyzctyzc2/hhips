//
//  PaperSelectController.h
//  setbook
//
//  Created by Steve Wang on 2018/7/14.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "PaperSelectController.h"
#import "MyBaseViewController.h"
#import "MyDataStatic.h"
#import "HttpHelper.h"
#import "paper/PaperFileHelper.h"

@interface PaperSelectController () {
    NSString *idpapers[5];
    MyDataStatic *dataStaticM;
    PaperFileHelper *myPaperHelper;
}

@end

@implementation PaperSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    myPaperHelper = [[PaperFileHelper alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getActivePaper];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)getActivePaper {
    NSString *res = [myPaperHelper getPaperList];
    
    NSData *jsonData = [res dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        int i = 0;
        CGFloat xPos = 100;
        CGFloat buttonWidth = UIScreen.mainScreen.bounds.size.width - xPos * 2;
        CGFloat buttonHight = 80;
        CGFloat buttonSlot = 30;
        
        for(NSString *item in jsonArray) {
            NSLog(@"Item: %@", item);
            
            NSData *jsonData = [item dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
            
            NSString *name = [jsonObject valueForKey:@"papername"];
            id _Nullable ppid =[jsonObject valueForKey:@"idpaper"];
            id _Nullable problemCnt =[jsonObject valueForKey:@"totalproblem"];
            id _Nullable doneCnt =[jsonObject valueForKey:@"totaldone"];
            NSString *myID = [NSString stringWithFormat:@"%@", ppid];
            name = [NSString stringWithFormat:@"%@ (%@/%@)", name, problemCnt, doneCnt];
            //idpapers[i] = myID;
            i++;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:name forState:UIControlStateNormal];
            CGRect      buttonFrame = btn.frame;
            buttonFrame.size = CGSizeMake(buttonWidth, buttonHight);
            buttonFrame.origin = CGPointMake(xPos, buttonSlot + (i-1)*(buttonSlot+buttonHight));
            [btn setFrame:buttonFrame];
            
            [btn setTag:[myID intValue]];
            [btn addTarget:self action:@selector(paperPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:btn];
            [super beautyButton:btn];
        }
        
        CGSize ff = CGSizeMake(UIScreen.mainScreen.bounds.size.width, i*(buttonSlot+buttonHight) + buttonSlot);
        UIScrollView *vv = (UIScrollView *)self.view;
        [vv setContentSize:ff];
    }
    
}

- (IBAction)paperPressed:(UIButton *)sender {
    //will switch to next controller
    NSLog(@"%d----", sender.tag);
    NSString *myID = [NSString stringWithFormat:@"%d", sender.tag];
    MyBaseViewController *bv = [[MyBaseViewController alloc] init];
    [bv setPaperID:myID];
    [self performSegueWithIdentifier:@"problem" sender:self];
}

- (UIViewController *)updateMainPaperID:(NSString *)paperID {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Study"];
    MyBaseViewController *mv = (MyBaseViewController *)vc;
    [mv setPaperID:paperID];
    return vc;
}

-(void)paperPicked:(NSString *) paperID {
    [self updateMainPaperID:paperID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
