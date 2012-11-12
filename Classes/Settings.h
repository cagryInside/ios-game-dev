//
//  Settings.h
//  Deliveryman
//
//  Created by Hakan Fatih Kalkan on 2/15/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameStateManager.h"
#import "Subroutines.h"
#import "DataManager.h"
#import "SoundManager.h"

@interface Settings : CCScene {
	
	// Declaring background image
	CCSprite *settingsBackground;
	
	// Declaring menu images
	CCMenuItem *soundOnItem;
	CCMenuItem *soundOffItem;
	CCMenuItemToggle *soundToggleItem;
	CCMenuItemImage *backButton;	
	CCMenu *mMenu;


}

-(void)goBack:(id)sender;
-(void)soundButtonTapped:(id)sender;

@end
