//
//  WorldManagerController.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/5/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Subroutines.h"
#import "GameStateManager.h"

@interface WorldManagerController : CCLayer <CCStandardTouchDelegate>{

	/*
	 Declaring rectangles for controller layer at left side, right side and center.
	 So we can use sides as a controler by checking our touches positions
	 */
	CGRect leftRect,rightRect,centerRect;
	BOOL leftRectTouched, rightRectTouched, centerRectTouched;
	
	CGRect backButtonRect;
 	
	//We use an unsigned integer to grap the first touch's hash code. So we can fallow this touch later on touchsMoved function
	uint controllerTouchHash;

	//Distance between where i began first touch at screen and current location of where i moved my finger
	float distance;
	
	//Position where we first touch on screen
	CGPoint firstTouch;
	//HUDLayer and its location for carrying images
	CGPoint HUDLayerLocation;
	CCLayerColor *HUDLayer;
	
	//Distance variable to use on syncing
	float syncDistance;
	
	//Control world selection 
	Byte selectableWorld;
}

//Methods to get touch events and coordinates
-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
-(void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event;
-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;
-(void)updateLayerPosition:(float) touchDistance;
-(void)adjustLayerPosition;
-(id)initWithHUDLayer:(CCLayerColor*)HUDlayer;

@end
