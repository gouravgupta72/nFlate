//
//  DeveloperDataClass.m
//  nFlate
//
//  Created by mac-007 on 01/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "DeveloperDataClass.h"

@implementation DeveloperDataClass
@synthesize idstr,name;

    - (id)initWithCoder:(NSCoder *)decoder {
        if (self = [super init]) {
            self.idstr = [decoder decodeObjectForKey:@"idstr"];
            self.name = [decoder decodeObjectForKey:@"name"];
        }
        return self;
    }
    
    - (void)encodeWithCoder:(NSCoder *)encoder {
        [encoder encodeObject:idstr forKey:@"idstr"];
        [encoder encodeObject:name forKey:@"name"];
       
    }
    

@end
