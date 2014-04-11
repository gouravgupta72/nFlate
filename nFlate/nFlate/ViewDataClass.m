//
//  ViewDataClass.m
//  nFlate
//
//  Created by mac-007 on 03/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "ViewDataClass.h"

@implementation ViewDataClass
@synthesize gameID,matrixID,value,title;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.gameID = [decoder decodeObjectForKey:@"gameID"];
        self.matrixID = [decoder decodeObjectForKey:@"matrixID"];
        self.value = [decoder decodeObjectForKey:@"value"];
        self.title = [decoder decodeObjectForKey:@"title"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:gameID forKey:@"gameID"];
    [encoder encodeObject:matrixID forKey:@"matrixID"];
    [encoder encodeObject:value forKey:@"value"];
    [encoder encodeObject:title forKey:@"title"];
    
}
@end
