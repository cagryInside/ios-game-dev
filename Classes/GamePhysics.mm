//
//  GamePhysics.mm
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "GamePhysics.h"

@implementation GamePhysics

#pragma mark -
#pragma mark Singleton & init

static GamePhysics *gPhysics = nil;

-(id)init{
	
	if ((self = [super init])){
		
		gravity = b2Vec2(GRAVITY_FORCE_X, GRAVITY_FORCE_Y);
		allowBodiesToSleep = true;
		gWorld = new b2World(gravity, allowBodiesToSleep);
	}
	return self;
}

+(GamePhysics *)getInstance {
	
	@synchronized(self){
		
		if (gPhysics == nil) {
			
			gPhysics = [[GamePhysics alloc] init];
		}
	}
	return gPhysics;
}

-(b2World *)getGameWorld {
	return gWorld;
}

#pragma mark -
#pragma mark Memory Management

-(void) dealloc {
	delete gWorld;
	[super dealloc];
}

@end
