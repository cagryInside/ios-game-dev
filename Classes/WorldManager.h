//
//  WorldManager.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/5/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Subroutines.h"
#import "WorldManagerController.h"
#import "DataManager.h"

@interface WorldManager : CCScene {

	CCSprite *wmBackground;
	
	//HUD layer images
	CCLayerColor *HUDLayer;
	CCSprite *w1;
	CCSprite *w2;
	CCSprite *w3;
	
	CCSprite *backButtonImage;
	
	//WorldManagerController *wmController;
	
}

@end
