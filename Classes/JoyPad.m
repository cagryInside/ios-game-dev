//
//  JoyPad.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "JoyPad.h"

@implementation JoyPad

#pragma mark -
#pragma mark Constructor

-(id)init {
	if ((self = [super init])) {
		
		//Define JoyPad images
		joypad = [CCSprite spriteWithFile:@"JoyPad.png"];
		joypad.position = ccp(80,80);
		joypadCircle = [CCSprite spriteWithFile:@"JoyPadC.png"];
		joypadCircle.position = ccp(81,78);
		joypadHead = [CCSprite spriteWithFile:@"JoyPadHeadN.png"];
		joypadHead.position = ccp(80,80);
		joypadBellows = [CCSprite spriteWithFile:@"JoyPadS.png"];
		
		//First initialization of JoyPad attributes and coordinates
		joypadMoving = NO;
		joypadCentery = 80;
		joypadCenterx = 80;
		joypadMaxRadius = 32;
		joypadWidth = 48;
		joypadHeight = 48;
		joypadRect = CGRectMake(joypadCenterx - joypadWidth, joypadCentery - joypadHeight,
								joypadCenterx + joypadWidth, joypadCentery + joypadHeight);
		
		joypadHeadLocation = CGPointMake(joypadCenterx, ORJ_TO_JOYPAD_Y);
		joypadBellows.position = ccp((joypadHead.position.x+80)/2, (joypadHead.position.y+80)/2);
		
		//Enabling touch for this layer
		self.isTouchEnabled = YES;
		
		//Delegating this layer for touch events
		[[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
		
		//Adding images to the scene
		[self addChild:joypad];
		[self addChild:joypadCircle];
		[self addChild:joypadBellows];
		[self addChild:joypadHead];
		
	}
	return self;
}

#pragma mark -
#pragma mark JoyPad Methods

//Purpose: Get JoyPad head location and move image to that position also move bellows to the point between head and joypad center

-(void) updateJoypadLocation :(CGPoint)positions {
	joypadHead.position = ccp(positions.x,MAX_Y - positions.y);
	joypadBellows.position = ccp((joypadHead.position.x+80)/2, (joypadHead.position.y+80)/2);
}

//Purpose: Sent JoyPad coordinates in cartesian systems

-(CGPoint)getJoyPadCoordinates {
	return CGPointMake ((joypadHeadLocation.x - JCENTER), (ORJ_TO_JOYPAD_Y - joypadHeadLocation.y));
}

#pragma mark -
#pragma mark Touch Event Methods

//Purpose: Get touch points when they began as a set and if its in JoyPad boundary rectangle, response it

-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event  {
	NSSet *allTouches = [event allTouches];
	for (UITouch *touch in allTouches) {
		CGPoint touchLocation = [touch locationInView:[touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:touchLocation];	
		if (CGRectContainsPoint(joypadRect, convertedPoint) && !joypadMoving) {
			joypadMoving = YES;
			joypadTouchHash = [touch hash];			
		}		
	}
}

//Purpose: Get new touch points after moved and calculate distance between start points

-(void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	NSSet *allTouches = [event allTouches] ;
	for (UITouch *touch in allTouches) { 
		if ([touch hash] == joypadTouchHash && joypadMoving) {
			CGPoint touchLocation = [touch locationInView:[touch view]];
			CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:touchLocation];
			float dx = (float)joypadCenterx-(float)convertedPoint.x;
			float dy = (float)joypadCentery-(float)convertedPoint.y;
			
			//Calculating the distance where palyer touched to screen 
			distance = sqrtf((joypadCenterx - convertedPoint.x)*(joypadCenterx - convertedPoint.x) + 
							 (joypadCentery - convertedPoint.y)*(joypadCentery - convertedPoint.y));
			
			//Calculae the angle of the players touch from the center of the joypad 
			touchAngle = atan2(dy, dx);
			
			//if the players finger is outside of the joypad ,make sure the cap down the jp
			if (distance > joypadMaxRadius ) {
				//Set the location of the joypadHead 32px from the center at the angle of the player 
				joypadHeadLocation = CGPointMake((joypadCenterx - cosf(touchAngle)*joypadMaxRadius),
												 MAX_Y-(joypadCentery - sinf(touchAngle)*joypadMaxRadius));
				[self updateJoypadLocation:joypadHeadLocation];
				
			}
			else {
				//Simply set the location of the joypad head to the location where player touched
				joypadHeadLocation = touchLocation;
				[self updateJoypadLocation:joypadHeadLocation];
			} 
		}
	}
}

//Purpose: Response if touches end

-(void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	for (UITouch *touch in touches) {
		if ([touch hash] == joypadTouchHash){
			joypadMoving = NO;
			joypadTouchHash = 0;
			distance = 0;
			touchAngle = 0;
			joypadHeadLocation = CGPointMake(joypadCenterx, ORJ_TO_JOYPAD_Y);
			[self updateJoypadLocation:joypadHeadLocation];
		}
	}
}

#pragma mark -
#pragma mark Memory Management

-(void)dealloc {
	
	[super dealloc];
}

@end
