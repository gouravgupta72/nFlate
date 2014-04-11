//
//  CoreDataClass.h
//  nFlate
//
//  Created by mac-007 on 25/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataClass : NSObject
-(void)saveData:(NSDictionary*)datadict;
-(void)saveDataList:(NSDictionary*) dict;
-(void)saveGameData:(NSDictionary*) dict;
-(NSMutableArray*)showData:(NSString *)strKey;
-(NSMutableArray*)showDataList:(NSString *)strKey;
-(NSMutableArray*)showGameList:(NSString *)strKey;


@end
