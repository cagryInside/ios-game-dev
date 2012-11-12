//
//  GameStateManager.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/22/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "GameStateManager.h"

@implementation GameStateManager

//Constructor

#pragma mark -
#pragma mark Constructor

-(id) init {
	if ( (self=[super init] )) {
		
	}
	return self;
}

#pragma mark -
#pragma mark Scene Changer Functions

//Purpose: Create a new scene object then send message to scene changer function.

+(void) startIntro {
	CCScene *intro = [Intro node];
	[GameStateManager changeScene: intro];
}

+(void) goGameMenu {
	CCScene *gameMenu = [GameMenu node];
	[GameStateManager changeScene: gameMenu];
}

+(void) startGame {
	//Stop background music when game starts 
	[[SoundManager getInstance] stopBGMusic];
	
	CCScene *game = [IBusDriverMain node];
	[GameStateManager changeScene: game];
}

+(void) goSettings {
	CCScene *settings = [Settings node];
	[GameStateManager changeScene: settings];
}

+(void) goCredits {
	CCScene *credits = [Credits node];
	[GameStateManager changeScene: credits];
}

+(void) startWorldManager {
	CCScene *worldManager = [WorldManager node];
	[GameStateManager changeScene:worldManager];
}

+(void) startLevelManager:(Byte)worldNumber {
	
	CCScene *levelManager;
	switch (worldNumber) {
		case 1:
			levelManager = [[LevelManager alloc] initFirstWorld];
			break;
		case 2:
			levelManager = [[LevelManager alloc] initSecondWorld];
			break;
		case 3:
			levelManager = [[LevelManager alloc] initThirdWorld];
			break;

		default:
			break;
	}
	
	[GameStateManager changeScene:levelManager];
}

//Purpose: Change scenes
//Input: A new scene which we want to change to.

+(void) changeScene:(CCScene *)newScene {
	CCDirector *director = [CCDirector sharedDirector];
	if ([director runningScene]) {
		[director replaceScene: newScene];
	}
	else {
		[director runWithScene:newScene];
	}
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc {
	[super dealloc];
}

@end
