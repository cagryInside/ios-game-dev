//
//  LevelManagerController.mm
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 3/6/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "LevelManagerController.h"


@implementation LevelManagerController

-(id)init {

	if ((self = [super init])) {
		
		lRect1 = CGRectMake(36, 208, 48, 64);
		lRect2 = CGRectMake(108, 208, 48, 64);
		lRect3 = CGRectMake(180, 208, 48, 64);
		lRect4 = CGRectMake(252, 208, 48 , 64);
		lRect5 = CGRectMake(324, 208, 48, 64);
		lRect6 = CGRectMake(396, 208, 48, 64);
		lRect7 = CGRectMake(36, 96, 48, 64);
		lRect8 = CGRectMake(108, 96, 48, 64);
		lRect9 = CGRectMake(180, 96, 48, 64);
		lRect10 = CGRectMake(252, 96, 48 , 64);
		lRect11 = CGRectMake(324, 96, 48, 64);
		lRect12 = CGRectMake(396, 96, 48, 64);
		
		//Back button rectangle
		backButtonRect = CGRectMake(24, 24, 32, 32);
		
		//Delegating this layer for touch events
		self.isTouchEnabled = YES;
		[[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];	

	}
	return self;
}

-(void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event  {
	//CCLOG(@"touch began");
	NSSet *allTouches = [event allTouches];
	for (UITouch *touch in allTouches) {
		CGPoint touchLocation = [touch locationInView:[touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:touchLocation];	
			CCLOG(@"touch began");
		//controllerTouchHash = [touch hash];		
		
		if (CGRectContainsPoint(lRect1, convertedPoint)) {
			CCLOG(@"1");
			[GameStateManager startGame];
		} else if (CGRectContainsPoint(lRect2, convertedPoint)) {
			CCLOG(@"2");
		} else if (CGRectContainsPoint(lRect3, convertedPoint)) {
			CCLOG(@"3");
		} else if (CGRectContainsPoint(lRect4, convertedPoint)) {
			CCLOG(@"4");
		} else if (CGRectContainsPoint(lRect5, convertedPoint)) {
			CCLOG(@"5");
		} else if (CGRectContainsPoint(lRect6, convertedPoint)) {
			CCLOG(@"6");
		} else if (CGRectContainsPoint(lRect7, convertedPoint)) {
			CCLOG(@"7");
		} else if (CGRectContainsPoint(lRect8, convertedPoint)) {
			CCLOG(@"8");
		} else if (CGRectContainsPoint(lRect9, convertedPoint)) {
			CCLOG(@"9");
		} else if (CGRectContainsPoint(lRect10, convertedPoint)) {
			CCLOG(@"10");
		} else if (CGRectContainsPoint(lRect11, convertedPoint)) {
			CCLOG(@"11");
		} else if (CGRectContainsPoint(lRect12, convertedPoint)) {
			CCLOG(@"12");
		} else if (CGRectContainsPoint(backButtonRect, convertedPoint)) {
			CCLOG(@"back it");
			[GameStateManager startWorldManager];
		}		
	}
}

-(void)dealloc {
	
	[super dealloc];
}

@end
