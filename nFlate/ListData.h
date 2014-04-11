//
//  ListData.h
//  nFlate
//
//  Created by mac-007 on 07/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ListID;

@interface ListData : NSManagedObject

@property (nonatomic, retain) NSData * listarr;
@property (nonatomic, retain) ListID *listID;

@end
