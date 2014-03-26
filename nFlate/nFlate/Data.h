//
//  Data.h
//  nFlate
//
//  Created by mac-007 on 26/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Data : NSManagedObject

@property (nonatomic, retain) NSData * dict;
@property (nonatomic, retain) NSManagedObject *key;

@end
