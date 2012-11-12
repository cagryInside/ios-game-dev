//
//  Subroutines.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "Subroutines.h"
#import <math.h>

@implementation Subroutines

#pragma mark -
#pragma mark Singleton & init

//Singleton class defination

static Subroutines *subInstance = nil;

+(id)init {
	self = [super init];
	return self;
}

+(Subroutines *)getInstance {
	
	@synchronized(self) {
		if (subInstance == nil) {
			subInstance = [[self alloc] init];
		}
	}
	return subInstance;
}

#pragma mark -
#pragma mark Sobroutine Unit Changer Messages

//Change points to Box2D vectors
-(b2Vec2) toMeters:(CGPoint)point {	
	return b2Vec2(point.x/PTM_RATIO, point.y/PTM_RATIO);
}

//Change Box2D vectors to points
-(CGPoint) toPixels:(b2Vec2)vec {
	return ccpMult(CGPointMake(vec.x, vec.y), PTM_RATIO);
}

//Change pixels to Box2D meters (Box2D using meters for creating objects and other stuff)
-(float) intToMeters:(float)number {
	return number/PTM_RATIO;
}

//Car Angle Synchronizer
-(float) angleSynchronizer:(float)angle{
	
	angle = fmodf(angle, 6.28f);
	if (angle < 0){
		angle += 6.28f;
	}
		
	return angle;
}

// Joypad angle fixing
-(float) joypadAngleSynchronizer:(float)angle {
	
	if (angle < 0) {
		angle += 6.28f;
	}
	return angle;
}
#pragma mark -
#pragma mark Memory Management

-(void) dealloc {
	[super dealloc];
}

@end
