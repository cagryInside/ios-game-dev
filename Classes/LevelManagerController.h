//
//  LevelManagerController.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/6/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameStateManager.h"

@interface LevelManagerController : CCLayer <CCStandardTouchDelegate> {
	
	CGRect lRect1,lRect2,lRect3,lRect4,lRect5,lRect6,lRect7,lRect8,lRect9,lRect10,lRect11,lRect12;
	CGRect backButtonRect;
}

-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;

@end
