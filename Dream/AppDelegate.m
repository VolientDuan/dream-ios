//
//  AppDelegate.m
//  Dream
//
//  Created by duanxiancai on 2022/11/1.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [DreamRootRouter shareInstance].window;
    
    return YES;
}

@end
