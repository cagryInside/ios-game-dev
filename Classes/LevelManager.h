//
//  LevelManager.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/5/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Subroutines.h"
#import "LevelManagerController.h"
#import "DataManager.h"

#define LEVEL_UNLOCKED_IMG @"levelSelectImage.png"
#define LEVEL_LOCKED_IMG @"levelLockedImage.png"


@interface LevelManager : CCScene {

	CCSprite *lmBackground;
	//Level images 
	CCSprite *l1_Image;
	CCSprite *l2_Image;
	CCSprite *l3_Image;
	CCSprite *l4_Image;
	CCSprite *l5_Image;
	CCSprite *l6_Image;
	CCSprite *l7_Image;
	CCSprite *l8_Image;
	CCSprite *l9_Image;
	CCSprite *l10_Image;
	CCSprite *l11_Image;
	CCSprite *l12_Image;
	
	//Back button image
	CCSprite *backButtonImage;
	
}

-(id)initFirstWorld;
-(id)initSecondWorld;
-(id)initThirdWorld;

-(NSString *)handleLevelIMG:(int)levelID;

@end
