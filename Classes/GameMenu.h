//  Created by Hakan Fatih Kalkan & Cagri Cetin.
//  Copyright 2011 OyunYazar.net. All rights reserved.


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameStateManager.h"
#import "Subroutines.h"

@interface GameMenu : CCScene {
	
	//Declaring GameMenu items, such as background image and buttons.
	
	CCSprite *menuBackgroundImage;
	CCMenu *mMenu;
	CCMenuItemImage *playButton;
	CCMenuItemImage *creditsButton;	
	CCMenuItemImage *settingsButton;	
}

//Messages to send GameMenu when buttons pressed.

-(void) callStartGame:(id)sender;
-(void) callCredits:(id)sender;
-(void) callSettings:(id)sender;
-(void) callWorldManager:(id)sender;

@end
