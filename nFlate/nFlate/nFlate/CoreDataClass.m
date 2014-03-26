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
/**
 *  Save Data to Core Data
 *
 *  @param datarr array of updated Data
 */
-(void)saveData:(NSArray*)datarr
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Key"];

 NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    /**
     *  if array Count value is Zero then insert new data
     */
    
    if ([arr count]==0) {
        
        
        NSManagedObject *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Key"
                                                                  inManagedObjectContext:self.managedObjectContext];
        NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"Data"
                                                                  inManagedObjectContext:self.managedObjectContext];
        
        
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:datarr];
        [newEntry2 setValue:myData forKey:@"dict"];
        NSString *strKey=@"key1";
        [newEntry setValue:strKey forKey:@"key"];
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
        for (int i=0; i<[arr count]; i++) {
            
            NSManagedObject *newData=[arr objectAtIndex:i];
            NSString *str=[newData valueForKey:@"key"];
            
            if([str  isEqual:@"key1"]) {
                // The key existed...
                NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"Data"
                                                                           inManagedObjectContext:self.managedObjectContext];
             
                
                NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:datarr];
                [newEntry2 setValue:myData forKey:@"dict"];
                [newData setValue:newEntry2 forKey:@"data"];
                
                NSError *error;
                if (![self.managedObjectContext save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }

                
            }
            else {
                NSManagedObject *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Key"
                                                                          inManagedObjectContext:self.managedObjectContext];
                NSManagedObject *newEntry2 = [NSEntityDescription insertNewObjectForEntityForName:@"Data"
                                                                           inManagedObjectContext:self.managedObjectContext];
                
                
                NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:datarr];
                [newEntry2 setValue:myData forKey:@"dict"];
                NSString *strKey=@"key2";
                [newEntry setValue:strKey forKey:@"key"];
                [newEntry setValue:newEntry2 forKey:@"data"];
                
                NSError *error;
                if (![self.managedObjectContext save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
                }

            }
            
        
        }
    [self showData];
    }
/**
 *  show The Data after Updation
 */
-(void)showData
{
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Key"];
     NSArray *arr = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for (int j=0; j<[arr count]; j++) {
        
    
    NSManagedObject *newData=[arr objectAtIndex:j];
    NSString *str=[newData valueForKey:@"key"];
    NSLog(@"key=%@",str);
    NSManagedObject *newData2=[newData valueForKey:@"data"];
    NSData *dataDict=[newData2 valueForKey:@"dict"];
    NSArray *arr1 = (NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData:dataDict];
    for (int i=0; i<[arr1 count]; i++)
    {
        NSDictionary *dict=[arr1 objectAtIndex:i];
        NSLog(@"dict=%@",dict);
    }
    
    }
}



@end
