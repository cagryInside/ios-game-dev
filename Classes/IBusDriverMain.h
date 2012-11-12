//
//  IBusDriverMain.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

//Purpose: Main Game Object 

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainBus.h"
#import "JoyPad.h"
#import "GamePhysics.h"
#import "TiledMapManager.h"
#import "AICar.h"

#define SCR_DIFF_X 240
#define SCR_DIFF_Y 160
#define ZOOM_INT 3
#define CAM_FIX_RATIO 277
#define PTM_RATIO 32
#define TEMP_ZOOM_SPC 0
#define ZOOM_DIFF_X 0.87
#define ZOOM_DIFF_Y 0.58

@interface IBusDriverMain : CCScene {
		
	MainBus *mainBus;
	float speed_x, speed_y;	
	CGSize screenSize;
	float zoomInterval;
	CCLayerColor *HUDlayer;
		
	//Controller objects
	JoyPad *joypad;
	CGPoint joypadCoordinates;
		
	//Physic objects
	b2World *mainPhysic;
		
	//TiledMap objects
	TiledMapManager *tmManager;
	CCTMXTiledMap *theMap;
	
	//Other Game objets 
	AICar *aiCar1;
}
	
-(void) setCenterOfScreen:(CGPoint)position zoomSpace:(int)zoomSpace zoomCancel:(BOOL)zoomCancel;
-(void) gameLoop :(ccTime)dt ;
	
@end
