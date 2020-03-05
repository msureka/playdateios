//
//  AppDelegate.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Bolts/Bolts.h>
#import "Reachability.h"
#import "MainMenuNavigationController.h"
#import "MainProfilenavigationController.h"
#import "Firebase.h"
#import "Flurry.h"
#import "LoginSignupViewController.h"
@import UserNotifications;

@interface AppDelegate ()
{
    
    NSUserDefaults * defauls;
    LoginSignupViewController * controller;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
  

    
  
    
   
    
  


    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [message show];
//
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
        
        
        
    }
    else
    {
        defauls=[[NSUserDefaults alloc]init];
        
        
        [defauls setObject:@"no" forKey:@"contactslist"];
        
      
      
        
        [FIRApp configure];
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
            UIUserNotificationType allNotificationTypes =
            (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =
            [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        } else {
            // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            // For iOS 10 display notification (sent via APNS)
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            UNAuthorizationOptions authOptions =
            UNAuthorizationOptionAlert
            | UNAuthorizationOptionSound
            | UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            }];
#endif
        }
        
        [application registerForRemoteNotifications];
        
    [FIRMessaging messaging].delegate = self;
        NSString *fcmToken = [FIRMessaging messaging].FCMToken;
        NSLog(@"FCM registration token: %@", fcmToken);
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        
        
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            
        }
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"])
        {
            [[NSUserDefaults standardUserDefaults] setInteger:([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"] + 1) forKey:@"AppLaunchCount"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"AppLaunchCount"];
        }
        
        
        
        
        //    [Flurry setDebugLogEnabled:YES];
        //    [Flurry startSession:@""];
        
        NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        
        NSLog(@"ver123 = %@%@",appVersionString,appBuildString);
        
        NSString *verBuild = [NSString stringWithFormat:@"%@.%@",appVersionString,appBuildString];
        
        FlurrySessionBuilder *builder = [[[[[ FlurrySessionBuilder new] withLogLevel:FlurryLogLevelAll]withCrashReporting:YES]withSessionContinueSeconds:10]withAppVersion:verBuild];
        
        [Flurry startSession:@"55BWQ689QBY338PSHW7B" withSessionBuilder:builder];

     
        [defauls setObject:@"no" forKey:@"notification"];
        [defauls synchronize];
        
        
        
        
        
        
        
        
     
        
        
        
        
        
        
        [[FBSDKApplicationDelegate sharedInstance] application:application
                                 didFinishLaunchingWithOptions:launchOptions];
        
        
     
        
        [defauls synchronize];
        
        
        if ([[defauls valueForKey:@"Loginplay"] isEqualToString:@"yes"])
        {
            [defauls setObject:@"no" forKey:@"letsChat"];
            [defauls synchronize];
            MainProfilenavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
            
            self.window.rootViewController=loginController;
        }
        else
        {
            
            
            MainMenuNavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainMenuNavigationController"];

       
             self.window.rootViewController=loginController;
        }
       
    }
    
    
//      NSString *channelID = [UAirship push].deviceToken;
//    NSLog(@"channel id = %@",channelID);
    
   


    return YES;
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
//      [self refreshMessageCenterBadge];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  
     [defauls setObject:@"no" forKey:@"contactslist"];
      [FBSDKAppEvents activateApp];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        exit(0);
//    }
//}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo
{
    UIApplicationState state=[application applicationState];
    if(state==UIApplicationStateActive)
    {
         NSLog(@"Active puss Yesss");
    }
    else
    {
        NSLog(@"Active puss not");
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    
 
}
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}
// With "FirebaseAppDelegateProxyEnabled": NO
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [FIRMessaging messaging].APNSToken = deviceToken;
}
@end
