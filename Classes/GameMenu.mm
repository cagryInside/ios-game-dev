//  Created by Hakan Fatih Kalkan & Cagri Cetin.
//  Copyright 2011 OyunYazar.net. All rights reserved.

#import "GameMenu.h"

@implementation GameMenu

#pragma mark -
#pragma mark Constructor

-(id) init {
	
	if( (self=[super init] )) {
		
		//Setting up menu background image position 
		menuBackgroundImage = [CCSprite spriteWithFile:@"menuBackground.png"];
		menuBackgroundImage.position = ccp (SCR_CENTER_X,SCR_CENTER_Y);
		
		//Adding buttons to the screen
		playButton = [CCMenuItemImage itemFromNormalImage:@"playN.png" selectedImage:@"playO.png"
												   target:self selector:@selector(callWorldManager:)];
		settingsButton = [CCMenuItemImage itemFromNormalImage:@"settingsN.png" selectedImage:@"settingsO.png"
													   target:self selector:@selector(callSettings:)];
		creditsButton = [CCMenuItemImage itemFromNormalImage:@"creditsN.png" selectedImage:@"creditsO.png"
													  target:self selector:@selector(callCredits:)];
		
		//Creating a new menu, setting its position and aligning
		mMenu = [CCMenu menuWithItems: playButton, settingsButton, creditsButton,  nil];
		//playButton.position = ccp(90,70);
		//settingsButton.position = ccp(240,50);
		//creditsButton.position = ccp(390,60);
		[mMenu alignItemsVerticallyWithPadding:3.0f];
		mMenu.position = ccp(420,160);
		
		//Adding items to the scene
		[self addChild:menuBackgroundImage];
		//[self addChild:playButton];
		//[self addChild:settingsButton];
		//[self addChild:creditsButton];
		[self addChild:mMenu];
	}
	return self;
}

#pragma mark -
#pragma mark Messages Of Buttons

-(void) callStartGame:(id)sender {
	[GameStateManager startGame];
}

-(void) callCredits:(id)sender {
	[GameStateManager goCredits];
}

-(void) callSettings:(id)sender {
	[GameStateManager goSettings];
}

-(void) callWorldManager:(id)sender {
	[GameStateManager startWorldManager];
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc {
	
	[super dealloc];
}

@end