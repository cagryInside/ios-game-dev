//
//  AICar.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 5/7/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GamePhysics.h"
#import "Subroutines.h"
#import "GLES-Render.h"
#include <stdlib.h>

#define CAR_IMG_HEIGHT 16
#define CAR_IMG_WIDTH 32

#define HORSEPOWER 60.0
#define STEER_SPEED 30.0f
#define MAX_STEER_ANGLE -0.785f;



@interface AICar : CCLayer {
	
	//Sprite images if object
	CCSprite *carImage;
	
	//Declaring box2d world
	b2World *mainWorld;
	
	//Declaring bus attributes
	float engineSpeed;
	float steeringAngle;
	float carAngle;
	float joypadAngle;
	float targetAngle;
	float currentVelocity;
	
	bool canAssist;
	bool joypadTurnController;
	
	int steerAssistCounter;
	
	float carWidthInMeters;
	float carHeightInMeters;
	
	GLESDebugDraw *myDebugDraw;
	
	//Declaring bus physic objects
	
	//Bus body
	b2BodyDef carBodyDef; 
	b2Body *carBody; 
	b2FixtureDef carFixtureDef;
	
	//Front left wheel
	b2BodyDef leftWheelDef;
	b2Body *leftWheel;
	
	//Front right wheel
	b2BodyDef rightWheelDef;
	b2Body *rightWheel;
	
	//Left rear wheel
	b2BodyDef leftRearWheelDef;
	b2Body *leftRearWheel;
	
	//Right rear wheel
	b2BodyDef rightRearWheelDef;
	b2Body *rightRearWheel;
	
	b2RevoluteJoint *leftJoint;
	b2RevoluteJoint *rightJoint;

}

-(id)init:(int)x withY:(int)y;

@end
