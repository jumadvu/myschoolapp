//
//  ActivitiesHome.h
//  MySchool
//
//  Created by Ashley Kayler on 4/10/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActivitiesHome : baseViewController {
	IBOutlet UIScrollView *scroller;
	NSArray *activities;
}

@property (nonatomic, retain) UIScrollView *scroller;
@property (nonatomic, retain) NSArray *activities;

@end
