//
//  JoyPad.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayer.h"
#import "CCTouchDispatcher.h"

#define JCENTER 80
#define MAX_Y 320
#define ORJ_TO_JOYPAD_Y 240

@interface JoyPad : CCLayer <CCStandardTouchDelegate> {
	
	//Tracks if joypad is moving or not 
	BOOL joypadMoving;
	
	//Boundaries of JoyPad as rectangle
	CGRect joypadRect;
	
	//Values used to control the joypad
	uint joypadCenterx, joypadCentery, joypadMaxRadius ,joypadWidth, joypadHeight ;
	
	//Integer that can be used as a table address in a hash table structure. 
	uint joypadTouchHash;
	
	//JoyPad images
	CCSprite *joypad;
	CCSprite *joypadBellows;
	CCSprite *joypadHead;
	CCSprite *joypadCircle;
	
	//Location of JoyPad head
	CGPoint joypadHeadLocation;
	
	//Touch angle
	float touchAngle;
	
	//Touch distance
	float distance;
	
	//Touch coordinates to move JoyPad head
	CGPoint currentCoordinates;
}

//Getter method for JoyPad coordinates in cartesian coordinates system
-(CGPoint)getJoyPadCoordinates;
-(void)updateJoypadLocation:(CGPoint)positions;

//Methods to get touch events and coordinates
-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
-(void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event;
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;

@end
