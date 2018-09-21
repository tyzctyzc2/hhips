//
//  PaperSelectController.h
//  setbook
//
//  Created by Steve Wang on 2018/7/14.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "LifeSelectController.h"
#import "MyBaseViewController.h"
#import "HttpHelper.h"
#import "ViewController.h"

@interface LifeSelectController () {
    NSString *idLife[30];
    int totalLife;
    NSString *fullResponse;
    
}

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation LifeSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"LifeSelectController viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
    
    if (fullResponse.length == 0)
        [self getAllLife];
    
    [self beautyCancelButton:_cancelButton];
}

int buttonSizeX = 200;
int buttonSizeY = 60;

- (void)createButton:(NSString *) buttonName: (NSString *) buttonID: (int) posX: (int) poxY {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:buttonName forState:UIControlStateNormal];
    [button sizeToFit];
    [button setTag:[buttonID intValue]];
    button.frame = CGRectMake(posX, poxY, buttonSizeX, buttonSizeY);
    [super beautyButton:button];

    button.titleLabel.font = [UIFont systemFontOfSize:40];
    
    // Add an action in current code file (i.e. target)
    [button addTarget:self action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    //will switch to next controller
    NSLog(@"%d----", sender.tag);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LifeTimeCounter" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LifeTimeCounter"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    MyBaseViewController *pc = (MyBaseViewController *)vc;
    [pc setPaperID:[NSString stringWithFormat:@"%ld", sender.tag]];
    
    [self presentViewController:vc animated:NO completion:NULL];
    
}

- (void)getAllLife {
    HttpHelper *httpH = [HttpHelper new];
    fullResponse = [httpH getJSONResponse:@"/life/counterlist"];
    
    NSData *jsonData = [fullResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        int totalButton = 0;
        int row = 0;
        int column = 0;
        int maxRow = 5;
        int maxColumn = 4;
        
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        int slotX = (screenWidth - 4 * buttonSizeX) / 5;
        
        int xStep = buttonSizeX + slotX;
        int yStep = 90;
        
        for(NSString *item in jsonArray) {
            NSLog(@"Item: %@", item);
            
            NSData *jsonData = [item dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
            
            NSString *name = [jsonObject valueForKey:@"timecounterdescription"];
            id _Nullable ppid =[jsonObject valueForKey:@"idtimecounterlookup"];
            NSString *myID = [NSString stringWithFormat:@"%@", ppid];
            totalButton++;
            
            [self createButton:name :myID :slotX+column*xStep :100+row*yStep];
            column = column + 1;
            if (column == maxColumn) {
                column = 0;
                row = row + 1;
            }
            totalButton = totalButton + 1;
            
        }
    }
    
}

-(void)lifePicked:(NSString *) pickID {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Puzzle" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Puzzle"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    MyBaseViewController *pc = (MyBaseViewController *)vc;
    [pc setPaperID:pickID];
    
    //[self presentViewController:vc animated:YES completion:NULL];
    [self.navigationController pushViewController:pc animated:NO];
    
}

- (IBAction)cancelTouch:(id)sender {
    [self switchToMain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
