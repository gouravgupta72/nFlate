//
//  Key.h
//  nFlate
//
//  Created by Mac Book on 27/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Data;

@interface Key : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) Data *data;

@end
