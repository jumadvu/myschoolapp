//
//  MySchoolAppDelegate.h
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class UserMO;
@class User;

@interface MySchoolAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navCon;
	NSMutableArray *users;
	NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	User *teacher;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navCon;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableArray *users;
@property (nonatomic, retain) User *teacher;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;
- (void)fetchData;

@end

