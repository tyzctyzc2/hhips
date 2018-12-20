//
//  FirstViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "FirstViewController.h"
#import "ui/BarAlertController.h"
#import "paper/PaperFileHelper.h"
#import "HttpHelper.h"

@interface FirstViewController ()
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *changePaperButton;

@property (strong, nonatomic) IBOutlet UIButton *changeOnLineButton;

@property PaperFileHelper *myPaperHelper;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:true];
    [super beautyButton:_startButton];
    [super beautyButton:_changePaperButton];
    [super beautyButton:_changeOnLineButton];
    
    self.myPaperHelper = [[PaperFileHelper alloc]init];
    
    [self updateConnectStatus];
}

-(void)updateConnectStatus {
    BOOL onLineMode = [self.myPaperHelper getOnLineMode];
    
    if (onLineMode == true) {
        [self.changeOnLineButton setTintColor:[UIColor greenColor]];
        self.changeOnLineButton.layer.backgroundColor = [UIColor blueColor].CGColor;
        [self.changeOnLineButton setTitle:@"On Line" forState:UIControlStateNormal];
    }
    else {
        [self.changeOnLineButton setTintColor:[UIColor redColor]];
        self.changeOnLineButton.layer.backgroundColor = [UIColor redColor].CGColor;
        [self.changeOnLineButton setTitle:@"Off Line" forState:UIControlStateNormal];
    }
}

- (IBAction)changeOnLineTouch:(id)sender {
    NSLog(@"changeOnLineTouch...");
    if ([self->_myPaperHelper getOnLineMode] == true) {
        [self confirmOffLine];
    }
    else {
        [self confirmOnLine];
    }
}

- (void)confirmOffLine {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"进入离线模式"message:@"进入离线模式，需要下载全部卷卷，确定吗？"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self downloadAllPaper];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)confirmOnLine {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"进入在线模式"message:@"进入在线模式，需要提交全部本地工作，确定吗？"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self uploadAllWork];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)uploadAllWork {
    BarAlertController * bar = [BarAlertController alertControllerWithTitle:@"lalala" message:@"0 %" preferredStyle:UIAlertControllerStyleAlert];
    [bar setTitle:@"Uploading ....."];
    
    
    [self presentViewController:bar animated:YES completion:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // update UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *allId = [self.myPaperHelper getOffLineWorkList];
            
            for(int i=0; i < allId.count; ++i) {
                NSString *cur = [allId objectAtIndex:i];
                [self.myPaperHelper uploadWork:cur];
                
                float p = (float)(i+1)/(float)allId.count;
                [bar updateProgress:p];
            }
            [self dismissViewControllerAnimated:true completion:nil];
            
            [self.myPaperHelper setOnLineMode:true];
            [self updateConnectStatus];
        });
        
    });
}

-(void)downloadAllPaper {
    BarAlertController * bar = [BarAlertController alertControllerWithTitle:@"lalala" message:@"0 %" preferredStyle:UIAlertControllerStyleAlert];
    [bar setTitle:@"Downloading ....."];
    
    
    [self presentViewController:bar animated:YES completion:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // update UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *allId = [self.myPaperHelper getOnLinePaperIdList];
            
            for(int i=0; i < allId.count; ++i) {
                NSString *cur = [allId objectAtIndex:i];
                [self.myPaperHelper downloadPaper:cur];
                
                float p = (float)(i+1)/(float)allId.count;
                [bar updateProgress:p];
            }
            [self dismissViewControllerAnimated:true completion:nil];
            
            [self.myPaperHelper setOnLineMode:false];
            [self updateConnectStatus];
            
            [self.myPaperHelper listAllFile];
        });
        
    });
}

@end
