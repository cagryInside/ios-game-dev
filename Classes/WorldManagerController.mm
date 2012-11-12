//
//  WorldManagerController.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/5/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "WorldManagerController.h"
#import "DataManager.h"

@implementation WorldManagerController

#pragma mark -
#pragma mark Constructors

-(id)init {
	
	if ((self = [super init])) {
	
	}
	return self;
}


-(id)initWithHUDLayer:(CCLayerColor*)HUDlayer {

	if ((self = [super init])) {
		
		//Layer to carry images
		HUDLayer = HUDlayer;
		
		//Rectangles to understand if touches where in these areas
		leftRect = CGRectMake(0, 80, 80, 160);
		rightRect = CGRectMake(400, 80, 80, 160);
		centerRect = CGRectMake(SCR_CENTER_X - 80, SCR_CENTER_Y - 80, 160, 160);
		
		//Back button rectangle
		backButtonRect = CGRectMake(24, 24, 32, 32);
		
		leftRectTouched = NO;
		rightRectTouched = NO;
		centerRectTouched = NO;
				
		//Enabling touch for this layer
		self.isTouchEnabled = YES;
		
		//When screen appears , first world is selectable as default
		selectableWorld = 1;
				
		//Delegating this layer for touch events
		[[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];	
	}
	return self;
}

#pragma mark -
#pragma mark Touch Functions

//Purpose: Get touch points when they began as a set and grap first touch

-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event  {
	
	NSSet *allTouches = [event allTouches];
	for (UITouch *touch in allTouches) {
		CGPoint touchLocation = [touch locationInView:[touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:touchLocation];	
		
		HUDLayerLocation = HUDLayer.position;
		firstTouch = convertedPoint;
		controllerTouchHash = [touch hash];		
		
		if (CGRectContainsPoint(centerRect, convertedPoint)) {
			centerRectTouched = YES;
		} else if (CGRectContainsPoint(rightRect, convertedPoint)) {
			rightRectTouched = YES;
		} else if (CGRectContainsPoint(leftRect, convertedPoint)) {
			leftRectTouched = YES;
		} else if (CGRectContainsPoint(backButtonRect, convertedPoint)) {
			[GameStateManager goGameMenu];
		}
	}
}

//Purpose: Get new touch points after moved and calculate distance between start point

-(void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	NSSet *allTouches = [event allTouches];
	for (UITouch *touch in allTouches) { 
		if ([touch hash] == controllerTouchHash) {
			CGPoint touchLocation = [touch locationInView:[touch view]];
			CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:touchLocation];
			//Calculating the distance where player touched to screen 
			distance = convertedPoint.x - firstTouch.x;
			//distance = convertedPoint.x - HUDLayerLocation.x;
			[self updateLayerPosition:distance];
		}
	}
}

//Purpose: Response if touches end

-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	for (UITouch *touch in touches) {
		if ([touch hash] == controllerTouchHash){
			if (centerRectTouched && (ABS(distance) < 5)) {
				centerRectTouched = NO;
				NSString *worldString = [NSString stringWithFormat:@"world%d",selectableWorld];
				//Calling GameStateManager to start level manager if player just touched centerRect
				if ([[[[[DataManager getInstance] generalData] objectForKey:worldString] objectForKey:kPlayable] intValue]) {
					//CCLOG(@"giriyorrr! %@",worldString);
					[GameStateManager startLevelManager:selectableWorld];
				}
			}
			//Reseting touch variable like hash code, distance..
			controllerTouchHash = 0;
			distance = 0;
			centerRectTouched = NO;
			[self adjustLayerPosition];
		}
	}
}

#pragma mark -
#pragma mark Layer Position Functions

//Update layer position where the finger moves
-(void)updateLayerPosition:(float)touchDistance {	
	HUDLayer.position = ccp(HUDLayerLocation.x + touchDistance,0); 
}

//Synchronize layer position after touches ended
-(void)adjustLayerPosition {

	syncDistance = HUDLayer.position.x;
	
	//Checking if right or left rect touched, else it will adjust the position of layer
	if (rightRectTouched || leftRectTouched) {
		//If right rect is touched, it moves HUDLayer to exact position of the next world which is at right position of the current world.
		if (rightRectTouched) {
			if (selectableWorld == 1) {
				selectableWorld = 2;
				[HUDLayer runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(-240,0)]];
			} else {
				selectableWorld = 3;
				[HUDLayer runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(-480,0)]];
			}
			rightRectTouched = NO;
		} 
		//If left rect is touched, it moves HUDLayer to exact position of the next world which is at left position of the current world.
		else if(leftRectTouched) {
			if (selectableWorld == 3) {
				selectableWorld = 2;
				[HUDLayer runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(-240,0)]];
			} else {
				selectableWorld = 1;
				[HUDLayer runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,0)]];
			}
			leftRectTouched = NO;
		}
		
	} else {
		//If I didnt touch left or right rectangles, I just need to adjust HUDLayer's position to the closest world position
		if (syncDistance > -120) {
			selectableWorld = 1;
			[HUDLayer runAction:[CCMoveTo actionWithDuration:ABS(syncDistance)/480 position:ccp(0,0)]];
		} else if (syncDistance > -360) {
			selectableWorld = 2;
			[HUDLayer runAction:[CCMoveTo actionWithDuration:ABS(syncDistance+240)/480 position:ccp(-240,0)]];
		} else {
			selectableWorld = 3;
			[HUDLayer runAction:[CCMoveTo actionWithDuration:ABS(syncDistance+480)/480 position:ccp(-480,0)]];
		}
	}
}


#pragma mark -
#pragma mark Memory Management

-(void)dealloc {
	[super dealloc];
}

@end
