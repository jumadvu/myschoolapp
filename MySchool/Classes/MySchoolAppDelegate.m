//
//  MySchoolAppDelegate.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import "MySchoolAppDelegate.h"


@implementation MySchoolAppDelegate

@synthesize window;
@synthesize navCon;
@synthesize users;

- (void)dealloc {
	[navCon release];
    [window release];
	[users release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after app launch    
    //[navCon initWithRootViewController:viewController];
	[navCon setNavigationBarHidden:YES];
    [window addSubview:navCon.view];
    [window makeKeyAndVisible];
}





@end
