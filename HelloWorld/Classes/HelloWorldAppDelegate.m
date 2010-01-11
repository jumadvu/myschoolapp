//
//  HelloWorldAppDelegate.m
//  HelloWorld
//
//  Created by Connor Riley on 1/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "MyViewController.h"
#import "HelloWorldAppDelegate.h"

@implementation HelloWorldAppDelegate

@synthesize window;
@synthesize myViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
    MyViewController *aViewController = [[MyViewController alloc]
										 initWithNibName:@"MyViewController" bundle:[NSBundle mainBundle]];
    [self setMyViewController:aViewController];
    [aViewController release];
	
    UIView *controllersView = [myViewController view];
    [window addSubview:controllersView];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [myViewController release];
    [window release];
    [super dealloc];
}

@end
