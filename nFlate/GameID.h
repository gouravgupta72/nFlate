//
//  GameID.h
//  nFlate
//
//  Created by mac-007 on 07/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GameID : NSManagedObject

@property (nonatomic, retain) NSString * gameIdKey;
@property (nonatomic, retain) NSManagedObject *gameData;

@end
