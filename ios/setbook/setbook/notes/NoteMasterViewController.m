//
//  FirstViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "NoteMasterViewController.h"
#import "HttpHelper.h"
#import "MyBaseViewController.h"
#import "MyDataStatic.h"
#import "PaperFileHelper.h"

@interface NoteMasterViewController () {
MyDataStatic *dataStaticM;
PaperFileHelper *myPaperHelper;
}
@end

@implementation NoteMasterViewController
NSMutableArray *sourceNameList;
NSMutableArray *sourceIDList;
NSMutableArray *requiredSourceId;


- (void)viewDidLoad {
    [super viewDidLoad];
    self->myPaperHelper = [[PaperFileHelper alloc]init];
    
    if ([self->myPaperHelper getOnLineMode] == false) {
        [self showToastMessage:@"离线状态下笔记是不能工作的，回去做题吧，少年。"];
        return;
    }

    
    [self prepareData];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self->dataStaticM = [[MyDataStatic alloc] init];
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

-(void)prepareData {
    sourceNameList = [NSMutableArray new];
    sourceIDList = [NSMutableArray new];
    requiredSourceId = [NSMutableArray new];
    
    HttpHelper *httpH = [HttpHelper new];
    NSString *fullResponse = [httpH getJSONResponse:@"/source/list"];
    
    NSData *jsonData = [fullResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];

    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        
        for(NSString *item in jsonArray) {
            NSString *name = [item valueForKey:@"sourcename"];
            id _Nullable ppid =[item valueForKey:@"idsource"];
            NSNumber *idN = [NSNumber numberWithInt:[ppid intValue]];
            name = [NSString stringWithFormat:@"+%@", name];
            [sourceNameList addObject:name];
            [sourceIDList addObject:idN];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sourceNameList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.row;

    NSString *cellIdentifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    cell.textLabel.text = [sourceNameList objectAtIndex:index];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.row;
    NSNumber *thisId = [sourceIDList objectAtIndex:index];
    
    if (thisId.intValue > 0) {
        NSLog(@"source picked....");
        [self addChapter:thisId, index];
    }
    else {
        NSLog(@"chapter picked...%d", thisId.intValue);
        
        MyBaseViewController *target = [self->dataStaticM getHookedController];
        if (target != nil) {
            int chI = 0 - thisId.intValue;
            NSString *idS = [NSString stringWithFormat:@"%d", chI];
            [target updateToPicked:idS];
        }
    }
}

-(void)addChapter:(NSNumber *)parentId ,int index {
    if ([requiredSourceId containsObject:parentId] == true) {
        return;
    }
    int newIndex = index+1;
    HttpHelper *httpH = [HttpHelper new];
    NSString *url = [NSString stringWithFormat:@"/chapter/insource?sourceid=%d", parentId.intValue];
    NSString *fullResponse = [httpH getJSONResponse:url];
    
    NSData *jsonData = [fullResponse dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingMutableContainers error: &e];
    
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        
        for(NSString *item in jsonArray) {
            NSString *name = [item valueForKey:@"sourcechaptername"];
            id _Nullable ppid =[item valueForKey:@"idsourcechapter"];
            NSNumber *idN = [NSNumber numberWithInt:0-[ppid intValue]];
            id _Nullable ncnt =[item valueForKey:@"chapternotecount"];
            name = [NSString stringWithFormat:@"---%@   (%@)",name,  ncnt];
            //NSLog(name);
            
            [sourceIDList insertObject:idN atIndex:newIndex];
            [sourceNameList insertObject:name atIndex:newIndex];
            newIndex++;
        }
        
        [self.tableView reloadData];
        
        [requiredSourceId addObject:parentId];
    }
}

@end
