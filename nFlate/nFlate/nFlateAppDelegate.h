//
//  nFlateAppDelegate.h
//  nFlate
//
//  Created by Mac-005 on 27/02/14.
//  Copyright (c) 2014 Hunka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loadingView.h"
//#import "loading.h"

@interface nFlateAppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL isInternetAvailable;
    loadingView *lview;
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@property (nonatomic, retain) loadingView *lview;

@property (strong, nonatomic) UIWindow *window;
+(nFlateAppDelegate *)sharedAppDelegate;

-(void)addloadingView;
-(void)removeLoadingView;
@end
