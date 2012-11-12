//
//  LevelManager.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/5/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "LevelManager.h"


@implementation LevelManager

-(id)init {
	
	if ((self = [super init])) {
		//Default Constructor
	}
	return self;
}

-(id)initFirstWorld {
	
	if ((self = [super init])) {

		
		lmBackground = [CCSprite spriteWithFile:@"levelManagerBackground.png"];
		lmBackground.position = ccp(SCR_CENTER_X,SCR_CENTER_Y);
		[self addChild:lmBackground];
		
		//Level selection images
		l1_Image = [CCSprite spriteWithFile:[self handleLevelIMG:1]];
		l1_Image.position = ccp(60,248);
		
		l2_Image = [CCSprite spriteWithFile:[self handleLevelIMG:2]];
		l2_Image.position = ccp(132,248);
		
		l3_Image = [CCSprite spriteWithFile:[self handleLevelIMG:3]];
		l3_Image.position = ccp(204,248);
		
		l4_Image = [CCSprite spriteWithFile:[self handleLevelIMG:4]];
		l4_Image.position = ccp(276,248);
		
		l5_Image = [CCSprite spriteWithFile:[self handleLevelIMG:5]];
		l5_Image.position = ccp(348,248);
		
		l6_Image = [CCSprite spriteWithFile:[self handleLevelIMG:6]];
		l6_Image.position = ccp(420,248);
		
		l7_Image = [CCSprite spriteWithFile:[self handleLevelIMG:7]];
		l7_Image.position = ccp(60,136);
		
		l8_Image = [CCSprite spriteWithFile:[self handleLevelIMG:8]];
		l8_Image.position = ccp(132,136);
		
		l9_Image = [CCSprite spriteWithFile:[self handleLevelIMG:9]];
		l9_Image.position = ccp(204,136);
		
		l10_Image = [CCSprite spriteWithFile:[self handleLevelIMG:10]];
		l10_Image.position = ccp(276,136);
		
		l11_Image = [CCSprite spriteWithFile:[self handleLevelIMG:11]];
		l11_Image.position = ccp(348,136);
		
		l12_Image = [CCSprite spriteWithFile:[self handleLevelIMG:12]];
		l12_Image.position = ccp(420,136);
		
		//Back button image
		backButtonImage = [CCSprite spriteWithFile:@"backButton.png"];
		backButtonImage.position = ccp(40,40);
		
		[self addChild:l1_Image];
		[self addChild:l2_Image];
		[self addChild:l3_Image];
		[self addChild:l4_Image];
		[self addChild:l5_Image];
		[self addChild:l6_Image];
		[self addChild:l7_Image];
		[self addChild:l8_Image];
		[self addChild:l9_Image];
		[self addChild:l10_Image];
		[self addChild:l11_Image];
		[self addChild:l12_Image];
		[self addChild:backButtonImage];
		
		//Touch controllers 
		LevelManagerController *levelManagerController = [[LevelManagerController alloc] init];
		[self addChild:levelManagerController];
	}
	return self;
}

-(id)initSecondWorld {
	
	if ((self = [super init])) {
		
		
	}
	return self;
}

-(id)initThirdWorld {
	
	if ((self = [super init])) {
		
		
	}
	return self;
}

-(NSString *)handleLevelIMG:(int)levelID {

	NSString *levelString = [NSString stringWithFormat:@"level%d",levelID];
	
	if ([[[[[[[DataManager getInstance] getGeneralData] objectForKey:kWorld1] objectForKey:@"levels"] objectForKey:levelString] objectForKey:kPlayable] intValue]) {
		
		return LEVEL_UNLOCKED_IMG;
	} else {
		
		return LEVEL_LOCKED_IMG;
	}
}
		


-(void)dealloc {
	[super dealloc];
}

@end
