//
//  MainBus.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GamePhysics.h"
#import "Subroutines.h"
#import "GLES-Render.h"

#define SELF_CAR_TYPE 0
#define ELENOR_IMG_HEIGHT 18
#define ELENOR_IMG_WIDTH 56

#define HORSEPOWER 60.0
#define STEER_SPEED 30.0f
#define MAX_STEER_ANGLE -0.785f;

@interface MainBus : CCLayer {
	
	//Sprite images if object
	CCSprite *elenor;
	
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
	
	float elenorWidthInMeters;
	float elenorHeightInMeters;
	
	GLESDebugDraw *myDebugDraw;
	
	//Declaring bus physic objects
	 
	//Bus body
	b2BodyDef elenorBodyDef; 
	b2Body *elenorBody; 
	b2FixtureDef elenorFixtureDef;
	
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

@property (nonatomic, retain) CCSprite *elenor;

-(void)moveGoodGuy:(CGPoint)joypadCoordinates;
-(id)init:(int)x withY:(int)y;
-(CGPoint)getPosition ;
-(void) killOrthagonalVelocity:(b2Body *)targetBody;
-(void) synchronizeCarEngine:(CGPoint)joypadCoordinates newHorsePower:(float)newHP;

@end
