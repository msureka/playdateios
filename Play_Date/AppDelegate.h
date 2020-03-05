//
//  AppDelegate.h
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetailViewControllerDelegate;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,weak)id<DetailViewControllerDelegate>delegate;

@end
@protocol DetailViewControllerDelegate<NSObject>
- (void)additem:(NSString *)ChannelIds;
@end
