//
//  MySchoolAppDelegate.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import "MySchoolAppDelegate.h"
#import "MySchoolViewController.h"

@implementation MySchoolAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize navCon;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:navCon.view];

	navCon.view = viewController.view;
	[navCon pushViewController:viewController animated:YES];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
