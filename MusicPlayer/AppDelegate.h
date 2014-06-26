//
//  AppDelegate.h
//  MusicPlayer
//
//  Created by atsushi.ito on 2014/06/10.
//  Copyright (c) 2014年 atsushi.ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // [1]
    UITabBarController *tabBarController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@end
