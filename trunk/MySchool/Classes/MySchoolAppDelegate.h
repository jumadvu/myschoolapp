//
//  MySchoolAppDelegate.h
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MySchoolViewController;

@interface MySchoolAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MySchoolViewController *viewController;
	UINavigationController *navCon;
}

@property (nonatomic, retain) UINavigationController *navCon;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MySchoolViewController *viewController;

@end

