//
//  TiledMap.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 2/23/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TiledMapManager : CCNode {
	
	//Declaring TiledMap and its layers
	CCTMXTiledMap *theMap;
	CCTMXLayer *bgLayer;
	
	//Declaring start point for main character
	int startPointX, startPointY;
}

@property (nonatomic, retain) CCTMXTiledMap *theMap;
@property (nonatomic, retain) CCTMXLayer *bgLayer;

//TiledMap Messages
+(TiledMapManager *)getInstance;
-(CCTMXTiledMap *)getTiledMap;
-(CGPoint)getStartPoint;

@end
