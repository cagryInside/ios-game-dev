//
//  DataManager.h
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 4/9/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWorld1		@"world1"
#define kWorld2		@"world2"
#define kWorld3		@"world3"
#define kSoundFX	@"soundFX"
#define kMusic		@"music"
#define kPlayable	@"playable"
#define kStarCount	@"starCount"
#define kLevels		@"levels"
#define kLevel1		@"level1"
#define kLevel2		@"level2"
#define kLevel3		@"level3"
#define kLevel4		@"level4"
#define kLevel5		@"level5"
#define kLevel6		@"level6"
#define kLevel7		@"level7"
#define kLevel8		@"level8"
#define kLevel9		@"level9"
#define kLevel10	@"level10"
#define kLevel11	@"level11"
#define kLevel12	@"level12"
#define kMaxScore	@"maxScore"
#define kHighLevel	@"highLevel"
#define kStations	@"stations"

@interface DataManager : NSObject {

	NSMutableDictionary *generalData;

}

@property (nonatomic, retain) NSDictionary *generalData;



- (NSString *)dataFilePath;
+ (DataManager *)getInstance;
- (void)saveContext;
- (NSDictionary *) getGeneralData;
- (NSString *)getBundlePath;
- (void) readRootDictionary;

@end
