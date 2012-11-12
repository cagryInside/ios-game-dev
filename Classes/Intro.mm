//
//  Intro.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/15/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "Intro.h"

@implementation Intro

#pragma mark -
#pragma mark Constructor

-(id) init {
	
	if( (self=[super init] )) {
		
		//Initilazing intro images and positioning to the center of the screen
		introImage1 = [CCSprite spriteWithFile:@"oyunyazarScreen.png"];
		introImage1.position = ccp(SCR_COORD_X, SCR_COORD_Y);
		
		introImage2 = [CCSprite spriteWithFile:@"ytuScreen.png"];
		introImage2.position = ccp(SCR_COORD_X, SCR_COORD_Y);
		introImage2.visible = NO;
		
		introImage3 = [CCSprite spriteWithFile:@"cocosbox.png"];
		introImage3.position = ccp(SCR_COORD_X, SCR_COORD_Y);
		introImage3.visible = NO;
		
		timeCounter = 0;
		
		//Calling introLoop method to update intro scene for every 1 second
		[self schedule:@selector(introLoop:) interval:1.0];
		
		//Add images to the scene
		[self addChild:introImage1];
		[self addChild:introImage3];
		[self addChild:introImage2];		
	}
	return self;
}

#pragma mark -
#pragma mark Intro Loop Function

//Purpose: Changing scenes by time and setting them visible at right time
//Input: Cocos delta time

-(void) introLoop :(ccTime)dt {
	
	timeCounter++;
	if (timeCounter == 2) {				
		introImage3.visible = YES;
	}
	if (timeCounter == 4) {
		introImage2.visible = YES;
	}
	if (timeCounter == 6) {	
		
		//Setting Sound here
		[[SoundManager getInstance] handleMenuSound];
		[GameStateManager goGameMenu];
	}
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc {
    [super dealloc];
}

@end
