//
//  FirstViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "IconViewController.h"
#import "HttpHelper.h"
#import "MyDataStatic.h"

@interface IconViewController ()
//@property (nonatomic, strong) IBOutlet UIButton *backButton;
@end


@implementation IconViewController
MyDataStatic *dataStaticM;
int imgSizeX = 120;
int imgSizeY = 120;

-(void)viewDidLoad {
    dataStaticM = [[MyDataStatic alloc] init];
    [dataStaticM setHookedController:self];
}

- (IBAction)goZoomButtonTouch:(id)sender {
    [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModePrimaryHidden];
    
    [self performSegueWithIdentifier:@"zoom" sender:self];
}

-(void) updateToPicked:(NSString *)picked {
    NSLog(@"get chapter notes %@", picked);
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    HttpHelper *httpH = [HttpHelper new];
    NSString *fullResponse = [httpH getJSONResponse:[NSString stringWithFormat:@"/note/allchapternotes?chapterid=%@", picked]];
    
    NSData *jsonData = [fullResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    CGFloat screenWidth = self.view.frame.size.width;
    
    int countPerColumn = 5;
    int slotX = (screenWidth - countPerColumn * imgSizeX) / (countPerColumn + 1);
    if (slotX < 0) {
        countPerColumn = 4;
        slotX = (screenWidth - countPerColumn * imgSizeX) / (countPerColumn + 1);
    }
    
    int xStep = imgSizeX + slotX;
    int yStep = imgSizeY + 10;
    
    int row = 0;
    int column = 0;
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        
        for(NSString *item in jsonArray) {
            NSString *img = [item valueForKey:@"chapternotedetail"];
            id _Nullable ppid =[item valueForKey:@"idchapternote"];
            NSNumber *idN = [NSNumber numberWithInt:[ppid intValue]];
            
            [self createIcon:idN.intValue :img :slotX+column*xStep :100+row*yStep];
            
            column++;
            if (column == countPerColumn) {
                column = 0;
                row = row + 1;
            }
        }
    }
}

-(IBAction)iconTouched:(UIImageView *)sender {
    NSLog(@"one icon picked..");
    NSLog(@"%ld----", (long)sender.tag);
    [dataStaticM setNoteId: [[NSNumber alloc] initWithInt:(long)sender.tag]];
    
    [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModePrimaryHidden];
    
    [self performSegueWithIdentifier:@"zoom" sender:self];
}

-(void)createIcon:(int)imgId: (NSString *)img: (int)posX: (int)posY {
    
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:img options:0];
    UIImage *ret = [UIImage imageWithData:nsdataFromBase64String];
    [dataStaticM setNoteMap:imgId noteId:ret];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(posX, posY, imgSizeX, imgSizeY)];
    [button setImage:ret forState:UIControlStateNormal];
    
    [button setTag:imgId];
    
    [button addTarget:self action:@selector(iconTouched:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

@end
