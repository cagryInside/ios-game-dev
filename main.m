//
//  main.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/9/11.
//  Copyright None / Student 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	int retVal = UIApplicationMain(argc, argv, nil, @"iBus_DriverAppDelegate");
	[pool release];
	return retVal;
}
