//
//  AppDelegate.m
//  MusicPlayer
//
//  Created by atsushi.ito on 2014/06/10.
//  Copyright (c) 2014年 atsushi.ito. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"



@implementation AppDelegate
@synthesize window;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    FirstViewController *firstViewController = FirstViewController.new; //[[FirstViewController alloc] init];
    SecondViewController *secondViewController = SecondViewController.new; //[[SecondViewController alloc] init];
    
    
    
    
    //tabBarControllerで管理するViewControllerを指定
    //self.tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    self.tabBarController = UITabBarController.new;
    
    // 06/25 : UINavigationControllerに変更します。
    //tabBarController.viewControllers = [NSArray arrayWithObjects:firstViewController, secondViewController, nil];
    tabBarController.viewControllers =
    [NSArray arrayWithObjects:
     [[UINavigationController alloc] initWithRootViewController:firstViewController],
     [[UINavigationController alloc] initWithRootViewController:secondViewController], nil];
    
    
    
    UITabBarItem *tbi01 = [tabBarController.tabBar.items objectAtIndex:0];
    tbi01.title = @"First";
    UITabBarItem *tbi02 = [tabBarController.tabBar.items objectAtIndex:1];
    tbi02.title = @"Second";
    
    
    //tabBarControllerをwindowのrootViewControllerに指定します。
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
