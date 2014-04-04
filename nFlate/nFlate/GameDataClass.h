//
//  GameDataClass.h
//  nFlate
//
//  Created by mac-007 on 03/04/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDataClass : NSObject
{
    NSString *gameID,*gameName,*gameColor;
}
@property(nonatomic,strong)NSString *gameID;
@property(nonatomic,strong)NSString *gameName;
@property(nonatomic,strong)NSString *gameColor;


@end
