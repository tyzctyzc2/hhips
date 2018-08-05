//
//  NSObject+MyBaseViewController.h
//  setbook
//
//  Created by Steve Wang on 2018/7/15.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "MyBaseViewController.h"


@interface MyBaseViewController () {
    
}

@end

@implementation MyBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *cl =  NSStringFromClass([self class]);
    NSLog(@"viewWillAppear%@", cl);
}

@end
