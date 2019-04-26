//
//  main.m
//  setbook
//
//  Created by Steve Wang on 2018/10/1.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NSString *getIPFromSetting() {
    NSString *ip = @"192.168.0.1";
    NSString * settingsBundle =[[NSBundle mainBundle]pathForResource:@"Settings"   ofType:@"bundle"];
    if (!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
    }
    else {
        NSDictionary * settings =[NSDictionary dictionaryWithContentsOfFile: [settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
        
        NSDictionary * Preference =[settings objectForKey:@"PreferenceSpecifiers"];
    
        for (NSDictionary * prefSpecification in Preference) {
            NSString * key =[prefSpecification objectForKey:@"DefaultValue"];
            if (key) {
                ip = key;
                NSLog(@"getting setting ~~~~~~~~~~~ %@", key);
                break;
            }
        }
    }
    return ip;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *address = [userDefaults objectForKey:@"serveraddress_preference"];
        
        if (address == nil) {
            NSString *ip = getIPFromSetting();
            NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:ip
                                                                    forKey:@"serveraddress_preference"];
            [userDefaults registerDefaults:appDefaults];
            [userDefaults synchronize];
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
