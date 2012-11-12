//
//  WorldManager.mm
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/5/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "WorldManager.h"


@implementation WorldManager

-(id)init {

	if ((self = [super init])) {
		
		wmBackground = [CCSprite spriteWithFile:@"worldManagerBackground.png"];
		wmBackground.position = ccp(SCR_CENTER_X,SCR_CENTER_Y);
		[self addChild:wmBackground];
		
		//Back button image
		backButtonImage = [CCSprite spriteWithFile:@"backButton.png"];
		backButtonImage.position = ccp(40,40);
		
		//HUD layer items initialization
		w1 = [CCSprite spriteWithFile:@"w1.png"];
		
		if ([[[[[DataManager getInstance] getGeneralData] objectForKey:kWorld2] objectForKey:kPlayable] intValue]) {
			
			w2 = [CCSprite spriteWithFile:@"w2.png"];
		}else {
			w2 = [CCSprite spriteWithFile:@"w2Locked.png"];
		}
		
		if ([[[[[DataManager getInstance] getGeneralData] objectForKey:kWorld3] objectForKey:kPlayable] intValue]) {
			
			w3 = [CCSprite spriteWithFile:@"w3.png"];
		}else {
			w3 = [CCSprite spriteWithFile:@"w3Locked.png"];
		}
		
	
		w1.position = ccp(240,160);
		w2.position = ccp(480,160);
		w3.position = ccp(720,160);
		
		HUDLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 0) width:960 height:320];
		HUDLayer.position = ccp(0,0);
		
		//Add to hudlayer
		[HUDLayer addChild:w1];
		[HUDLayer addChild:w2];
		[HUDLayer addChild:w3];
		
		
		[self addChild:HUDLayer];
		[self addChild:backButtonImage];
		
		
		//worldManagerController instance 
		WorldManagerController *wmController = [[WorldManagerController alloc] initWithHUDLayer:HUDLayer];
		[self addChild:wmController];
		
	}
	return self;
}


-(void) dealloc {
	
	[super dealloc];
}
@end
