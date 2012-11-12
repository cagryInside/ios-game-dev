//
//  AICar.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 5/7/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "AICar.h"


@implementation AICar

-(id)init {
	if ((self = [super init])) {
		//Default Consructor 
	}
	return self;
}

//Constructor for new or saved x, y values

-(id)init:(int)x withY:(int)y {
	if ((self = [super init])) {
		
		//Elenor sprite
		//Width: 40px - Height: 112px
		
		srand ( time(NULL) );
		int imageID = rand()%6 + 1;
		NSString *carImageString = [NSString stringWithFormat:@"ai%d.png",imageID];
		
		carImage = [CCSprite spriteWithFile:carImageString];
		carImage.position = ccp (x,y);
		
		//Changing elenor pixels into meters for box2d
		carWidthInMeters = [[Subroutines getInstance] intToMeters:CAR_IMG_WIDTH];
		carHeightInMeters = [[Subroutines getInstance] intToMeters:CAR_IMG_HEIGHT];
		
		//Getting singleton instance for physics
		mainWorld = [[GamePhysics getInstance] getGameWorld];
		b2Vec2 carStartingPoint = [[Subroutines getInstance] toMeters:carImage.position];
		
		//Initializing car physic objects  
		carBodyDef.type = b2_dynamicBody; 
		carBodyDef.position = carStartingPoint;
		carBodyDef.userData = carImage; 
		carBodyDef.linearDamping = 1;
		carBodyDef.angularDamping = 2;
		
		//Create bus body from BodyDef
		carBody = mainWorld->CreateBody(&carBodyDef);
		
		b2PolygonShape dynamicBox;
		dynamicBox.SetAsBox(carWidthInMeters, carHeightInMeters);
		carFixtureDef.shape = &dynamicBox;
		carFixtureDef.density = 12.0f;
		carFixtureDef.friction = 1.0f;
		carFixtureDef.restitution = 0.6f;
		carBody->CreateFixture(&carFixtureDef);
		
		//Defining first values
		steeringAngle = 0;
		engineSpeed = 0;
		joypadTurnController = YES;
		steerAssistCounter = 0;
		canAssist = NO;
		
		//Other physic companents
		
		//Left front wheel definations
		leftWheelDef.position = b2Vec2(carStartingPoint.x+carWidthInMeters - 0.4f , carStartingPoint.y+carHeightInMeters - 0.1f);
		leftWheelDef.type = b2_dynamicBody;
		leftWheel = mainWorld->CreateBody(&leftWheelDef);
		
		//Right front wheel definations
		rightWheelDef.position = b2Vec2(carStartingPoint.x+carWidthInMeters - 0.4f, carStartingPoint.y-carHeightInMeters + 0.1f);
		rightWheelDef.type = b2_dynamicBody;
		rightWheel = mainWorld->CreateBody(&rightWheelDef);
		
		//Left rear wheel definations
		leftRearWheelDef.position = b2Vec2(carStartingPoint.x-carWidthInMeters + 0.4f, carStartingPoint.y+carHeightInMeters-0.1f);
		leftRearWheelDef.type = b2_dynamicBody;
		leftRearWheel = mainWorld->CreateBody(&leftRearWheelDef);
		
		//Left front wheel definations
		rightRearWheelDef.position = b2Vec2(carStartingPoint.x-carWidthInMeters + 0.4f, carStartingPoint.y-carHeightInMeters+0.1f );
		rightRearWheelDef.type = b2_dynamicBody;
		rightRearWheel = mainWorld->CreateBody(&rightRearWheelDef);
		
		//Shape definitions 
		b2PolygonShape leftWheelShapeDef;
		leftWheelShapeDef.SetAsBox(0.2f, 0.1f);
		b2FixtureDef leftWheelFixtureDef;
		leftWheelFixtureDef.shape = &leftWheelShapeDef;
		leftWheelFixtureDef.density = 0.2f;
		leftWheelFixtureDef.friction = 1.0f;
		leftWheel->CreateFixture(&leftWheelFixtureDef);
		
		b2PolygonShape rightWheelShapeDef;
		rightWheelShapeDef.SetAsBox(0.2f, 0.1f);
		b2FixtureDef rightWheelFixtureDef;
		rightWheelFixtureDef.shape = &rightWheelShapeDef;
		rightWheelFixtureDef.density = 0.2f;
		rightWheelFixtureDef.friction = 1.0f;
		rightWheel->CreateFixture(&rightWheelFixtureDef);
		
		b2PolygonShape leftRearWheelShapeDef;
		leftRearWheelShapeDef.SetAsBox(0.2f, 0.1f);
		b2FixtureDef leftRearWheelFixtureDef;
		leftRearWheelFixtureDef.shape = &leftRearWheelShapeDef;
		leftRearWheelFixtureDef.density = 0.2f;
		leftRearWheelFixtureDef.friction = 1.5f;
		leftRearWheel->CreateFixture(&leftRearWheelFixtureDef);
		
		b2PolygonShape rightRearWheelShapeDef;
		rightRearWheelShapeDef.SetAsBox(0.2f, 0.1f);
		b2FixtureDef rightRearWheelFixtureDef;
		rightRearWheelFixtureDef.shape = &rightRearWheelShapeDef;
		rightRearWheelFixtureDef.density = 0.2f;
		rightRearWheelFixtureDef.friction = 1.5f;
		rightRearWheel->CreateFixture(&rightWheelFixtureDef);
		
		//Creating joints
		b2RevoluteJointDef leftJointDef;
		leftJointDef.Initialize(carBody, leftWheel, leftWheel->GetWorldCenter());
		leftJointDef.enableMotor = true;
		leftJointDef.maxMotorTorque = 100;
		
		b2RevoluteJointDef rightJointDef;
		rightJointDef.Initialize(carBody, rightWheel, rightWheel->GetWorldCenter());
		rightJointDef.enableMotor = true;
		rightJointDef.maxMotorTorque = 100;
		
		leftJoint = (b2RevoluteJoint *)mainWorld->CreateJoint(&leftJointDef);
		rightJoint = (b2RevoluteJoint *)mainWorld->CreateJoint(&rightJointDef);
		
		//Telling box2d to turn wheel just on x axis of vehicle
		b2Vec2 wheelAngle;
		wheelAngle.Set(1,0);
		
		b2PrismaticJointDef leftRearJointDef;
		leftRearJointDef.Initialize(carBody, leftRearWheel, leftRearWheel->GetWorldCenter(), wheelAngle);
		leftRearJointDef.enableLimit = true;
		leftRearJointDef.lowerTranslation = 0;
		leftRearJointDef.upperTranslation = 0;
		mainWorld->CreateJoint(&leftRearJointDef);
		
		b2PrismaticJointDef rightRearJointDef;
		rightRearJointDef.Initialize(carBody, rightRearWheel, rightRearWheel->GetWorldCenter(), wheelAngle);
		rightRearJointDef.enableLimit = true;
		rightRearJointDef.lowerTranslation = 0;
		rightRearJointDef.upperTranslation = 0;
		mainWorld->CreateJoint(&rightRearJointDef);
		
		[self addChild: carImage];
		
		//Debug draw definations
		myDebugDraw = new GLESDebugDraw(32);
		mainWorld->SetDebugDraw(myDebugDraw);
		
		uint32 flags = 0;
		flags += b2DebugDraw::e_shapeBit;
		flags += b2DebugDraw::e_jointBit;
		flags += b2DebugDraw::e_aabbBit;
		flags += b2DebugDraw::e_pairBit;
		flags += b2DebugDraw::e_centerOfMassBit;
		myDebugDraw->SetFlags(flags);
	}
	return self;
}


@end
