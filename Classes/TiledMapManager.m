//
//  TiledMap.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "TiledMapManager.h"

@implementation TiledMapManager

@synthesize theMap;
@synthesize bgLayer;

#pragma mark -
#pragma mark Singleton & init

static TiledMapManager *tiledMapManager;

-(id)init {
	
	if ((self = [super init])) {
		
		//Defining tiled map
		theMap = [CCTMXTiledMap tiledMapWithTMXFile:@"world1.tmx"];
		
		//Tiled Layers
		bgLayer = [theMap layerNamed:@"bg"];
		
		//Object Layer & start point
		CCTMXObjectGroup *objects = [theMap objectGroupNamed:@"obj"];
		NSMutableDictionary *startPoint = [objects objectNamed:@"startPoint"];
		startPointX = [[startPoint valueForKey:@"x"]intValue];
		startPointY = [[startPoint valueForKey:@"y"]intValue];
		
	}
	return self;
}

+(TiledMapManager *)getInstance {
	
	@synchronized(self) {
		
		if (tiledMapManager == nil) {
			
			tiledMapManager = [[TiledMapManager alloc] init];
		}
		
		return tiledMapManager;
	}
}

-(CCTMXTiledMap *)getTiledMap {
	return theMap;
}

-(CGPoint)getStartPoint {
	return CGPointMake(startPointX, startPointY);
}

- (void) dealloc{
	self.theMap = nil;
	self.bgLayer = nil;
	[super dealloc];
}



@end
