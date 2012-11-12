//
//  Subroutines.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

//Purpose: Converts some units for physic engine, screen adjustment and etc.

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#define PTM_RATIO 32
#define PI_FLOAT 3.14f
#define TWOPI_FLOAT 6.28f
#define SCR_CENTER_X 240
#define SCR_CENTER_Y 160

@interface Subroutines : CCNode {
	
	bool musicIsMute;
	bool effectIsMute;
}

+(Subroutines *)getInstance;

//Messages to change variables for communicating between BOX2D and Cocos2D
-(b2Vec2) toMeters:(CGPoint)point;
-(CGPoint) toPixels:(b2Vec2)vec;
-(float) intToMeters:(float)number;
-(float) angleSynchronizer:(float)angle;
-(float) joypadAngleSynchronizer:(float)angle;

@end
