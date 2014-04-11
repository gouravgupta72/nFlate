//
//  GameDataClass.m
//  nFlate
//
//  Created by mac-007 on 03/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "GameDataClass.h"

@implementation GameDataClass
@synthesize gameID,gameColor,gameName;
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.gameID = [decoder decodeObjectForKey:@"gameID"];
        self.gameName = [decoder decodeObjectForKey:@"gameName"];
        self.gameColor=[decoder decodeObjectForKey:@"gameColor"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:gameID forKey:@"gameID"];
    [encoder encodeObject:gameName forKey:@"gameName"];
    [encoder encodeObject:gameColor forKey:@"gameColor"];

    
}

@end
