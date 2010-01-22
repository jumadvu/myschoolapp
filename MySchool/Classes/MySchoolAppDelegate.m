//
//  MySchoolAppDelegate.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import "MySchoolAppDelegate.h"
#import "Welcome.h"

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
	//add navigation controller view  (root view is set to main menu in nib)
    [window addSubview:navCon.view];
	
	//push welcome screen to nav con
	Welcome *vc = [[[Welcome alloc] initWithNibName:nil bundle:nil] autorelease];
	[navCon pushViewController:vc animated:YES];
    [window makeKeyAndVisible];
}





@end
