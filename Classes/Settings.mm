//
//  Settings.mm
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/22/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "Settings.h"
//#import "CCLabel.h"

@implementation Settings

-(id)init {
	if ((self = [super init])) {
		
		settingsBackground = [CCSprite spriteWithFile:@"worldManagerBackground.png"];
		settingsBackground.position = ccp(SCR_CENTER_X,SCR_CENTER_Y);
		[self addChild:settingsBackground];

		backButton = [CCMenuItemImage itemFromNormalImage:@"backButton.png" selectedImage:@"backButton.png" target:self selector:@selector(goBack:)];
		backButton.position = ccp(40,40);
		//TODO true or false from preferences?
		
		soundOffItem = [CCMenuItemImage itemFromNormalImage:@"off-f.png" selectedImage:@"off-t.png" target:self selector:nil];
		soundOnItem = [CCMenuItemImage itemFromNormalImage:@"on-f.png" selectedImage:@"on-t.png" target:self selector:nil];
				
		
		soundToggleItem = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundButtonTapped:) items:soundOnItem, soundOffItem, nil];
		soundToggleItem.position = ccp(160,200);
		mMenu = [CCMenu menuWithItems: soundToggleItem, backButton, nil];
		mMenu.position = ccp(0,0);
		[self addChild:mMenu];
		
 		
		
		//Getting sound info from database using DataManager
		if ([[[[DataManager getInstance] getGeneralData] objectForKey:@"soundFX"] intValue]) {
			//Sound enable
			[soundToggleItem setSelectedIndex:0];
		} else {
			//Sound disable
			[soundToggleItem setSelectedIndex:1];
			
		}
		
		//TODO SET TOOGLE MANUALLY FROM SAVED SETTINGS
	}
	return self;
}

-(void)goBack:(id)sender {
	
	[GameStateManager goGameMenu];
}

-(void) soundButtonTapped:(id)sender {
	
	//Saving sound situation to temprory data file 
	
	if ([[[[DataManager getInstance] getGeneralData] objectForKey:@"soundFX"] intValue]) {
		
		//Close sound 
		[[[DataManager getInstance] getGeneralData] setValue: (id)kCFBooleanFalse forKey:@"soundFX"];	
		
		[[SoundManager getInstance] controlAllSounds:TRUE];
	}else {
		
		//open sound
		[[[DataManager getInstance] getGeneralData] setValue: (id)kCFBooleanTrue forKey:@"soundFX"];

		[[SoundManager getInstance] controlAllSounds:FALSE];
	}
	
	[[SoundManager getInstance] handleMenuSound];

}

-(void) dealloc {
	[super dealloc];
}

@end
