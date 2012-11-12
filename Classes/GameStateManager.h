//  Created by Hakan Fatih Kalkan & Cagri Cetin.
//  Copyright 2011 OyunYazar.net. All rights reserved.

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Intro.h"
#import "IBusDriverMain.h"
#import "GameMenu.h"
#import "Settings.h"
#import "Credits.h"
#import "WorldManager.h"
#import "LevelManager.h"
#import "SoundManager.h"

@interface GameStateManager : CCNode {
	
}

// Game States
+(void) startIntro;
+(void) goGameMenu;
+(void) startGame;
+(void) goSettings;
+(void) goCredits;
+(void) startWorldManager;
+(void) startLevelManager:(Byte)worldNumber;

//State Switcher Function
+(void) changeScene: (CCScene *) newScene;

@end