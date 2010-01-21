//
//  MySchoolAppDelegate.h
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySchoolAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navCon;
	NSMutableArray *users;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navCon;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableArray *users;

@end

