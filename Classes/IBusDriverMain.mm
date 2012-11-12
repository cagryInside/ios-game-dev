//
//  IBusDriverMain.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "IBusDriverMain.h"

@implementation IBusDriverMain

-(id)init {
	
	if ((self = [super init])) {
		
		// Getting Singleton Instance of Physic Engine
		mainPhysic = [[GamePhysics getInstance] getGameWorld];
		
		// Getting Screen size
		screenSize = [[CCDirector sharedDirector]winSize];
		zoomInterval = 0;		
		
		//Getting Singleton Instance of TiledMap
		tmManager = [TiledMapManager getInstance];
		theMap = [tmManager getTiledMap];
		[self addChild:theMap z:-1];
		
		mainBus = [[MainBus alloc] init:[tmManager getStartPoint].x withY:[tmManager getStartPoint].y];
		[self addChild:mainBus];
		
		//Game AI cars 
		aiCar1 = [[AICar alloc] init:[tmManager getStartPoint].x+80 withY:[tmManager getStartPoint].y];
		[self addChild:aiCar1];
		
		//Initializing HUDlayer 
		HUDlayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 0) width: screenSize.width height: screenSize.height];
		//Setting up HUDlayer's Position to Center of the Screen
		HUDlayer.position = [mainBus getPosition];
		HUDlayer.isRelativeAnchorPoint = YES;	
		
		// Initializing joypad object 
		joypad = [[JoyPad alloc] init];
		// Adding Joypad Images to main layer
		[HUDlayer addChild:joypad z:10];
		
		[self addChild:HUDlayer];
		
		//Calling GameLoop method on every frame 
		[[CCScheduler sharedScheduler] scheduleSelector:@selector(gameLoop:) forTarget:self interval:1.0f/60.0f paused:NO];
		
	}
	
	return self;
}

-(void) gameLoop :(ccTime)dt {
	
	[mainBus moveGoodGuy:CGPointMake([joypad getJoyPadCoordinates].x,[joypad getJoyPadCoordinates].y)];
	[self setCenterOfScreen:[mainBus getPosition] zoomSpace:TEMP_ZOOM_SPC zoomCancel:NO];
	
	//Physic Engine Calling Every Frame 
	mainPhysic->Step(0.03f, 8, 1);
	for (b2Body *b = mainPhysic->GetBodyList(); b != nil; b=b->GetNext()) {    
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
			//CCLOG(@"ball position %f",b->GetPosition().y);
            ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }        
    }
}

-(void)setCenterOfScreen:(CGPoint)position zoomSpace:(int)zoomSpace zoomCancel:(BOOL)zoomCancel{
	float temp = ZOOM_INT;
	int x = MAX(position.x, screenSize.width/2 + (ZOOM_DIFF_X * zoomSpace));
	int y = MAX(position.y, screenSize.height/2 + (ZOOM_DIFF_Y * zoomSpace));
	
	x = MIN(x, theMap.mapSize.width * theMap.tileSize.width - screenSize.width/2 - (ZOOM_DIFF_X * zoomSpace));
	y = MIN(y, theMap.mapSize.height * theMap.tileSize.height - screenSize.height/2 - (ZOOM_DIFF_Y * zoomSpace));
	
	CGPoint goodPoint = ccp(x, y);
	
	// Camera zoom properties 
	if ((!zoomCancel) && (zoomInterval<zoomSpace)){
		zoomInterval += ZOOM_INT;		
		HUDlayer.scale += temp/CAM_FIX_RATIO;		
	}	
	if ((zoomCancel) && (zoomInterval>0)) {
		zoomInterval -= ZOOM_INT;
		HUDlayer.scale -= temp/CAM_FIX_RATIO;
	}
	
	// Setting up Camera's location on every frame 
	[self.camera setCenterX:goodPoint.x-SCR_DIFF_X centerY:goodPoint.y-SCR_DIFF_Y centerZ:0];	
	[self.camera setEyeX:goodPoint.x-SCR_DIFF_X eyeY:goodPoint.y-SCR_DIFF_Y eyeZ:1+zoomInterval];
	
	// Updateing HUDlayers position on every frame
	HUDlayer.position =ccp(goodPoint.x,goodPoint.y);
	
	
}

- (void) dealloc{
	
	joypad = nil;
	mainPhysic = nil;
	mainBus = nil;
	tmManager = nil;
	theMap = nil;
	[super dealloc];
}

@end
