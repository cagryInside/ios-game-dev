//
//  Intro.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/15/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameStateManager.h"
#import "SoundManager.h"

#define SCR_COORD_X 240
#define SCR_COORD_Y 160

@interface Intro : CCScene {
	
	//Declaring intro images
	CCSprite *introImage1;
	CCSprite *introImage2;
	CCSprite *introImage3;
	
	//Counter for images to change by time
	int timeCounter;
}

-(void) introLoop:(ccTime)dt;

@end
