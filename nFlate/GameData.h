//
//  GameData.h
//  nFlate
//
//  Created by mac-007 on 07/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameID;

@interface GameData : NSManagedObject

@property (nonatomic, retain) NSData * gameDataArr;
@property (nonatomic, retain) GameID *gameID;

@end
