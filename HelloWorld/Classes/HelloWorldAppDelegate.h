//
//  HelloWorldAppDelegate.h
//  HelloWorld
//
//  Created by Connor Riley on 1/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyViewController;

@interface HelloWorldAppDelegate : NSObject <UIApplicationDelegate> {
	MyViewController *myViewController;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) MyViewController *myViewController

@end

