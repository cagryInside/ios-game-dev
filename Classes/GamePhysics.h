//
//  GamePhysics.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#define GRAVITY_FORCE_X 0.0f
#define GRAVITY_FORCE_Y 0.0f

@interface GamePhysics : CCNode {
	
	//Declaring Singleton attributes
	b2World *gWorld;
	b2Vec2 gravity;
	bool allowBodiesToSleep;
	
}

//Messages to get instances
+(GamePhysics *)getInstance;
-(b2World*)getGameWorld;

@end

