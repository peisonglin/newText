//
//  AppDelegate.m
//  JS-OC
//
//  Created by lvdesheng on 2017/8/7.
//  Copyright © 2017年 lvdesheng. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"


@interface AppDelegate ()
@property (nonatomic,assign)BOOL isFullScreen;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc ]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    
    [self addViewController];
    
    

    return YES;
}

-(void)addViewController{
    
    OneViewController *one=[[OneViewController alloc]init];
    
    one.title=@"一页";
    
    TwoViewController *two=[[TwoViewController alloc]init];
    
    two.title=@"二页";
    
    ThreeViewController *three=[[ThreeViewController alloc]init];
    
    three.title=@"三页";

    UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:one];
    nvc.tabBarItem.title = @"一页";
    UINavigationController *nvc1=[[UINavigationController alloc]initWithRootViewController:two];
    nvc1.tabBarItem.title = @"二页";
    UINavigationController *nvc2=[[UINavigationController alloc]initWithRootViewController:three];
    nvc2.tabBarItem.title = @"三页";
    
    
    UITabBarController *tab=[[UITabBarController alloc]init];
    
    tab.viewControllers=@[nvc,nvc1,nvc2];
    
    self.window.rootViewController=tab;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark-禁止横屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    if (self.isFullScreen) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return UIInterfaceOrientationMaskAll;
    }else{
        if (self.isFullScreen) {
            return UIInterfaceOrientationMaskLandscapeLeft;
        }else{
            return UIInterfaceOrientationMaskPortrait;
        }
        
    }
    
}

@end
