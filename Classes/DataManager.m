//
//  DataManager.m
//  iBus Driver
//
//  Created by Hakan Fatih Kalkan on 4/9/11.
//  Copyright 2011 None / Student. All rights reserved.
//

#import "DataManager.h"
#define kFilename	@"iBusData.plist"


@implementation DataManager

@synthesize generalData;


#pragma mark -
#pragma mark Singleton & init

static DataManager *dataManager = nil;

-(id)init{
	
	if ((self = [super init])) {
		NSString *filePath = [self dataFilePath];
		if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
			[self readRootDictionary];
			NSLog(@"var haci");
			
		} else {
			NSError *error = nil;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:[self getBundlePath] toPath:[self dataFilePath] error:&error];
			[self readRootDictionary];
			NSLog(@"yaratildi haci");
			
		}

	}
	return self;
}

- (void) readRootDictionary {
	
	NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithContentsOfFile:[self dataFilePath]];
	self.generalData = tmp;
	[tmp release];
	//NSLog(@"%@",generalData);
	
}


- (NSString *)getBundlePath {
	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent:kFilename];
	return finalPath;
}

- (NSDictionary *)getGeneralData {
	return generalData;
}

+(DataManager *)getInstance {
	
	@synchronized(self){
		if (dataManager == nil) {
			dataManager = [[DataManager alloc] init];
		}
	}
	return dataManager;
}

- (NSString *)dataFilePath { 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (void)saveContext {
	
//	NSError *error = nil;
//	NSFileManager *fileManager = [NSFileManager defaultManager];
	//[fileManager ]
	// [NSKeyedArchiver archiveRootObject:[self getGeneralData] toFile: [self dataFilePath]];
	[[self getGeneralData] writeToFile:[self dataFilePath] atomically:YES];
	//[fileManager copy:[self getGeneralData] toPath:[self dataFilePath] error:&error];
	//[self readRootDictionary];
	NSLog(@"yazdim bunu");
}

-(void) dealloc {
	[super dealloc];
}

@end
