//
//  main.m
//  setbook
//
//  Created by Steve Wang on 2018/3/28.
//  Copyright © 2018年 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        // Set the application defaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"192.168.0.101"
                                                                forKey:@"serveraddress_preference"];
        [defaults registerDefaults:appDefaults];
        [defaults synchronize];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
