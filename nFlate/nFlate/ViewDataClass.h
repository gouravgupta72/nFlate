//
//  ViewDataClass.h
//  nFlate
//
//  Created by mac-007 on 03/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewDataClass : NSObject<NSCoding>
{
    NSString *gameID,*matrixID,*title,*value;
}
@property(nonatomic,strong)NSString *gameID;
@property(nonatomic,strong)NSString *matrixID;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *value;

@end
