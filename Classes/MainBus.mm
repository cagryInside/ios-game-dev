//
//  MainBus.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "MainBus.h"
#import "Subroutines.h"

@implementation MainBus

@synthesize elenor;

#pragma mark -
#pragma mark Constructors

//Default constructor for a fixed positon (100,100)

-(id)init {
	if ((self = [super init])) {
		//Width: 40px - Height: 112px
		elenor = [CCSprite spriteWithFile:@"bus.png" ];
		elenor.position = ccp (100,100);
		[self addChild: elenor];		
	}
	return self;
}

//Constructor for new or saved x, y values

-(id)init:(int)x withY:(int)y {
	if ((self = [super init])) {
		
		//Elenor sprite
		//Width: 40px - Height: 112px
		elenor = [CCSprite spriteWithFile:@"bus.png"];
		elenor.position = ccp (x,y);
		
		//Changing elenor pixels into meters for box2d
		elenorWidthInMeters = [[Subroutines getInstance] intToMeters:ELENOR_IMG_WIDTH];
		elenorHeightInMeters = [[Subroutines getInstance] intToMeters:ELENOR_IMG_HEIGHT];
		
		//Getting singleton instance for physics
		mainWorld = [[GamePhysics getInstance] getGameWorld];
		b2Vec2 carStartingPoint = [[Subroutines getInstance] toMeters:elenor.position];
		
		//Initializing car physic objects  
		elenorBodyDef.type = b2_dynamicBody; 
		elenorBodyDef.position = carStartingPoint;
		elenorBodyDef.userData = elenor; 
		elenorBodyDef.linearDamping = 1;
		elenorBodyDef.angularDamping = 2;
		
		//Create bus body from BodyDef
		elenorBody = mainWorld->CreateBody(&elenorBodyDef);
		
		b2PolygonShape dynamicBox;
		dynamicBox.SetAsBox(elenorWidthInMeters, elenorHeightInMeters);
		elenorFixtureDef.shape = &dynamicBox;
		elenorFixtureDef.density = 12.0f;
		elenorFixtureDef.friction = 1.0f;
		elenorFixtureDef.restitution = 0.6f;
		elenorBody->CreateFixture(&elenorFixtureDef);
		
		//Defining first values
		steeringAngle = 0;
		engineSpeed = 0;
		joypadTurnController = YES;
		steerAssistCounter = 0;
		canAssist = NO;
		
		//Other physic companents
		
		//Left front wheel definations
		leftWheelDef.position = b2Vec2(carStartingPoint.x+elenorWidthInMeters - 0.7f, carStartingPoint.y+elenorHeightInMeters - 0.1f);
		leftWheelDef.type = b2_dynamicBody;
		leftWheel = mainWorld->CreateBody(&leftWheelDef);
		
		//Right front wheel definations
		rightWheelDef.position = b2Vec2(carStartingPoint.x+elenorWidthInMeters - 0.7f, carStartingPoint.y-elenorHeightInMeters + 0.1f);
		rightWheelDef.type = b2_dynamicBody;
		rightWheel = mainWorld->CreateBody(&rightWheelDef);
		
		//Left rear wheel definations
		leftRearWheelDef.position = b2Vec2(carStartingPoint.x-elenorWidthInMeters + 0.7f, carStartingPoint.y+elenorHeightInMeters-0.2f);
		leftRearWheelDef.type = b2_dynamicBody;
		leftRearWheel = mainWorld->CreateBody(&leftRearWheelDef);
		
		//Left front wheel definations
		rightRearWheelDef.position = b2Vec2(carStartingPoint.x-elenorWidthInMeters + 0.7f, carStartingPoint.y-elenorHeightInMeters+0.1f );
		rightRearWheelDef.type = b2_dynamicBody;
		rightRearWheel = mainWorld->CreateBody(&rightRearWheelDef);
		
		//Shape definitions 
		b2PolygonShape leftWheelShapeDef;
		leftWheelShapeDef.SetAsBox(0.3f, 0.1f);
		b2FixtureDef leftWheelFixtureDef;
		leftWheelFixtureDef.shape = &leftWheelShapeDef;
		leftWheelFixtureDef.density = 0.2f;
		leftWheelFixtureDef.friction = 1.0f;
		leftWheel->CreateFixture(&leftWheelFixtureDef);
		
		b2PolygonShape rightWheelShapeDef;
		rightWheelShapeDef.SetAsBox(0.3f, 0.1f);
		b2FixtureDef rightWheelFixtureDef;
		rightWheelFixtureDef.shape = &rightWheelShapeDef;
		rightWheelFixtureDef.density = 0.2f;
		rightWheelFixtureDef.friction = 1.0f;
		rightWheel->CreateFixture(&rightWheelFixtureDef);
		
		b2PolygonShape leftRearWheelShapeDef;
		leftRearWheelShapeDef.SetAsBox(0.3f, 0.2f);
		b2FixtureDef leftRearWheelFixtureDef;
		leftRearWheelFixtureDef.shape = &leftRearWheelShapeDef;
		leftRearWheelFixtureDef.density = 0.2f;
		leftRearWheelFixtureDef.friction = 1.5f;
		leftRearWheel->CreateFixture(&leftRearWheelFixtureDef);
		
		b2PolygonShape rightRearWheelShapeDef;
		rightRearWheelShapeDef.SetAsBox(0.3f, 0.2f);
		b2FixtureDef rightRearWheelFixtureDef;
		rightRearWheelFixtureDef.shape = &rightRearWheelShapeDef;
		rightRearWheelFixtureDef.density = 0.2f;
		rightRearWheelFixtureDef.friction = 1.5f;
		rightRearWheel->CreateFixture(&rightWheelFixtureDef);
		
		//Creating joints
		b2RevoluteJointDef leftJointDef;
		leftJointDef.Initialize(elenorBody, leftWheel, leftWheel->GetWorldCenter());
		leftJointDef.enableMotor = true;
		leftJointDef.maxMotorTorque = 100;
		
		b2RevoluteJointDef rightJointDef;
		rightJointDef.Initialize(elenorBody, rightWheel, rightWheel->GetWorldCenter());
		rightJointDef.enableMotor = true;
		rightJointDef.maxMotorTorque = 100;
		
		leftJoint = (b2RevoluteJoint *)mainWorld->CreateJoint(&leftJointDef);
		rightJoint = (b2RevoluteJoint *)mainWorld->CreateJoint(&rightJointDef);
		
		//Telling box2d to turn wheel just on x axis of vehicle
		b2Vec2 wheelAngle;
		wheelAngle.Set(1,0);
		
		b2PrismaticJointDef leftRearJointDef;
		leftRearJointDef.Initialize(elenorBody, leftRearWheel, leftRearWheel->GetWorldCenter(), wheelAngle);
		leftRearJointDef.enableLimit = true;
		leftRearJointDef.lowerTranslation = 0;
		leftRearJointDef.upperTranslation = 0;
		mainWorld->CreateJoint(&leftRearJointDef);
		
		b2PrismaticJointDef rightRearJointDef;
		rightRearJointDef.Initialize(elenorBody, rightRearWheel, rightRearWheel->GetWorldCenter(), wheelAngle);
		rightRearJointDef.enableLimit = true;
		rightRearJointDef.lowerTranslation = 0;
		rightRearJointDef.upperTranslation = 0;
		mainWorld->CreateJoint(&rightRearJointDef);
		
		[self addChild: elenor];
		
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

#pragma mark -
#pragma mark Draw Functions

//Debug draw function
/*
-(void) draw {
 
 [super draw];
 glEnableClientState(GL_VERTEX_ARRAY);
 mainWorld->DrawDebugData();
 glDisableClientState(GL_VERTEX_ARRAY);
}*/


-(void) moveGoodGuy:(CGPoint)joypadCoordinates {
	
	//Synchronizing car engine
	[self synchronizeCarEngine:joypadCoordinates newHorsePower:HORSEPOWER];
	
	[self killOrthagonalVelocity:leftWheel];
	[self killOrthagonalVelocity:rightWheel];
	[self killOrthagonalVelocity:leftRearWheel];
	[self killOrthagonalVelocity:rightRearWheel];
	
	//Driving 
	b2Vec2 lDirection = leftWheel->GetTransform().R.col1;
	lDirection *=engineSpeed;
	
	b2Vec2 rDirection = rightWheel->GetTransform().R.col1;
	rDirection *=engineSpeed;
    
	leftWheel->ApplyForce(lDirection, leftWheel->GetPosition());
	rightWheel->ApplyForce(rDirection, rightWheel->GetPosition());
	
	//Steering 
	float mspeed = steeringAngle - leftJoint->GetJointAngle();
	leftJoint->SetMotorSpeed(mspeed * STEER_SPEED);
	
	mspeed = steeringAngle - rightJoint->GetJointAngle();
	rightJoint->SetMotorSpeed(mspeed * STEER_SPEED);
}

-(void) synchronizeCarEngine:(CGPoint)joypadCoordinates newHorsePower:(float)newHP {
	
	joypadAngle = [[Subroutines getInstance] joypadAngleSynchronizer:atan2(joypadCoordinates.y, joypadCoordinates.x)];
	carAngle = [[Subroutines getInstance] angleSynchronizer:elenorBody->GetAngle()];
	//	wheelAngle = [[Subroutines getInstance] angleSynchronizer:leftWheel->GetAngle()];
	currentVelocity = sqrt((joypadCoordinates.x * joypadCoordinates.x) + (joypadCoordinates.y * joypadCoordinates.y));
	
	// Calculating target angle
	targetAngle = (joypadAngle - carAngle);
	//CCLOG(@"target angle: %f",targetAngle);
	
	//Checking breake interval between 105 and 255 degrees 
	if ((ABS(targetAngle) < 1.83f) || (ABS(targetAngle) > 4.44f )){
		// Acceleration and wheel controls 
		
		// Calculating absolute angle value 
		if (targetAngle > 3.14f) {
			targetAngle = targetAngle - 6.28f;
		}else {
			if (targetAngle < -3.14f) {
				targetAngle = targetAngle + 6.28;
			}
		}
	
		// Checking maxSteerAngle value
		if (ABS(targetAngle) > 0.785f){
			if (targetAngle < 0) {
				targetAngle = -0.785f;
			} else {
				targetAngle = 0.785f;
			}
		
		}	
		//Setting steering angle to zero on very tiny targetAngle differences
		if (ABS(targetAngle * 0.5f ) > 0.01f) {
			steeringAngle = targetAngle * 0.5f;
		}else {
			steeringAngle = 0;
		}
	
		engineSpeed = (currentVelocity * (newHP/32));
		
	}else {
		//Break and backwards control
		//steeringAngle = 0;
		if (ABS(targetAngle) < 2.20f ){	
			steeringAngle = 0.785f;
		}else {
			if (ABS(targetAngle) > 4.00f) {
			steeringAngle = -0.785f;
			}else {
				steeringAngle = 0;
			}
		}
		/*	
		//Setting steering angle to zero on very tiny targetAngle differences
		if (ABS(targetAngle * 0.5f ) > 0.01f) {
			steeringAngle = targetAngle * 0.5f;
		}else {
			steeringAngle = 0;
		}
		*/
		
		if (currentVelocity < 25.0f){
			engineSpeed = 0;	
            
		}else {
			
			engineSpeed = -25;
			
		}

	}
	
	//Checking if joypad is moving
	if ((joypadCoordinates.x == 0.0f) && (joypadCoordinates.y == 0.0f)){
		steeringAngle = 0;
		engineSpeed = 0;
		
	}

//	CCLOG(@"cA: %f -- jA: %f -- tA: %f", carAngle, joypadAngle, targetAngle);
}

//Functions to make box2d from side-view to top-view
-(void) killOrthagonalVelocity:(b2Body *)targetBody{
	
	b2Vec2 localPoint;
	localPoint.Set(0,0);
	b2Vec2 velocity = targetBody->GetLinearVelocityFromLocalPoint(localPoint);
	
	b2Vec2 sideWayAxis = targetBody->GetTransform().R.col2;
	sideWayAxis *= b2Dot(velocity, sideWayAxis);
	
	targetBody->SetLinearVelocity(sideWayAxis);	
}


//Function to get position of object
-(CGPoint)getPosition {
	return elenor.position;
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc {
    [super dealloc];
}

@end
