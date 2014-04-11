//
//  DeveloperDataClass.h
//  nFlate
//
//  Created by mac-007 on 01/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeveloperDataClass : NSObject<NSCoding>
{
    NSString *idStr,*name;
}
@property(nonatomic,strong)NSString *idstr;
@property(nonatomic,strong)NSString *name;

@end
