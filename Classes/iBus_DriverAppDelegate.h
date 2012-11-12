//
//  iBus_DriverAppDelegate.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/9/11.
//  Copyright None / Student 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@class RootViewController;

@interface iBus_DriverAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
