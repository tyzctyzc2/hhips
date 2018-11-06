//
//  BarAlertController.m
//  TestDraft
//
//  Created by Casinolinkpa on 11/2/18.
//  Copyright © 2018 Casinolinkpa. All rights reserved.
//

#import "BarAlertController.h"

@interface BarAlertController ()

@end

@implementation BarAlertController
UIProgressView *progbar;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)layoutEverything {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    width = width / 3;
    
    // Height constraint
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute: NSLayoutAttributeNotAnAttribute
                                                     multiplier:1
                                                       constant:100]];
    
    float height = 200;
    progbar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progbar.backgroundColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
    [progbar setFrame:CGRectMake(20,80,230,height)];
    [progbar setTrackTintColor:UIColor.grayColor];
    [progbar setProgressTintColor:UIColor.blueColor];
    progbar.progress = 0.0;
    
    [self.view addSubview:progbar];
}

- (id)init {
    NSLog(@"my init called");
    self = [super init];
    
    [self layoutEverything];
    return self;
}

- (void)updateProgress:(float)value {
    progbar.progress = value;
    
    int ii = value * 100;
    NSString *t = [NSString stringWithFormat:@"%d %%", ii];
    [self setMessage:t];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
