//
//  SoundManager.m
//  iBus Driver
//
//  Created by cagry on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"


@implementation SoundManager

static SoundManager *soundManager = nil;

-(id)init {
	
	if ((self = [super init])){
		
	}
	return self;
}

+(SoundManager *)getInstance {
	
	@synchronized(self){
		
		if (soundManager == nil) {
			
			soundManager = [[SoundManager alloc] init];
		}
	}
	return soundManager;
}

-(void)controlAllSounds:(Boolean)control {
	
	[CDAudioManager sharedManager].mute = control;
}

-(void)handleMenuSound {
	
	//Getting sound info from database using DataManager
	if ([[[[DataManager getInstance] getGeneralData] objectForKey:@"soundFX"] intValue] == 0) {
		//Sound disabled
		[self controlAllSounds:TRUE];
		NSLog(@"stop sound");
	}else {		
		//Loading menu sound
		[[CDAudioManager sharedManager] playBackgroundMusic:@"menuLoop.wav" loop:YES];
	}

	
}

-(void)stopBGMusic {
	
	[[CDAudioManager sharedManager] stopBackgroundMusic];
}

@end
