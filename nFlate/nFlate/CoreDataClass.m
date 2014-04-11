//
//  CoreDataClass.m
//  nFlate
//
//  Created by mac-007 on 25/03/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import "CoreDataClass.h"
#import <CoreData/CoreData.h>

@interface CoreDataClass()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
@implementation CoreDataClass

-(id)init
{
    if ((self = [super init]))
    {
        self.managedObjectContext=[nFlateAppDelegate sharedAppDelegate].managedObjectContext;
    }
    return self;
}


#pragma Save Game Data.

-(void)saveData:(NSDictionary*)dataDict
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Key"];
    
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(key like '%@')", [[dataDict allKeys] objectAtIndex:0] ]];
    
    [fetchRequest setPredicate:requestPredicate];
    NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    /**
     *  if array Count value is Zero then insert new data
     */
    
    if ([arr count]==0) {
        
        
        NSManagedObject *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Key"
                                                                  inManagedObjectContext:self.managedObjectContext];
        NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"Data"
                                                                   inManagedObjectContext:self.managedObjectContext];
        
        
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:[[dataDict allValues] objectAtIndex:0 ]];
        [newEntry2 setValue:myData forKey:@"dict"];
        // NSString *strKey=@"key1";
        [newEntry setValue:[[dataDict allKeys] objectAtIndex:0 ] forKey:@"key"];
        [newEntry setValue:newEntry2 forKey:@"data"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    }
    /**
     *  if count number is greater then zero then check data is exist or not.
     */
    
    else
    {
        
        
        NSManagedObject *newData=[arr objectAtIndex:0];
        
        
        
        // The key existed...
        NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"Data"
                                                                   inManagedObjectContext:self.managedObjectContext];
        
        
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:[[dataDict allValues]objectAtIndex:0 ]];
        [newEntry2 setValue:myData forKey:@"dict"];
        [newData setValue:newEntry2 forKey:@"data"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        
    }
    //[self showData];
    
}





/**
 *  show The Data after Updation
 */
-(NSMutableArray*)showData:(NSString *)strKey
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Key"];
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(key like '%@')", strKey]];
    [fetchRequest setPredicate:requestPredicate];
    NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
    if ([arr count]>0)
    {
        NSManagedObject *newData=[arr objectAtIndex:0];
        NSString *str=[newData valueForKey:@"key"];
        NSLog(@"key=%@",str);
        NSManagedObject *newData2=[newData valueForKey:@"data"];
        NSData *dataDict=[newData2 valueForKey:@"dict"];
        arr1 = (NSMutableArray*) [NSKeyedUnarchiver unarchiveObjectWithData:dataDict];
        NSLog(@"dict=%@",arr1);
    }
    return  arr1;
    
}

#pragma Save List Data.

-(void)saveDataList:(NSDictionary*) dict
{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ListID"];
    
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(listIDkey like '%@')", [[dict allKeys] objectAtIndex:0] ]];
    
    [fetchRequest setPredicate:requestPredicate];
    NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    /**
     *  if array Count value is Zero then insert new data
     */
    
    if ([arr count]==0)
    {
        NSManagedObject *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"ListID"
                                                                  inManagedObjectContext:self.managedObjectContext];
        NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"ListData"
                                                                   inManagedObjectContext:self.managedObjectContext];
        NSArray *arr=[[dict allValues] objectAtIndex:0];
        // NSLog(@"%@",);
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:arr] ;
        [newEntry2 setValue:myData forKey:@"listarr"];
        // NSString *strKey=@"key1";
        [newEntry setValue:[[dict allKeys] objectAtIndex:0 ] forKey:@"listIDkey"];
        [newEntry setValue:newEntry2 forKey:@"listData"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    }
    /**
     *  if count number is greater then zero then check data is exist or not.
     */
    
    else
    {
        NSManagedObject *newData=[arr objectAtIndex:0];
        
        // The key existed...
        NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"ListData"
                                                                   inManagedObjectContext:self.managedObjectContext];
        
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:[[dict allValues]objectAtIndex:0 ]];
        [newEntry2 setValue:myData forKey:@"listarr"];
        [newData setValue:newEntry2 forKey:@"listData"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        
    }
    // [self showDataList];
    
    
}
-(NSMutableArray*)showDataList:(NSString *)strKey
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ListID"];
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(listIDkey like '%@')", strKey]];
    [fetchRequest setPredicate:requestPredicate];
    NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
    if ([arr count]>0)
    {
        NSManagedObject *newData=[arr objectAtIndex:0];
        NSString *str=[newData valueForKey:@"listIDkey"];
        NSLog(@"key=%@",str);
        NSManagedObject *newData2=[newData valueForKey:@"listData"];
        NSData *dataDict=[newData2 valueForKey:@"listarr"];
        arr1 = (NSMutableArray*) [NSKeyedUnarchiver unarchiveObjectWithData:dataDict];
        NSLog(@"dict=%@",arr1);
        
    }
    return arr1;
}

#pragma Save Game Data.

-(void)saveGameData:(NSDictionary*) dict
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GameID"];
    
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(gameIdKey like '%@')", [[dict allKeys] objectAtIndex:0] ]];
    
    [fetchRequest setPredicate:requestPredicate];
    NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    /**
     *  if array Count value is Zero then insert new data
     */
    
    if ([arr count]==0)
    {
        NSManagedObject *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"GameID"
                                                                  inManagedObjectContext:self.managedObjectContext];
        NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"GameData"
                                                                   inManagedObjectContext:self.managedObjectContext];
        NSArray *arr=[[dict allValues]objectAtIndex:0 ];
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:arr] ;
        [newEntry2 setValue:myData forKey:@"gameDataArr"];
        [newEntry setValue:[[dict allKeys] objectAtIndex:0 ] forKey:@"gameIdKey"];
        [newEntry setValue:newEntry2 forKey:@"gameData"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    }
    /**
     *  if count number is greater then zero then check data is exist or not.
     */
    
    else
    {
        NSManagedObject *newData=[arr objectAtIndex:0];
                // The key existed...
        NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"GameData"
                                                                   inManagedObjectContext:self.managedObjectContext];
        
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:[[dict allValues]objectAtIndex:0 ]];
        [newEntry2 setValue:myData forKey:@"gameDataArr"];
        [newData setValue:newEntry2 forKey:@"gameData"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        
    }
}

-(NSMutableArray*)showGameList:(NSString *)strKey
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GameID"];
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(gameIdKey like '%@')", strKey]];
    [fetchRequest setPredicate:requestPredicate];
    NSMutableArray *arr1=[[NSMutableArray alloc]init] ;
    NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if ([arr count]>0)
    {
        NSManagedObject *newData=[arr objectAtIndex:0];
        NSString *str=[newData valueForKey:@"gameIdKey"];
        NSLog(@"key=%@",str);
        NSManagedObject *newData2=[newData valueForKey:@"gameData"];
        NSData *dataDict=[newData2 valueForKey:@"gameDataArr"];
        arr1 = (NSMutableArray*) [NSKeyedUnarchiver unarchiveObjectWithData:dataDict];
        NSLog(@"dict=%@",arr1);
        
    }
    return arr1;
}
@end
