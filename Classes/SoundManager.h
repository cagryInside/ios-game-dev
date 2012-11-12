//
//  SoundManager.h
//  iBus Driver
//
//  Created by cagry on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "SimpleAudioEngine.h"
#import "CocosDenshion.h"
#import "CDAudioManager.h"

@interface SoundManager : NSObject {

}

+(SoundManager *)getInstance;
-(void)controlAllSounds:(Boolean)control;
-(void)handleMenuSound;
-(void)stopBGMusic;

@end
