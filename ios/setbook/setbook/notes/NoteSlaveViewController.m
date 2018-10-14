//
//  FirstViewController.m
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "NoteSlaveViewController.h"
#import "HttpHelper.h"
#import "MyDataStatic.h"

@interface NoteSlaveViewController ()
@property (strong, nonatomic) IBOutlet UITableView *detailTable;

@end

@implementation NoteSlaveViewController
NSMutableArray *chapterNameList;
NSMutableArray *chapterIDList;
NSString *sourceId;

MyDataStatic *dataStatic;

- (void)viewDidLoad {
    [super viewDidLoad];
    dataStatic = [[MyDataStatic alloc] init];
    [dataStatic setHookedController:self];
   
    sourceId = @"3";
    
    [self updateToSource];
    
    self.detailTable.dataSource = (id <UITableViewDataSource>)self;
    self.detailTable.delegate = (id <UITableViewDelegate>)self;
}

-(void)updateToPicked:(NSString *)picked{
    NSLog(@"target updateToPicked called --- %@", picked);
    sourceId = picked;
    [self updateToSource];
    [self.detailTable reloadData];
}

-(void)updateToSource {
    if (sourceId == nil)
        return;
    
    chapterNameList = [NSMutableArray new];
    chapterIDList = [NSMutableArray new];
    
    HttpHelper *httpH = [HttpHelper new];
    NSString *url = [NSString stringWithFormat:@"/chapter/insource?sourceid=%@", sourceId];
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
            NSString *myID = [NSString stringWithFormat:@"%@", ppid];
            id _Nullable ncnt =[item valueForKey:@"chapternotecount"];
            name = [NSString stringWithFormat:@"%@      (%@)",name,  ncnt];
            [chapterNameList addObject:name];
            [chapterIDList addObject:myID];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [chapterIDList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    int index = (int)indexPath.row;
    NSString *cellIdentifier = [chapterIDList objectAtIndex:index];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    cell.textLabel.text = [chapterNameList objectAtIndex:index];
    //cell.detailTextLabel.text = [sourceNameList objectAtIndex:index];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.row;
    NSString *cellIdentifier = [chapterIDList objectAtIndex:index];
    [dataStatic setChapterId:cellIdentifier];
    NSLog(@"chapter picked --     (%@)" , cellIdentifier);
    
    /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"IconView"];
    
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    
    
    //[self.navigationController pushViewController:vc animated:false];
    [self presentViewController:vc animated:NO completion:NULL];*/
    
    [self performSegueWithIdentifier:@"Thumb" sender:self];
}
@end
